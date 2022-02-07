import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/domain/entities/character.dart';

import '../../people_response.dart';

void main() {
  test("Should return a object with luke name", () {
    final people = peopleResponse["results"];
    final character = Character.fromMap(people[0]);
    expect(character.name, "Luke Skywalker");
  });

  test("Should return luke homeworld as string", () {
    final people = peopleResponse["results"];
    final character = Character.fromMap(people[0]);

    expect(character.homeworld.runtimeType, String);
  });

  test("Should return luke homeworld as empty instead of url on instantiation from json", () {
    final people = peopleResponse["results"];
    final character = Character.fromMap(people[0]);

    expect(character.homeworld, "");
  });

  test("Should return luke correct homeworld name when setHomeworld", () {
    final people = peopleResponse["results"];
    final character = Character.fromMap(people[0]);
    character.setHomeworld("Tatooine");

    expect(character.homeworld, "Tatooine");
  });

  test("Should not be able to set homeworld name twice", () {
    final people = peopleResponse["results"];
    final character = Character.fromMap(people[0]);
    character.setHomeworld("Tatooine");
    final wasAbleToSet = character.setHomeworld("Tatooine");

    expect(wasAbleToSet, false);
  });

  test("Should return luke species as n/a", () {
    final people = peopleResponse["results"];
    final character = Character.fromMap(people[0]);

    expect(character.species[0], "n/a");
  });

  test("Should return r2d2 hair color as n/a", () {
    final people = peopleResponse["results"];
    final character = Character.fromMap(people[0]);

    expect(character.hairColor, "n/a");
  });

  test("Should return r2d2 height as double", () {
    final people = peopleResponse["results"];
    final character = Character.fromMap(people[0]);

    expect(character.height.runtimeType, double);
  });
}

