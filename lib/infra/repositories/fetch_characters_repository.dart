import 'package:star_wars_app/core/enums.dart';
import 'package:star_wars_app/core/mixins/http_error_mixin.dart';
import 'package:star_wars_app/domain/entities/character_entity.dart';
import 'package:star_wars_app/domain/entities/response_entity.dart';
import 'package:star_wars_app/domain/repositories/fetch_characters_repository_interface.dart';
import 'package:star_wars_app/infra/datasources/api_datasource_interface.dart';
import 'package:star_wars_app/infra/datasources/cache_datasource_interface.dart';

class FetchCharactersRepository with HttpResponseErrorMenager implements IFetchCharactersRespository {
  final IApiDatasource _datasource;
  final ICacheDatasource _cache;

  FetchCharactersRepository(this._datasource, this._cache);

  // verify if is on favorite list
  bool isOnFavoriteList(Map character, List favoriteList) {
    bool res = false;

    for(var favorite in favoriteList) {
      (favorite['url'] == character['url']) ? res = true : res = false;
    }

    return res;
  }

  // here we instantiate the json from api server to character objects
  Future<List<CharacterEntity>> _treatResponseResult(Map response) async {
    List<CharacterEntity> characterList = [];
    final favoriteList = await _cache.fetch('characters');

    for (var character in response['results']) {
      Map _character = {'favorite': isOnFavoriteList(character, favoriteList)};
      _character.addAll(character);
      characterList.add(CharacterEntity.fromMap(_character));
    }

    return characterList;
  }

  // get data from server api
  Future<List<CharacterEntity>> fetchDataFromApi() async {
    final apiResponse = await _datasource(Endpoint.characters);
    return await _treatResponseResult(apiResponse);
  }

  @override
  Future<ResponseEntity> call() async {
    return await manageHttpResponse(fetchDataFromApi);
  }
}
