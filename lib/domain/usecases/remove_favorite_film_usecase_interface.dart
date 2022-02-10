import 'package:star_wars_app/domain/entities/entity.dart';
import 'package:star_wars_app/domain/entities/response_entity.dart';
import 'package:star_wars_app/domain/repositories/favorites_repository_interface.dart';

class RemoveFavoriteFilmUsecase {
  final IFavoritesRespository _respository;

  RemoveFavoriteFilmUsecase(this._respository);

  Future<ResponseEntity> call(Entity entity) async {
    return await _respository.remove(entity);
  }
}
