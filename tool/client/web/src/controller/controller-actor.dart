part of tcc.client.controller;

/**
 * Actor controller
 */
class Actor {

  final libtcc.TestCaseService _service;
  final model.UINotification _uiNotification;
  final Logger _log = new Logger ('$libraryName.Actor');

  /**
   * Default constructor.
   */
  Actor(this._service, this._uiNotification);

  /**
   *
   */
  Future<libtcc.Actor> create (libtcc.Actor actor) =>
     _service.createActor(actor)
    .then((_) => _notify ('Actor $actor added'))
    .catchError(_logAndNotify);

  /**
   *
   */
  Future<libtcc.Actor> update (libtcc.Actor actor) =>
     _service.updateActor(actor)
    .then((_) => _notify ('Actor $actor added'))
    .catchError(_logAndNotify);

  /**
   *
   */
  Future remove (libtcc.Actor actor) =>
     _service.removeActor(actor)
    .then((_) => _notify ('Actor removed'))
    .catchError(_logAndNotify);


  /**
   *
   */
  Future<Iterable<libtcc.Actor>> list () =>
    _service.getActors();

  /**
   *
   */
  Future<libtcc.Actor> get (int actorID) =>
    _service.getActor(actorID);

  /**
   *
   */
  void _notify(String message) {
    _uiNotification.addInfo(message);
  }

  /**
   *
   */
  void _logAndNotify (String message, error, StackTrace) {
    _log.severe(message, error, StackTrace);
    _uiNotification.addError('$message. Got: $error');
  }
}
