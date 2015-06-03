part of tcc;

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

  @override
  String toString() => '${this.type}${!this.anonymous ? ' ${this.iden}' : ''}';

  @override
  int get hashCode => this.iden.hashCode;

  @override
  bool operator ==(Target other) => this.iden == other.iden;

  Map toJson() =>
      {Key.type: type, Key.identity: iden, Key.anonymous: anonymous};
}
