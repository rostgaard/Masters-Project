part of tcc.client.controller;

/**
 * Template controller. Centralized point of REST service calls.
 */
class Template {

  final libtcc.TestCaseService _service;
  final model.UINotification _uiNotification;
  final Logger log = new Logger ('$libraryName.Template');

  /**
   * Default constructor.
   */
  Template(this._service, this._uiNotification);

  /**
   * Create a new template
   */
  Future create (libtcc.TestTemplate template) =>
     _service.createTemplate(template)
    .then((_) => _notify ('Template added'))
    .catchError(_logAndNotify);

  /**
   * Remove a templates
   */
  Future remove (libtcc.TestTemplate template) =>
     _service.removeTemplate(template)
    .then((_) => _notify ('Template removed'))
    .catchError(_logAndNotify);

  /**
   * Retrieves a list of all templates from the REST service.
   */
  Future<Iterable<libtcc.TestTemplate>> list () =>
    _service.getTemplates();

  /**
   * Retrieves a single template from the REST service.
   */
  Future<libtcc.TestTemplate> get (int templateId) =>
    _service.getTemplate(templateId);

  /**
   * Notifies the UI of an event.
   */
  void _notify(String message) {
    _uiNotification.addInfo(message);
  }

  /**
   * Conveniece method for logging and notifying in case of an error.
   */
  void _logAndNotify (String message, error, StackTrace) {
    log.severe(message, error, StackTrace);
    _uiNotification.addError('$message. Got: $error');
  }
}
