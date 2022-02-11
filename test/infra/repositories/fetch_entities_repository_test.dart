import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:star_wars_app/core/enums.dart';
import 'package:star_wars_app/data/datasource/local/sqlite_database_manager.dart';
import 'package:star_wars_app/data/datasource/local/sqllite_datasource.dart';
import 'package:star_wars_app/domain/entities/entity.dart';
import 'package:star_wars_app/infra/repositories/favorites_repository.dart';
import 'package:star_wars_app/infra/repositories/fetch_entities_repository.dart';

import '../../datasources/api_datasource_stub.dart';
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
  final datasource = ApiDatasourceTestStub();
  final favoriteRepository = FavoritesRepository(cache);
  // setup database, creating tables
  await SqliteDatabaseManager.createEntityTable(db);
  // setup repository instance
  final repository = FetchEntitiesRepository(datasource, cache);

  test("Should return all characters on fetch", () async {
    final response = await repository(Endpoint.characters);
    expect(response.result.length, peopleResponse['results'].length);
  });

  test("Luke should have true in favorite property", () async {
    await favoriteRepository.add(character);
    final favoritesResp = await favoriteRepository.fetch();

    final response = await repository(Endpoint.characters);
    expect(response.result[0].isFavorite, true);
  });

  test("Should return list of characters entity instances", () async {
    final response = await repository(Endpoint.characters);
    expect(response.result[0].runtimeType, Entity);
  });

  test("Should return luke as first character", () async {
    final response = await repository(Endpoint.characters);
    expect(response.result[0].name, "Luke Skywalker");
  });

  test("A new hope should have true in favorite property", () async {
    final addFavoriteRes = await favoriteRepository.add(film);
    final favoritesResp = await favoriteRepository.fetch();

    final response = await repository(Endpoint.films);
    expect(response.result[0].name, film.name);
    expect(response.result[0].isFavorite, true);
  });

  test("Should return list of films entity instances", () async {
    final response = await repository(Endpoint.films);
    expect(response.result[0].type, EntityType.film);
  });

  test("Should return a new hope as first character", () async {
    final response = await repository(Endpoint.films);
    expect(response.result[0].name, "A New Hope");
  });

  test("Should return error message on socket exception", () async {
    final _datasource = ApiDatasourceTestSocketExceptionStub();
    final repository = FetchEntitiesRepository(_datasource, cache);
    final response = await repository(Endpoint.films);
    expect(response.error, true);
    expect(response.errMessage, "No Internet connection 😑");
  });

  test("Should return error message on http exception", () async {
    final _datasource = ApiDatasourceTestHttpExceptionStub();
    final repository = FetchEntitiesRepository(_datasource, cache);
    final response = await repository(Endpoint.films);
    expect(response.error, true);
    expect(response.errMessage, "Couldn't find the resource 😱");
  });

  test("Should return error message on format exception", () async {
    final _datasource = ApiDatasourceTestFormatExceptionStub();
    final repository = FetchEntitiesRepository(_datasource, cache);
    final response = await repository(Endpoint.films);
    expect(response.error, true);
    expect(response.errMessage, "Bad response format 👎");
  });

  test("Should return error message on other exception", () async {
    final _datasource = ApiDatasourceTestOtherExceptionStub();
    final repository = FetchEntitiesRepository(_datasource, cache);
    final response = await repository(Endpoint.films);
    expect(response.error, true);
    expect(response.errMessage, "Bad response 👎: Exception: Other exception");
  });
}
