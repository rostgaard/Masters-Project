part of libtcc.base;

class Definition {

  final Concept _concept;
  String role;

  Concept get concept => this._concept;

  Definition (this._concept);

  @override
  int get hashCode => '${_concept.type}::${_concept.role}'.hashCode;

}