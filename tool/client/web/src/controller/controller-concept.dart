part of tcc.client.controller;

/**
 * Concept controller
 */
class Concept {

  final libtcc.TestCaseService _service;
  final model.UINotification _uiNotification;
  final Logger log = new Logger ('$libraryName.Concept');

  /**
   * Default constructor.
   */
  Concept(this._service, this._uiNotification);

  /**
   *
   */
  Future create (libtcc.Concept concept) =>
     _service.addConcept(concept)
    .then((_) => _notify ('Concept added'))
    .catchError(_logAndNotify);

  /**
   *
   */
  Future remove (libtcc.Concept concept) =>
     _service.removeConcept(concept)
    .then((_) => _notify ('Concept removed'))
    .catchError(_logAndNotify);


  /**
   *
   */
  Future<Iterable<libtcc.Concept>> list () =>
    _service.getConcepts();

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
    log.severe(message, error, StackTrace);
    _uiNotification.addError('$message. Got: $error');
  }
}
