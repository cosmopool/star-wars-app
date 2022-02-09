import 'package:star_wars_app/core/response.dart';
import 'package:star_wars_app/domain/entities/entity.dart';

abstract class IFavoritesRespository {
  bool add(Entity entity);
  bool remove(Entity entity);
  Response showAll();
}
