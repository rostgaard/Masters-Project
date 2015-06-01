// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:async';
import 'dart:convert';
import '../lib/tcc.dart';

const String Preconditions  = 'preconditions';
const String Postconditions = 'postconditions';

int anonObjCount = 0;


final Actor receptionist1 = new Actor('Receptionist');
final Actor receptionist2 = new Actor('Receptionist', role: 'other receptionist');
final Actor caller = new Actor('Caller');

UseCase useCase1 =
  new UseCase ('Use case 1')
    ..stakeholders = [receptionist1, caller]
    ..postconditions = [new Predicate(new Expression('message'), is_, new Expectation('sent'))]
    ..statements = new StatementList([
                       new Statement(
                           receptionist1,
                           new Action ('send'),
                           new Target ('message')),
                       new Statement(
                           receptionist1,
                           new Action ('save'),
                           new Target ('message')),
                       new Statement(
                           receptionist1,
                           new Action ('send'),
                           new Target ('message')),
                       new Statement(
                           receptionist2,
                           new Action ('retrieve'),
                           new Target ('message', iden: 'A'))
                       ]);

//String aquisition_code (Actor)

main() {

 String filename = 'uc1.dart';

  print (Platform.script.path);
  var file = new File(filename);

//  Future<File> finishedWriting = file.writeAsString(toTestCase(useCase1));
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
print('${toTestCase(useCase1)})\n');
//print('Involved actors: ${useCase1.involvedActors}\n');

//print('${useCase1.toMarkdown()}\n');


//print(toTestCase(useCase1));

}
