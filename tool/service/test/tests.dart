library tcc.service.test;

//import 'dart:async';
//import 'dart:convert';
//import 'dart:io' show HttpStatus;

//import 'package:shelf/shelf.dart' as shelf;
//import 'package:shelf_path/shelf_path.dart';
import 'package:unittest/unittest.dart';

import 'package:libtcc/libtcc.dart' as Model;
//import '../lib/router.dart';
import '../lib/database.dart' as Database;
import '../lib/config.dart' as Config;

part 'src/database-template.dart';
//part 'src/service-concept_role.dart';


main() {
  /// Database tests.
  testDatabaseTemplate();
}
