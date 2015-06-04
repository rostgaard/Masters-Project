part of libtcc.base;

class Action {
  String name;

  Action (this.name);

  @override
  String toString () => this.name;

  String toJson() => name;
}