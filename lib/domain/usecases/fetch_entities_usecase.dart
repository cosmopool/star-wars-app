import 'package:star_wars_app/core/domain/entities/response.dart';
import 'package:star_wars_app/domain/entities/entity.dart';

abstract class IFetchEntitiesUsecase {
  Future<Response<Entity>> call();
}

class FetchEntitiesUsecase implements IFetchEntitiesUsecase {
  final IFetchEntitiesRespository _respository;

  FetchEntitiesUsecase(this._respository);

  @override
  Future<Response<Entity>> call() async {
    final response = await _respository(); 
    return response.result;
  }
}
