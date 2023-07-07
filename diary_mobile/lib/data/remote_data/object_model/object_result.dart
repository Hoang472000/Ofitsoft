class ObjectResult{
  final int status;
  final dynamic object;
  final String? code;
  final bool isOK;
  final bool isError;

  ObjectResult(this.status, this.object, this.code, this.isOK, this.isError);

  ObjectResult.fromJson(Map<String, dynamic> json)
      : status = json["Status"],
        object = json["Object"],
        code = json["Code"]?? "",
        isOK = json["isOk"],
        isError = json["isError"];

  @override
  String toString() {
    return "ResultObject: status = $status, object = $object, isok = $isOK, isError = $isError, code = $code";
  }
}