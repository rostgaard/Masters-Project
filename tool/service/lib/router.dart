library tcctool.router;

import 'dart:async';
import 'dart:convert';

import 'dart:io' as IO;

import 'package:logging/logging.dart';

import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_route/shelf_route.dart' as shelf_route;
import 'package:shelf_cors/shelf_cors.dart' as shelf_cors;
import 'tcc.dart';

part 'handler-actor.dart';

const String libraryName = 'tcctool.router';
final Logger log = new Logger (libraryName);

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
  Actor actorHandler = new Actor();


  var router = shelf_route.router()
    ..get('/actor', actorHandler.list)
    ..get('/dummy', actorHandler.dummy)
    ..get('/actor/{name}', actorHandler.get)
    ..put('/actor/{name}', actorHandler.update)
    ..post('/actor/{name}', actorHandler.create)
    ..delete('/actor/{name}', actorHandler.remove);
  var handler = const shelf.Pipeline()
      .addMiddleware(shelf_cors.createCorsHeadersMiddleware(corsHeaders : corsHeaders))
      .addMiddleware(shelf.logRequests(logger : _accessLogger))
      .addHandler(router.handler);

  log.fine('Serving interfaces:');
  shelf_route.printRoutes(router, printer : log.fine);

  return shelf_io.serve(handler, hostname, port);
}
