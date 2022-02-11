import 'package:star_wars_app/core/domain/entities/response.dart';
import 'package:star_wars_app/domain/entities/entity.dart';
import 'package:star_wars_app/domain/repositories/favorites_repository_interface.dart';

class ShowFavoritesUsecase {
  final IFavoritesRespository _repository;

  ShowFavoritesUsecase(this._repository);

  Future<Response<Entity>> call(String table) async {
    final response = await _repository.fetch(table);
    return response;
  }
}
