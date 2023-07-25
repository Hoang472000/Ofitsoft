import 'package:get/get.dart';

class ObjectData{
  String token;
  final bool isLogin;
  //final int commandType;
  final dynamic params;

  ObjectData(
      {this.token = "",
        this.params = const {},
        //required this.commandType,
        this.isLogin= false,
      });

  Map<String, dynamic> toJson() => {
    "token": token,
    //"OrgGUID": orgGUID,
   /* "CommandType": commandType,*/
    "params": params,
  };
}