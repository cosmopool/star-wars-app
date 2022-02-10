import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:star_wars_app/data/datasource/sqlite_database_manager.dart';
import 'package:star_wars_app/data/datasource/sqllite_datasource.dart';
import 'package:star_wars_app/domain/entities/character_entity.dart';
import 'package:star_wars_app/domain/entities/film_entity.dart';
import 'package:star_wars_app/infra/repositories/favorites_repository.dart';

import '../../films_response.dart';
import '../../people_response.dart';

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

  // setup stub entities
  final character = CharacterEntity.fromMap(people[0]);
  final character1 = CharacterEntity.fromMap(people[1]);
  final character2 = CharacterEntity.fromMap(people[2]);
  final film = FilmEntity.fromMap(films[0]);

  // setup database, creating tables
  await SqliteDatabaseManager.createEntityTable(db, film);
  await SqliteDatabaseManager.createEntityTable(db, character);
  // setup repository instance
  final repository = FavoritesRepository(cache);

  test("Should return 1 when insert a film successfuly", () async {
    final res = await repository.add(film);
    expect(res.result, [1]);
  });

  test("Should return 1 when insert a character successfuly", () async {
    final res = await repository.add(character);
    expect(res.result, [1]);
  });

  test("Should return maps of all 2 favorites films", () async {
    final _film = FilmEntity.fromMap(films[1]);
    await repository.add(_film);
    final res = await repository.fetch(_film.toString());

    const expected = [
      {'id': 1, 'name': 'A New Hope', 'url': 'https://swapi.dev/api/films/1/'},
      {'id': 2, 'name': 'The Empire Strikes Back', 'url': 'https://swapi.dev/api/films/2/'}
    ];

    expect(res.result, expected);
  });

  test("Should return maps of all 3 favorites characters", () async {
    await repository.add(character1);
    await repository.add(character2);
    final res = await repository.fetch('characters');

    const expected = [
      {
        'id': 1,
        'name': 'Luke Skywalker',
        'url': 'https://swapi.dev/api/people/1/'
      },
      {'id': 2, 'name': 'C-3PO', 'url': 'https://swapi.dev/api/people/2/'},
      {'id': 3, 'name': 'R2-D2', 'url': 'https://swapi.dev/api/people/3/'}
    ];

    expect(res.result, expected);
  });

  test("Should remove just one character from favorites", () async {
    final character = CharacterEntity.fromMap(people[1]);
    final res = await repository.remove(character);
    final showRes = await repository.fetch('characters');

    const expected = [
      {
        'id': 1,
        'name': 'Luke Skywalker',
        'url': 'https://swapi.dev/api/people/1/'
      },
      {'id': 3, 'name': 'R2-D2', 'url': 'https://swapi.dev/api/people/3/'}
    ];

    expect(res.result, [1]);
    expect(showRes.result, expected);
  });

  test("Should return 1 when remove a character from favorites with success",
      () async {
    final character = CharacterEntity.fromMap(people[2]);
    final removeRes = await cache.remove(character.toString(), character.id);
    expect(removeRes, 1);
  });
}
