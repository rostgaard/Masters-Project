part of tcc.client.controller;

class Config {
  final libtcc.TestCaseService _service;
  final libtcc.Configuration _model;
  final model.UINotification _uiNotification;
  final Logger log = new Logger('$libraryName.Config');

  Config(this._service, this._model, this._uiNotification);

  Future save() => this._service
      .saveConfig(this._model)
      .then((_) => _notify('Config updated'))
      .catchError((error, stackTrace) =>
          _logAndNotify('Failed to save', error, stackTrace));

  Future<libtcc.Configuration> load() => this._service
      .getConfig()
      .catchError((error, stackTrace) =>
          _logAndNotify('Failed to load', error, stackTrace));

  void _notify(String message) {
    _uiNotification.addInfo(message);
  }

  void _logAndNotify(String message, error, StackTrace) {
    log.severe(message, error, StackTrace);
    _uiNotification.addError('$message. Got: $error');
  }
}
