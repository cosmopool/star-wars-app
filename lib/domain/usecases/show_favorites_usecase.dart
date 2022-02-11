import 'package:star_wars_app/core/domain/entities/response.dart';
import 'package:star_wars_app/domain/entities/entity.dart';
import 'package:star_wars_app/domain/repositories/favorites_repository_interface.dart';

abstract class IShowFavoritesUsecase {
  Future<Response<Entity>> call();
}

class ShowFavoritesUsecase implements IShowFavoritesUsecase {
  final IFavoritesRespository _repository;

  ShowFavoritesUsecase(this._repository);

  @override
  Future<Response<Entity>> call() async {
    return await _repository.fetch();
  }
}
