part of tcc.service.database;

class Config {

  /// Database connection backend.
  Connection _connection;

  /**
   * Default constructor.
   */
  Config (Connection this._connection);

  /**
   *
   */
  Future<Model.Configuration> load() {
    String sql = 'SELECT client FROM configuration';

    return _connection.query(sql).then((Iterable rows) =>
      rows.isEmpty
      ? new Model.Configuration.initial()
      : _rowToConfiguration(rows.first));
  }

  /**
   *
   */
  Future<Model.Configuration> save(Model.Configuration config) {
    String sql = '''
UPDATE
  configuration
SET
  client = @json
''';

    Map parameters = {'json' : config.asMap};

    return _connection.query(sql, parameters).then((_) => config);
  }
}

_rowToActor(var row) => new Model.Actor(row.name)
  ..description = row.description
  ..id = row.id;

_rowToConfiguration (var row) =>
    new Model.Configuration.fromMap(row.client);
