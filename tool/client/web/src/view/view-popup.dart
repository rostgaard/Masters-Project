part of tcc.client.view;

class Popup {
  final Uri _errorIcon = Uri.parse('http://localhost/');
  final Uri _infoIcon = Uri.parse('http://localhost/');
  final Uri _successIcon = Uri.parse('http://localhost/');
  final Duration _timeout = new Duration(seconds: 3);

  final model.UINotification _notification;

  /**
   * Constructor.
   */
  Popup(this._notification) {
    _observers();
  }

  _observers() {
    this._notification.onError.listen(
        (String message) => this.error('Error', message, closeAfter: _timeout));
    this._notification.onInfo.listen(
        (String message) => this.error('Info', message, closeAfter: _timeout));
    this._notification.onWarning.listen((String message) =>
        this.error('Warning', message, closeAfter: _timeout));
  }

  void error(String title, String body, {Duration closeAfter}) {
    _schedulePopupForClose(
        new Notification(title, body: body, icon: _errorIcon.path), closeAfter);
  }

  void info(String title, String body, {Duration closeAfter}) {
    _schedulePopupForClose(
        new Notification(title, body: body, icon: _infoIcon.path), closeAfter);
  }

  void _schedulePopupForClose(Notification notification, Duration timeout) {
    Duration closeAfter = _timeout;
    if (timeout != null) {
      closeAfter = timeout;
    }
    new Timer(closeAfter, () {
      notification.close();
    });
  }

  void success(String title, String body, {Duration closeAfter}) {
    _schedulePopupForClose(
        new Notification(title, body: body, icon: _successIcon.path),
        closeAfter);
  }
}
