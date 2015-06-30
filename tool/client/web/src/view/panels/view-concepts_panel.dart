part of tcc.client.view;

/**
 *
 */
class ConceptsPanel implements Panel {
  final Element _root;
  final controller.Concept _conceptController;

  DivElement get _definitions => _root.querySelector('.definitions');
  ButtonElement get _addButton => _root.querySelector('button.create');

  InputElement get _addInputName => _root.querySelector('#input-new-concept-name');
  InputElement get _addInputRole => _root.querySelector('#input-new-concept-role');
  InputElement get _addInputDescription => _root.querySelector('#input-new-concept-description');


  /**
   * Constructor.
   */
  ConceptsPanel(this._root, this._conceptController) {
    _observers();
    _render();
  }

  /**
   * Register observers on the panel.
   */
  _observers() {
    _addButton.onClick.listen((_) {
      _conceptController.create(_inputConcept())
        .whenComplete(_render);
      ;
    });

    _addInputName.onInput.listen((_) {
      _addButton.disabled = _addInputRole.value.isEmpty ||
                            _addInputName.value.isEmpty;
    });

    _addInputRole.onInput.listen((_) {
      _addButton.disabled = _addInputRole.value.isEmpty ||
                            _addInputName.value.isEmpty;
    });
}

  /**
   * Select the panel.
   */
  _select() {
    _root.hidden = false;
    _render();
  }

  /**
   * Renders the widget.
   */
  _render() {
    _conceptController.list().then((Iterable<libtcc.Concept> concepts) {
      _definitions.children = [new Concepts(concepts, _conceptController).element];
    });
  }

  /**
   * Extracts a [libtcc.Concept] from the UI component.
   */
  libtcc.Concept _inputConcept() =>
      new libtcc.Concept.withRole(_addInputName.value, _addInputName.value)
        ..description = _addInputDescription.value;

}
