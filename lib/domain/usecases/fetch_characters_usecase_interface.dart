import 'package:star_wars_app/domain/entities/response_entity.dart';
import 'package:star_wars_app/domain/repositories/fetch_entities_repository_interface.dart';

class FetchCharactersUsecase {
  final IFetchEntityRespository _respository;

  FetchCharactersUsecase(this._respository);

  Future<ResponseEntity> call() async {
    final response = await _respository(); 
    return response;
  }
}
