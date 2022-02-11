import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:star_wars_app/domain/entities/entity.dart';

/// class to initialize and create databases
class SqliteDatabaseManager {
  static Future<String> getDatabasePath(String databaseName) async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);
    return path;
  }

  static Future<Database> openOrCreateDatabase(String databaseName) async {
    return await openDatabase(databaseName);
  }

  static Future createEntityTable(Database db, Entity entity) async {
    final map = entity.toMap();
    final nameColumn = (map['title'] != null) ? 'title' : 'name';

    // final result = await db.execute('''
    //   CREATE TABLE ${entity.toString()} ( 
    //   id integer primary key, 
    //   $nameColumn text not null,
    //   url text not null)
    // ''');
    final result = await db.execute('''
      CREATE TABLE favorites ( 
      id integer primary key, 
      $nameColumn text not null,
      url text not null)
    ''');
    return result;
  }
}
