part of tcc.service.controller;

class Test {

  final Database.UseCase _useCaseStore;
  final Database.Template _templateStore;
  final Database.Concept _conceptStore;
  final Database.Config  _configStore;

  Test(this._useCaseStore, this._templateStore, this._conceptStore, this._configStore);

  shelf.Response analyse (shelf.Request request) => throw new UnimplementedError();

  shelf.Response get (shelf.Request request) => throw new UnimplementedError();

  shelf.Response list (shelf.Request request) => throw new UnimplementedError();

  shelf.Response update (shelf.Request request) => throw new UnimplementedError();

  /**
   * TODO: Add definitionStore.
   */
  Future<shelf.Response> generate (shelf.Request request) async {
    final int ucID = int.parse(shelf_route.getPathParameter(request, 'id'));
    final int tplID = int.parse(shelf_route.getPathParameter(request, 'tplid'));

    Model.UseCase uc = await this._useCaseStore.get(ucID);
    Model.TestTemplate tpl = await this._templateStore.get(tplID);
    Iterable<Concept> concepts = await this._conceptStore.listAll();
    Model.Definitions definitions = new Model.Definitions(concepts);
    Model.Configuration config = await this._configStore.load();

    if (!tpl.body.contains('/*[@USECASES@]*/')) {
      return new shelf.Response.internalServerError
          (body : 'No placeholder in template');
    }

    Model.GeneratedTest genTest = new Model.GeneratedTest(uc, definitions, tpl);

    final String filename = '${config.testLocation}/${uc.id}.dart';
    /// Analyze the test.
    new IO.File (filename).writeAsStringSync(genTest.testBody);

    return IO.Process.start(config.analyzerLocation, [filename], workingDirectory : config.testLocation).then((process) {
      process.stdout.transform(UTF8.decoder).transform(new LineSplitter()).listen((String line) {
        genTest.analysisOutput.add('(output): ${line}');
      });
      process.stderr.transform(UTF8.decoder).transform(new LineSplitter()).listen((String line) {
        genTest.analysisOutput.add('(errors): ${line}');
      });

      return process.exitCode.then((_) => new shelf.Response.ok (JSON.encode(genTest)));
    });
  }

}