part of libtcc.base;

class Action {
  String name;

  Action (this.name);

  Action.fromMap (String name) {
    this.name = name;
  }

  @override
  String toString () => this.name;

  String toJson() => name;
}