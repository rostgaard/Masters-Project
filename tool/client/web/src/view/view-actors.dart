part of tcc.client.view;

class ActorsView {

  UListElement element = new UListElement();

  set actors (Iterable<libtcc.Actor> newActors) {
    element.children =
        newActors.map(_toNode).toList();
  }

  ActorsView ();


  LIElement _toNode (libtcc.Actor actor) {
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