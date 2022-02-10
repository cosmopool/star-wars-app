import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:star_wars_app/data/datasource/sqlite_database_manager.dart';
import 'package:star_wars_app/data/datasource/sqllite_datasource.dart';
import 'package:star_wars_app/domain/entities/character_entity.dart';
import 'package:star_wars_app/infra/repositories/favorites_repository.dart';
import 'package:star_wars_app/infra/repositories/fetch_characters_repository.dart';

import '../../datasources/api_datasource_stub.dart';
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
  final favoriteRepository = FavoritesRepository(cache);

  final datasource = ApiCharactersDatasourceTestStub();
  final luke = CharacterEntity.fromMap(people[0]);
  await favoriteRepository.add(luke);
  final __entity = CharacterEntity.fromMap(people[0]);
  final __res = await SqliteDatabaseManager.createEntityTable(db, __entity);
  // print('====================== ${__res}');

  test("Should return all characters on fetch", () async {
    final repository = FetchCharactersRepository(datasource, cache);
    final response = await repository();
    expect(response.result.length, peopleResponse['results'].length);
  });

  test("Luke should have true in favorite property", () async {
    final character = CharacterEntity.fromMap(people[0]);
    await favoriteRepository.add(character);
    final favoritesResp = await favoriteRepository.fetch('characters');

    final _repository = FetchCharactersRepository(datasource, cache);
    final response = await _repository();
    expect(response.result[0].favorite, true);
  });

  test("Should return list of characters entity instances", () async {
    final repository = FetchCharactersRepository(datasource, cache);
    final response = await repository();
    expect(response.result[0].runtimeType, CharacterEntity);
  });

  test("Should return luke as first character", () async {
    final repository = FetchCharactersRepository(datasource, cache);
    final response = await repository();
    expect(response.result[0].name, "Luke Skywalker");
  });

  test("Should return error message on socket exception", () async {
    final _datasource = ApiDatasourceTestSocketExceptionStub();
    final repository = FetchCharactersRepository(_datasource, cache);
    final response = await repository();
    expect(response.error, true);
    expect(response.errMessage, "No Internet connection 😑");
  });

  test("Should return error message on http exception", () async {
    final _datasource = ApiDatasourceTestHttpExceptionStub();
    final repository = FetchCharactersRepository(_datasource, cache);
    final response = await repository();
    expect(response.error, true);
    expect(response.errMessage, "Couldn't find the resource 😱");
  });

  test("Should return error message on format exception", () async {
    final _datasource = ApiDatasourceTestFormatExceptionStub();
    final repository = FetchCharactersRepository(_datasource, cache);
    final response = await repository();
    expect(response.error, true);
    expect(response.errMessage, "Bad response format 👎");
  });

  test("Should return error message on other exception", () async {
    final _datasource = ApiDatasourceTestOtherExceptionStub();
    final repository = FetchCharactersRepository(_datasource, cache);
    final response = await repository();
    expect(response.error, true);
    expect(response.errMessage, "Bad response 👎: Exception: Other exception");
  });
}
