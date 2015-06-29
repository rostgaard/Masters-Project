part of tcc.service.test;

/**
 * Collection of unit tests for the database templates.
 */
void testDatabaseConfig() {
  group('Database.Config', () {
    Database.Config configDB;
    Database.Connection connection;
    setUp(() {

      return Database.Connection
          .connect(Config.ServiceConfiguration.databaseDSN)
          .then((Database.Connection conn) {
        connection = conn;
        configDB = new Database.Config(connection);
      });

    });

    tearDown (() {
      return connection.close();
    });

    /**
     * Tests saving of config in database.
     */
    test('save', () {
      Model.Configuration config =
          new Model.Configuration()
           ..jenkinsUri = Uri.parse('http://localhost:3456');

      return configDB.save(config)
          .then((Model.Configuration savedConfig) {
        expect (savedConfig.jenkinsUri, isNotNull);
        expect (savedConfig.jenkinsUri.toString(),
            equals(config.jenkinsUri.toString()));
      });
    });

    /**
     * Test loading of config from the database.
     */
    test('load', () {
      Model.Configuration config =
          new Model.Configuration()
           ..jenkinsUri = Uri.parse('http://localhost:3456');

      return configDB.save(config)
          .then((_) =>
              configDB.load().then((Model.Configuration loadedConfig) {
        expect (loadedConfig.jenkinsUri, isNotNull);
        expect (loadedConfig.jenkinsUri.toString(),
            equals(config.jenkinsUri.toString()));

      }));
    });
  });
}
