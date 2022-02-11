import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:star_wars_app/data/datasource/local/sqlite_database_manager.dart';
import 'package:star_wars_app/data/datasource/local/sqllite_datasource.dart';
import 'package:star_wars_app/domain/entities/entity.dart';

import '../films_response.dart';
import '../people_response.dart';

void main() async {
  // setup for the in memory database
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  // here we initialize a in memory database
  final Database db =
      await SqliteDatabaseManager.openOrCreateDatabase(inMemoryDatabasePath);

final cache = SqliteDatasource(db);
  final people = peopleResponse['results'];
  final films = filmResponse['results'];

  // sqflite return null on success
  test("Should create table", () async {
    final res = await SqliteDatabaseManager.createEntityTable(db);
    expect(res, null);
  });

  test("Should not be able to create table twice", () async {
    void createTableTwice() async {
      await SqliteDatabaseManager.createEntityTable(db);
    }

    expect(() => createTableTwice(), throwsA((e) => (e != null)));
  });

  test("Should return true insert a character with success", () async {
    final character = Entity.fromMap(people[0]);
    // print('=================================== char: ${character.toMap()}');
    final res = await cache.add('favorites', {'name': character.name, 'url': character.url, 'id': character.id});
    // final res = await cache.add('favorites', character.toMap());
    expect(res, true);
  });

  test("Should return maps of all 3 favorites characters", () async {
    final character1 = Entity.fromMap(people[1]);
    final character2 = Entity.fromMap(people[2]);
    await cache.add('favorites', {'name': character1.name, 'url': character1.url, 'id': character1.id});
    await cache.add('favorites', {'name': character2.name, 'url': character2.url, 'id': character2.id});
    final res = await cache.fetch('favorites');

    const expected = [
      {'id': 1001, 'name': 'Luke Skywalker', 'url': 'https://swapi.dev/api/people/1/'},
      {'id': 1002, 'name': 'C-3PO', 'url': 'https://swapi.dev/api/people/2/'},
      {'id': 1003, 'name': 'R2-D2', 'url': 'https://swapi.dev/api/people/3/'}
    ];

    expect(res, expected);
  });

  test("Should remove just one character from favorites",
      () async {
    final character = Entity.fromMap(people[1]);
    await cache.remove('favorites', character.id);
    final showRes = await cache.fetch('favorites');

    const expected = [
      {'id': 1001, 'name': 'Luke Skywalker', 'url': 'https://swapi.dev/api/people/1/'},
      {'id': 1003, 'name': 'R2-D2', 'url': 'https://swapi.dev/api/people/3/'}
    ];

    expect(showRes, expected);
  });

  test("Should return true when remove a character from favorites with success",
      () async {
    final character = Entity.fromMap(people[2]);
    final removeRes = await cache.remove('favorites', character.id);
    expect(removeRes, true);
  });
}
