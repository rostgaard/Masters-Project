part of tcc.service.controller;

class TestTemplate {

  shelf.Response get (shelf.Request request) => throw new UnimplementedError();

  shelf.Response list (shelf.Request request) {
    List<IO.FileSystemEntity> files = new IO.Directory ('${ServiceConfiguration.templateDir}').listSync();

    String result = JSON.encode(files.map((IO.FileSystemEntity f) =>
      f.path.substring(ServiceConfiguration.templateDir.length+1,f.path.length-5)).toList());

    return new shelf.Response.ok (result);
  }

  shelf.Response create (shelf.Request request) => throw new UnimplementedError();

  shelf.Response update (shelf.Request request) => throw new UnimplementedError();

}