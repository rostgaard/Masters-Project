library tcctool.router;

import 'dart:async';
import 'dart:convert';

import 'dart:io' as IO;

import 'package:logging/logging.dart';
import 'package:libtcc/libtcc.dart' as Model;

import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_route/shelf_route.dart' as shelf_route;
import 'package:shelf_cors/shelf_cors.dart' as shelf_cors;

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

const String fileStore = '/home/krc/DTU/Masters-Project/tool/examples';

final Map corsHeaders =
  {'Access-Control-Allow-Origin': '*' ,
   'Access-Control-Allow-Methods' : 'GET, PUT, POST, DELETE'};


/// Simple access logging.
void _accessLogger(String msg, bool isError) {
  if (isError) {
    log.severe(msg);
  } else {
    log.finest(msg);
  }
}


Future<IO.HttpServer> start({String hostname : '0.0.0.0', int port : 7777}) {

  return Database.Connection.connect(ServiceConfiguration.databaseDSN)
    .then((Database.Connection databaseConnection) {

    Database.Concept conceptStore = new Database.Concept(databaseConnection);

    Actor actorController = new Actor();
    Concept conceptController = new Concept(conceptStore);
    Config configController = new Config();
    Test testController = new Test();
    UseCase useCaseController = new UseCase();
    TestTemplate testTemplateController = new TestTemplate();


    var router = shelf_route.router()
      ..get('/actor', actorController.list)
      ..get('/dummy', actorController.dummy)
      ..get('/actor/{id}', actorController.get)
      ..put('/actor/{id}', actorController.update)
      ..post('/actor/{name}', actorController.create)
      ..delete('/actor/{name}', actorController.remove)

      ..get('/concept', conceptController.list)
      ..get('/concept/{id}', conceptController.get)
      ..put('/concept/{id}', conceptController.update)
      ..post('/concept', conceptController.create)
      ..delete('/concept/{id}', conceptController.remove)

      ..get('/test/template', testTemplateController.list)
      ..post('/test/template', testTemplateController.create)
      ..get('/test/template/{tplid}', testTemplateController.get)
      ..put('/test/template{tplid}', testTemplateController.update)
      ..get('/usecase', useCaseController.list)
      ..get('/usecase/{name}', useCaseController.get)
      ..put('/usecase/{name}', useCaseController.update)
      ..post('/usecase/{name}', useCaseController.create)
      ..delete('/usecase/{name}', useCaseController.remove)
      ..post('/test/{tid}/analyse', testController.analyse)
      ..get('/configuration', configController.get)
      ..put('/configuration', configController.update);

    var pipeline = const shelf.Pipeline()
        .addMiddleware(shelf_cors.createCorsHeadersMiddleware(corsHeaders : corsHeaders))
        .addMiddleware(shelf.logRequests(logger : _accessLogger))
        .addHandler(router.handler);

    log.fine('Serving interfaces:');
    shelf_route.printRoutes(router, printer : log.fine);

    return shelf_io.serve(pipeline, hostname, port);
  });



}
