class ObjectResult{
  final int status;
  final dynamic response;
  final String message;
  final String? responseCode;
  final bool isOK;
  final bool isError;

  ObjectResult(this.status, this.response, this.message, this.responseCode, this.isOK, this.isError);

  ObjectResult.fromJson(Map<String, dynamic> json)
      : status = json["status"],
        response = json["response"],
        message = json["message"]?? "",
        responseCode = json["response_code"]?? "",
        isOK = json["isOk"] ?? false,
        isError = json["isError"] ?? false;

  @override
  String toString() {
    return "ResultObject: status = $status, response = $response, isok = $isOK, isError = $isError, response_code = $responseCode, message = $message";
  }
}