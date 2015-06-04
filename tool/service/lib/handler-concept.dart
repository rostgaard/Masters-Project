part of tcctool.router;

class Concepts {

  String _jsonStorePath = '/tmp/json';

  Future<shelf.Response> get (shelf.Request request) {
    String name = shelf_route.getPathParameter(request, 'name');

    IO.File file = new IO.File ('$_jsonStorePath/$name.json');

    return file.readAsString().then((String result) =>
      new shelf.Response.ok (result));
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