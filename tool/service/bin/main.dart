// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:libtcc/libtcc.dart';

const String Preconditions  = 'preconditions';
const String Postconditions = 'postconditions';

int anonObjCount = 0;


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
