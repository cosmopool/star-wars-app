import 'package:star_wars_app/domain/entities/entity.dart';
import 'package:star_wars_app/domain/repositories/favorites_repository_interface.dart';

class AddFavoriteUsecase {
  final IFavoritesRespository _respository;

  AddFavoriteUsecase(this._respository);

  Future<bool> call(Entity character) async {
    final result = await _respository.add(character);
    return !result.error;
  }
}
