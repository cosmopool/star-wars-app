import 'package:star_wars_app/core/enums.dart';
import 'package:star_wars_app/domain/entities/film_entity.dart';
import 'package:star_wars_app/domain/repositories/fetch_entities_repository_interface.dart';
import 'package:star_wars_app/infra/datasource/datasource_interface.dart';

class FetchFilmsRepository implements IFetchEntityRespository {
  final IDatasource _datasource;

  FetchFilmsRepository(this._datasource);

  List<FilmEntity> _parseResponse(Map response) {
    return [];
  }

  @override
  List<FilmEntity> call() {
    final response = _datasource(Endpoint.films);

    return _parseResponse(response);
  }
}
