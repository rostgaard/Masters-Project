part of tcc.client.view;

class Concepts {

  UListElement element = new UListElement();
  final controller.Concept _conceptController;

  Concepts (Iterable<libtcc.Concept> concepts, this._conceptController) {
    _render (concepts);
  }

  _fetchAndRender() {
    _conceptController.list().then(_render);
  }


  LIElement _toNode (libtcc.Concept concept) {
    SpanElement label = new SpanElement()..text =
      '${concept.role} '
      '(${concept.type})';

   ButtonElement deleteButtton = new ButtonElement()
     ..text = 'Remove'
     ..classes.add('delete');

   ButtonElement editButtton = new ButtonElement()
     ..text = 'Edit'
     ..classes.add('edit');

   deleteButtton.onClick.listen((_) =>
       _conceptController.remove(concept)
               .then((_) => _fetchAndRender()));

   editButtton.onClick.listen((_) =>
       _conceptController.remove(concept)
               .then((_) => _fetchAndRender()));

   return new LIElement()
    ..children.addAll([deleteButtton, label]);

  }


  void _render(Iterable<libtcc.Concept> concepts) {
    element.children = []..addAll(concepts.map(_toNode));
  }


}