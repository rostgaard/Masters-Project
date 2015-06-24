part of tcc.service.controller;

class Actor {

  String _jsonStorePath = '/tmp/json';

  shelf.Response dummy (shelf.Request request) {

    return new shelf.Response.ok (JSON.encode(Model.useCase1));
  }

  Future<shelf.Response> get (shelf.Request request) {
    int conceptID = int.parse(shelf_route.getPathParameter(request, 'id'));

    return new shelf.Response.ok (JSON.encode('{}'));
  }

  shelf.Response list (shelf.Request request) {
    List<IO.FileSystemEntity> files = new IO.Directory ('$_jsonStorePath').listSync();

    String result = JSON.encode(files.map((IO.FileSystemEntity f) =>
      f.path.substring(_jsonStorePath.length+1,f.path.length-5)).toList());

    return new shelf.Response.ok (result);
  }

  Future<shelf.Response> create (shelf.Request request) {
    String name = shelf_route.getPathParameter(request, 'name');

    IO.File file = new IO.File ('$_jsonStorePath/$name.json');
    file.createSync();


    return request.readAsString().then((String body) {
      file.writeAsStringSync(body);
      return new shelf.Response.ok ('ok');
    });
  }

  Future<shelf.Response> update (shelf.Request request) {
    String name = shelf_route.getPathParameter(request, 'name');

    IO.File file = new IO.File ('$_jsonStorePath/$name.json');

    return request.readAsString().then(file.writeAsString).then((_) => new shelf.Response.ok ('ok'));
  }

  Future<shelf.Response> remove (shelf.Request request) {
    String name = shelf_route.getPathParameter(request, 'name');

    IO.File file = new IO.File ('$_jsonStorePath/$name.json');
    return  file.delete().then((_) => new shelf.Response.ok ('ok'));
  }
}