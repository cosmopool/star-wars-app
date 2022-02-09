class Response {
  late final bool error;
  late final String errMessage;
  late final List result;

  Response(this.error, this.errMessage, this.result);

  Response.onError(String message) {
    error = true;
    errMessage = message;
    result = [];
  }

  Response.onSuccess(List responseResult) {
    error = false;
    errMessage = "No error.";
    result = responseResult;
  }
}
