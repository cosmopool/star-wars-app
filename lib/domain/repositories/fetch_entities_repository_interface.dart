import 'package:star_wars_app/core/response.dart';

abstract class IFetchEntityRespository {
  Future<Response> call();
}
