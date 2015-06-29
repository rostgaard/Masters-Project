library tcc.service.test;

//import 'dart:async';
//import 'dart:convert';
//import 'dart:io' show HttpStatus;

//import 'package:shelf/shelf.dart' as shelf;
//import 'package:shelf_path/shelf_path.dart';
import 'package:unittest/unittest.dart';
import 'package:logging/logging.dart';

import 'package:libtcc/libtcc.dart' as Model;
//import '../lib/router.dart';
import '../lib/database.dart' as Database;
import '../lib/config.dart' as Config;

part 'src/database-actor.dart';
part 'src/database-concept.dart';
part 'src/database-config.dart';
part 'src/database-template.dart';
part 'src/database-use_case.dart';
//part 'src/service-concept_role.dart';


main() {
  /// Setup logger
  Logger.root.level = Level.FINEST;
  Logger.root.onRecord.listen((LogRecord record) =>
      logMessage(record.toString()));

  /// Database tests.
//  testDatabaseActor();
//  testDatabaseConcept();
//  testDatabaseConfig();
//  testDatabaseTemplate();
  testDatabaseUseCase();


}
