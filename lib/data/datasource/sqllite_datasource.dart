import 'package:sqflite/sqflite.dart';
import 'package:star_wars_app/core/response.dart';
import 'package:star_wars_app/infra/datasources/cache_datasource_interface.dart';

class SqliteDatasource implements ICacheDatasource {
  final Database _database;

  SqliteDatasource(this._database);

  @override
  Future<Response> add(String table, Map entry) async {
    try {
      final result = await _database.insert(table, entry.cast());
      return Response.onSuccess([result]);
    } catch (e) {
      return Response.onError("Error inserting entry in database: $e");
    }
  }

  // raw delete
  @override
  Future<Response> remove(String table, int id) async {
    try {
      // final result = await _database.delete(table, where: 'id', whereArgs: [id]);
      final result = await _database.transaction((t) async {
        return await t.rawDelete('DELETE FROM $table WHERE id = $id');
      });
      return Response.onSuccess([result]);
    } catch (e) {
      return Response.onError("Error inserting entry in database: $e");
    }
  }

  // return all favorite entities for a given table
  @override
  Future<Response> show(String table) async {
    try {
      final result = await _database.query(table);
      return Response.onSuccess(result);
    } catch (e) {
      return Response.onError("Error inserting entry in database: $e");
    }
  }
}
