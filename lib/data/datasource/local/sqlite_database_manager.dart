import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

  static Future createEntityTable(Database db) async {
    final result = await db.execute('''
      CREATE TABLE favorites ( 
      id integer primary key, 
      name text not null,
      url text not null)
    ''');
    return result;
  }

  // static Future createAvatarTable(Database db) async {
  //   final result = await db.execute('''
  //     CREATE TABLE avatar ( 
  //     id integer primary key, 
  //     name text not null,
  //     url text not null)
  //   ''');
  //   return result;
  // }
}
