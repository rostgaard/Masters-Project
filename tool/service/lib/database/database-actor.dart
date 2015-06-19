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
  Future<Model.Actor> get(int conceptID) {
    String sql = '''
SELECT 
  id, name, description 
FROM 
  concepts
WHERE 
  id = @conceptID ''';

    Map parameters = {'conceptID': conceptID};

    return _connection.query(sql, parameters).then((Iterable rows) {
      if (rows.isEmpty) {
        throw new StateError('No contact found with ID $conceptID');
      }

      return _rowToConcept(rows.first);
    });
  }

  /**
   *
   */
  Future<Iterable<Model.Actor>> list() {
    String sql = '''
SELECT 
  id, name, description 
FROM 
  concepts''';

    return _connection
        .query(sql)
        .then((Iterable rows) => rows.map(_rowToConcept));
  }

  /**
   *
   */
  Future<Model.Actor> create(Model.Concept concept) {
    String sql = '''
INSERT INTO 
  concepts (name, description) 
VALUES
  (@name, @description)
RETURNING 
  id''';

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

_rowToActor(var row) => new Model.Actor(row.name)
  ..description = row.description
  ..id = row.id;
