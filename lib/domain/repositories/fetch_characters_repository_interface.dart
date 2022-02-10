import 'package:star_wars_app/domain/entities/response_entity.dart';

abstract class IFetchCharactersRespository {
  Future<ResponseEntity> call();
}
