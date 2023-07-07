class ObjectCommandData{
  final String accessToken;
  final String orgGUID;
  //final int commandType;
  final dynamic commandObject;

  ObjectCommandData(
      {this.accessToken="",
        required this.commandObject,
        //required this.commandType,
        this.orgGUID= ""});

  Map<String, dynamic> toJson() => {
    "AccessToken": accessToken,
    "OrgGUID": orgGUID,
   /* "CommandType": commandType,*/
    "CommandObject": commandObject,
  };
}