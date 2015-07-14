part of tcc.client.controller;

class UseCase {
  final libtcc.TestCaseService _service;
  final model.UINotification _uiNotification;
  final Logger log = new Logger('$libraryName.UseCase');

  UseCase(this._service, this._uiNotification);

  /**
   *
   */
  Future<libtcc.UseCase> get(int ucID) => this._service
      .getUseCase(ucID)
      .catchError(_logAndNotify)
      .catchError((error, stackTrace) =>
          _logAndNotify('Failed to get', error, stackTrace));

  /**
   *
   */
  Future<Iterable<libtcc.UseCase>> list() => this._service
      .getUseCases()
      .catchError(_logAndNotify)
      .catchError((error, stackTrace) =>
          _logAndNotify('Failed to list', error, stackTrace));

  /**
   *
   */
  Future<libtcc.Configuration> create(libtcc.UseCase useCase) => this._service
      .createUseCase(useCase)
      .then((_) => _notify('Use case "${useCase.name}" created.'))
      .catchError((error, stackTrace) =>
          _logAndNotify('Failed to create', error, stackTrace));

  /**
   *
   */
  Future<libtcc.Configuration> update(libtcc.UseCase useCase) => this._service
      .updateUseCase(useCase)
      .then((_) => _notify('Use case "${useCase.name}" updated.'))
      .catchError((error, stackTrace) =>
          _logAndNotify('Failed to update', error, stackTrace));

  /**
   *
   */
  Future remove(libtcc.UseCase useCase) => this._service
      .removeUseCase(useCase)
      .then((_) => _notify('Use case "${useCase.name}" removed.'))
      .catchError((error, stackTrace) =>
          _logAndNotify('Failed to remove', error, stackTrace));

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
    log.severe(message, error, StackTrace);
    _uiNotification.addError('$message. Got: $error');
  }
}
