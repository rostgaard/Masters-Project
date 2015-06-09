part of tcctool.router;

class UseCase {

  final String _jsonStorePath = '$fileStore/usecases';
  final Logger log = new Logger('$libraryName.UseCase');

  /**
   * Retrieve a single use case
   */
  Future<shelf.Response> get (shelf.Request request) {
    String name = shelf_route.getPathParameter(request, 'name');

    IO.File file = new IO.File ('$_jsonStorePath/$name.json');

    log.fine('Sending file: ${file.path}');

    return file.readAsString().then((String result) =>
      new shelf.Response.ok (result));
  }

  /**
   * Retrieve a list of available use cases
   */
  shelf.Response list (shelf.Request request) {
    List<IO.FileSystemEntity> files = new IO.Directory ('$_jsonStorePath').listSync();

    String result = JSON.encode(files.map((IO.FileSystemEntity f) =>
      f.path.substring(_jsonStorePath.length+1,f.path.length-5)).toList());

    return new shelf.Response.ok (result);
  }

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