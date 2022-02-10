import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:star_wars_app/data/datasource/sqlite_database_manager.dart';
import 'package:star_wars_app/data/datasource/sqllite_datasource.dart';
import 'package:star_wars_app/domain/entities/film_entity.dart';
import 'package:star_wars_app/infra/repositories/favorites_repository.dart';
import 'package:star_wars_app/infra/repositories/fetch_films_repository.dart';

import '../../datasources/api_datasource_stub.dart';
import '../../films_response.dart';


void main() async {
  // setup for the in memory database
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  // here we initialize a in memory database
  final Database db =
      await SqliteDatabaseManager.openOrCreateDatabase(inMemoryDatabasePath);

  final cache = SqliteDatasource(db);
  final film = filmResponse['results'];
  final favoriteRepository = FavoritesRepository(cache);

  final datasource = ApiFilmsDatasourceTestStub();
  final _entity = FilmEntity.fromMap(film[0]);
  await favoriteRepository.add(_entity);
  final __entity = FilmEntity.fromMap(film[0]);
  final __res = await SqliteDatabaseManager.createEntityTable(db, __entity);

  test("Should return all films on fetch", () async {
    final repository = FetchFilmsRepository(datasource, cache);
    final response = await repository();
    expect(response.result.length, filmResponse['results'].length);
  });

  test("A new hope should have true in favorite property", () async {
    final character = FilmEntity.fromMap(film[0]);
    await favoriteRepository.add(character);
    final favoritesResp = await favoriteRepository.fetch('film');

    final _repository = FetchFilmsRepository(datasource, cache);
    final response = await _repository();
    expect(response.result[0].favorite, true);
  });

  test("Should return list of films entity instances", () async {
    final repository = FetchFilmsRepository(datasource, cache);
    final response = await repository();
    expect(response.result[0].runtimeType, FilmEntity);
  });

  test("Should return a new hope as first character", () async {
    final repository = FetchFilmsRepository(datasource, cache);
    final response = await repository();
    expect(response.result[0].name, "A New Hope");
  });

  test("Should return error message on socket exception", () async {
    final _datasource = ApiDatasourceTestSocketExceptionStub();
    final repository = FetchFilmsRepository(_datasource, cache);
    final response = await repository();
    expect(response.error, true);
    expect(response.errMessage, "No Internet connection 😑");
  });

  test("Should return error message on http exception", () async {
    final _datasource = ApiDatasourceTestHttpExceptionStub();
    final repository = FetchFilmsRepository(_datasource, cache);
    final response = await repository();
    expect(response.error, true);
    expect(response.errMessage, "Couldn't find the resource 😱");
  });

  test("Should return error message on format exception", () async {
    final _datasource = ApiDatasourceTestFormatExceptionStub();
    final repository = FetchFilmsRepository(_datasource, cache);
    final response = await repository();
    expect(response.error, true);
    expect(response.errMessage, "Bad response format 👎");
  });

  test("Should return error message on other exception", () async {
    final _datasource = ApiDatasourceTestOtherExceptionStub();
    final repository = FetchFilmsRepository(_datasource, cache);
    final response = await repository();
    expect(response.error, true);
    expect(response.errMessage, "Bad response 👎: Exception: Other exception");
  });
}
