import 'package:star_wars_app/domain/entities/character_entity.dart';
import 'package:star_wars_app/domain/repositories/favorites_repository_interface.dart';

class AddFavoriteCharacterUsecase {
  final IFavoritesRespository _respository;

  AddFavoriteCharacterUsecase(this._respository);

  bool call(CharacterEntity character) {
    final result = _respository.add(character);
    return result;
  }
}
