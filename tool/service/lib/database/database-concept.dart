part of tcc.service.database;

class Concept {

  /// Database connection backend.
  Connection _connection;

  /**
   * Default constructor.
   */
  Concept(Connection this._connection);

  /**
   *
   */
  Future<Model.Concept> get(int conceptID) {
    String sql = '''
SELECT 
  id, name, role, type, description 
FROM 
  concepts
WHERE 
  type = 'concept' 
AND 
  id = @conceptID ''';

    Map parameters = {'conceptID': conceptID};

    return _connection.query(sql, parameters).then((Iterable rows) {
      if (rows.isEmpty) {
        throw new StateError('No concept found with ID $conceptID');
      }

      return _rowToConcept(rows.first);
    });
  }

  /**
   *
   */
  Future<Iterable<Model.Concept>> list() {
    String sql = '''
SELECT 
  id, name, role,type, description 
FROM 
  concepts
WHERE 
  type = 'concept' 
''';

    return _connection
        .query(sql)
        .then((Iterable rows) => rows.map(_rowToConcept));
  }

  /**
   *
   */
  Future<Iterable<Model.Concept>> listAll() {
    String sql = '''
SELECT 
  id, name, role,type, description 
FROM 
  concepts''';

    return _connection
        .query(sql)
        .then((Iterable rows) => rows.map(_rowToConcept));
  }

  /**
   *
   */
  Future<Model.Concept> create(Model.Concept concept) {
    String sql = '''
INSERT INTO 
  concepts (name, role, description, type)
SELECT 
   @name, @role, @description, 'concept'
WHERE NOT EXISTS 
  (SELECT 1 FROM concepts WHERE name=@name)
RETURNING id;''';

    Map parameters = {'name': concept.type, 'role' : concept.role,
      'description': concept.description};

    return _connection.query(sql, parameters).then(
        (Iterable rows) => rows.length == 1
            ? (concept..id = rows.first.id)
            : new Future.error(new StateError('Not completed (already defined)')));
  }

  /**
   *
   */
  Future<Model.Concept> update(Model.Concept concept) {
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
      'id': concept.id,
      'role' : concept.role,
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
  Future remove(int conceptID) {
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
