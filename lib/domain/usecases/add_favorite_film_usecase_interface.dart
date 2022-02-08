import 'package:star_wars_app/domain/entities/film_entity.dart';
import 'package:star_wars_app/domain/repositories/favorites_repository_interface.dart';

class AddFavoriteFilmUsecase {
  final IFavoritesRespository _respository;

  AddFavoriteFilmUsecase(this._respository);

  bool call(FilmEntity film) {
    final result = _respository.add(film);
    return result;
  }
}
