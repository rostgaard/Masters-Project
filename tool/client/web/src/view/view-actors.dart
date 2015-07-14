part of tcc.client.view;

class Actors {

  UListElement element = new UListElement();
  final controller.Actor _actorController;

  Actors (Iterable<libtcc.Actor> actors, this._actorController) {
    _render (actors);
  }

  _fetchAndRender() {
    _actorController.list().then(_render);
  }


  LIElement _toNode (libtcc.Actor actor) {
    SpanElement label = new SpanElement()
      ..classes.add('definition')
      ..text = '${actor.role} (${actor.type})';

   ButtonElement deleteButtton = new ButtonElement()
     ..text = 'Remove'
     ..classes.add('delete');

   ButtonElement editButtton = new ButtonElement()
     ..text = 'Edit'
     ..classes.add('edit');

   deleteButtton.onClick.listen((_) =>
       _actorController.remove(actor)
               .then((_) => _fetchAndRender()));

   editButtton.onClick.listen((_) =>
       _actorController.remove(actor)
               .then((_) => _fetchAndRender()));

   return new LIElement()
    ..children.addAll([deleteButtton, label]);

  }


  void _render(Iterable<libtcc.Actor> actors) {
    element.children = []..addAll(actors.map(_toNode));
  }


  set actors (Iterable<libtcc.Actor> newActors) {
    element.children =
        newActors.map(_toNode).toList();
  }


  LIElement _toNodeOld (libtcc.Actor actor) {
    String html = '''
    <div class="actor pure-g">
                <div class="icon pure-u-1-3">
                  <div class="actor pure-g">
                    <div class="icon pure-u-1-3"><img alt="Actor icon" src="img/actor-stick.png"></div>
                    <div class="name pure-u-1-3"><p>${actor.type}</p></div>
                    <div class="description pure-u-1-3"><p></p></div>
                  </div>
                </div>
              </div>''';


    return new LIElement()..appendHtml(html);


  }


}