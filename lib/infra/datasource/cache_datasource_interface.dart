import 'package:star_wars_app/domain/entities/entity.dart';

abstract class ICacheDatasource {
  bool add(Entity entity);
  bool remove(Entity entity);
  Map<String, dynamic> showAll();

}
