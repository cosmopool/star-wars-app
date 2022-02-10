import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:star_wars_app/data/datasource/sqlite_database_manager.dart';
import 'package:star_wars_app/data/datasource/sqllite_datasource.dart';
import 'package:star_wars_app/domain/entities/character_entity.dart';
import 'package:star_wars_app/domain/entities/film_entity.dart';

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
  test("Should create table with characters entity type name", () async {
    final entity = CharacterEntity.fromMap(people[0]);
    final res = await SqliteDatabaseManager.createEntityTable(db, entity);
    expect(res, null);
  });

  // sqflite return null on success
  test("Should create table with films entity type name", () async {
    final entity = FilmEntity.fromMap(films[0]);
    final res = await SqliteDatabaseManager.createEntityTable(db, entity);
    expect(res, null);
  });

  test("Should not be able to create table films twice", () async {
    final entity = FilmEntity.fromMap(films[0]);
    void createTableTwice() async {
      await SqliteDatabaseManager.createEntityTable(db, entity);
    }

    expect(() => createTableTwice(), throwsA((e) => (e != null)));
  });

  test("Should not be able to create table characters twice", () async {
    final entity = CharacterEntity.fromMap(people[0]);
    void createTableTwice() async {
      await SqliteDatabaseManager.createEntityTable(db, entity);
    }

    expect(() => createTableTwice(), throwsA((e) => (e != null)));
  });

  test("Should return character id 0 when insert a character", () async {
    final character = CharacterEntity.fromMap(people[0]);
    final res = await cache.add(character.toString(), character.toMap());
    expect(res.error, false);
    expect(res.result[0], 1);
  });

  test("Should return maps of all 3 favorites characters", () async {
    final character1 = CharacterEntity.fromMap(people[1]);
    final character2 = CharacterEntity.fromMap(people[2]);
    await cache.add(character1.toString(), character1.toMap());
    await cache.add(character2.toString(), character2.toMap());
    final res = await cache.show('characters');

    const expected = [
      {'id': 1, 'name': 'Luke Skywalker', 'url': 'https://swapi.dev/api/people/1/'},
      {'id': 2, 'name': 'C-3PO', 'url': 'https://swapi.dev/api/people/2/'},
      {'id': 3, 'name': 'R2-D2', 'url': 'https://swapi.dev/api/people/3/'}
    ];

    expect(res.error, false);
    expect(res.result, expected);
  });

  test("Should remove just one character from favorites",
      () async {
    final character = CharacterEntity.fromMap(people[1]);
    final removeRes = await cache.remove(character.toString(), character.id);
    final showRes = await cache.show('characters');

    const expected = [
      {'id': 1, 'name': 'Luke Skywalker', 'url': 'https://swapi.dev/api/people/1/'},
      {'id': 3, 'name': 'R2-D2', 'url': 'https://swapi.dev/api/people/3/'}
    ];

    expect(removeRes.error, false);
    expect(showRes.result, expected);
  });

  test("Should return 1 when remove a character from favorites with success",
      () async {
    final character = CharacterEntity.fromMap(people[2]);
    final removeRes = await cache.remove(character.toString(), character.id);
    expect(removeRes.error, false);
    expect(removeRes.result, [1]);
  });

}
