part of tcc.client.view;

class Definitions {

  UListElement element = new UListElement();
  final libtcc.TestCaseService _service;

  Definitions (Iterable<libtcc.Definition> definitions, this._service) {
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
       _service.removeConcept(definition.concept)
               .then((_) => li.remove()));

   li.children.add(delete);

    return li;
  }



}