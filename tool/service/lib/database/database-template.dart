part of tcc.service.database;

class Template {

  /// Database connection backend.
  Connection _connection;

  /**
   * Default constructor.
   */
  Template(Connection this._connection);

  /**
   * Get a single test template.
   */
  Future<Model.TestTemplate> get(int templateID) {
    String sql = '''
SELECT 
  name, body, description 
FROM 
  templates 
WHERE 
  id = @templateID
''';

    Map parameters = {'templateID': templateID};

    return _connection.query(sql, parameters).then((Iterable rows) =>
      rows.isEmpty
      ? new Future.error
          (new StateError('No use templates found with ID $templateID'))
      : _rowToTestTemplate(rows.first));
  }

  /**
   * List all test templates.
   */
  Future<Iterable<Model.TestTemplate>> list() {
    String sql = '''
SELECT 
  name, body, description 
FROM 
  templates 
''';
    return _connection
        .query(sql)
        .then((Iterable rows) => rows.map(_rowToConcept));
  }

  /**
   * Create a new [TestTemplate].
   */
  Future<Model.TestTemplate> create(Model.TestTemplate testTemplate) {
    String sql = '''
INSERT INTO 
  templates (name, body, description)
VALUES 
  (@name, @body, @description)
RETURNING id
''';

    Map parameters =
      {'name': testTemplate.name,
       'description': testTemplate.description,
       'body': testTemplate.body};

    return _connection.query(sql, parameters).then(
        (Iterable rows) =>
            rows.isNotEmpty
            ? (testTemplate..id = rows.first.id)
            : new Future.error(new StateError('Not completed')));
  }

  /**
   *
   */
  Future<Model.TestTemplate> update(Model.TestTemplate template) {
    String sql = '''
UPDATE
  templates
SET
  name = @name, 
  body = @body,
  description = @description
WHERE
  id = @id''';

    Map parameters = {
      'id': template.id,
      'name': template.name,
      'body' : template.body,
      'description': template.description
    };

    return _connection.execute(sql, parameters).then(
        (int rowsAffected) => rowsAffected == 1
            ? template
            : new Future.error(new StateError('Not completed')));
  }

  /**
   * Remove a single template from the database.
   */
  Future remove(int templateID) {
    String sql = '''
DELETE FROM 
  templates
WHERE
  id = @id''';
    Map parameters = {'id': templateID};

    return _connection.execute(sql, parameters).then(
        (int rowsAffected) => rowsAffected == 1
            ? null
            : new Future.error(new StateError('Not completed')));
  }
}
