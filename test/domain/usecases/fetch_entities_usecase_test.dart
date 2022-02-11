import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:star_wars_app/core/enums.dart';
import 'package:star_wars_app/data/datasource/local/sqlite_database_manager.dart';
import 'package:star_wars_app/data/datasource/local/sqllite_datasource.dart';
import 'package:star_wars_app/domain/usecases/fetch_entities_usecase.dart';
import 'package:star_wars_app/infra/repositories/fetch_entities_repository.dart';

import '../../datasources/api_datasource_stub.dart';
import '../../films_response.dart';
import '../../people_response.dart';

void main() async {
  // setup for the in memory database
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  // here we initialize a in memory database
  final Database db = await SqliteDatabaseManager.openOrCreateDatabase(inMemoryDatabasePath);
  final cache = SqliteDatasource(db);
  final api = ApiDatasourceTestStub();
  final people = peopleResponse['results'];
  final films = filmResponse['results'];

  // setup database, creating tables
  await SqliteDatabaseManager.createEntityTable(db);
  // setup repository instance
  final repository = FetchEntitiesRepository(api, cache);
  final usecase = FetchEntitiesUsecase(repository);

  test("Should fetch people endpoint", () async {
    final res = await usecase(Endpoint.characters);
    expect(res.result.length, people.length);
  });

  test("Should fetch films endpoint", () async {
    final res = await usecase(Endpoint.films);
    expect(res.result.length, films.length);
  });
}
