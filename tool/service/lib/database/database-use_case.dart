part of tcc.service.database;

//INSERT INTO concepts (name, description)
//       SELECT 'test1', ''
//       WHERE NOT EXISTS (SELECT id FROM concepts WHERE name='test1')
//       RETURNING id;

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
  use_case.id AS id, 
  use_case.name AS name,
  scenario,
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
ON role.actor_id = actor.id
WHERE
  use_case.id = @useCaseID
''';

    Map parameters = {'useCaseID': useCaseID};

    return _connection.query(sql, parameters).then((Iterable rows) =>
      rows.isEmpty
      ? new Future.error (new StateError('No use case found with ID $useCaseID'))
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
INSERT INTO use_cases (name, primary_role_id, scenario, extensions, description)
VALUES ('Transfer call', 1, '[]', '[]', 'Transfer an inbound call'),
       ('Send message', 2, '[]', '[]', 'Send a message to an employee');

''';

    Map parameters = {'name': concept.type, 'description': concept.description};

    print(sql);
    print(parameters);
    return _connection.query(sql, parameters).then(
        (Iterable rows) => rows.length == 1
            ? (concept..id = rows.first.id)
            : new Future.error(new StateError('Not completed')));
  }

  /**
   *
   */
  Future<Model.Actor> update(Model.Actor concept) {
    String sql = '''
UPDATE
  concepts
SET
  name = @name, 
  description = @description 
WHERE
  id = @id''';

    Map parameters = {
      'id': concept.id,
      'name': concept.type,
      'description': concept.description
    };

    return _connection.execute(sql, parameters).then(
        (int rowsAffected) => rowsAffected == 1
            ? concept
            : new Future.error(new StateError('Not completed')));
  }

  /**
   *
   */
  Future remove(int actorID) {
    String sql = '''
DELETE FROM 
  concepts
WHERE
  id = @id''';
    Map parameters = {'id': conceptID};

    return _connection.execute(sql, parameters).then(
        (int rowsAffected) => rowsAffected == 1
            ? null
            : new Future.error(new StateError('Not completed')));
  }
}

Model.UseCase _rowToUseCase(var row) =>
  new Model.UseCase(row.name)
    ..description = row.description;