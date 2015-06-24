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
  shelf.Response list (shelf.Request request) =>
    _usecaseStore.list().then(_okJSONIterableResponse);

  /**
   * Create a new use case.
   */
  Future<shelf.Response> create (shelf.Request request) {
    String name = shelf_route.getPathParameter(request, 'name');

    IO.File file = new IO.File ('$_jsonStorePath/$name.json');
    file.createSync();


    return request.readAsString().then((String body) {
      file.writeAsStringSync(body);
      return new shelf.Response.ok ('ok');
    });
  }

  /**
   * Update an existing use case
   */
  Future<shelf.Response> update (shelf.Request request) {
    String name = shelf_route.getPathParameter(request, 'name');

    IO.File file = new IO.File ('$_jsonStorePath/$name.json');

    return request.readAsString().then(file.writeAsString).then((_) => new shelf.Response.ok ('ok'));
  }

  /**
   * Remove an existing use case.
   */
  Future<shelf.Response> remove (shelf.Request request) {
    String name = shelf_route.getPathParameter(request, 'name');

    IO.File file = new IO.File ('$_jsonStorePath/$name.json');
    return  file.delete().then((_) => new shelf.Response.ok ('ok'));
  }
}