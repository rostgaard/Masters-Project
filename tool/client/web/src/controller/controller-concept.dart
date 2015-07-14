part of tcc.client.controller;

/**
 * Concept controller
 */
class Concept {
  final libtcc.TestCaseService _service;
  final model.UINotification _uiNotification;
  final Logger _log = new Logger('$libraryName.Concept');

  /**
   * Default constructor.
   */
  Concept(this._service, this._uiNotification);

  /**
   *
   */
  Future create(libtcc.Concept concept) => _service
      .addConcept(concept)
      .then((_) => _notify('Concept added'))
      .catchError((error, stackTrace) =>
          _logAndNotify('Failed to create', error, stackTrace));

  /**
   *
   */
  Future remove(libtcc.Concept concept) => _service
      .removeConcept(concept)
      .then((_) => _notify('Concept removed'))
      .catchError((error, stackTrace) =>
          _logAndNotify('Failed to remove', error, stackTrace));

  /**
   *
   */
  Future<Iterable<libtcc.Concept>> list() => _service
      .getConcepts()
      .catchError((error, stackTrace) =>
          _logAndNotify('Failed to list', error, stackTrace));

  /**
   *
   */
  void _notify(String message) {
    _uiNotification.addInfo(message);
  }

  /**
   *
   */
  void _logAndNotify(String message, error, StackTrace) {
    _log.severe(message, error, StackTrace);
    _uiNotification.addError('$message. Got: $error');
  }
}
