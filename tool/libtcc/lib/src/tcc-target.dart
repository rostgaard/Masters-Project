part of libtcc.base;

class Target {
  String type;
  String iden;
  static const String anonID = '__anonymous_object_';
  bool anonymous = true;

  Target(this.type, {String this.iden: ''}) {
    if (this.iden.isEmpty) {
      this.iden = anonID + this.type;
    } else {
      anonymous = false;
    }
  }

  Target.fromMap(Map map) {
    type = map[Key.type];
    iden = map[Key.identifier];
    anonymous = map[Key.anonymous];
  }

  @override
  String toString() => '${this.type}${!this.anonymous ? ' ${this.iden}' : ''}';

  @override
  int get hashCode => this.iden.hashCode;

  @override
  bool operator ==(Target other) => this.iden == other.iden;

  Map toJson() =>
      {Key.type: type, Key.identifier: iden, Key.anonymous: anonymous};
}
