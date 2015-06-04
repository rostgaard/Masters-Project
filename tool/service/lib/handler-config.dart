part of tcctool.router;

class Config {

  String _jsonStorePath = '/tmp/json';

  Future<shelf.Response> get (shelf.Request request) {
    IO.File file = new IO.File ('$_jsonStorePath/config.json');

    return file.readAsString().then((String result) =>
      new shelf.Response.ok (result));
  }

  Future<shelf.Response> update (shelf.Request request) {
    IO.File file = new IO.File ('$_jsonStorePath/config.json');

    return request.readAsString().then(file.writeAsString).then((_) => new shelf.Response.ok ('ok'));
  }

}