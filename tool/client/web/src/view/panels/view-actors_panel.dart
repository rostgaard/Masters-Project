part of tcc.client.view;

class ActorsPanel implements Panel {

  final Element _root;
  final controller.Actor _actorController;
  DivElement get _definitions => _root.querySelector('.definitions');

  ButtonElement get _addButton => _root.querySelector('button.create');

  InputElement get _addInputName => _root.querySelector('#input-new-actor-name');
  InputElement get _addInputRole => _root.querySelector('#input-new-actor-role');
  InputElement get _addInputDescription => _root.querySelector('#input-new-actor-description');


  ActorsPanel(this._root, this._actorController) {
    _render();
    _observers();
  }

  /**
   * Register observers on the panel.
   */
  _observers() {
    _addButton.onClick.listen((_) {
      _actorController.create(_inputActor())
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

  _render() {
    _actorController.list().then((Iterable<libtcc.Actor> actors) {
      _definitions.children = [new Actors(actors, _actorController).element];
    });
  }

  /**
   * Extracts a [libtcc.Actor] from the UI component.
   */
  libtcc.Actor _inputActor() =>
      new libtcc.Actor.withRole(_addInputName.value, _addInputName.value)
        ..description = _addInputDescription.value;

}