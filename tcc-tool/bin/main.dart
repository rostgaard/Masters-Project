// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:async';
import 'dart:convert';
import '../lib/tcc.dart';

const String Preconditions  = 'preconditions';
const String Postconditions = 'postconditions';

int anonObjCount = 0;


UseCase useCase1 = new UseCase (
    'useCase1',
    new ConditionList([
                       ]),
    new StatementList([
                       new Statement(
                           new Actor  ('Receptionist', iden: 'R1'),
                           new Action ('send'),
                           new Target ('message', iden: 'A')),
                       new Statement(
                           new Actor  ('Receptionist'),
                           new Action ('save'),
                           new Target ('message')),
                       new Statement(
                           new Actor  ('Receptionist', iden: 'R1'),
                           new Action ('send'),
                           new Target ('message', iden: 'B')),
                       new Statement(
                           new Actor  ('Receptionist', iden: 'R2'),
                           new Action ('retrieve'),
                           new Target ('message', iden: 'A'))
                       ]),
    new ConditionList.empty());

//String aquisition_code (Actor)

main() {

 String filename = 'uc1.dart';

  print (Platform.script.path);
  var file = new File(filename);

  Future<File> finishedWriting = file.writeAsString(toTestCase(useCase1));
//
//  finishedWriting.then((File newFile)  {
//    Process.start('/home/krc/lib/dart/dart-sdk/bin/dartanalyzer', [newFile.path]).then((process) {
//
//      process.stdout.transform(UTF8.decoder).transform(new LineSplitter()).listen((String line) {
//            print('(output): ${line}');
//          });
//          process.stderr.transform(UTF8.decoder).transform(new LineSplitter()).listen((String line) {
//            print(' (errors): ${line}');
//          });
//    });
//  });


print('${useCase1}\n');
print('Involved actors: ${useCase1.involvedActors}\n');

print(toTestCase(useCase1));

}
