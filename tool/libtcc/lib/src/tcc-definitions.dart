part of libtcc.base;

class Definitions extends IterableBase<Concept> {

  final Set<Concept> _concepts;

  Iterator get iterator => _concepts.iterator;

  Definitions (Iterable<Concept> concepts) :
    _concepts = new Set<Concept>()..addAll (concepts);

  /**
   * Very inefficient parser returns a list of components.
   */
  List parse (String line) {


  }

  void add (Concept concept) {
    this._concepts.add(concept);
  }

  void addAll (Iterable<Concept> concepts) {
    this._concepts.addAll(concepts);
  }

}
