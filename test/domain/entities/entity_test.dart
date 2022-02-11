import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/core/enums.dart';
import 'package:star_wars_app/domain/entities/entity.dart';

import '../../films_response.dart';
import '../../people_response.dart';

void main() {
  test("Should return a object with luke name", () {
    final entry = peopleResponse["results"];
    final entity = Entity.fromMap(entry[0]);
    expect(entity.name, "Luke Skywalker");
  });

  test("Should return id of a luke as 1", () {
    final entry = peopleResponse["results"];
    final entity = Entity.fromMap(entry[0]);
    expect(entity.id, 1001);
  });

  test("convertUrlToType should return type character", () {
    final entry = peopleResponse["results"];
    final entity = Entity.fromMap(entry[0]);
    expect(entity.type, EntityType.character);
  });

  test("Should return a object with a new hope title", () {
    final entry = filmResponse["results"];
    final entity = Entity.fromMap(entry[0]);
    expect(entity.name, "A New Hope");
  });

  test("Should return id of a new hope as 1", () {
    final entry = filmResponse["results"];
    final entity = Entity.fromMap(entry[0]);
    expect(entity.id, 1);
  });

  test("Should return a object with type film", () {
    final entry = filmResponse["results"];
    final entity = Entity.fromMap(entry[0]);
    expect(entity.type, EntityType.film);
  });
}

