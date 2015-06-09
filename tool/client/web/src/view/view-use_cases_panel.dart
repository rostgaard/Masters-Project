part of tcc.client.view;

class UseCasesPanel implements Panel {

  final Element _root;
  final controller.Config _configController;
  final libtcc.TestCaseService _service;
  final UseCase useCaseView = new UseCase();

  UseCasesPanel(this._root, this._configController, this._service) {
    _render();
    _observers();

    _root.append(useCaseView.element);
  }

  _observers() {
  }

  _select() {
    _root.hidden = false;
    _render();
  }

  _render() {
    _service.getDummyUseCase().then((libtcc.UseCase uc) {
    //_root.appendHtml(uc.toMarkdown());
      useCaseView.selectedUseCase = uc;
    });
  }

}