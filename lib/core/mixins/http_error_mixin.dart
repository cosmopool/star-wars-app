import 'dart:io';

import 'package:star_wars_app/domain/entities/response_entity.dart';

mixin HttpResponseErrorMenager {
  Future<ResponseEntity> manageHttpResponse(dynamic tryFunction) async {
    try {
      final result = await tryFunction();
      return ResponseEntity.onSuccess(result);
    } on SocketException {
      return ResponseEntity.onError("No Internet connection 😑");
    } on HttpException {
      return ResponseEntity.onError("Couldn't find the resource 😱");
    } on FormatException {
      return ResponseEntity.onError("Bad response format 👎");
    } catch (e) {
      return ResponseEntity.onError("Bad response 👎: $e");
    }
  }
}
