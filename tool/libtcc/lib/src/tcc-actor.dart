part of libtcc.base;

class Actor extends Concept {
  String role;

  ///For code generation.
  static const String anonID = '__anonymous_actor_';
  bool get anonymous => this.role.isEmpty;

  Actor(type) : super(type);

  factory Actor.withRole(String type, String role) =>
      new Actor(type)..role = role;

  factory Actor.fromMap(Map map) =>
      new Actor.withRole(map[Key.type], map[Key.role]);

  @override
  String toString() =>
      '${this.role.isNotEmpty ? ' ${this.role}' : '??' } (${this.type})';

  /**
   * Hashcodes for actors are defined as identical if their role and type are
   * identical.
   */
  @override
  int get hashCode {
    int hash = 23;
    hash = hash * 31 + this.type.hashCode;
    hash = hash * 31 + this.role.hashCode;

    return hash;
  }

  @override
  bool operator ==(Actor other) => this.role == other.role;

  Map toJson() => {
    Key.id: id,
    Key.type: type,
    Key.description: description,
    Key.role: role,
  };
}
