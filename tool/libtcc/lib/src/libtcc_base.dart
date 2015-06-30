// Copyright (c) 2015, Kim Rostgaard Christensen. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library libtcc.base;

import 'dart:async';
import 'dart:convert';
import 'dart:collection';
import 'package:markdown/markdown.dart';

part 'service.dart';
part 'configuration.dart';
part 'tcc-actor.dart';
part 'tcc-use_case.dart';
part 'tcc-concept.dart';
part 'tcc-definitions.dart';
part 'tcc-test_template.dart';
part 'tcc-user_goal.dart';
part 'tcc-use_case_block.dart';
part 'tcc-use_case_entry.dart';
part 'tcc-use_case_extension.dart';

part 'deprecated/tcc-action.dart';
part 'deprecated/tcc-mappings.dart';
part 'deprecated/tcc-condition.dart';
part 'deprecated/tcc-declaration.dart';
part 'deprecated/tcc-analyzed_use_case.dart';
part 'deprecated/tcc-statement.dart';
part 'deprecated/tcc-target.dart';


String normalize(String string) => string != null
    ?string.replaceAll(' ', '_').toLowerCase()
     :'undefined';

String statementToCode(Statement stmt) {
  return '${stmt.actor.role}.${stmt.action}(${stmt.object.iden});';
}

String declarationToCode(Declaration decl) {
  return '${decl.type} ${decl.iden};';
}

String predicateToCode(Predicate con) {
  String match = matcherMappings[con.matcher.identity];
  String actual = expressionMappings[con.expr.identity];
  String expectation = expectationMappings[con.expectation.identity];

  return '${match}($actual, $expectation)';
}

String actorDeclarationToCode(Actor act) {
  return '${act.type} ${normalize(act.role)}';
}

String toTestCase(AnalyzedUseCase uc) {
  Iterable<String> parameters = uc.involvedActors.map(actorDeclarationToCode);

  String template = '''import \'domain_model.dart\';

void ${uc.identity} (${parameters.join(', ')}) {
  
   /* Declarations */
   ${uc.declarations.map(declarationToCode).join('\n   ')}
   ${uc.involvedActors.map(actorDeclarationToCode).join('\n   ')}

   /* Preconditions */
   ${uc.preconditions.map(predicateToCode).join('\n   ')}

   /* Use case body */
   ${uc.statements.map(statementToCode).join('\n   ')}

   /* Postconditions */
   ${uc.postconditions.map(predicateToCode).join('\n   ')}

}''';

  return template;
}

final Actor receptionist1 = new Actor('Receptionist');
final Actor receptionist2 =
    new Actor.withRole('Receptionist', 'other receptionist');
final Actor caller = new Actor('Caller');

AnalyzedUseCase useCase1 = new AnalyzedUseCase('Use case 1')
  ..stakeholders = [receptionist1, caller]
  ..postconditions =
  [new Predicate(new Expression('message'), is_, new Expectation('sent'))]
  ..statements = new StatementList([
    new Statement(receptionist1, new Action('send'), new Target('message')),
    new Statement(receptionist1, new Action('save'), new Target('message')),
    new Statement(receptionist1, new Action('send'), new Target('message')),
    new Statement(
        receptionist2, new Action('retrieve'), new Target('message', iden: 'A'))
  ]);


definitionToDeclaration (Concept concept) =>
  '${concept.type} ${normalize(concept.role)}';

useCaseEntryToCode(UseCaseEntry e, Definitions defs) {
  String arguments = e.involvedDefinitions(defs).map(definitionToDeclaration).join(', ');

  return '${e.identity} (${arguments})';
}

String useCasesToCode (UseCase uc, Definitions defs, String template) {

  Set usedDefinitions = new Set();
  uc.paths.forEach((List<UseCaseEntry> entries) =>
      entries.forEach((UseCaseEntry entry) =>
          usedDefinitions.addAll(entry.involvedDefinitions(defs))));

  String arguments = usedDefinitions.map(definitionToDeclaration).join(', ');

  int offset = 1;
  StringBuffer buf = new StringBuffer();

  uc.paths.forEach((Iterable<UseCaseEntry> e) {
    /// TODO: Harvest all declarations.
    buf.write('\n');
    buf.write('use_case_${normalize(uc.name)}_path_${offset++}($arguments) {\n');

    buf.write('  ');
    buf.write (e.map((e1) => useCaseEntryToCode(e1, defs)).join('\n    '));
    buf.write('\n  }\n');

  });

  return template.replaceAll('[%USECASES]', buf.toString());
}
