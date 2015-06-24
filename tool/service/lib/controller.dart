library tcc.service.controller;

import 'dart:async';
import 'dart:convert';

import 'dart:io' as IO;

import 'package:logging/logging.dart';
import 'package:libtcc/libtcc.dart' as Model;

import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf_route/shelf_route.dart' as shelf_route;

import 'config.dart';
import 'database.dart' as Database;

part 'controller/controller-actor.dart';
part 'controller/controller-concept.dart';
part 'controller/controller-use_case.dart';
part 'controller/controller-config.dart';
part 'controller/controller-test.dart';
part 'controller/controller-test_template.dart';


const String libraryName = 'tcctool.router';
final Logger log = new Logger (libraryName);

_okJSONResponse (var value) => new shelf.Response.ok (JSON.encode(value));
_okJSONIterableResponse (Iterable value) =>
  new shelf.Response.ok (JSON.encode(value.toList(growable: false)));