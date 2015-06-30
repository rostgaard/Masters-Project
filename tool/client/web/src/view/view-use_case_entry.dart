part of tcc.client.view;

class UseCaseEntry {
  LIElement element;

  libtcc.UseCaseEntry _entry;

  /// Stream for external use.
  StreamController<libtcc.UseCaseEntry> _entryChange =
      new StreamController<libtcc.UseCaseEntry>();
  Stream<libtcc.UseCaseEntry> get onEntryChange => _entryChange.stream;

  /**
   *
   */
  UseCaseEntry(libtcc.UseCaseEntry entry, libtcc.Definitions definitions) {
    _entry = entry;
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
        _entryChange.add(_entry);
      });

    ButtonElement upButton = new ButtonElement()
      ..text = '↑'
      ..onClick.listen((_) {
        if (this.element != this.element.parent.children.first) {
          this.element.parent.insertBefore(
              this.element, this.element.previousElementSibling);
          _entryChange.add(_entry);
        }
      });

    ButtonElement downButton = new ButtonElement()
      ..text = '↓'
      ..onClick.listen((_) {
        if (this.element != this.element.parent.children.last) {
          this.element.parent.insertBefore(
              this.element, this.element.nextElementSibling.nextElementSibling);
          _entryChange.add(_entry);
        }
      });

    LIElement element = new LIElement();
    String decomposed = entry.text.toLowerCase();

    definitions.forEach((libtcc.Concept concept) {
      String definition = concept.type.toLowerCase();
      if (decomposed.contains(definition)) {
        print(_toElement(concept).outerHtml.toString());
      }

      decomposed =
          decomposed.replaceAll(definition, _toElement(concept).outerHtml);
    });

    return element
      ..children.addAll([upButton, downButton, deleteButton])
      ..appendHtml(decomposed);
  }

  /**
   *
   */
  static SpanElement _toElement(libtcc.Concept concept) => new SpanElement()
    ..classes.add(concept.runtimeType.toString().toLowerCase())
    ..text = concept.type;
}
