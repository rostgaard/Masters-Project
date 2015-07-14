part of tcc.client.controller;

/**
 * Template controller. Centralized point of REST service calls.
 */
class Template {
  final libtcc.TestCaseService _service;
  final model.UINotification _uiNotification;
  final Logger log = new Logger('$libraryName.Template');

  /**
   * Default constructor.
   */
  Template(this._service, this._uiNotification);

  /**
   * Create a new template
   */
  Future create(libtcc.TestTemplate template) => _service
      .createTemplate(template)
      .then((_) => _notify('Template added'))
      .catchError((error, stackTrace) =>
          _logAndNotify('Failed to create', error, stackTrace));

  /**
   * Update an existing template
   */
  Future update(libtcc.TestTemplate template) => _service
      .updateTemplate(template)
      .then((_) => _notify('Template updated'))
      .catchError((error, stackTrace) =>
          _logAndNotify('Failed to update', error, stackTrace));

  /**
   * Remove a templates
   */
  Future remove(libtcc.TestTemplate template) => _service
      .removeTemplate(template)
      .then((_) => _notify('Template removed'))
      .catchError((error, stackTrace) =>
          _logAndNotify('Failed to remove', error, stackTrace));

  /**
   * Retrieves a list of all templates from the REST service.
   */
  Future<Iterable<libtcc.TestTemplate>> list() => _service
      .getTemplates()
      .catchError((error, stackTrace) =>
          _logAndNotify('Failed to list', error, stackTrace));

  /**
   * Retrieves a single template from the REST service.
   */
  Future<libtcc.TestTemplate> get(int templateId) => _service
      .getTemplate(templateId)
      .catchError((error, stackTrace) =>
          _logAndNotify('Failed to get', error, stackTrace));

  /**
   * Notifies the UI of an event.
   */
  void _notify(String message) {
    _uiNotification.addInfo(message);
  }

  /**
   * Conveniece method for logging and notifying in case of an error.
   */
  void _logAndNotify(String message, error, StackTrace) {
    log.severe(message, error, StackTrace);
    _uiNotification.addError('$message. Got: $error');
  }
}
