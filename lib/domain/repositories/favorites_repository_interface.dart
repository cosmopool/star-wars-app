import 'package:star_wars_app/core/domain/entities/response.dart';
import 'package:star_wars_app/domain/entities/entity.dart';

abstract class IFavoritesRespository {
  Future<Response> add(Entity entity);
  Future<Response> remove(Entity entity);
  Future<Response<Entity>> fetch();
}
