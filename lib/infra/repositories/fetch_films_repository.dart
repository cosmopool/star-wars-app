import 'package:star_wars_app/core/enums.dart';
import 'package:star_wars_app/core/mixins/http_error_mixin.dart';
import 'package:star_wars_app/core/response.dart';
import 'package:star_wars_app/domain/entities/film_entity.dart';
import 'package:star_wars_app/domain/repositories/fetch_entities_repository_interface.dart';
import 'package:star_wars_app/infra/datasources/api_datasource_interface.dart';

class FetchFilmsRepository with HttpResponseErrorMenager implements IFetchEntityRespository {
  final IApiDatasource _datasource;

  FetchFilmsRepository(this._datasource);

  List<FilmEntity> _treatResponseResult(Map response) {
    List<FilmEntity> characterList = [];
    for (var character in response['results']) {
      characterList.add(FilmEntity.fromMap(character));
    }
    return characterList;
  }

  Future<List<FilmEntity>> fetchDataFromApi() async {
    final apiResponse = await _datasource(Endpoint.characters);
    return _treatResponseResult(apiResponse);
  }

  @override
  Future<Response> call() async {
    return await manageHttpResponse(fetchDataFromApi);
  }
}
