part of libtcc.base;

class GeneratedTest {

  String testBody = '';
  List<String> analysisOutput = [];

  /**
   * Deserializing constructor.
   */
  GeneratedTest.fromMap(Map map) {
    testBody = map[Key.body];
    analysisOutput = map[Key.output];
  }

  /**
   * Default generating constructor.
   */
  GeneratedTest (UseCase uc, Definitions defs, TestTemplate template) {
    testBody = useCasesToCode (uc, defs, template.body);
  }

  /**
   * Decoder.
   */
  static GeneratedTest decode (Map map) => new GeneratedTest.fromMap(map);

  /**
   * Serialization.
   */
  Map toJson() => {
    Key.body : testBody,
    Key.output : analysisOutput
  };

}