part of libtcc.base;

class Definitions extends IterableBase<Definition> {

  final Set<Definition> _definitions;

  Iterator get iterator => _definitions.iterator;

  Definitions (Iterable<Definition> definitions) :
    _definitions = new Set<Definition>()..addAll (definitions);

  /**
   * Very inefficient parser returns a list of components.
   */
  List parse (String line) {


  }

  void add (Definition definition) {
    this._definitions.add(definition);
  }

}
