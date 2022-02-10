class ResponseEntity {
  late final bool error;
  late final String errMessage;
  late final List result;

  ResponseEntity(this.error, this.errMessage, this.result);

  ResponseEntity.onError(String message) {
    error = true;
    errMessage = message;
    result = [];
  }

  ResponseEntity.onSuccess(List responseResult) {
    error = false;
    errMessage = "No error.";
    result = responseResult;
  }
}
