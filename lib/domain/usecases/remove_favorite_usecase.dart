import 'package:star_wars_app/core/domain/entities/response.dart';
import 'package:star_wars_app/domain/entities/entity.dart';
import 'package:star_wars_app/domain/repositories/favorites_repository_interface.dart';

abstract class IRemoveFavoriteUsecase {
  Future<Response> call(Entity entity);
}
class RemoveFavoriteUsecase {
  final IFavoritesRespository _respository;

  RemoveFavoriteUsecase(this._respository);

  Future<Response> call(Entity entity) async {
    return await _respository.remove(entity);
  }
}
