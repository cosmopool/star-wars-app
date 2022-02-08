import 'package:star_wars_app/domain/entities/entity.dart';

abstract class IFetchEntityRespository {
  List<Entity> call();
}
