part of libtcc.base;

/**
 * Test template class.
 */
class TestTemplate {

  static const int noId = 0;

  int id;
  String name;
  String description;
  String body;

  /**
   * Default empty contructor.
   */
  TestTemplate.empty();

  /**
   * Constructor that creates a [TestTemplate] object from a deserialized map.
   */
  TestTemplate.fromMap (Map map) {
    id = map[Key.id];
    name = map[Key.name];
    description = map[Key.description];
    body = map[Key.body];
  }

  /**
   * Factory method that creates a new object from a map
   */
  static TestTemplate decode(Map map) => new TestTemplate.fromMap(map);


  /**
   * Serialization function
   */
  Map toJson() => {
    Key.id : id,
    Key.name : name,
    Key.description : description,
    Key.body : body
  };

}