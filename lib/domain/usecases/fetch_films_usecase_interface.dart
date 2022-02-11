import 'package:star_wars_app/domain/repositories/fetch_films_repository_interface.dart';

abstract class IFetchFilmsUsecase {
  Future<List> call();
}

class FetchFilmsUsecase implements IFetchFilmsUsecase {
  final IFetchFilmsRespository _respository;

  FetchFilmsUsecase(this._respository);

  @override
  Future<List> call() async {
    final response = await _respository(); 
    return response.result;
  }
}
