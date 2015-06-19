part of tcctool.router;

class Concept {
  String _jsonStorePath = '/tmp/json';

  final Database.Concept conceptStore;

  Concept(this.conceptStore);

  /**
   *
   */
  Future<shelf.Response> get(shelf.Request request) {
    final int conceptID =
        int.parse(shelf_route.getPathParameter(request, 'id'));

    return conceptStore.get(conceptID).then(
        (Model.Concept concept) => new shelf.Response.ok(JSON.encode(concept)));
  }

  /**
   *
   */
  Future<shelf.Response> list(shelf.Request request) {
    return conceptStore.list().then((Iterable<Model.Concept> concept) =>
        new shelf.Response.ok(JSON.encode(concept.toList(growable: false))));
  }
  /**
   *
   */
  Future<shelf.Response> create(shelf.Request request) {
    return request.readAsString().then((String content) {
      Model.Concept concept = new Model.Concept.fromJson(JSON.decode(content));

      return conceptStore.create(concept).then((Model.Concept concept) =>
          new shelf.Response.ok(JSON.encode(concept)));
    });
  }

  /**
   *
   */
  Future<shelf.Response> update(shelf.Request request) {
    final int conceptID =
        int.parse(shelf_route.getPathParameter(request, 'id'));

    return request.readAsString().then((String content) {
      Model.Concept concept = new Model.Concept.fromJson(JSON.decode(content))
        ..id = conceptID;

      return conceptStore.update(concept).then((Model.Concept concept) =>
          new shelf.Response.ok(JSON.encode(concept)));
    });
  }

  /**
   *
   */
  Future<shelf.Response> remove(shelf.Request request) {
    final int conceptID =
        int.parse(shelf_route.getPathParameter(request, 'id'));

    return conceptStore.remove(conceptID).then(
        (Model.Concept concept) => new shelf.Response.ok(JSON.encode({})));
  }
}
