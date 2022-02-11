import 'package:star_wars_app/core/domain/entities/response.dart';
import 'package:star_wars_app/core/enums.dart';
import 'package:star_wars_app/domain/entities/entity.dart';
import 'package:star_wars_app/domain/repositories/fetch_entities_repository_interface.dart';

abstract class IFetchEntitiesUsecase {
  Future<Response<Entity>> call(Endpoint endpoint);
}

class FetchEntitiesUsecase implements IFetchEntitiesUsecase {
  final IFetchEntitiesRespository _respository;

  FetchEntitiesUsecase(this._respository);

  @override
  Future<Response<Entity>> call(Endpoint endpoint) async {
    final response = await _respository(endpoint); 
    return response;
  }
}
