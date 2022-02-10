import 'package:star_wars_app/domain/entities/entity.dart';
import 'package:star_wars_app/domain/repositories/favorites_repository_interface.dart';

class ShowFavoritesUsecase {
  final IFavoritesRespository _repository;

  ShowFavoritesUsecase(this._repository);

  Future<List<Entity>> call() async {
    final response = await _repository.fetchAll();
    return response.result.cast();
  }
}
