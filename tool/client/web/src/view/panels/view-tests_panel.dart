part of tcc.client.view;

class TestsPanel implements Panel {

  final Element _root;
  final controller.Config _configController;
  final libtcc.TestCaseService _service;
  final TestCase testCaseView = new TestCase();


  TestsPanel(this._root, this._configController, this._service) {
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
//    _service.getUseCase('Use_Case_1').then((libtcc.AnalyzedUseCase uc) {
//      testCaseView.selectedUseCase = uc;
//    });
//
//    _service.getUseCases().then((Iterable<String> ucNames) {
//
//      _service.getUseCase(ucNames.first).then((libtcc.AnalyzedUseCase uc) {
//        //_root.appendHtml(uc.toMarkdown());
//        //useCaseView.selectedUseCase = uc;
//      });
//    });


  }

}