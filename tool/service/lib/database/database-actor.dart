part of tcc.service.database;

class Actor {

  /// Database connection backend.
  Connection _connection;

  /**
   * Default constructor.
   */
  Actor(Connection this._connection);

  /**
   *
   */
  Future<Model.Actor> get(int actorID) {
    String sql = '''
SELECT 
  id, name, role,type, description 
FROM 
  concepts
WHERE 
  type = 'actor' 
AND 
  id = @actorID ''';

    Map parameters = {'actorID': actorID};

    return _connection.query(sql, parameters).then((Iterable rows) {
      if (rows.isEmpty) {
        throw new StateError('No actor found with ID $actorID');
      }

      return _rowToActor(rows.first);
    });
  }

  /**
   *
   */
  Future<Iterable<Model.Actor>> list() {
    String sql = '''
SELECT 
  id, name, role,type, description 
FROM 
  concepts
WHERE 
  type = 'actor' 
''';

    return _connection
        .query(sql)
        .then((Iterable rows) => rows.map(_rowToActor));
  }

  /**
   *
   */
  Future<Model.Actor> create(Model.Actor actor) {
    String sql = '''
INSERT INTO 
  concepts (name, role, description, type)
SELECT 
   @name, @role, @description, 'actor'
WHERE NOT EXISTS 
  (SELECT 1 FROM concepts WHERE name=@name)
RETURNING id;''';

    Map parameters = {'name': actor.type, 'role' : actor.role,
      'description': actor.description};

    return _connection.query(sql, parameters).then(
        (Iterable rows) => rows.length == 1
            ? (actor..id = rows.first.id)
            : new Future.error(new StateError('Not completed (already defined)')));
  }

  /**
   *
   */
  Future<Model.Actor> update(Model.Actor actor) {
    String sql = '''
UPDATE
  concepts
SET
  name = @name, 
  role = @role,
  description = @description 
WHERE
  id = @id''';

    Map parameters = {
      'id': actor.id,
      'role' : actor.role,
      'name': actor.type,
      'description': actor.description
    };

    return _connection.execute(sql, parameters).then(
        (int rowsAffected) => rowsAffected == 1
            ? actor
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
    Map parameters = {'id': actorID};

    return _connection.execute(sql, parameters).then(
        (int rowsAffected) => rowsAffected == 1
            ? null
            : new Future.error(new StateError('Not completed')));
  }
}
