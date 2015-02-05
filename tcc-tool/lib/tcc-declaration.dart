part of tcc;

class Declaration {
  String type;
  String iden;

  Declaration.fromStatement(Statement stmt) {
    this.type = lookupClass(stmt.object.type);
    this.iden = stmt.object.iden;
  }

  @override
  String toString () => '${this.type} ${this.iden}';

  @override
  int get hashCode => this.iden.hashCode;

  @override
  bool operator ==(Declaration other) => this.iden == other.iden;
}