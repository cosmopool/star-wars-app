import 'package:star_wars_app/domain/entities/response_entity.dart';
import 'package:star_wars_app/domain/entities/entity.dart';
import 'package:star_wars_app/domain/repositories/favorites_repository_interface.dart';
import 'package:star_wars_app/infra/datasources/cache_datasource_interface.dart';

class FavoritesRepository implements IFavoritesRespository {
  final ICacheDatasource _cache;

  FavoritesRepository(this._cache);

  @override
  Future<ResponseEntity> add(Entity entity) async {
    final table = entity.toString();
    try {
    Map entityToMap = {'name': entity.name, 'id': entity.id, 'url': entity.url};
    final response = await _cache.add(table, entityToMap);
      return ResponseEntity.onSuccess([response]);
    } catch(e) {
      return ResponseEntity.onError("Não foi possível adicionar aos favoritos");
    }
  }

  @override
  Future<ResponseEntity> remove(Entity entity) async {
    final entityId = entity.toMap()['id'];
    final table = entity.toString();
    try {
      final response = await _cache.remove(table, entityId);
      return ResponseEntity.onSuccess([response]);
    } catch (e) {
      return ResponseEntity.onError("Não foi possível remover dos favoritos");
    }
  }

  @override
  Future<ResponseEntity> fetch(String table) async {
    try {
      final response = await _cache.fetch(table);
      return ResponseEntity.onSuccess(response);
    } catch (e) {
      return ResponseEntity.onError("Não foi possível mostar os favoritos");
    }
  }
}
