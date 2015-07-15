part of tcc.client.view;

class TestsPanel implements Panel {

  final Element _root;
  final TestCase testCaseView = new TestCase();

  /// Controllers requirered for this panel.
  final controller.UseCase _useCaseController;
  final controller.Template _templateController;

  SelectElement get _useCaseSelector => _root.querySelector('#test-use-case-selector');
  SelectElement get _templateSelector => _root.querySelector('#test-template-selector');

  DivElement get _analysisOutput => _root.querySelector('#test-generation-output');
  DivElement get _testOutput => _root.querySelector('#test-generation-body');

  ButtonElement get _generateButton => _root.querySelector('button.generate');

  TestsPanel(this._root, this._useCaseController, this._templateController) {
    _render();
    _observers();

    _root.append(testCaseView.element);
  }


  _observers() {
    _generateButton.onClick.listen((_) {
      _generateButton.disabled = true;
      _generateButton.text = 'Please wait..';

      int ucId = int.parse
          (_useCaseSelector.options[_useCaseSelector.selectedIndex].value);

      int tplId = int.parse
          (_templateSelector.options[_templateSelector.selectedIndex].value);

      _useCaseController.generateTest(ucId, tplId).then((libtcc.GeneratedTest genTest) {

        _analysisOutput.innerHtml = genTest.analysisOutput.join('<br />');
        _testOutput.children = [new PreElement()..text = genTest.testBody];
      }).whenComplete(() {
        _generateButton.disabled = false;
        _generateButton.text = 'Generate';
      });

    });
  }

  _select() {
    _root.hidden = false;
    _render();
  }

  _render() {
    _useCaseController.list().then((Iterable<libtcc.UseCase> useCases) {

         _useCaseSelector.children = []..addAll(useCases.map(_useCaseToOptionElement));
    });

    _templateController.list().then((Iterable<libtcc.TestTemplate> templates) {

         _templateSelector.children = []..addAll(templates.map(_templateToOptionElement));
    });
  }

}