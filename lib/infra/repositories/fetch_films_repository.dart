import 'package:star_wars_app/core/enums.dart';
import 'package:star_wars_app/core/mixins/http_error_mixin.dart';
import 'package:star_wars_app/domain/entities/film_entity.dart';
import 'package:star_wars_app/domain/entities/response_entity.dart';
import 'package:star_wars_app/domain/repositories/fetch_entities_repository_interface.dart';
import 'package:star_wars_app/infra/datasources/api_datasource_interface.dart';

class FetchFilmsRepository with HttpResponseErrorMenager implements IFetchEntityRespository {
  final IApiDatasource _datasource;

  FetchFilmsRepository(this._datasource);

  // here we instantiate the json from api server to film objects
  List<FilmEntity> _treatResponseResult(Map response) {
    List<FilmEntity> filmList = [];
    for (var film in response['results']) {
      filmList.add(FilmEntity.fromMap(film));
    }
    return filmList;
  }

  // get data from server api
  Future<List<FilmEntity>> fetchDataFromApi() async {
    final apiResponse = await _datasource(Endpoint.films);
    return _treatResponseResult(apiResponse);
  }

  @override
  Future<ResponseEntity> call() async {
    return await manageHttpResponse(fetchDataFromApi);
  }
}
