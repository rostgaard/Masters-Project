// Copyright (c) 2015, Kim Rostgaard Christensen. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library libtcc.base;

import 'dart:async';
import 'dart:convert';
import 'dart:collection';
import 'package:markdown/markdown.dart';

part 'tcc-action.dart';
part 'service.dart';
part 'configuration.dart';
part 'tcc-actor.dart';
part 'tcc-base_use_case.dart';
part 'tcc-concept.dart';
part 'tcc-defintion.dart';
part 'tcc-definitions.dart';
part 'tcc-condition.dart';
part 'tcc-declaration.dart';
part 'tcc-mappings.dart';
part 'tcc-statement.dart';
part 'tcc-target.dart';
part 'tcc-use_case.dart';
part 'tcc-use_case_block.dart';
part 'tcc-use_case_entry.dart';
part 'tcc-use_case_extension.dart';

// Mappings of type 'hints' to classes.
final Map<String, String> classMap = {'message': 'Message'};

String lookupClass(String className) {
  if (!classMap.containsKey(className)) {
    throw new ArgumentError(
        'Class $className not found in classMap, consider adding a mapping.');
  }

  return classMap[className];
}

String normalize(String string) => string.replaceAll(' ', '_').toLowerCase();

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

String toTestCase(UseCase uc) {
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

UseCase useCase1 = new UseCase('Use case 1')
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
