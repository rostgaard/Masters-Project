library tcc.httpclient;

import 'dart:async';
import 'dart:html' as HTML;
import 'package:libtcc/libtcc.dart' as libtcc;

import 'package:logging/logging.dart';

/**
 * HTTP Client for use with dart:html.
 */
class HttpClient extends libtcc.WebService{

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
            libtcc.WebService.checkResponse(
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
            libtcc.WebService.checkResponse(
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
            libtcc.WebService.checkResponse(
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
            libtcc.WebService.checkResponse(
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

