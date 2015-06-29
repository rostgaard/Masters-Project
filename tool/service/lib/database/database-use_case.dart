part of tcc.service.database;



class UseCase {

  /// Database connection backend.
  Connection _connection;

  /**
   * Default constructor.
   */
  UseCase(Connection this._connection);

  /**
   *
   */
  Future<Model.UseCase> get(int useCaseID) {
    String sql = '''
SELECT 
  use_case.id          AS id, 
  use_case.name        AS name,
  scenario,
  extensions,
  preconditions,
  postconditions,
  use_case.description AS description,
  actor.id             AS actor_id,
  actor.name           AS actor_name,
  actor.role           AS actor_role,
  actor.description    AS actor_description
FROM 
  use_cases use_case
JOIN 
  concepts actor 
ON 
  actor.id = primary_role_id 
AND 
  actor.type = 'actor'
WHERE
  use_case.id = @useCaseID
''';

    Map parameters = {'useCaseID': useCaseID};

    return _connection.query(sql, parameters).then(
        (Iterable rows) => rows.isEmpty
            ? new Future.error(
                new StateError('No use case found with ID $useCaseID'))
            : _rowToUseCase(rows.first));
  }

  /**
   *
   */
  Future<Iterable<Model.UseCase>> list() {
    String sql = '''
SELECT 
  use_case.id AS id, 
  use_case.name AS name,
  scenario,
  preconditions,
  postconditions,
  extensions,
  use_case.description AS description,
  actor.name AS actor_name,
  role.name AS actor_role
FROM 
  use_cases use_case
JOIN 
  actor_roles role 
ON
  use_case.primary_role_id = role.id
JOIN 
  actors actor
ON role.actor_id = actor.id;
WHERE
  use_case.id = @useCaseID
''';
    return _connection
        .query(sql)
        .then((Iterable rows) => rows.map(_rowToConcept));
  }

  /**
   *
   */
  Future<Model.UseCase> create(Model.UseCase useCase) {
    String sql = '''
INSERT INTO 
  use_cases 
   (name, primary_role_id, scenario, extensions, 
    description, preconditions, postconditions)
VALUES 
  (@name, @actor_id, @scenario, @extensions, 
   @description, @preconditions, @postconditions)
RETURNING 
  id
''';

    Map parameters = {
      'name': useCase.name,
      'actor_id': useCase.primaryActor.id,
      'scenario': JSON.encode(useCase.scenario.toJson()),
      'extensions': JSON.encode(useCase.extensions
          .map((ext) => ext.toJson())
          .toList(growable: false)),
      'preconditions': JSON.encode(useCase.preconditions.toJson()),
      'postconditions': JSON.encode(useCase.postconditions.toJson()),
      'description': useCase.description
    };

    return _connection.query(sql, parameters).then(
        (Iterable rows) => rows.length == 1
            ? (useCase..id = rows.first.id)
            : new Future.error(
                new StateError('Not completed: rowsAffected ${rows.length}')));
  }

  /**
   * Update an exisiting use case in the database.
   */
  Future<Model.UseCase> update(Model.UseCase useCase) {
    String sql = '''
UPDATE
  use_cases
SET
  name = @name,
  primary_role_id = @actor_id,
  scenario = @scenario,
  extensions = @extensions, 
  preconditions = @preconditions,
  postconditions = @postconditions,
  description = @description 
WHERE
  id = @id''';

    Map parameters = {
      'id' : useCase.id,
      'name': useCase.name,
      'actor_id': useCase.primaryActor.id,
      'scenario': JSON.encode(useCase.scenario.toJson()),
      'extensions': JSON.encode(useCase.extensions
          .map((ext) => ext.toJson())
          .toList(growable: false)),
      'preconditions': JSON.encode(useCase.preconditions.toJson()),
      'postconditions': JSON.encode(useCase.postconditions.toJson()),
      'description': useCase.description
    };

    return _connection.execute(sql, parameters).then(
        (int rowsAffected) => rowsAffected == 1
            ? useCase
            : new Future.error(new StateError('Not completed')));
  }

  /**
   *
   */
  Future remove(int useCaseID) {
    String sql = '''
DELETE FROM 
  use_cases
WHERE
  id = @id''';
    Map parameters = {'id': useCaseID};

    return _connection.execute(sql, parameters).then(
        (int rowsAffected) => rowsAffected == 1
            ? null
            : new Future.error(new StateError('Not completed')));
  }
}
