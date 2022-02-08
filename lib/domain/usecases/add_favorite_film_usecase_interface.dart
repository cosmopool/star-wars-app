import '../entities/film_entity.dart';

abstract class IAddFavoriteFilmUsecase {
  bool call(FilmEntity character);
}

