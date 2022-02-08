import '../entities/character_entity.dart';

abstract class IAddFavoriteCharacterUsecase {
  bool call(CharacterEntity character);
}

