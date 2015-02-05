// Copyright (c) 2015, Kim Rostgaard Christensen. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// The TestCaseCompiler library.
library tcc;

import 'dart:collection';

part 'tcc-action.dart';
part 'tcc-actor.dart';
part 'tcc-condition.dart';
part 'tcc-declaration.dart';
part 'tcc-statement.dart';
part 'tcc-target.dart';
part 'tcc-use_case.dart';

// Mappings of type 'hints' to classes.
final Map<String,String> classMap = {
'message' : 'Message'
};

String lookupClass (String className) {
if (!classMap.containsKey(className)) {
 throw new ArgumentError('Class $className not found in classMap, consider adding a mapping.');
}

return classMap[className];
}

String statementToCode (Statement stmt) {
  return '${stmt.actor.iden}.${stmt.action}(${stmt.object.iden});';
}

String declarationToCode (Declaration decl) {
  return '${decl.type} ${decl.iden};';
}

String conditionToCode (Condition con) {
  return statementToCode (con.statement);
}

String actorDeclarationToCode (Actor act) {
  return '${act.type} ${act.iden} = ${act.type}Pool.aquire();';
}


String toTestCase (UseCase uc) {
  String buffer = 'import \'domain_model.dart\';\n\n';

  buffer += '''
${uc.name} () {\n
   /* Declarations */
   ${uc.declarations.map(declarationToCode).join('\n   ')}
   ${uc.involvedActors.map(actorDeclarationToCode).join('\n   ')}

   /* Preconditions */
   ${uc._preconditions.map(conditionToCode).join('\n   ')}

   /* Use case body */
   ${uc._statements.map(statementToCode).join('\n   ')}

   /* Postconditions */
   ${uc._postconditions.map(conditionToCode).join('\n   ')}

}''';

 return buffer;
}
