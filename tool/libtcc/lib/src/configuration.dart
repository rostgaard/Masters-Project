part of libtcc.base;


class Configuration {

  Uri jenkinsUri = Uri.parse('http://localhost/jenkins');

  Configuration();

  factory Configuration.initial() => new Configuration();

  Configuration.fromMap(Map map) :
    jenkinsUri = Uri.parse(map[Key.jenkinsUri]);

  Map toJson() => this.asMap;

  Map get asMap => {
    Key.jenkinsUri : jenkinsUri
  };

}