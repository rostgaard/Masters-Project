part of libtcc.base;

class Actor {
  String type;
  String role;
  static const String anonID = '__anonymous_actor_';
  bool anonymous = true;

  Actor(this.type, {String this.role : ''}) {
    if (this.role.isEmpty) {
      this.role = this.type.toLowerCase();
    } else {
      anonymous = false;
    }
  }

  Actor.fromMap(Map map) {
    type = map[Key.type];
    role = map[Key.role];
    anonymous = map[Key.anonymous];
  }

  @override
  String toString () => '${this.role.isNotEmpty ? ' ${this.role}' : '??' } (${this.type})';

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
    Key.type : type,
    Key.role : role,
    Key.anonymous : anonymous
  };

}
