import 'dart:io';

import 'package:star_wars_app/core/domain/entities/response.dart';
import 'package:star_wars_app/domain/entities/entity.dart';

mixin HttpResponseErrorMenager {
  Future<Response<Entity>> manageHttpResponse(dynamic tryFunction) async {
    try {
      final result = await tryFunction();
      return Response.onSuccess(result);
    } on SocketException {
      return Response.onError("No Internet connection 😑");
    } on HttpException {
      return Response.onError("Couldn't find the resource 😱");
    } on FormatException {
      return Response.onError("Bad response format 👎");
    } catch (e) {
      return Response.onError("Bad response 👎: $e");
    }
  }
}
