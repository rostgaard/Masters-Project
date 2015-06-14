part of tcc.client.view;

class TemplatesPanel implements Panel {

  final Element _root;
  final controller.Config _configController;
  final libtcc.TestCaseService _service;

  TemplatesPanel(this._root, this._configController, this._service) {
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