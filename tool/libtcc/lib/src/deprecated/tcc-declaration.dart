part of libtcc.base;

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

// Mappings of type 'hints' to classes.
final Map<String, String> classMap = {'message': 'Message'};

String lookupClass(String className) {
if (!classMap.containsKey(className)) {
 throw new ArgumentError(
     'Class $className not found in classMap, consider adding a mapping.');
}

return classMap[className];
}
