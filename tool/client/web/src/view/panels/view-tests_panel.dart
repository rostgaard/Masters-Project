part of tcc.client.view;

class TestsPanel implements Panel {

  final Element _root;
  final controller.Config _configController;
  final libtcc.TestCaseService _service;
  final TestCase testCaseView = new TestCase();
  UseCaseSelector _useCaseSelector;

  TestsPanel(this._root, this._configController, this._service) {
    _useCaseSelector = new UseCaseSelector(_root.querySelector('nav.use-case'));
    _render();
    _observers();

    _root.append(testCaseView.element);
  }


  _observers() {
  }

  _select() {
    _root.hidden = false;
    _render();
  }

  _render() {
    _service.getUseCase('Use_Case_1').then((libtcc.UseCase uc) {
      testCaseView.selectedUseCase = uc;
    });

    _service.getUseCases().then((Iterable<String> ucNames) {

      _useCaseSelector.render(ucNames.map(_useCaseSelector._menuItem));

      _service.getUseCase(ucNames.first).then((libtcc.UseCase uc) {
        //_root.appendHtml(uc.toMarkdown());
        //useCaseView.selectedUseCase = uc;
      });
    });


  }

}