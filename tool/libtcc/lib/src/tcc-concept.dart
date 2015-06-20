part of libtcc.base;

/**
 *
 */
class Concept {

  static const int noID = 0;

  int id = noID;
  String type = '';
  String description = '';
  String role = '';

  Concept(this.type);

  Concept.fromMap(Map map) {
    id = map.containsKey(Key.id) ? map[Key.id] : id;
    type = map.containsKey(Key.type) ? map[Key.type] : type;
    description = map.containsKey(Key.description)
        ? map[Key.description]
        : description;
    role = map.containsKey(Key.role) ? map[Key.role] : role;
  }

  factory Concept.withRole(String type, String role) =>
      new Actor(type)..role = role;

  Map toJson() => {
    Key.id : id,
    Key.type : type,
    Key.description : description,
    Key.role : role
  };
}