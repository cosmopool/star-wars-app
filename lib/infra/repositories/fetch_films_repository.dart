import 'package:star_wars_app/core/enums.dart';
import 'package:star_wars_app/core/mixins/http_error_mixin.dart';
import 'package:star_wars_app/domain/entities/film_entity.dart';
import 'package:star_wars_app/domain/entities/response_entity.dart';
import 'package:star_wars_app/domain/repositories/fetch_films_repository_interface.dart';
import 'package:star_wars_app/infra/datasources/api_datasource_interface.dart';
import 'package:star_wars_app/infra/datasources/cache_datasource_interface.dart';

class FetchFilmsRepository with HttpResponseErrorMenager implements IFetchFilmsRespository {
  final IApiDatasource _datasource;
  final ICacheDatasource _cache;

  FetchFilmsRepository(this._datasource, this._cache);

  // verify if is on favorite list
  bool isOnFavoriteList(Map film, List favoriteList) {
    bool res = false;

    for(var favorite in favoriteList) {
      (favorite['url'] == film['url']) ? res = true : res = false;
    }

    return res;
  }

  // here we instantiate the json from api server to film objects
  Future<List<FilmEntity>> _treatResponseResult(Map response) async {
    List<FilmEntity> filmList = [];
    final favoriteList = await _cache.fetch('films');

    for (var film in response['results']) {
      Map _film = {'favorite': isOnFavoriteList(film, favoriteList)};
      _film.addAll(film);

      final entity =FilmEntity.fromMap(_film);
      filmList.add(entity);
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
