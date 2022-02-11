import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:star_wars_app/core/enums.dart';
import 'package:star_wars_app/data/datasource/local/sqlite_database_manager.dart';
import 'package:star_wars_app/data/datasource/local/sqllite_datasource.dart';
import 'package:star_wars_app/domain/entities/entity.dart';
import 'package:star_wars_app/domain/usecases/add_favorite_usecase.dart';
import 'package:star_wars_app/domain/usecases/remove_favorite_usecase.dart';
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
  final character1 = Entity.fromMap(people[1]);
  final character2 = Entity.fromMap(people[2]);
  final film = Entity.fromMap(films[0]);
  final film2 = Entity.fromMap(films[2]);

  // setup database, creating tables
  await SqliteDatabaseManager.createEntityTable(db);
  // setup repository instance
  final repository = FavoritesRepository(cache);

  final usecase = RemoveFavoriteUsecase(repository);
  final addUsecase = AddFavoriteUsecase(repository);


  test("Should add a 2 character and 2 films to favorites", () async {
    await addUsecase(character1);
    await addUsecase(character2);
    await addUsecase(film2);
    await addUsecase(film);
    final response = await repository.fetch();
    expect(response.result.length, 4);
  });

  test("Should return no error when remove all characters", () async {
    final response1 = await usecase(character1);
    final response2 = await usecase(character2);
    expect(response1.error, false);
    expect(response2.error, false);
  });

  test("Should return only 2 entities after remove characters", () async {
    final response = await repository.fetch();
    expect(response.result.length, 2);
  });

  test("Should be type film first entity in favorites", () async {
    final response = await repository.fetch();
    expect(response.result[0].type, EntityType.film);
  });

  test("Should be type film second entity in favorites", () async {
    final response = await repository.fetch();
    expect(response.result[1].type, EntityType.film);
  });

  test("Should return no error when remove all films", () async {
    final response1 = await usecase(film);
    final response2 = await usecase(film2);
    expect(response1.error, false);
    expect(response2.error, false);
  });

  test("Should return 0 entities after remove films", () async {
    final response = await repository.fetch();
    expect(response.result.length, 0);
  });
}
