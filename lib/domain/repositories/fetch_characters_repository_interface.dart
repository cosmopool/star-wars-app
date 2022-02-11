import 'package:star_wars_app/core/domain/entities/response.dart';
import 'package:star_wars_app/domain/entities/character_entity.dart';

abstract class IFetchCharactersRespository {
  Future<Response<CharacterEntity>> call();
}
