import 'package:star_wars_app/core/enums.dart';

abstract class IApiDatasource {
  Future<Map> call(Endpoint endpoint);
}
