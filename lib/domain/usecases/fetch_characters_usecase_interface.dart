import '../entities/character_entity.dart';

abstract class IFetchCharactersUsecase {
  List<CharacterEntity> call();
}
