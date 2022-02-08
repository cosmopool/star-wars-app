import 'package:star_wars_app/domain/entities/film_entity.dart';
import 'package:star_wars_app/domain/repositories/favorites_repository_interface.dart';

class RemoveFavoriteFilmUsecase {
  final IFavoritesRespository _respository;

  RemoveFavoriteFilmUsecase(this._respository);

  bool call(FilmEntity film) {
    final result = _respository.remove(film);
    return result;
  }
}
