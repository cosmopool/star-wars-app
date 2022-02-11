import 'package:star_wars_app/core/domain/entities/response.dart';
import 'package:star_wars_app/core/enums.dart';
import 'package:star_wars_app/domain/entities/entity.dart';

abstract class IFetchEntitiesRespository {
  Future<Response<Entity>> call(Endpoint endpoint);
}
