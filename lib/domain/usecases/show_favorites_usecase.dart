import 'package:star_wars_app/domain/entities/entity.dart';
import 'package:star_wars_app/domain/repositories/favorites_repository_interface.dart';

class ShowFavoritesUsecase {
  final IFavoritesRespository _repository;

  ShowFavoritesUsecase(this._repository);

  List<Entity> call() {
    final result = _repository.showAll();
    return result;
  }
}
