import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:star_wars_app/data/datasource/local/sqlite_database_manager.dart';
import 'package:star_wars_app/data/datasource/local/sqllite_datasource.dart';
import 'package:star_wars_app/domain/entities/entity.dart';
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
  final character = Entity.fromMap(people[0]);
  final character1 = Entity.fromMap(people[1]);
  final character2 = Entity.fromMap(people[2]);
  final film = Entity.fromMap(films[0]);
  final film1 = Entity.fromMap(films[1]);
  final film2 = Entity.fromMap(films[2]);

  // setup database, creating tables
  await SqliteDatabaseManager.createEntityTable(db);
  // setup repository instance
  final repository = FavoritesRepository(cache);

  test("Should return error = false when insert a film successfuly", () async {
    final res = await repository.add(film);
    // print('================================ errmsg: ${res.errMessage}');
    expect(res.error, false);
  });

  test("Should return return a new home from favorites", () async {
    final res = await repository.fetch();
    expect(res.result[0].name, film.name);
  });

  test("Should return error = false when remove from favorites", () async {
    final res = await repository.remove(film);
    expect(res.error, false);
  });


  test("Should return return empty list from favorites", () async {
    final res = await repository.fetch();
    expect(res.result, []);
  });

  test("Should return error = false when insert a character successfuly", () async {
    final res = await repository.add(character);
    expect(res.error, false);
  });

  test("Should return maps of all 2 favorites films", () async {
    await repository.add(film1);
    final res = await repository.fetch();
    expect(res.result[0].name, film1.name);
    expect(res.result[1].name, character.name);
  });

  test("Should return maps of all 3 favorites characters", () async {
    await repository.add(character1);
    await repository.add(character2);
    final res = await repository.fetch();
    expect(res.result[0].name, film1.name);
    expect(res.result[1].name, character.name);
    expect(res.result[2].name, character1.name);
  });

  test("Should remove just one character from favorites", () async {
    final remove = await repository.remove(character);
    final res = await repository.fetch();

    expect(remove.error, false);
    expect(res.result[0].name, film1.name);
    expect(res.result[1].name, character1.name);
  });
}
