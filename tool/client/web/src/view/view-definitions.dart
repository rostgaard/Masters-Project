part of tcc.client.view;

class Definitions {

  UListElement element = new UListElement();
  final controller.Concept _conceptController;

  Definitions (Iterable<libtcc.Definition> definitions, this._conceptController) {
    element.children.addAll(definitions.map(_toNode));
  }


  LIElement _toNode (libtcc.Definition definition) {
    LIElement li = new LIElement()..text =
        '${definition.concept.runtimeType} ${definition.concept.role} '
        '(${definition.concept.type})';

   ButtonElement delete = new ButtonElement()
     ..text = 'Remove'
     ..classes.add('delete');

   delete.onClick.listen((_) =>
       _conceptController.remove(definition.concept)
               .then((_) => li.remove()));

   li.children.add(delete);

    return li;
  }



}