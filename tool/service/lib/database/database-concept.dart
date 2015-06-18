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
  id, name, description 
FROM 
  actors
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
  Future<Iterable<Model.Concept>> list() {
    String sql = '''
SELECT 
  id, name, description 
FROM 
  actors''';

    return _connection
        .query(sql)
        .then((Iterable rows) => rows.map(_rowToConcept));
  }
}

_rowToConcept(var row) => new Model.Concept(row.name);
