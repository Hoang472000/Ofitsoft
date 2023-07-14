class ObjectData{
  String token;
  //final String orgGUID;
  //final int commandType;
  final dynamic object;

  ObjectData(
      {this.token = "",
        this.object = const {},
        //required this.commandType,
        //this.orgGUID= ""
      });

  Map<String, dynamic> toJson() => {
    "token": token,
    //"OrgGUID": orgGUID,
   /* "CommandType": commandType,*/
    "object": object,
  };
}