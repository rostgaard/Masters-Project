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

  UseCaseEntry.fromMap(Map map) {
    id = map[Key.id];
    text = map[Key.value];
  }

  /**
   * Decode factory.
   */
  static UseCaseEntry decode (Map map) => new UseCaseEntry.fromMap(map);

  Set<Concept> involvedDefinitions(Definitions definitions) {
    Set<Concept> involved = new Set();
    String decomposed = text.toLowerCase();

    definitions.forEach((Concept def) {
      ///TODO: make def.role
      String definition = def.type.toLowerCase();
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
