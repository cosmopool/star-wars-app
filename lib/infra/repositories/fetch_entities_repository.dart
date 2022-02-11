import 'dart:io';

import 'package:star_wars_app/core/domain/entities/response.dart';
import 'package:star_wars_app/core/enums.dart';
import 'package:star_wars_app/core/mixins/http_error_mixin.dart';
import 'package:star_wars_app/domain/entities/entity.dart';
import 'package:star_wars_app/domain/repositories/fetch_entities_repository_interface.dart';
import 'package:star_wars_app/infra/datasources/api_datasource_interface.dart';
import 'package:star_wars_app/infra/datasources/cache_datasource_interface.dart';

class FetchEntitiesRepository with HttpResponseErrorMenager implements IFetchEntitiesRespository {
  final IApiDatasource _api;
  final ICacheDatasource _cache;

  FetchEntitiesRepository(this._api, this._cache);

  // verify if entity is on favorite list
  bool isOnFavoriteList(Map entity, List favoriteList) {
    bool res = false;

    for(var favorite in favoriteList) {
      if (favorite['url'] == entity['url']) return true;
    }

    return res;
  }

  // here we instantiate the json from api server to entity objects
  Future<List<Entity>> _treatResponseResult(Map response) async {
    List<Entity> entityList = [];
    final favoriteList = await _cache.fetch('favorites');

    for (var entity in response['results']) {
      Map _entity = {'isFavorite': isOnFavoriteList(entity, favoriteList)};
      _entity.addAll(entity);
      entityList.add(Entity.fromMap(_entity));
    }

    return entityList;
  }

  // get data from server api
  Future<List<Entity>> fetchDataFromApi(Endpoint endpoint) async {
    final apiResponse = await _api(endpoint);
    final res= await _treatResponseResult(apiResponse);
      return res;
  }

  @override
  Future<Response<Entity>> call(Endpoint endpoint) async {
    try {
      final result = await fetchDataFromApi(endpoint);
      return Response.onSuccess(result);
    } on SocketException {
      return Response.onError("No Internet connection 😑");
    } on HttpException {
      return Response.onError("Couldn't find the resource 😱");
    } on FormatException {
      return Response.onError("Bad response format 👎");
    } catch (e) {
      return Response.onError("Bad response 👎: $e");
    }
  }
}
