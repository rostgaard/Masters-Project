library tcc.service.database;

import 'dart:async';

import 'package:postgresql/pool.dart' as PGPool;
import 'package:postgresql/postgresql.dart' as PG;
import 'package:libtcc/libtcc.dart' as Model;

part 'database/database-concept.dart';
part 'database/database-config.dart';
part 'database/database-use_case.dart';

const String libraryName = 'tcc.service.database';

class Connection {
  PGPool.Pool _pool;

  static Future<Connection> connect(String dsn,
      {int minimumConnections: 1, int maximumConnections: 5}) {
    Connection db = new Connection._stub()
      .._pool = new PGPool.Pool(dsn,
          minConnections: minimumConnections,
          maxConnections: maximumConnections);

    return db._pool.start().then((_) => db._testConnection()).then((_) => db);
  }

  Connection._stub();

  Future _testConnection() =>
      this._pool.connect().then((PG.Connection conn) => conn.close());

  Future query(String sql, [Map parameters = null]) => this._pool
      .connect()
      .then((PG.Connection conn) => conn
          .query(sql, parameters)
          .toList()
          .whenComplete(() => conn.close()));

  Future runInTransaction(Future operation()) => this._pool
      .connect()
      .then((PG.Connection conn) =>
          conn.runInTransaction(operation).whenComplete(() => conn.close()));

  Future execute(String sql, [Map parameters = null]) => this._pool
      .connect()
      .then((PG.Connection conn) =>
          conn.execute(sql, parameters).whenComplete(() => conn.close()));
}
