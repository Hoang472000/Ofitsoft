

import '../../../utils/constans/api_const.dart';
import '../network_processor/http_method.dart';
import '../object_model/object_command_data.dart';

///diffine api
class ApiBaseGenerator{
  String path;
  String method;
  String baseUrl;
  dynamic body;
  Map<String, dynamic>? queryParameters;
  Map<String, dynamic> header;

  ///cac truong bat buoc : body, method, cac truong khac neu khong truyen vao thi lay gia tri mac dinh
  ///body: truong bat buoc: commandObject,
  ApiBaseGenerator({this.path= "", this.method= HttpMethod.POST, this.baseUrl= ApiConst.domainApi,
    required this.body, this.queryParameters=const {}, this.header=const {}});

  static int get sendTimeout => 20000;

  static int get receiveTimeOut => 20000;
}