class ObjectResult{
  final int status;
  final dynamic response;
  final String message;
  final String? code;
  final bool isOK;
  final bool isError;

  ObjectResult(this.status, this.response, this.message, this.code, this.isOK, this.isError);

  ObjectResult.fromJson(Map<String, dynamic> json)
      : status = json["Status"],
        response = json["response"],
        message = json["message"]?? "",
        code = json["Code"]?? "",
        isOK = json["isOk"] ?? false,
        isError = json["isError"] ?? false;

  @override
  String toString() {
    return "ResultObject: status = $status, response = $response, isok = $isOK, isError = $isError, code = $code, message = $message";
  }
}