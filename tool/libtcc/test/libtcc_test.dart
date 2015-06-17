// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library libtcc.test;

import 'package:test/test.dart';

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
  BaseUseCase uc1;
  UseCaseEntry part1 = new UseCaseEntry('some does stuff');
  UseCaseEntry part2 = new UseCaseEntry('stuff happens to some');
  UseCaseEntry part3 = new UseCaseEntry('some does other stuff');

  UseCaseEntry part4 = new UseCaseEntry('expected stuff');
  UseCaseEntry part5 = new UseCaseEntry('not much to do');

  UseCaseExtension ext = new UseCaseExtension(part2, [part4, part5]);

  UseCaseBlock block1 =
    new UseCaseBlock([part1, part2, part3]);

  uc1 = new BaseUseCase('some use case')
   ..scenario = block1
   ..extensions = [ext];


  print (uc1);

  print (uc1.paths);
}
