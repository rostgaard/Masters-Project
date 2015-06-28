// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library libtcc.test;

import 'package:test/test.dart';
import '../example/libtcc.dart';

/**
 * Set of unit tests that assert basic properties of the system.
 */
import 'package:libtcc/libtcc.dart';

void main() {
  group('Database.Template', () {

    setUp(() {
       Database;
    });

    test('First Test', () {
      expect(tc.name, equals('test'));
    });

    test('First Test', () {
      expect(tc.name, equals('test'));
    });

  });




  //testBaseUseCase();
}


testBaseUseCase() {
  String template = '''
import domain_model;

int main () {
}

[%USECASES]
''';


  Definitions defs = new
      Definitions([new Definition(new Actor('Receptionist'))..role = 'receptionist']);


  print (useCasesToCode(buc1, defs, template));
}
