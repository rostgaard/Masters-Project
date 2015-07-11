library tcc.service.test;

import 'dart:async';
import 'dart:convert';
import 'dart:io' as IO;

import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf_path/shelf_path.dart';
import 'package:shelf_route/shelf_route.dart' as shelf_route;
import 'package:unittest/unittest.dart';
import 'package:logging/logging.dart';

import 'package:libtcc/libtcc.dart' as Model;
import '../lib/router.dart' as Router;
import '../lib/database.dart' as Database;
import '../lib/config.dart' as Config;

part 'src/database-actor.dart';
part 'src/database-concept.dart';
part 'src/database-config.dart';
part 'src/database-template.dart';
part 'src/database-use_case.dart';
part 'src/router-concept.dart';


main() {
  /// Setup logger
  Logger.root.level = Level.FINEST;
  Logger.root.onRecord.listen((LogRecord record) =>
      logMessage(record.toString()));

  /// Database tests.
  testDatabaseActor();
  testDatabaseConcept();
  testDatabaseConfig();
  testDatabaseTemplate();
  testDatabaseUseCase();

  /// Router tests
  testRouterConcept();


}
