part of tcc.client.view;

class ActorsPanel implements Panel {

  final Element _root;
  final controller.Config _configController;
  final libtcc.TestCaseService _service;

  ActorsView _actorsView = new ActorsView();


  ActorsPanel(this._root, this._configController, this._service) {
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
    _service.getUseCases().then((Iterable<String> ucNames) {
      _service.getUseCase(ucNames.first).then((libtcc.UseCase uc) {
        _actorsView.actors = uc.involvedActors;

_root.append (_actorsView.element);
      });
    });


  }

}