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
  UseCaseEntry(libtcc.UseCaseEntry entry, libtcc.Definitions definitions, {bool decompose: true}) {
    _entry = entry;
    element = _decompose(entry, definitions, decompose : decompose);

  }

  /**
   *
   */
  String _decomposedHtml(libtcc.UseCaseEntry entry, libtcc.Definitions definitions) {
    String decomposed = entry.text.toLowerCase();

    definitions.forEach((libtcc.Concept concept) {
      String definition = concept.type.toLowerCase();

      decomposed =
          decomposed.replaceAll(definition, _toElement(concept).outerHtml);
    });

    return decomposed;
  }

  /**
   *
   */
  LIElement _decompose(
      libtcc.UseCaseEntry entry, libtcc.Definitions definitions, {bool decompose: true}) {
    ButtonElement deleteButton = new ButtonElement()
      ..classes.add('tiny-edit-button')
      ..text = 'X'
      ..onClick.listen((_) {
        this.element.remove();
        _entryChange.add(_entry);
      });

    ButtonElement upButton = new ButtonElement()
      ..classes.add('tiny-edit-button')
      ..text = '↑'
      ..onClick.listen((_) {
        if (this.element != this.element.parent.children.first) {
          this.element.parent.insertBefore(
              this.element, this.element.previousElementSibling);
          _entryChange.add(_entry);
        }
      });

    ButtonElement downButton = new ButtonElement()
      ..classes.add('tiny-edit-button')
      ..text = '↓'
      ..onClick.listen((_) {
        if (this.element != this.element.parent.children.last) {
          this.element.parent.insertBefore(
              this.element, this.element.nextElementSibling.nextElementSibling);
          _entryChange.add(_entry);
        }
      });

    LIElement element = new LIElement();
    String decomposed = _decomposedHtml(entry, definitions);

    ParagraphElement par = new ParagraphElement()..style.display = 'inline';

    if (decompose) {
      par.appendHtml(decomposed);
    }
    else {
      par.text = entry.text;
    }

    return element
      ..children.addAll([upButton, downButton, deleteButton, par]);
  }

  /**
   *
   */
  static SpanElement _toElement(libtcc.Concept concept) => new SpanElement()
    ..classes.add(concept.runtimeType.toString().toLowerCase())
    ..text = concept.type;
}
