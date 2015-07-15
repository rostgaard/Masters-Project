part of libtcc.base;

class TestCaseService {
  WebService _backend = null;
  Uri _host;

  TestCaseService(Uri this._host, this._backend);

  /// Conversion functions.
  Concept _mapToConcept(Map map) => new Concept.fromMap(map);
  Iterable<Map> _mapsToConcept(Iterable<Map> maps) => maps.map(_mapToConcept);

  /**
   * Generate a test from a template.
   */
  Future<GeneratedTest> generateTest (int useCaseId, int templateId) {
    Uri uri = Uri.parse('${this._host}/usecase/$useCaseId/generate/$templateId');

    return this._backend
        .get(uri)
        .then(JSON.decode)
        .then(GeneratedTest.decode);
  }

  /**
   * Gets actor
   */
  Future<Actor> getActor(int actorID) {
    Uri uri = Uri.parse('${this._host}/usecase/$actorID');

    return this._backend
        .get(uri)
        .then(JSON.decode)
        .then(Actor.decode);
  }

  /**
   * Lists actors.
   */
  Future<Iterable<Actor>> getActors() {
    Uri uri = Uri.parse('${this._host}/actor');

    Iterable<UseCase> decodeList (Iterable<Map> maps ) =>
        maps.map(Actor.decode);

    return this._backend
        .get(uri)
        .then(JSON.decode)
        .then(decodeList);
  }

  /**
   * Create actor.
   */
  Future<UseCase> createActor(Actor actor) {
    Uri uri = Uri.parse('${this._host}/actor');

    return this._backend
        .post(uri, JSON.encode(actor))
        .then(JSON.decode)
        .then(Actor.decode);
  }

  /**
   * Update actor.
   */
  Future<Actor> updateActor(Actor actor) {
    Uri uri = Uri.parse('${this._host}/actor/${actor.id}');

    return this._backend
        .put(uri, JSON.encode(actor))
        .then(JSON.decode)
        .then(Actor.decode);
  }

  /**
   * Remove actor.
   */
  Future removeActor(Actor actor) {
    Uri uri = Uri.parse('${this._host}/actor/${actor.id}');

    return this._backend.delete(uri);
  }

  /**
   * Gets use case
   */
  Future<UseCase> getUseCase(int useCaseID) {
    Uri uri = Uri.parse('${this._host}/usecase/$useCaseID');

    return this._backend
        .get(uri)
        .then(JSON.decode)
        .then(UseCase.decode);
  }

  /**
   * Lists use cases.
   */
  Future<Iterable<UseCase>> getUseCases() {
    Uri uri = Uri.parse('${this._host}/usecase');

    Iterable<UseCase> decodeList (Iterable<Map> maps ) =>
        maps.map(UseCase.decode);

    return this._backend
        .get(uri)
        .then(JSON.decode)
        .then(decodeList);
  }

  /**
   * Create use case.
   */
  Future<UseCase> createUseCase(UseCase useCase) {
    Uri uri = Uri.parse('${this._host}/usecase');

    return this._backend
        .post(uri, JSON.encode(useCase))
        .then(JSON.decode)
        .then(UseCase.decode);
  }

  /**
   * Update use case.
   */
  Future<UseCase> updateUseCase(UseCase useCase) {
    Uri uri = Uri.parse('${this._host}/usecase/${useCase.id}');

    return this._backend
        .put(uri, JSON.encode(useCase))
        .then(JSON.decode)
        .then(UseCase.decode);
  }

  /**
   * Remove use case.
   */
  Future removeUseCase(UseCase useCase) {
    Uri uri = Uri.parse('${this._host}/usecase/${useCase.id}');

    return this._backend.delete(uri);
  }


  /**
   * Gets template.
   */
  Future<TestTemplate> getTemplate(int templateID) {
    Uri uri = Uri.parse('${this._host}/template/$templateID');

    return this._backend
        .get(uri)
        .then(JSON.decode)
        .then(TestTemplate.decode);
  }

  /**
   * Lists templates.
   */
  Future<Iterable<TestTemplate>> getTemplates() {
    Uri uri = Uri.parse('${this._host}/template');

    Iterable<TestTemplate> decodeList (Iterable<Map> maps ) =>
        maps.map(TestTemplate.decode);

    return this._backend
        .get(uri)
        .then(JSON.decode)
        .then(decodeList);
  }

  /**
   * Create template.
   */
  Future<TestTemplate> createTemplate(TestTemplate template) {
    Uri uri = Uri.parse('${this._host}/template');

    return this._backend
        .post(uri, JSON.encode(template))
        .then(JSON.decode)
        .then(TestTemplate.decode);
  }

  /**
   * Update template.
   */
  Future<TestTemplate> updateTemplate(TestTemplate template) {
    Uri uri = Uri.parse('${this._host}/template/${template.id}');

    return this._backend
        .put(uri, JSON.encode(template))
        .then(JSON.decode)
        .then(TestTemplate.decode);
  }

  /**
   * Remove template.
   */
  Future removeTemplate(TestTemplate template) {
    Uri uri = Uri.parse('${this._host}/template/${template.id}');

    return this._backend.delete(uri);
  }

  /**
   * Gets concept.
   */
  Future<Concept> getConcept(int conceptID) {
    Uri uri = Uri.parse('${this._host}/concept/$conceptID');

    return this._backend
        .get(uri)
        .then((String response) => new Concept.fromMap(JSON.decode(response)));
  }


  /**
   * Gets concepts.
   */
  Future<Iterable<Concept>> getConcepts() {
    Uri uri = Uri.parse('${this._host}/concept');

    return this._backend
        .get(uri)
        .then((String response) => _mapsToConcept(JSON.decode(response)));
  }

  /**
   * Add concept.
   */
  Future<Concept> addConcept(Concept concept) {
    Uri uri = Uri.parse('${this._host}/concept');

    return this._backend
        .post(uri, JSON.encode(concept))
        .then((String response) => _mapToConcept(JSON.decode(response)));
  }

  /**
   * Update concept.
   */
  Future<Concept> updateConcept(Concept concept) {
    Uri uri = Uri.parse('${this._host}/concept/${concept.id}');

    return this._backend
        .put(uri, JSON.encode(concept))
        .then((String response) => _mapToConcept(JSON.decode(response)));
  }

  /**
   * Delete concept.
   */
  Future removeConcept(Concept concept) {
    Uri uri = Uri.parse('${this._host}/concept/${concept.id}');

    return this._backend.delete(uri);
  }

  /**
   * Gets config.
   */
  Future<Configuration> getConfig() {
    Uri uri = Uri.parse('${this._host}/configuration');

    return this._backend.get(uri).then(
        (String response) => new Configuration.fromMap(JSON.decode(response)));
  }

  /**
   * Gets [AnalyzedUseCase].
   */
  @deprecated
  Future<AnalyzedUseCase> getAnalyzedUseCase(String name) {
    Uri uri = Uri.parse('${this._host}/usecase/$name');

    return this._backend
        .get(uri)
        .then((String response) => new AnalyzedUseCase.fromJson(JSON.decode(response)));
  }

  /**
   * Gets all [AnalyzedUseCase] names.
   */
  @deprecated
  Future<Iterable<String>> getAnalyzedUseCases() {
    Uri uri = Uri.parse('${this._host}/usecase');

    return this._backend.get(uri).then(JSON.decode);
  }

  /**
   * Gets dummy [AnalyzedUseCase].
   */
  @deprecated
  Future<AnalyzedUseCase> getDummyUseCase() {
    Uri uri = Uri.parse('${this._host}/dummy');

    return this._backend
        .get(uri)
        .then((String response) => new AnalyzedUseCase.fromJson(JSON.decode(response)));
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
  static const String GET = 'GET';
  static const String PUT = 'PUT';
  static const String POST = 'POST';
  static const String DELETE = 'DELETE';

  Future<String> get(Uri path);
  Future<String> put(Uri path, String payload);
  Future<String> post(Uri path, String payload);
  Future<String> delete(Uri path);

  static void checkResponse(
      int responseCode, String method, Uri path, String response) {
    switch (responseCode) {
      case 200:
        break;

      case 400:
        throw new ClientError('$method $path - $response');
        break;

      case 401:
        throw new NotAuthorized('$method  $path - $response');
        break;

      case 403:
        throw new Forbidden('$method $path - $response');
        break;

      case 409:
        throw new Conflict('$method $path - $response');
        break;

      case 404:
        throw new NotFound('$method  $path - $response');
        break;

      case 500:
        throw new ServerError('$method  $path - $response');
        break;

      default:
        throw new StateError(
            'Status (${responseCode}): $method $path - $response');
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
