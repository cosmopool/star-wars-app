import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/domain/entities/character_entity.dart';
import 'package:star_wars_app/infra/repositories/fetch_characters_repository.dart';

import '../../datasources/api_datasource_stub.dart';
import '../../people_response.dart';

void main() {
  final datasource = ApiCharactersDatasourceTestStub();

  test("Should return all characters on fetch", () async {
    final repository = FetchCharactersRepository(datasource);
    final response = await repository();
    expect(response.result.length, peopleResponse['results'].length);
  });

  test("Should return list of characters entity instances", () async {
    final repository = FetchCharactersRepository(datasource);
    final response = await repository();
    expect(response.result[0].runtimeType, CharacterEntity);
  });

  test("Should return luke as first character", () async {
    final repository = FetchCharactersRepository(datasource);
    final response = await repository();
    expect(response.result[0].name, "Luke Skywalker");
  });

  test("Should return error message on socket exception", () async {
    final _datasource = ApiDatasourceTestSocketExceptionStub();
    final repository = FetchCharactersRepository(_datasource);
    final response = await repository();
    expect(response.error, true);
    expect(response.errMessage, "No Internet connection 😑");
  });

  test("Should return error message on http exception", () async {
    final _datasource = ApiDatasourceTestHttpExceptionStub();
    final repository = FetchCharactersRepository(_datasource);
    final response = await repository();
    expect(response.error, true);
    expect(response.errMessage, "Couldn't find the resource 😱");
  });

  test("Should return error message on format exception", () async {
    final _datasource = ApiDatasourceTestFormatExceptionStub();
    final repository = FetchCharactersRepository(_datasource);
    final response = await repository();
    expect(response.error, true);
    expect(response.errMessage, "Bad response format 👎");
  });

  test("Should return error message on other exception", () async {
    final _datasource = ApiDatasourceTestOtherExceptionStub();
    final repository = FetchCharactersRepository(_datasource);
    final response = await repository();
    expect(response.error, true);
    expect(response.errMessage, "Bad response 👎: Exception: Other exception");
  });
}
