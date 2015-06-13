part of tcc.client.view;

class UIExamples extends Panel {
  final Element _root;

  UIExamples(this._root) {
    _render();
    _observers();
  }

  _observers() {}

  _select() {
    _root.hidden = false;
    _render();
  }

  _render() {
    libtcc.Definitions definitions =
      new libtcc.Definitions ([
        new libtcc.Definition (new libtcc.Actor('Admin')),
        new libtcc.Definition (new libtcc.Actor('User')),
        new libtcc.Definition (new libtcc.Concept('Backed'))
        ]);

    libtcc.UseCaseBlock block = new libtcc.UseCaseBlock([
      new libtcc.UseCaseEntry('User logs in to backed'),
      new libtcc.UseCaseEntry('Admin reacts to log in'),
      new libtcc.UseCaseEntry('Admin bans user'),
      ]);


    _root.children = [
       new UseCaseBlock(block, definitions).element
      ];

  }
}