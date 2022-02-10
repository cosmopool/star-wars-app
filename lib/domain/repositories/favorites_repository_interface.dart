import 'package:star_wars_app/domain/entities/entity.dart';
import 'package:star_wars_app/domain/entities/response_entity.dart';

abstract class IFavoritesRespository {
  Future<ResponseEntity> add(Entity entity);
  Future<ResponseEntity> remove(Entity entity);
  Future<ResponseEntity> fetchAll();
}
