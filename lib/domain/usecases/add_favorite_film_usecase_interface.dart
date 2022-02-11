import 'package:star_wars_app/domain/entities/entity.dart';
import 'package:star_wars_app/domain/repositories/favorites_repository_interface.dart';

abstract class IAddFavoriteFilmUsecase {
  Future<bool> call(Entity entity);
}

class AddFavoriteFilmUsecase implements IAddFavoriteFilmUsecase{
  final IFavoritesRespository _respository;

  AddFavoriteFilmUsecase(this._respository);

  @override
  Future<bool> call(Entity film) async {
    final result = await _respository.add(film);
    return !result.error;
  }
}
