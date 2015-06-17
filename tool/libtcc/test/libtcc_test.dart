// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library libtcc.test;

import 'package:test/test.dart';
import '../example/libtcc.dart';

import 'package:libtcc/libtcc.dart';

void main() {
  group('A group of tests', () {
    UseCase tc;

    setUp(() {
      tc = new UseCase('test');
    });

    test('First Test', () {
      expect(tc.name, equals('test'));
    });
  });

  testBaseUseCase();
}

testBaseUseCase() {


  //print (uc1);

  print ('paths:');
  buc1.paths.forEach((Iterable<UseCaseEntry> e) {
    print ('---------');
    print (e.join('\n'));

  });

  print ('LOOPS:');
    print ('---------');
    print (buc1.loops.join('\n'));

}
