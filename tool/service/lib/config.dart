library tcc.service.configuration;

class ServiceConfiguration {
  static const String dbuser = 'tcc';
  static const String dbpassword = 'tccservice';
  static const String dbhost = 'localhost';
  static const String dbport = '5432';
  static const String dbname = 'tcc';

  static String get databaseDSN =>
      'postgres://${dbuser}:${dbpassword}@${dbhost}:${dbport}/${dbname}';
}
