part of libtcc.base;

abstract class Key {
  static const String id = 'id';
  static const String identity = 'identity';
  static const String identifier = 'identifier';
  static const String name = 'name';
  static const String description = 'description';
  static const String preconditions = 'preconditions';
  static const String statements = 'statements';
  static const String postconditions = 'postconditions';
  static const String stakeholders = 'stakeholders';
  static const String expression = 'expression';
  static const String matcher = 'matcher';
  static const String expectation = 'expectation';
  static const String type = 'type';
  static const String value = 'value';
  static const String role = 'role';
  static const String anonymous = 'anonymous';
  static const String actor = 'actor';
  static const String action = 'action';
  static const String target = 'target';
  static const String jenkinsUri = 'jenkinsUri';
  static const String testLocation = 'testLocation';
  static const String analyzerLocation = 'analyzerLocation';
  static const String primaryActor= 'primaryActor';
  static const String scenario = 'scenario';
  static const String extensions = 'extensions';
  static const String body = 'body';
  static const String extensionOf = 'extensionOf';
  static const String returnsTo = 'returnsTo';
  static const String entries = 'entries';
  static const String output = 'output';
}