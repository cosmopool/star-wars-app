import 'package:star_wars_app/domain/entities/entity.dart';

abstract class IShowFavoritesUsecase {
  List<Entity> call();
}
