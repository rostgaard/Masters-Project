part of tcc.service.controller;

class Test {

  String _jsonStorePath = '/tmp/json';

  final Database.UseCase _useCaseStore;
  final Database.Template _templateStore;

  Test(this._useCaseStore, this._templateStore);

  shelf.Response analyse (shelf.Request request) => throw new UnimplementedError();

  shelf.Response get (shelf.Request request) => throw new UnimplementedError();

  shelf.Response list (shelf.Request request) => throw new UnimplementedError();

  shelf.Response update (shelf.Request request) => throw new UnimplementedError();

  Future<shelf.Response> generate (shelf.Request request) {
    final int ucID = int.parse(shelf_route.getPathParameter(request, 'id'));
    final int tplID = int.parse(shelf_route.getPathParameter(request, 'tplid'));

    return this._useCaseStore.get(ucID).then((UseCase uc) =>
      this._templateStore.get(tplID)
      .then((Template tpl) {


      return new shelf.Response.ok (libtcc.useCasesToCode(buc1, defs, template));
    }));


  }

}