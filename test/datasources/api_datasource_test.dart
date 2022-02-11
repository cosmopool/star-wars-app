import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/core/enums.dart';
import 'package:star_wars_app/core/utils.dart';
import 'package:star_wars_app/data/datasource/remote/api_datasource.dart';

import '../films_response.dart';
import '../people_response.dart';

void main() async {
  final api = ApiDatasource();

  test("Should return all films", () async {
    final response = await api(Endpoint.films);
    expect(response, filmResponse);
  });

  test("Should return all characters", () async {
    final response = await api(Endpoint.characters);
    expect(response, peopleResponse);
  });

  test("Should return a url to fetch films", () async {
    final url = convertEndpoint(Endpoint.films);
    expect(url, "https://swapi.dev/api/films");
  });

  test("Should return a url to fetch characters", () async {
    final url = convertEndpoint(Endpoint.characters);
    expect(url, "https://swapi.dev/api/people");
  });

  test("Should return a url with given id to fetch characters", () async {
    final url = convertEndpointWithId(Endpoint.characters, 5);
    expect(url, "https://swapi.dev/api/people/5");
  });

  test("Should return a url with given id to fetch films", () async {
    final url = convertEndpointWithId(Endpoint.films, 5);
    expect(url, "https://swapi.dev/api/films/5");
  });
}
