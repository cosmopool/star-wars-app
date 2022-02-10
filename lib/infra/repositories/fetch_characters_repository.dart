import 'package:star_wars_app/core/enums.dart';
import 'package:star_wars_app/core/mixins/http_error_mixin.dart';
import 'package:star_wars_app/domain/entities/character_entity.dart';
import 'package:star_wars_app/domain/entities/response_entity.dart';
import 'package:star_wars_app/domain/repositories/fetch_entities_repository_interface.dart';
import 'package:star_wars_app/infra/datasources/api_datasource_interface.dart';

class FetchCharactersRepository with HttpResponseErrorMenager implements IFetchEntityRespository {
  final IApiDatasource _datasource;

  FetchCharactersRepository(this._datasource);

  // here we instantiate the json from api server to character objects
  List<CharacterEntity> _treatResponseResult(Map response) {
    List<CharacterEntity> characterList = [];
    for (var character in response['results']) {
      characterList.add(CharacterEntity.fromMap(character));
    }
    return characterList;
  }

  // get data from server api
  Future<List<CharacterEntity>> fetchDataFromApi() async {
    final apiResponse = await _datasource(Endpoint.characters);
    return _treatResponseResult(apiResponse);
  }

  @override
  Future<ResponseEntity> call() async {
    return await manageHttpResponse(fetchDataFromApi);
  }
}
