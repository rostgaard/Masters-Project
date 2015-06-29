part of tcc.service.test;

/**
 * Collection of unit tests for the database use cases.
 */
void testDatabaseUseCase() {



  group('Database.UseCase', () {
    Logger log = new Logger('Database.UseCase');
    Database.UseCase useCaseDB;
    Database.Connection connection;
    setUp(() {

      return Database.Connection
          .connect(Config.ServiceConfiguration.databaseDSN)
          .then((Database.Connection conn) {
        connection = conn;
        useCaseDB = new Database.UseCase(connection);
      });

    });

    tearDown (() {
      return connection.close();
    });

    /**
     * Tests creation of a use case in the database.
     */
    test('create', () {

      Model.UseCase useCase =
          new Model.UseCase('A use case meant for creation test')
           ..description = 'Another use case'
           ..extensions = []
          ..postconditions = new Model.UseCaseBlock([])
          ..preconditions = new Model.UseCaseBlock([])
          ..primaryActor = (new Model.Actor.withRole('Admin', 'admin')..id = 1)
          ..scenario = new Model.UseCaseBlock([])
          ..stakeholders = [];

      log.info('Creating new usecase.');
      return useCaseDB.create(useCase)
          .then((Model.UseCase createdUsecase) {
        log.info('Created new usecase - running expectations.');
        expect (useCase.id, greaterThan(0));
        expect (useCase.id, isNotNull);
        expect (useCase.description, createdUsecase.description);
        expect (useCase.extensions, createdUsecase.extensions);
        expect (useCase.postconditions, createdUsecase.postconditions);
        expect (useCase.preconditions, createdUsecase.preconditions);
        expect (useCase.primaryActor, createdUsecase.primaryActor);
        expect (useCase.scenario, createdUsecase.scenario);
        expect (useCase.stakeholders, createdUsecase.stakeholders);

        log.info('Expectations OK, removing newly created use case'
            ' with id ${createdUsecase.id}.');
        return useCaseDB.remove(createdUsecase.id);

      });
    });

    /**
     * Test fetching a single concept from the database.
     */
    test('get', () {

      Model.UseCase useCase =
          new Model.UseCase('A use case meant for get test')
           ..description = 'Another use case'
           ..extensions = []
          ..postconditions = new Model.UseCaseBlock([])
          ..preconditions = new Model.UseCaseBlock([])
          ..primaryActor = (new Model.Actor.withRole('Admin', 'admin')..id = 1)
          ..scenario = new Model.UseCaseBlock([])
          ..stakeholders = [];

      log.info('Creating new usecase.');
      return useCaseDB.create(useCase)
          .then((Model.UseCase createdUsecase) =>
              useCaseDB.get(createdUsecase.id)
              .then((Model.UseCase fetchedUsecase) {
        log.info('Created new usecase - running expectations.');
        expect (useCase.id, greaterThan(0));
        expect (useCase.id, isNotNull);
        expect (useCase.description, fetchedUsecase.description);
        expect (useCase.extensions, fetchedUsecase.extensions);
        expect (useCase.postconditions, fetchedUsecase.postconditions);
        expect (useCase.preconditions, fetchedUsecase.preconditions);
        expect (useCase.primaryActor, fetchedUsecase.primaryActor);
        expect (useCase.scenario, fetchedUsecase.scenario);
        expect (useCase.stakeholders, fetchedUsecase.stakeholders);

        log.info('Expectations OK, removing newly created use case'
            ' with id ${createdUsecase.id}.');
        return useCaseDB.remove(createdUsecase.id);

      }));
    });
//
//    /**
//     * Test deleting a single concept from the database.
//     */
//    test('remove', () {
//      Model.Concept concept =
//          new Model.Concept.withRole('Test', 'A Concept')
//          ..description = 'Some concept';
//
//      return conceptDB.create(concept)
//          .then((Model.Concept createdConcept) =>
//        conceptDB.remove(createdConcept.id));
//    });
//
//    /**
//     * Test deleting a single concept from the database.
//     */
//    test('list', () {
//      return conceptDB.list()
//          .then((Iterable<Model.Concept> concepts) =>
//              expect (concepts, isNotEmpty));
//    });
//
    /**
     * Test updating a concept from the database.
     */
    test('update', () {
      Model.UseCase useCase =
          new Model.UseCase('A use case to update')
           ..description = 'Another use case meant to be updated'
           ..extensions = []
          ..postconditions = new Model.UseCaseBlock([])
          ..preconditions = new Model.UseCaseBlock([])
          ..primaryActor = (new Model.Actor.withRole('Admin', 'admin')..id = 1)
          ..scenario = new Model.UseCaseBlock([])
          ..stakeholders = [];

      log.info('Creating new usecase.');
      return useCaseDB.create(useCase)
          .then((Model.UseCase createdUsecase) {
        log.info('Created new usecase - running expectations.');

        {
          createdUsecase
             ..name = 'An updated use case'
             ..description = 'Another use case that was updated'
             ..extensions = []
             ..postconditions = new Model.UseCaseBlock([])
             ..preconditions = new Model.UseCaseBlock([])
             ..primaryActor = (new Model.Actor.withRole('User', 'user')..id = 1)
             ..scenario = new Model.UseCaseBlock([])
             ..stakeholders = [];
        }

        return useCaseDB.update(createdUsecase)
            .then((Model.UseCase updatedUseCase) {
          log.info('Created new usecase - running expectations.');
          expect (useCase.id, greaterThan(0));
          expect (useCase.id, isNotNull);
          expect (useCase.description, updatedUseCase.description);
          expect (useCase.extensions, updatedUseCase.extensions);
          expect (useCase.postconditions, updatedUseCase.postconditions);
          expect (useCase.preconditions, updatedUseCase.preconditions);
          expect (useCase.primaryActor, updatedUseCase.primaryActor);
          expect (useCase.scenario, updatedUseCase.scenario);
          expect (useCase.stakeholders, updatedUseCase.stakeholders);

          log.info('Expectations OK, removing newly created use case'
              ' with id ${createdUsecase.id}.');
          return useCaseDB.remove(createdUsecase.id);
        });

      });
    });
  });
}
