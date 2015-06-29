part of tcc.service.test;

/**
 * Collection of unit tests for the database actors.
 */
void testDatabaseActor() {
  group('Database.Actor', () {
    Database.Actor actorDB;
    Database.Connection connection;
    setUp(() {

      return Database.Connection
          .connect(Config.ServiceConfiguration.databaseDSN)
          .then((Database.Connection conn) {
        connection = conn;
        actorDB = new Database.Actor(connection);
      });

    });

    tearDown (() {
      return connection.close();
    });

    /**
     * Tests creation of an [Actor] in the database.
     */
    test('create', () {
      Model.Actor actor =
          new Model.Actor.withRole('Test', 'An actor')
          ..description = 'Some actor';

      return actorDB.create(actor)
          .then((Model.Actor createdActor) {
        expect (actor.id, greaterThan(0));
        expect (actor.id, isNotNull);
        expect (actor.description, createdActor.description);
        expect (actor.role, createdActor.role);
        expect (actor.type, createdActor.type);

        return actorDB.remove(createdActor.id);

      });
    });

    /**
     * Test fetching a single actor from the database.
     */
    test('get', () {
      Model.Actor actor =
          new Model.Actor.withRole('Test', 'An actor')
          ..description = 'Some actor';

      return actorDB.create(actor)
          .then((Model.Actor createdActor) =>
              actorDB.get(createdActor.id)
                .then((Model.Actor fetchedActor) {
              expect (fetchedActor.id, greaterThan(0));
              expect (fetchedActor.id, isNotNull);
              expect (fetchedActor.description, actor.description);
              expect (fetchedActor.role, actor.role);
              expect (fetchedActor.type, actor.type);
              return actorDB.remove(createdActor.id);
      }));
    });

    /**
     * Test deleting a single actor from the database.
     */
    test('remove', () {
      Model.Actor actor =
          new Model.Actor.withRole('Test', 'An actor')
          ..description = 'Some actor';

      return actorDB.create(actor)
          .then((Model.Actor createdActor) =>
        actorDB.remove(createdActor.id));
    });

    /**
     * Test deleting a single actor from the database.
     */
    test('list', () {
      return actorDB.list()
          .then((Iterable<Model.Actor> actors) =>
              expect (actors, isNotEmpty));
    });

    /**
     * Test updating an actor from the database.
     */
    test('update', () {
      Model.Actor actor =
          new Model.Actor.withRole('Test', 'An actor')
          ..description = 'Some actor';

      return actorDB.create(actor)
          .then((Model.Actor createdActor) {

        {
          int id = createdActor.id;
          createdActor =
          new Model.Actor.withRole('Updated Test', 'Updated actor')
          ..description = 'An updated actor';
          createdActor.id = id;
        }

        return actorDB.update(createdActor)
            .then((Model.Actor updatedActor) {
          expect (updatedActor.id, createdActor.id);
          expect (updatedActor.role, createdActor.role);
          expect (updatedActor.type, createdActor.type);
          expect (updatedActor.description, createdActor.description);
          return actorDB.remove(createdActor.id);
        });

      });
    });
  });
}
