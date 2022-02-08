import 'package:star_wars_app/domain/entities/entity.dart';
import 'package:star_wars_app/domain/repositories/fetch_entities_repository_interface.dart';

class FetchCharactersUsecase {
  final IFetchEntityRespository _respository;

  FetchCharactersUsecase(this._respository);

  List<Entity> call() {
    final result = _respository(); 
    return result;
  }
}
