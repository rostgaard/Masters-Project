library tcc.service.database;

import 'dart:async';

import 'package:postgresql/pool.dart' as PGPool;
import 'package:postgresql/postgresql.dart' as PG;
import 'package:libtcc/libtcc.dart' as Model;

part 'database/database-concept.dart';
part 'database/database-config.dart';
part 'database/database-template.dart';
part 'database/database-use_case.dart';

const String libraryName = 'tcc.service.database';

/**
 * Conversion function. Creates a [UseCase] object from a database row.
 */
Model.UseCase _rowToUseCase(var row) =>
  new Model.UseCase(row.name)
    ..description = row.description;

/**
 * Conversion function. Creates a [TestTemplate] object from a database row.
 */
Model.TestTemplate _rowToTestTemplate(var row) =>
  new Model.TestTemplate.empty()
    ..id = row.id
    ..name = row.name
    ..body = row.body
    ..description = row.description;

/**
 * Database connection class. Abstracts away connection pooling.
 */
class Connection {

  ///Connection pool
  PGPool.Pool _pool;

  /**
   * Factory method that creates a new connection (and tests it).
   */
  static Future<Connection> connect(String dsn,
      {int minimumConnections: 1, int maximumConnections: 5}) {
    Connection db = new Connection._unConnected()
      .._pool = new PGPool.Pool(dsn,
          minConnections: minimumConnections,
          maxConnections: maximumConnections);

    return db._pool.start().then((_) => db._testConnection()).then((_) => db);
  }

  /**
   * Close the connection
   */
  Future close() => _pool.stop();

  /**
   * Default internal named constructor. Provides an unconnected object.
   */
  Connection._unConnected();

  /**
   * Test the database connection by just opening and closing a connection.
   */
  Future _testConnection() =>
      this._pool.connect().then((PG.Connection conn) => conn.close());

  /**
   * Database query wrapper.
   */
  Future query(String sql, [Map parameters = null]) => this._pool
      .connect()
      .then((PG.Connection conn) => conn
          .query(sql, parameters)
          .toList()
          .whenComplete(() => conn.close()));

  /**
   * Transaction procedure wrapper.
   */
  Future runInTransaction(Future operation()) => this._pool
      .connect()
      .then((PG.Connection conn) =>
          conn.runInTransaction(operation).whenComplete(() => conn.close()));

  /**
   * Execute wrapper.
   */
  Future execute(String sql, [Map parameters = null]) => this._pool
      .connect()
      .then((PG.Connection conn) =>
          conn.execute(sql, parameters).whenComplete(() => conn.close()));
}
