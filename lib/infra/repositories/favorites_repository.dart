import 'package:star_wars_app/core/domain/entities/response.dart';
import 'package:star_wars_app/domain/entities/entity.dart';
import 'package:star_wars_app/domain/repositories/favorites_repository_interface.dart';
import 'package:star_wars_app/infra/datasources/cache_datasource_interface.dart';

class FavoritesRepository implements IFavoritesRespository {
  final ICacheDatasource _cache;

  FavoritesRepository(this._cache);

  @override
  Future<Response> add(Entity entity) async {
    try {
    Map entityToMap = {'name': entity.name, 'id': entity.id, 'url': entity.url};
    final response = await _cache.add('favorites', entityToMap);
    return  response ? Response.onSuccess([]): Response.onError("Não foi possível adicionar aos favoritos");
    } catch(e) {
      return Response.onError("Não foi possível adicionar aos favoritos: $e");
    }
  }

  @override
  Future<Response> remove(Entity entity) async {
    final entityId = entity.toMap()['id'];
    try {
      final response = await _cache.remove('favorites', entityId);
    return  response ? Response.onSuccess([]): Response.onError("Não foi possível remover dos favoritos");
    } catch (e) {
      return Response.onError("Não foi possível remover dos favoritos: $e");
    }
  }

  @override
  Future<Response<Entity>> fetch() async {
    try {
      final List<Entity> entityList = [];
      final favorites = await _cache.fetch('favorites');

      for(var favorite in favorites) {
        final entity = Entity.fromMap(favorite);
        entityList.add(entity);
      }

      return Response.onSuccess(entityList);
    } catch (e) {
      return Response.onError("Não foi possível mostar os favoritos: $e");
    }
  }
}
