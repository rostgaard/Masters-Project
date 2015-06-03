library httpclient;

import 'dart:async';
import 'dart:html' as HTML;

import 'package:logging/logging.dart';

/**
 * HTTP Client for use with dart:html.
 */
class HttpClient {

  Logger log = new Logger('httpclient');

  /**
   * Retrives [resource] using HTTP GET.
   * Throws subclasses of [StorageException] upon failure.
   */
  Future<String> get(Uri resource) {
    final Completer<String> completer = new Completer<String>();

    log.finest("GET $resource");

    HTML.HttpRequest request;
    request = new HTML.HttpRequest()
        ..open('GET', resource.toString())
        ..onLoad.listen((_) {
          try {
            WebService.checkResponse(
                request.status,
                'GET',
                resource,
                request.responseText);
            completer.complete(request.responseText);
          } catch (error) {
            completer.completeError(error);
          }
        })
        ..onError.listen((e) => completer.completeError(e))
        ..send();

    return completer.future;
  }

  /**
   * Retrives [resource] using HTTP PUT, sending [payload].
   * Throws subclasses of [StorageException] upon failure.
   */
  Future<String> put(Uri resource, String payload) {
    final Completer<String> completer = new Completer<String>();

    log.finest("PUT $resource");

    HTML.HttpRequest request;
    request = new HTML.HttpRequest()
        ..open('PUT', resource.toString())
        ..onLoad.listen((_) {
          try {
            WebService.checkResponse(
                request.status,
                'PUT',
                resource,
                request.responseText);
            completer.complete(request.responseText);
          } catch (error) {
            completer.completeError(error);
          }
        })
        ..onError.listen((e) => completer.completeError(e))
        ..send(payload);

    return completer.future;
  }

  /**
   * Retrives [resource] using HTTP POST, sending [payload].
   * Throws subclasses of [StorageException] upon failure.
   */
  Future<String> post(Uri resource, String payload) {
    final Completer<String> completer = new Completer<String>();

    log.finest("POST $resource");

    HTML.HttpRequest request;
    request = new HTML.HttpRequest()
        ..open('POST', resource.toString())
        ..onLoad.listen((_) {
          try {
            WebService.checkResponse(
                request.status,
                'GET',
                resource,
                request.responseText);
            completer.complete(request.responseText);
          } catch (error) {
            completer.completeError(error);
          }
        })
        ..onError.listen((e) => completer.completeError(e))
        ..send(payload);

    return completer.future;
  }

  /**
   * Retrives [resource] using HTTP DELETE.
   * Throws subclasses of [StorageException] upon failure.
   */
  Future<String> delete(Uri resource) {
    final Completer<String> completer = new Completer<String>();

    log.finest("DELETE $resource");

    HTML.HttpRequest request;
    request = new HTML.HttpRequest()
        ..open('DELETE', resource.toString())
        ..onLoad.listen((_) {
          try {
            WebService.checkResponse(
                request.status,
                'DELETE',
                resource,
                request.responseText);
            completer.complete(request.responseText);
          } catch (error) {
            completer.completeError(error);
          }
        })
        ..onError.listen((e) => completer.completeError(e))
        ..send();

    return completer.future;
  }
}

abstract class WebService {

  static const String GET    = 'GET';
  static const String PUT    = 'PUT';
  static const String POST   = 'POST';
  static const String DELETE = 'DELETE';

  Future<String> get    (Uri path);
  Future<String> put    (Uri path, String payload);
  Future<String> post   (Uri path, String payload);
  Future<String> delete (Uri path);

  static void checkResponse(int responseCode,String method,
                            Uri path, String response) {
    switch (responseCode) {
      case 200:
        break;

      case 400:
        throw new ClientError ('$method $path - $response');
        break;

      case 401:
        throw new NotAuthorized ('$method  $path - $response');
        break;

      case 403:
        throw new Forbidden ('$method $path - $response');
        break;

      case 409:
        throw new Conflict ('$method $path - $response');
        break;

      case 404:
       throw new NotFound('$method  $path - $response');
       break;

      case 500:
        throw new ServerError('$method  $path - $response');
        break;

      default:
        throw new StateError('Status (${responseCode}): $method $path - $response');
    }
  }
}


class StorageException implements Exception {}

class NotFound implements StorageException {

  final String message;
  const NotFound([this.message = ""]);

  String toString() => "NotFound: $message";
}


class SaveFailed implements StorageException {

  final String message;
  const SaveFailed([this.message = ""]);

  String toString() => "SaveFailed: $message";
}

class Forbidden implements StorageException {

  final String message;
  const Forbidden([this.message = ""]);

  String toString() => "Forbidden: $message";
}

class Conflict implements StorageException {

  final String message;
  const Conflict([this.message = ""]);

  String toString() => "Conflict: $message";
}


class NotAuthorized implements StorageException {

  final String message;
  const NotAuthorized([this.message = ""]);

  String toString() => "NotAuthorized: $message";
}

class ClientError implements StorageException {

  final String message;
  const ClientError([this.message = ""]);

  String toString() => "ClientError: $message";
}

class ServerError implements StorageException {

  final String message;
  const ServerError([this.message = ""]);

  String toString() => "ServerError: $message";
}
