part of tcc.client.view;

class UseCasesPanel implements Panel {

  final Element _root;
  final controller.Config _configController;
  final libtcc.TestCaseService _service;

  UseCasesPanel(this._root, this._configController, this._service) {
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
    _service.getDummyUseCase().then((libtcc.UseCase uc) {
    _root.appendHtml(uc.toMarkdown());
    });
  }

}