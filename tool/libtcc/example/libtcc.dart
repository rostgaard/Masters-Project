// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library libtcc.example;

import 'package:libtcc/libtcc.dart';

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