import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:star_wars_app/core/enums.dart';
import 'package:star_wars_app/data/datasource/local/sqlite_database_manager.dart';
import 'package:star_wars_app/data/datasource/local/sqllite_datasource.dart';
import 'package:star_wars_app/domain/entities/entity.dart';
import 'package:star_wars_app/domain/usecases/show_favorites_usecase.dart';
import 'package:star_wars_app/infra/repositories/favorites_repository.dart';

import '../../films_response.dart';
import '../../people_response.dart';

void main() async {
  // setup for the in memory database
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  // here we initialize a in memory database
  final Database db = await SqliteDatabaseManager.openOrCreateDatabase(inMemoryDatabasePath);
  final cache = SqliteDatasource(db);
  final people = peopleResponse['results'];
  final films = filmResponse['results'];

  // setup database, creating tables
  await SqliteDatabaseManager.createEntityTable(db);
  // setup repository instance
  final repository = FavoritesRepository(cache);
  final usecase = ShowFavoritesUsecase(repository);

  test("Should return no entity", () async {
    final res = await usecase();
    expect(res.result.length, 0);
  });

  test("Should return one entity type film", () async {
    await repository.add(Entity.fromMap(films[0]));
    final res = await usecase();
    expect(res.result[0].type, EntityType.film);
  });

  test("Should return two entities, one type character", () async {
    await repository.add(Entity.fromMap(people[0]));
    final res = await usecase();
    expect(res.result[1].type, EntityType.character);
  });
}
