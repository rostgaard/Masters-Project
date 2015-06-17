// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library libtcc.example;

import 'package:libtcc/libtcc.dart';

final Actor receptionist1 = new Actor('Receptionist');
final Actor receptionist2 = new Actor.withRole('Receptionist', 'other receptionist');
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


UseCaseEntry pickupCall = new UseCaseEntry('Receptionist picks up call');
UseCaseEntry giveGreeting = new UseCaseEntry('Receptionist gives greeting');
UseCaseEntry lookupEmployee = new UseCaseEntry('Receptionist looks up employee');

UseCaseEntry specificEmployee = new UseCaseEntry('Receptionist select specific employee');

UseCaseEntry searchEmployee = new UseCaseEntry('Receptionist searches for employee');
UseCaseEntry dialContact = new UseCaseEntry('Receptionist dials contact');

UseCaseEntry initiateTransfer = new UseCaseEntry('Receptionist initiates transfer');

UseCaseExtension noSpecificEmployee = new UseCaseExtension(lookupEmployee, [searchEmployee])
  ..returnsTo= dialContact;

UseCaseExtension contactNotAvailable = new UseCaseExtension(lookupEmployee, [searchEmployee])
  ..returnsTo= lookupEmployee;

UseCaseBlock block1 =
  new UseCaseBlock([pickupCall, giveGreeting, lookupEmployee, specificEmployee, dialContact, initiateTransfer]);

BaseUseCase buc1 = new BaseUseCase('some use case')
 ..scenario = block1
 ..extensions = [noSpecificEmployee, contactNotAvailable];
