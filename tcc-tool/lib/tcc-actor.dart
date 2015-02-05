part of tcc;

class Actor {
  String type;
  String iden;
  static const String anonID = '__anonymous_actor_';
  bool anonymous = true;

  Actor(this.type, {String this.iden : ''}) {
    if (this.iden.isEmpty) {
      this.iden = anonID + this.type.toLowerCase();
    } else {
      anonymous = false;
    }
  }

  @override
  String toString () => '${this.type}${this.iden.isNotEmpty ? ' ${this.iden}' : ''}';

  @override
  int get hashCode => this.iden.hashCode;

  @override
  bool operator ==(Actor other) => this.iden == other.iden;
}
