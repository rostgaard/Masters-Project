part of tcc.client.view;

class UseCasesPanel implements Panel {
  final Element _root;
  final controller.Config _configController;
  final libtcc.TestCaseService _service;
  final UseCase useCaseView = new UseCase();
  final UseCaseSelector useCaseSelector =
      new UseCaseSelector(querySelector('nav.use-case'));

  UseCasesPanel(this._root, this._configController, this._service) {
    _render();
    _observers();

    _root.append(useCaseView.element);
  }

  _observers() {
    _root.querySelector('.get-selection').onClick.listen((_) {
      print(window.getSelection().getRangeAt(0).cloneContents().innerHtml);
    });
  }

  _select() {
    _root.hidden = false;
    _render();
  }

  _render() {
    _service.getUseCases().then((Iterable<String> ucNames) {
      useCaseSelector.render(ucNames.map(useCaseSelector._menuItem));

      _service.getUseCase(ucNames.first).then((libtcc.UseCase uc) {
        //_root.appendHtml(uc.toMarkdown());
        useCaseView.selectedUseCase = uc;
      });
    });


  }
}
