part of tcc.service.test;

/**
 * Collection of unit tests for the database templates.
 */
void testDatabaseTemplate() {
  group('Database.Template', () {
    Database.Template templateDB;
    Database.Connection connection;
    setUp(() {

      return Database.Connection
          .connect(Config.ServiceConfiguration.databaseDSN)
          .then((Database.Connection conn) {
        connection = conn;
        templateDB = new Database.Template(connection);
      });

    });

    tearDown (() {
      return connection.close();
    });

    /**
     * Tests creation of a template in the database.
     */
    test('create', () {
      Model.TestTemplate template =
          new Model.TestTemplate.empty()
          ..name = 'Test'
          ..description = 'A tests'
          ..body = 'main() { [%TESTCASES%]]';

      return templateDB.create(template)
          .then((Model.TestTemplate createdTemplate) {
        expect (template.id, greaterThan(0));
        expect (template.id, isNotNull);
        expect (template.name, createdTemplate.name);
        expect (template.body, createdTemplate.body);
        expect (template.description, createdTemplate.description);

        return templateDB.remove(createdTemplate.id);

      });
    });

    /**
     * Test fetching a single template from the database.
     */
    test('get', () {
      Model.TestTemplate template =
          new Model.TestTemplate.empty()
          ..name = 'Test'
          ..description = 'A tests'
          ..body = 'main() { [%TESTCASES%]]';

      return templateDB.create(template)
          .then((Model.TestTemplate createdTemplate) =>
              templateDB.get(createdTemplate.id)
                .then((Model.TestTemplate fetchedTemplate) {
              expect (template.id, greaterThan(0));
              expect (template.id, isNotNull);
              expect (template.name, createdTemplate.name);
              expect (template.body, createdTemplate.body);
              expect (template.description, createdTemplate.description);
              return templateDB.remove(createdTemplate.id);
      }));
    });

    /**
     * Test deleting a single template from the database.
     */
    test('remove', () {
      Model.TestTemplate template =
          new Model.TestTemplate.empty()
          ..name = 'Test'
          ..description = 'A tests'
          ..body = 'main() { [%TESTCASES%]]';

      return templateDB.create(template)
          .then((Model.TestTemplate createdTemplate) =>
        templateDB.remove(createdTemplate.id));
    });

    /**
     * Test deleting a single template from the database.
     */
    test('list', () {
      return templateDB.list()
          .then((Iterable<Model.TestTemplate> templates) =>
              expect (templates, isNotEmpty));
    });

    /**
     * Test updating a template from the database.
     */
    test('update', () {
      Model.TestTemplate template =
          new Model.TestTemplate.empty()
          ..name = 'Test'
          ..description = 'A tests'
          ..body = 'main() { [%TESTCASES%]]';

      return templateDB.create(template)
          .then((Model.TestTemplate createdTemplate) {

        createdTemplate
            ..name = 'Updated test'
            ..description = 'An updated tests'
            ..body = 'int main() { [%TESTCASES%]]';

        return templateDB.update(createdTemplate)
            .then((Model.TestTemplate updatedTemplate) {
          expect (updatedTemplate.id, createdTemplate.id);
          expect (updatedTemplate.name, createdTemplate.name);
          expect (updatedTemplate.body, createdTemplate.body);
          expect (updatedTemplate.description, createdTemplate.description);
          return templateDB.remove(createdTemplate.id);
        });

      });
    });
  });
}
