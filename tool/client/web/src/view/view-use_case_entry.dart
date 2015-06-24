part of tcc.client.view;

class UseCaseEntry {
  LIElement element;

  /**
   *
   */
  UseCaseEntry(libtcc.UseCaseEntry entry, libtcc.Definitions definitions) {
    element = _decompose(entry, definitions);
  }

  /**
   *
   */
  LIElement _decompose(
      libtcc.UseCaseEntry entry, libtcc.Definitions definitions) {
    ButtonElement deleteButton = new ButtonElement()
      ..text = 'X'
      ..onClick.listen((_) {
        this.element.remove();
      });

    ButtonElement upButton = new ButtonElement()
      ..text = '↑'
      ..onClick.listen((_) {
        if (this.element != this.element.parent.children.first) {
          this.element.parent.insertBefore(this.element, this.element.previousElementSibling);
        }
      });

    ButtonElement downButton = new ButtonElement()
      ..text = '↓'
      ..onClick.listen((_) {
      if (this.element != this.element.parent.children.last) {
        this.element.parent.insertBefore(this.element,
            this.element.nextElementSibling.nextElementSibling);
      }
      });


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

    return element
      ..children.addAll([upButton,downButton, deleteButton])
      ..appendHtml(decomposed);
  }


  /**
   *
   */
  static SpanElement _toElement (libtcc.Concept concept) =>
    new SpanElement()..classes.add(concept.runtimeType.toString().toLowerCase())
      ..text = concept.type;

}
