part of tcc.service.test;

/**
 * Collection of unit tests for the database concepts.
 */
void testDatabaseConcept() {
  group('Database.Concept', () {
    Database.Concept conceptDB;
    Database.Connection connection;
    setUp(() {

      return Database.Connection
          .connect(Config.ServiceConfiguration.databaseDSN)
          .then((Database.Connection conn) {
        connection = conn;
        conceptDB = new Database.Concept(connection);
      });

    });

    tearDown (() {
      return connection.close();
    });

    /**
     * Tests creation of a concept in the database.
     */
    test('create', () {
      Model.Concept concept =
          new Model.Concept.withRole('Test', 'A Concept')
          ..description = 'Some concept';

      return conceptDB.create(concept)
          .then((Model.Concept createdConcept) {
        expect (concept.id, greaterThan(0));
        expect (concept.id, isNotNull);
        expect (concept.description, createdConcept.description);
        expect (concept.role, createdConcept.role);
        expect (concept.type, createdConcept.type);

        return conceptDB.remove(createdConcept.id);

      });
    });

    /**
     * Test fetching a single concept from the database.
     */
    test('get', () {
      Model.Concept concept =
          new Model.Concept.withRole('Test', 'A Concept')
          ..description = 'Some concept';

      return conceptDB.create(concept)
          .then((Model.Concept createdConcept) =>
              conceptDB.get(createdConcept.id)
                .then((Model.Concept fetchedConcept) {
              expect (concept.id, greaterThan(0));
              expect (concept.id, isNotNull);
              expect (concept.description, createdConcept.description);
              expect (concept.role, createdConcept.role);
              expect (concept.type, createdConcept.type);
              return conceptDB.remove(createdConcept.id);
      }));
    });

    /**
     * Test deleting a single concept from the database.
     */
    test('remove', () {
      Model.Concept concept =
          new Model.Concept.withRole('Test', 'A Concept')
          ..description = 'Some concept';

      return conceptDB.create(concept)
          .then((Model.Concept createdConcept) =>
        conceptDB.remove(createdConcept.id));
    });

    /**
     * Test deleting a single concept from the database.
     */
    test('list', () {
      return conceptDB.list()
          .then((Iterable<Model.Concept> concepts) =>
              expect (concepts, isNotEmpty));
    });

    /**
     * Test updating a concept from the database.
     */
    test('update', () {
      Model.Concept concept =
          new Model.Concept.withRole('Test', 'A Concept')
          ..description = 'Some concept';

      return conceptDB.create(concept)
          .then((Model.Concept createdConcept) {

        {
          int id = createdConcept.id;
          createdConcept =
          new Model.Concept.withRole('Updated Test', 'Updated concept')
          ..description = 'An updated concept';
          createdConcept.id = id;
        }

        return conceptDB.update(createdConcept)
            .then((Model.Concept updatedConcept) {
          expect (updatedConcept.id, createdConcept.id);
          expect (updatedConcept.role, createdConcept.role);
          expect (updatedConcept.type, createdConcept.type);
          expect (updatedConcept.description, createdConcept.description);
          return conceptDB.remove(createdConcept.id);
        });

      });
    });
  });
}
