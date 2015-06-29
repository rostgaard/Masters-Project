part of tcc.service.controller;

class TestTemplate {

  final Database.Template _templateDB;

  TestTemplate (this._templateDB);

  Future<shelf.Response> get (shelf.Request request) {
    final int tplID = int.parse(shelf_route.getPathParameter(request, 'tplid'));

    return _templateDB.get(tplID).then((Model.TestTemplate template) =>
        new shelf.Response.ok(JSON.encode(template)));
  }

  Future<shelf.Response> list (shelf.Request request) =>
    _templateDB.list().then((Iterable<Model.TestTemplate> templates) =>
        new shelf.Response.ok(JSON.encode(templates.toList(growable: false))));

  /**
   * HTTP response handler for creating a [TestTemplate] resource.
   */
  Future<shelf.Response> create (shelf.Request request) =>
    request.readAsString()
    .then(JSON.decode)
    .then(Model.TestTemplate.decode)
    .then(_templateDB.create)
    .then(_okJSONResponse);

  Future<shelf.Response> update (shelf.Request request) =>
      request.readAsString()
      .then(JSON.decode)
      .then(Model.TestTemplate.decode)
      .then(_templateDB.update)
      .then(_okJSONResponse);
}