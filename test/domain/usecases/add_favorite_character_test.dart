import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:star_wars_app/data/datasource/local/sqlite_database_manager.dart';
import 'package:star_wars_app/data/datasource/local/sqllite_datasource.dart';
import 'package:star_wars_app/domain/entities/entity.dart';
import 'package:star_wars_app/domain/usecases/add_favorite_usecase.dart';
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

  final usecase = AddFavoriteUsecase(repository);


  test("Should add a character to favorites", () async {
    final res = await usecase(character2);
    expect(res, true);
  });

  test("Added character should return on fetch", () async {
    final response = await repository.fetch();
    final char = response.result[0];
    expect(char.url, character2.url);
  });
}
