part of tcc.client.model;

class UINotification {

  StreamController<String> _error = new StreamController<String>();
  StreamController<String> _warning = new StreamController<String>();
  StreamController<String> _info = new StreamController<String>();

  Stream<String> get onError => _error.stream;
  Stream<String> get onWarning => _warning.stream;
  Stream<String> get onInfo => _info.stream;

  void addInfo(String message) =>
    _info.add(message);

  void addError (String message) =>
    _error.add(message);

  void addWarning (String message) =>
    _warning.add(message);
}
