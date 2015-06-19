part of tcc.client.view;

class UseCaseEntry {
  final LIElement element;

  UseCaseEntry(libtcc.UseCaseEntry entry, libtcc.Definitions definitions)
      : element = _decompose(entry, definitions);

  static LIElement _decompose(
      libtcc.UseCaseEntry entry, libtcc.Definitions definitions) {
    LIElement element = new LIElement();
    String decomposed = entry.text.toLowerCase();

    definitions.forEach((libtcc.Definition def) {
      String definition = def.concept.type.toLowerCase();
      if (decomposed.contains(definition)) {
        print (_toElement(def.concept).outerHtml.toString());
      }

      decomposed = decomposed.replaceAll
          (definition, _toElement(def.concept).outerHtml);
    });

    print(decomposed);

    return element..appendHtml(decomposed);
  }


  static SpanElement _toElement (libtcc.Concept concept) =>
    new SpanElement()..classes.add(concept.runtimeType.toString().toLowerCase())
      ..text = concept.type;

}
