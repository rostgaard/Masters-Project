part of libtcc.base;

class TestCaseService {

  WebService _backend = null;
  Uri        _host;


  TestCaseService (Uri this._host, this._backend);

  /**
   * Gets config.
   */
  Future<Configuration> getConfig() {
    Uri uri = Uri.parse('${this._host}/configuration');

    return this._backend.get (uri)
      .then((String response)
        => new Configuration.fromMap(JSON.decode(response)));
  }

  /**
   * Gets [UseCase].
   */
  Future<UseCase> getUseCase(String name) {
    Uri uri = Uri.parse('${this._host}/usecase/$name');

    return this._backend.get (uri)
      .then((String response)
        => new UseCase.fromMap(JSON.decode(response)));
  }


  /**
   * Gets all [UseCase].
   */
  Future<Iterable<UseCase>> getUseCases() {
    Uri uri = Uri.parse('${this._host}/usecase');

    return this._backend.get (uri)
      .then(JSON.decode)
        .then((Iterable<Map> maps) =>
          maps.map((Map map) =>
            new UseCase.fromMap(JSON.decode(map))));
  }

  /**
   * Gets all [Actor].
   */
  Future<Iterable<Actor>> getActors() {
    Uri uri = Uri.parse('${this._host}/actor');

    return this._backend.get (uri)
      .then(JSON.decode)
        .then((Iterable<Map> maps) =>
          maps.map((Map map) =>
            new Actor.fromMap(JSON.decode(map))));
  }

  /**
   * Gets [Actor].
   */
  Future<Actor> getActor(String name) {
    Uri uri = Uri.parse('${this._host}/actor/$name');

    return this._backend.get (uri)
      .then((String response)
        => new Actor.fromMap(JSON.decode(response)));
  }

  /**
   * Saves config.
   */
  Future saveConfig(Configuration config) {
    Uri uri = Uri.parse('${this._host}/configuration');

    return this._backend.put(uri, JSON.encode(config));
  }

}
/**
 * Superclass for abstracting away the griddy details of
 * client/server-specific web-clients.
 *
 * TODO:
 *   -Add reason for the exception. Should be carried in 'message'
 *    or 'error' field from the server.
 */
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