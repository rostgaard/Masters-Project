part of libtcc.base;


class Configuration {

  Uri jenkinsUri = Uri.parse('http://localhost/jenkins');
  String testLocation = '/home/krc/tests/';
  String analyzerLocation = '/home/krc/lib/dart/dart-sdk/bin/dartanalyzer';

  /**
   *
   */
  Configuration();

  /**
   *
   */
  factory Configuration.initial() => new Configuration();

  /**
   *
   */
  Configuration.fromMap(Map map) :
    jenkinsUri = Uri.parse(map[Key.jenkinsUri]),
    testLocation = map[Key.testLocation],
    analyzerLocation = map[Key.analyzerLocation]
    ;



  static Configuration decode (Map map) =>
    new Configuration.fromMap(map);
  /**
   *
   */
  Map toJson() => this.asMap;

  /**
   *
   */
  Map get asMap => {
    Key.jenkinsUri : jenkinsUri.toString(),
    Key.testLocation : testLocation,
    Key.analyzerLocation : analyzerLocation

  };

}