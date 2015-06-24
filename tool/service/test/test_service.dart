library tcc.service.test;

import 'dart:async';
import 'dart:convert';
import 'dart:io' show HttpStatus;

import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf_path/shelf_path.dart';
import 'package:unittest/unittest.dart';

import 'package:libtcc/libtcc.dart' as Model;
import '../lib/router.dart';

part 'src/service-concept_role.dart';

const String GET = 'GET';
const String POST = 'POST';
const String PUT = 'PUT';

/**
 * Create a dummy Shelf.Request object.
 */
shelf.Request createRequest(String method, String path, {String body: ''}) {
  return new shelf.Request(method, Uri.parse('http://localhost${path}'),
      body: new Stream.fromFuture(new Future.value(UTF8.encode(body))));
}

main() {
  start().then((_) {
    testConceptRole();
//    group('Testing unknown route', () {
//      test('GET /unknown -> return 404 Not Found', () {
//        shelf.Request request = createRequest(GET, '/unknown');
//        shelf.Response response = router.handler(request);
//
//        expect(response.statusCode, equals(HttpStatus.NOT_FOUND));
//      });
//
//      test('PUT /user/1 -> return 404 Not Found', () {
//        shelf.Request request = createRequest(PUT, '/user/1');
//        request = addPathParameters(request, {'userid': '1'});
//        shelf.Response response = router.handler(request);
//
//        expect(response.statusCode, equals(HttpStatus.NOT_FOUND));
//      });
//
//      test('POST /user/1/name -> return 404 Not Found', () {
//        shelf.Request request = createRequest(POST, '/user/1/name',
//            body: '{"name":"New Thomas LÃ¸cke"}');
//        request = addPathParameters(request, {'userid': '1'});
//        shelf.Response response = router.handler(request);
//
//        expect(response.statusCode, equals(HttpStatus.NOT_FOUND));
//      });
//    });
//
//    group('Testing route', () {
//      test('GET /user/42 -> return 404 Not Found', () {
//        shelf.Request request = createRequest(GET, '/user/42');
//        request = addPathParameters(request, {'userid': '42'});
//
//        expect(() => router.handler(request),
//            throwsA(new isInstanceOf<Exception>()));
//      });
//
//      test('GET /user/ZZZ -> return 400 Bad Request', () {
//        shelf.Request request = createRequest(GET, '/user/ZZZ');
//        request = addPathParameters(request, {'userid': 'ZZZ'});
//
//        expect(() => router.handler(request),
//            throwsA(new isInstanceOf<Exception>()));
//      });
//
//      test(
//          'GET /user/1 -> return 200 OK and output {"id":1,"name":"Thomas LÃ¸cke"}',
//          () {
//        shelf.Request request = createRequest(GET, '/user/1');
//        request = addPathParameters(request, {'userid': '1'});
//        shelf.Response response = router.handler(request);
//
//        expect(response.statusCode, equals(HttpStatus.OK));
//        expect(response.readAsString(),
//            completion(equals('{"id":1,"name":"Thomas LÃ¸cke"}')));
//      });
//
//      test('PUT /user/42/name -> return 404 Not Found', () {
//        shelf.Request request =
//            createRequest(PUT, '/user/42/name', body: '{"name":"42"}');
//        request = addPathParameters(request, {'userid': '42'});
//
//        router
//            .handler(request)
//            .then((_) => fail('did not raise a NotFoundException as expected'))
//            .catchError((error) {
//          expect(error, equals(new isInstanceOf<Exception>()));
//        });
//      });
//
//      test('PUT /user/ZZZ/name -> return 400 Bad Request', () {
//        shelf.Request request =
//            createRequest(PUT, '/user/ZZZ/name', body: '{"name":"ZZZ"}');
//        request = addPathParameters(request, {'userid': 'ZZZ'});
//
//        router
//            .handler(request)
//            .then(
//                (_) => fail('did not raise a BadRequestException as expected'))
//            .catchError((error) {
//          expect(error, equals(new isInstanceOf<Exception>()));
//        });
//      });
//
//      test('PUT /user/1/name with missing name key -> return 400 Bad Request',
//          () {
//        shelf.Request request =
//            createRequest(PUT, '/user/1/name', body: '{"":"missing name key"}');
//        request = addPathParameters(request, {'userid': '1'});
//
//        router
//            .handler(request)
//            .then(
//                (_) => fail('did not raise a BadRequestException as expected'))
//            .catchError((error) {
//          expect(error, equals(new isInstanceOf<Exception>()));
//        });
//      });
//
//      test('PUT /user/1/name with empty name value -> return 400 Bad Request',
//          () {
//        shelf.Request request =
//            createRequest(PUT, '/user/1/name', body: '{"name":""}');
//        request = addPathParameters(request, {'userid': '1'});
//
//        router
//            .handler(request)
//            .then(
//                (_) => fail('did not raise a BadRequestException as expected'))
//            .catchError((error) {
//          expect(error, equals(new isInstanceOf<Exception>()));
//        });
//      });
//
//      test('PUT /user/1/name with malformed body -> return 400 Bad Request',
//          () {
//        shelf.Request request =
//            createRequest(PUT, '/user/1/name', body: 'malformed!');
//        request = addPathParameters(request, {'userid': '1'});
//
//        router
//            .handler(request)
//            .then(
//                (_) => fail('did not raise a BadRequestException as expected'))
//            .catchError((error) {
//          expect(error, equals(new isInstanceOf<Exception>()));
//        });
//      });
//
//      test(
//          'PUT /user/1/name -> return 200 OK and output {"id":1,"name":"New Thomas LÃ¸cke"}',
//          () {
//        shelf.Request request = createRequest(PUT, '/user/1/name',
//            body: '{"name":"New Thomas LÃ¸cke"}');
//        request = addPathParameters(request, {'userid': '1'});
//
//        router.handler(request).then((shelf.Response response) {
//          expect(response.statusCode, equals(HttpStatus.OK));
//          expect(response.readAsString(),
//              completion(equals('{"id":1,"name":"New Thomas LÃ¸cke"}')));
//        });
//      });
//    });
  });
}
