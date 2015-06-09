part of tcc.client.view;

class GoalsPanel implements Panel {

  final Element _root;
  final controller.Config _configController;
  final libtcc.TestCaseService _service;

  GoalsPanel(this._root, this._configController, this._service) {
    _render();
    _observers();
  }

  _observers() {
  }

  _select() {
    _root.hidden = false;
    _render();
  }

  _render() {
  }

}