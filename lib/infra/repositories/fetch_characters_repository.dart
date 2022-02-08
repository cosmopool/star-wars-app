import 'package:star_wars_app/core/enums.dart';
import 'package:star_wars_app/domain/entities/character_entity.dart';
import 'package:star_wars_app/domain/repositories/fetch_entities_repository_interface.dart';
import 'package:star_wars_app/infra/datasource/datasource_interface.dart';

class FetchCharactersRepository implements IFetchEntityRespository {
  final IDatasource _datasource;

  FetchCharactersRepository(this._datasource);

  List<CharacterEntity> _parseResponse(Map response) {
    return [];
  }

  @override
  List<CharacterEntity> call() {
    final response = _datasource(Endpoint.characters);

    return _parseResponse(response);
  }
}
