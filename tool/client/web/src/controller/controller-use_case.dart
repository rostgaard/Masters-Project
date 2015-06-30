part of tcc.client.controller;

class UseCase {

  final libtcc.TestCaseService _service;
  final model.UINotification _uiNotification;
  final Logger log = new Logger ('$libraryName.UseCase');

  UseCase(this._service, this._uiNotification);

  /**
   *
   */
  Future<libtcc.UseCase> get (int ucID) => this._service.getUseCase(ucID)
    .catchError(_logAndNotify);

  /**
   *
   */
  Future<Iterable<libtcc.UseCase>> list () => this._service.getUseCases()
    .catchError(_logAndNotify);

  /**
   *
   */
  Future<libtcc.Configuration> create (libtcc.UseCase useCase) =>
    this._service.createUseCase(useCase)
    .then((_) => _notify ('Use case "${useCase.name}" created.'))
    .catchError(_logAndNotify);

  /**
   *
   */
  Future<libtcc.Configuration> update (libtcc.UseCase useCase) =>
    this._service.updateUseCase(useCase)
    .then((_) => _notify ('Use case "${useCase.name}" updated.'))
    .catchError(_logAndNotify);

  /**
   *
   */
  Future remove (libtcc.UseCase useCase) =>
    this._service.removeUseCase(useCase)
    .then((_) => _notify ('Use case "${useCase.name}" removed.'))
    .catchError(_logAndNotify);

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
