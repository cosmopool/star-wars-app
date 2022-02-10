import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:star_wars_app/data/datasource/sqlite_database_manager.dart';
import 'package:star_wars_app/data/datasource/sqllite_datasource.dart';
import 'package:star_wars_app/domain/entities/character_entity.dart';
import 'package:star_wars_app/domain/usecases/add_favorite_character_usecase_interface.dart';
import 'package:star_wars_app/infra/repositories/favorites_repository.dart';

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

  final repository = FavoritesRepository(cache);
  final usecase = AddFavoriteCharacterUsecase(repository);
  final __entity = CharacterEntity.fromMap(people[5]);
  final __res = await SqliteDatabaseManager.createEntityTable(db, __entity);

//  print('================================ repoRes: ${repoRes}');

  test("Should add a character to favorites", () async {
    final character = CharacterEntity.fromMap(people[0]);
    final res = await usecase(character);
    final response = await repository.fetch('characters');
    expect(res, true);
  });

  test("Added character should return on fetch", () async {
    final response = await repository.fetch('characters');
    final char = response.result[0]['url'];
    final charRef = people[0]['url'];
    expect(char, charRef);
  });
}
