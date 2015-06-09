part of tcctool.router;

class Config {

  final String _jsonStorePath = fileStore;
  final Logger log = new Logger('$libraryName.Config');

  Future<shelf.Response> get (shelf.Request request) {
    IO.File file = new IO.File ('$_jsonStorePath/config.json');

    if(!file.existsSync()) {
      new shelf.Response.notFound('No config found');
    }

    return file.readAsString().then((String result) =>
      new shelf.Response.ok (result));
  }

  Future<shelf.Response> update (shelf.Request request) {
    IO.File file = new IO.File ('$_jsonStorePath/config.json');
    file.createSync();

    return request.readAsString().then(file.writeAsString).then((_) => new shelf.Response.ok ('ok'));
  }

}