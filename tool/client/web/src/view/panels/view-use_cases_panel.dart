part of tcc.client.view;

/**
 * Panel for creating and modifying use cases.
 */
class UseCasesPanel implements Panel {

  /// Root DOM element.
  final Element _root;

  /// Local cache
  libtcc.Definitions definitions;

  /// Controllers requirered for this panel.
  final controller.UseCase _useCaseController;
  final controller.Concept _conceptController;
  final controller.Actor _actorController;

  /// Rendered use case representation.
  RenderedUseCase useCaseView;

  /// Use case dropdown selector.
  SelectElement get _useCaseSelector =>
      _root.querySelector('#use-case-selector');

  TextAreaElement get _editArea => _root.querySelector('#use-case-edit');

  InputElement get _useCaseIdInput => _root.querySelector('#use-case-edit-id');
  InputElement get _useCaseNameInput => _root.querySelector('#use-case-edit-name');
  InputElement get _useCaseDescriptionInput => _root.querySelector('#use-case-edit-description');
  ButtonElement get _addButton => _root.querySelector('button.create');
  ButtonElement get _saveButton => _root.querySelector('button.save');
  ButtonElement get _markActorButton => _root.querySelector('.mark-actor');
  ButtonElement get _markConceptButton => _root.querySelector('.mark-concept');

  DivElement get _scenarioElement => _root.querySelector('.use-case-edit-scenario');

  int get _useCaseId => int.parse(_useCaseIdInput.value);
  set _useCaseId (int id) => _useCaseIdInput.value = id.toString();

  String get _useCaseName => _useCaseNameInput.value;
  set _useCaseName (String name) => _useCaseNameInput.value = name;

  bool get _hasSelectedText => window.getSelection().rangeCount > 0 &&
      window.getSelection().getRangeAt(0).cloneContents().innerHtml != '';


  String get _selectedText => _hasSelectedText
      ? window.getSelection().getRangeAt(0).cloneContents().innerHtml
      : '';

  StreamController<libtcc.UseCase> _useCaseChanged = new StreamController<libtcc.UseCase>();
  Stream get onUseCaseChanged => _useCaseChanged.stream;

  /**
   * Default constructor.
   */
  UseCasesPanel(this._root, this._useCaseController, this._conceptController, this._actorController) {

    useCaseView = new RenderedUseCase(_root.querySelector(".use-case-representation"));

    _render();
    _observers();

    _root.append(useCaseView.element);
  }

  _useCaseChangeListeners() {
    this._useCaseNameInput.onInput.listen((_) {
      _useCaseChanged.add(_harvestUseCase());
    });

    this._useCaseDescriptionInput.onInput.listen((_) {
      _useCaseChanged.add(_harvestUseCase());
    });
  }


  libtcc.UseCase _harvestUseCase() {
    Iterable<libtcc.UseCaseEntry> uces =
        _scenarioElement.querySelectorAll('li').map((LIElement li) =>
            new libtcc.UseCaseEntry(li.text));

    libtcc.UseCaseBlock scenario = new libtcc.UseCaseBlock(uces);

    return new libtcc.UseCase(this._useCaseName)
      ..description = this._useCaseDescriptionInput.value
      ..scenario = scenario;
  }

  /**
   * Observers
   */
  _observers() {

    _useCaseChangeListeners();

    onUseCaseChanged.listen((libtcc.UseCase useCase) {
      useCaseView.activeUseCase = useCase;
    });

    _useCaseSelector.onClick.listen((_){
      int ucid = int.parse
          (_useCaseSelector.options[_useCaseSelector.selectedIndex].value);

      if (ucid != _useCaseId) {
        _useCaseController.get (ucid).then(_renderUseCase);
      }
    });

    _addButton.onClick.listen((_) {
      _saveButton.disabled = true;
      _useCaseId = libtcc.TestTemplate.noId;
      _useCaseSelector.value = '';

      _useCaseNameInput.focus();
    });

    _useCaseNameInput.onInput.listen((_) {
      _saveButton.disabled = _useCaseNameInput.value.isEmpty;
    });

    _saveButton.onClick.listen((_) {
      if(_useCaseId == libtcc.TestTemplate.noId) {
        _useCaseController.create(useCaseView.activeUseCase).whenComplete(_render);
      }
      else {
        _useCaseController.update(useCaseView.activeUseCase).whenComplete(_render);
      }
    });

    _markActorButton.disabled = !_hasSelectedText;
    _markConceptButton.disabled = !_hasSelectedText;
    _root.onClick.listen((_) {
      print( window.getSelection().rangeCount);
      _markActorButton.disabled = !_hasSelectedText;
      _markConceptButton.disabled = !_hasSelectedText;
    });


    _markActorButton.onClick.listen((_) {
      if (_hasSelectedText) {
        _actorController.create(new libtcc.Actor(_selectedText));
        _render();
      }
    });

    _markConceptButton.onClick.listen((_) {
      if (_hasSelectedText) {
        _conceptController.create(new libtcc.Concept(_selectedText));
        _render();
      }
    });


  }

  /**
   * On select handler.
   */
  _select() {
    _root.hidden = false;
    _render();
  }

  /**
   * Render the panel.
   */
  _render() {

    _useCaseController.list()
      .then((Iterable<libtcc.UseCase> useCases) {
      _useCaseSelector
          .children = []..addAll(useCases.map(_useCaseToOptionElement));
    });

    _conceptController.list().then((Iterable<libtcc.Concept> concepts) {
      definitions = new libtcc.Definitions(concepts);
    });
  }

  /**
   *
   */
  _renderUseCase(libtcc.UseCase useCase) {
    UseCaseBlock scenarioView = new UseCaseBlock(useCase.scenario, definitions);

    scenarioView.onBlockChange.listen((_) => _useCaseChanged.add(_harvestUseCase()));

    _useCaseId = useCase.id;
    _useCaseName = useCase.name;
    _useCaseDescriptionInput.value = useCase.description;
    useCaseView.activeUseCase = useCase;
    _scenarioElement.children = [scenarioView.element];
  }

  /**
   *
   */
  OptionElement _useCaseToOptionElement(libtcc.UseCase useCase) =>
    new OptionElement()
    ..text = useCase.name
    ..value = useCase.id.toString()
    ..onClick.listen(print);
}
