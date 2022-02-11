import 'package:star_wars_app/core/enums.dart';

const _baseUrl = "https://swapi.dev/api";

String convertEndpoint(Endpoint endpoint) {
  late final String string;

  switch (endpoint) {
    case Endpoint.films: { string = "$_baseUrl/films"; } break;
    case Endpoint.characters: { string = "$_baseUrl/people"; } break;
  }

  return string;
}


String convertEndpointWithId(Endpoint endpoint, int id) {
  return convertEndpoint(endpoint) + '/' + id.toString();
}
