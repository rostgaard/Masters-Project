part of libtcc.base;

/**
 * Class representing a single use case entry.
 */
class UseCaseEntry {
  int id;
  static const int noID = -1;
  String text = 'undefined';

  static final UseCaseEntry termination =
    new UseCaseEntry('termination')
    ..id = noID;

  String get identity => normalize ('${this.text}');


  UseCaseEntry(this.text);

  Set<Definition> involvedDefinitions(Definitions definitions) {
    Set<Definition> involved = new Set();
    String decomposed = text.toLowerCase();

    definitions.forEach((Definition def) {
      ///TODO: make def.role
      String definition = def.concept.type.toLowerCase();
      if (decomposed.contains(definition)) {
        involved.add(def);
      }
    });

    return involved;
  }

  operator ==(UseCaseEntry other) => this.id == other.id;

  @override
  String toString() => '$id. $text';

  Map toJson() => {Key.id: id, Key.value: text};
}
