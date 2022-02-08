import 'package:star_wars_app/domain/entities/entity.dart';

abstract class IRemoveFavoriteFilmUsecase {
  bool call(Entity entity);
}
