part of tcc.client.view;

class Definitions {

  UListElement element = new UListElement();

  Definitions (Iterable<libtcc.Definition> definitions) {
    element.children.addAll(definitions.map(_toNode));
  }


  LIElement _toNode (libtcc.Definition definition) =>
      new LIElement()..text = '${definition.concept.runtimeType} ${definition.concept.role} (${definition.concept.type})';

}