library tcc.service.router;

import 'dart:async';

import 'dart:io' as IO;

import 'package:logging/logging.dart';

import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_route/shelf_route.dart' as shelf_route;
import 'package:shelf_cors/shelf_cors.dart' as shelf_cors;

import 'config.dart';
import 'database.dart' as Database;
import 'controller.dart' as Controller;

const String libraryName = 'tcctool.router';
final Logger log = new Logger(libraryName);

final Map corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, PUT, POST, DELETE'
};

/// Simple access logging.
void _accessLogger(String msg, bool isError) {
  if (isError) {
    log.severe(msg);
  } else {
    log.finest(msg);
  }
}

Future<shelf_route.Router> setupRouter() {
  return Database.Connection
      .connect(ServiceConfiguration.databaseDSN)
      .then((Database.Connection databaseConnection) {

    Database.Actor actorStore = new Database.Actor(databaseConnection);
    Database.Concept conceptStore = new Database.Concept(databaseConnection);
    Database.Config configStore = new Database.Config(databaseConnection);
    Database.UseCase usecaseStore = new Database.UseCase(databaseConnection);
    Database.Template templateStore = new Database.Template(databaseConnection);

    Controller.Actor actorController = new Controller.Actor(actorStore);
    Controller.Concept conceptController = new Controller.Concept(conceptStore);
    Controller.Config configController = new Controller.Config(configStore);
    Controller.Test testController =
        new Controller.Test(usecaseStore, templateStore, conceptStore, configStore);
    Controller.UseCase useCaseController = new Controller.UseCase(usecaseStore);
    Controller.TestTemplate testTemplateController =
        new Controller.TestTemplate(templateStore);

    return shelf_route.router()
      ..get('/actor', actorController.list)
      ..get('/actor/{id}', actorController.get)
      ..put('/actor/{id}', actorController.update)
      ..post('/actor', actorController.create)
      ..delete('/actor/{id}', actorController.remove)
      ..get('/concept', conceptController.list)
      ..get('/concept/{id}', conceptController.get)
      ..put('/concept/{id}', conceptController.update)
      ..post('/concept', conceptController.create)
      ..delete('/concept/{id}', conceptController.remove)
      ..get('/template', testTemplateController.list)
      ..post('/template', testTemplateController.create)
      ..get('/template/{tplid}', testTemplateController.get)
      ..put('/template/{tplid}', testTemplateController.update)
      ..get('/usecase', useCaseController.list)
      ..get('/usecase/{id}', useCaseController.get)
      ..put('/usecase/{id}', useCaseController.update)
      ..post('/usecase', useCaseController.create)
      ..delete('/usecase/{id}', useCaseController.remove)
      ..get('/usecase/{id}/generate/{tplid}', testController.generate)
      ..post('/test/{tid}/analyze', testController.analyse)
      ..get('/configuration', configController.get)
      ..put('/configuration', configController.save);
  });
}

Future<IO.HttpServer> start({String hostname: '0.0.0.0', int port: 7777}) {
  return setupRouter().then((shelf_route.Router router) {
    var pipeline = const shelf.Pipeline()
        .addMiddleware(
            shelf_cors.createCorsHeadersMiddleware(corsHeaders: corsHeaders))
        .addMiddleware(shelf.logRequests(logger: _accessLogger))
        .addHandler(router.handler);

    log.fine('Serving interfaces:');
    shelf_route.printRoutes(router, printer: log.fine);

    return shelf_io.serve(pipeline, hostname, port);
  });
}
