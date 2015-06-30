part of tcc.client.view;

class ActorsPanel implements Panel {

  final Element _root;
  final controller.Config _configController;
  final libtcc.TestCaseService _service;

  Actors _actorsView = new Actors();


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
//    _service.getUseCases().then((Iterable<libtcc.UseCase> ucs) {
//      _service.getUseCase(ucNames.first).then((libtcc.AnalyzedUseCase uc) {
//        _actorsView.actors = uc.involvedActors;
//
//_root.append (_actorsView.element);
//      });
//    });


  }

}