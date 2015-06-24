part of tcc.service.controller;

class Config {

  final Logger log = new Logger('$libraryName.Config');

  final Database.Config _configStore;

  /**
   * Default constructor.
   */
  Config(this._configStore);

  /**
   * Loads and serialized a [Configuration] object.
   */
  Future<shelf.Response> get (shelf.Request request) =>
    _configStore.load().then((Model.Configuration config) =>
      new shelf.Response.ok (JSON.encode(config)));


  /**
   * Saves the config
   */
  Future<shelf.Response> save (shelf.Request request) =>
   request.readAsString()
     .then(JSON.decode)
     .then(Model.Configuration.decode)
     .then(_configStore.save)
     .then(_okJSONResponse);
}