part of tcc.service.controller;

class UseCase {

  final Logger log = new Logger('$libraryName.UseCase');

  final Database.UseCase _usecaseStore;

  UseCase (this._usecaseStore);

  /**
   * Retrieve a single use case
   */
  Future<shelf.Response> get (shelf.Request request) {
    int id = int.parse(shelf_route.getPathParameter(request, 'id'));

    return _usecaseStore.get(id).then(_okJSONResponse);
  }

  /**
   * Retrieve a list of available use cases
   */
  Future<shelf.Response> list (shelf.Request request) =>
    _usecaseStore.list().then(_okJSONIterableResponse);

  /**
   * Create a new use case.
   */
  Future<shelf.Response> create (shelf.Request request) =>
    request.readAsString()
    .then(JSON.decode)
    .then(Model.UseCase.decode)
    .then(_usecaseStore.create)
    .then(_okJSONResponse);

  /**
   * Update an existing use case
   */
  Future<shelf.Response> update (shelf.Request request) =>
      request.readAsString()
      .then(JSON.decode)
      .then(Model.UseCase.decode)
      .then(_usecaseStore.update)
      .then(_okJSONResponse);

  /**
   * Remove an existing use case.
   */
  Future<shelf.Response> remove (shelf.Request request) =>
      _usecaseStore.remove(int.parse(shelf_route.getPathParameter(request, 'id')))
      .then(_okJSONEmptyResponse);
}