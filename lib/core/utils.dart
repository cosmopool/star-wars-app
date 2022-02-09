import 'package:star_wars_app/core/enums.dart';

const _baseUrl = "https://swapi.dev/api";

parseEndpoint(Endpoint endpoint) {
  late final String string;

  switch (endpoint) {
    case Endpoint.films: { string = "$_baseUrl/films"; } break;
    case Endpoint.characters: { string = "$_baseUrl/characters"; } break;
  }

  return string;
}


parseEndpointWithId(Endpoint endpoint, int id) {
  return parseEndpoint(endpoint) + id.toString();
}
