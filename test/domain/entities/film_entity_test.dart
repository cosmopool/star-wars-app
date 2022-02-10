import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_app/domain/entities/film_entity.dart';

import '../../films_response.dart';

void main() {
  test("Should return a object with a new hope title", () {
    final films = filmResponse["results"];
    final film = FilmEntity.fromMap(films[0]);
    expect(film.name, "A New Hope");
  });

  test("Should return id of a new hope as 1", () {
    final people = filmResponse["results"];
    final film = FilmEntity.fromMap(people[0]);
    expect(film.id, 1);
  });

  // test("Should return opening crawl as a big string", () {
  //   final people = filmResponse["results"];
  //   final film = FilmEntity.fromMap(people[0]);
  //   final openingCrawlLen = film.openingCrawl.length;

  //   expect((openingCrawlLen > 60), true);
  // });

  // test("Should return episodeId of a new hope as 4", () {
  //   final people = filmResponse["results"];
  //   final film = FilmEntity.fromMap(people[0]);

  //   expect(film.episodeId, 4);
  // });

  // test("Should return characters as a list", () {
  //   final people = filmResponse["results"];
  //   final film = FilmEntity.fromMap(people[0]);

  //   expect(film.characters.runtimeType, List<CharacterEntity>);
  // });

  // test("Should return datetime relase", () {
  //   final people = filmResponse["results"];
  //   final film = FilmEntity.fromMap(people[0]);

  //   expect(film.releaseDate, DateTime(1977, 05, 25));
  // });
}
