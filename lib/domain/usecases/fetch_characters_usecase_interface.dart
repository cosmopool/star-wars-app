import 'package:star_wars_app/domain/entities/character_entity.dart';
import 'package:star_wars_app/domain/repositories/fetch_characters_repository_interface.dart';

class FetchCharactersUsecase {
  final IFetchCharactersRespository _respository;

  FetchCharactersUsecase(this._respository);

  Future<List<CharacterEntity>> call() async {
    final response = await _respository(); 
    return response.result;
  }
}
