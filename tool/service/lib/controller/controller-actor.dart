part of tcc.service.controller;

/**
 * Request handlers responsible for fetching and manipulating Actor objects.
 */
class Actor {

  final Database.Actor _actorStore;

  Actor(this._actorStore);

  /**
   *
   */
  Future<shelf.Response> get(shelf.Request request) {
    final int actorID =
        int.parse(shelf_route.getPathParameter(request, 'id'));

    return _actorStore.get(actorID).then(
        (Model.Actor actor) => new shelf.Response.ok(JSON.encode(actor)));
  }

  /**
   *
   */
  Future<shelf.Response> list(shelf.Request request) {
    return _actorStore.list().then((Iterable<Model.Actor> actor) =>
        new shelf.Response.ok(JSON.encode(actor.toList(growable: false))));
  }
  /**
   *
   */
  Future<shelf.Response> create(shelf.Request request) {
    return request.readAsString().then((String content) {
      Model.Actor actor = new Model.Actor.fromMap(JSON.decode(content));

      return _actorStore.create(actor).then((Model.Actor actor) =>
          new shelf.Response.ok(JSON.encode(actor)));
    });
  }

  /**
   *
   */
  Future<shelf.Response> update(shelf.Request request) {
    final int actorID =
        int.parse(shelf_route.getPathParameter(request, 'id'));

    return request.readAsString().then((String content) {
      Model.Actor actor = new Model.Actor.fromMap(JSON.decode(content))
        ..id = actorID;

      return _actorStore.update(actor).then((Model.Actor actor) =>
          new shelf.Response.ok(JSON.encode(actor)));
    });
  }

  /**
   *
   */
  Future<shelf.Response> remove(shelf.Request request) {
    final int actorID =
        int.parse(shelf_route.getPathParameter(request, 'id'));

    return _actorStore.remove(actorID).then(
        (Model.Actor actor) => new shelf.Response.ok(JSON.encode({})));
  }
}