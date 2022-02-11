import 'package:sqflite/sqflite.dart';
import 'package:star_wars_app/infra/datasources/cache_datasource_interface.dart';

class SqliteDatasource implements ICacheDatasource {
  final Database _database;

  SqliteDatasource(this._database);

  @override
  Future<bool> add(String table, Map entry) async {
    final res = await _database.insert(table, entry.cast());
    return (res == 0) ? false : true;
  }

  // raw delete
  @override
  Future<bool> remove(String table, int id) async {
    return await _database.transaction((t) async {
      final res = await t.rawDelete('DELETE FROM $table WHERE id = $id');
      return (res == 0) ? false : true;
    });
  }

  // return all favorite entities for a given table
  @override
  Future<List<Map>> fetch(String table) async {
    return await _database.query(table);
  }
}
