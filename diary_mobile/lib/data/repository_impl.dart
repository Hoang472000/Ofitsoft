
import 'dart:async';
import 'dart:convert';

import 'package:diary_mobile/data/remote_data/network_processor/http_method.dart';
import 'package:diary_mobile/data/remote_data/network_processor/network_executor.dart';
import 'package:diary_mobile/data/remote_data/object_model/object_result.dart';
import 'package:diary_mobile/utils/constans/api_const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants/shared_preferences_key.dart';
import '../utils/widgets/dialog_manager.dart';
import 'entity/item_default/item_default.dart';
import 'fake_data/fake_repository_impl.dart';
import 'remote_data/api_model/api_base_generator.dart';
import 'remote_data/object_model/object_command_data.dart';
import 'repository.dart';

import "package:http/http.dart" as http;

class RepositoryImpl extends Repository {
  final FakeRepositoryImpl _fakeData = FakeRepositoryImpl();
  //final bool isFakeData = FakeDataSource.isFake;


  // final ApiProvider _apiProvider = ApiProvider();

  //final NetworkExecutor networkExecutor = NetworkExecutor();

  BuildContext context;
  late NetworkExecutor networkExecutor;

  RepositoryImpl({required this.context}) {
    networkExecutor = NetworkExecutor(context: context);
  }
  @override
  Future<ObjectResult> login(String userName, String pass) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final Map<String, Object> object = {
      'login': userName,
      'password': pass,
    };
    final Map<String, Object> object1 = {
      'login': "ofitsoft@gmail.com",
      'password': "Abcd@1234",
    };
    var headers = {'Content-Type': 'application/json'};
    print("HoangCV: login data: ${object1}");
    //HoangCV: fix accessToken

    // sharedPreferences.setString(SharedPreferencesKey.accessToken,
    //     "72545975963369f5a96082a2d565772b2baa7e24");
    //
    //HoangCV: pass login
    // final Dio _dio = Dio();
    // final response = await _dio.fetch(RequestOptions(path: 'https://10.0.2.2:8015/api/login', data: object1,headers: _headers));
    // print("HoangCV: login response: ${response.data}");
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: "/api/login",
            method: HttpMethod.POST,
            body: object1,
            header: headers),
        isLogin: true);
    //

    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: login response: ${objectResult.response}");
    if (objectResult.isOK) {
      sharedPreferences.setString(SharedPreferencesKey.accessToken,objectResult.response["access_token"]);
      //sau khi login thanh công gọi danh mục dùng chung
      getListActivities();
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return objectResult;
  }

  /*@override
  Future<ObjectResult> login(String userName, String pass) async {
    Dio dio = Dio(); // Khởi tạo đối tượng Dio
    try {
*//*      Response response = await dio.get(
        'http://10.0.2.2:8015/api/login',
        queryParameters: object1,
      );*//*
      *//*      var queryParams = {'username': 'your_username', 'password': 'your_password'};
      var uri = Uri.https(url.authority, url.path, object1);*//*
      final Map<String, Object> object1 = {
        'login': "ofitsoft@gmail.com",
        'password': "Abcd@1234",
      };
      var body = json.encode(object1);
      var headers = {'Content-Type': 'application/json'};

      var url = Uri.parse('http://192.168.2.79:8015');

      var response = await http.post(url, body: body, headers: headers);
      // Xử lý dữ liệu trả về
      print("HoangCV1111"+ response.body);
    } catch (e) {
      // Xử lý lỗi
      print("HoangCV11111111: "+e.toString());
    }
    ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    return objectResult;
  }*/

  @override
  Future<bool> checkExpToken() async{
    return true;
  }

  @override
  Future<bool> getListActivities() async{
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
          path: ApiConst.getListActivities,
            method: HttpMethod.GET,
            body: ObjectData()));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListActivities response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.isOK) {
      List<Item> list = List.from(objectResult.response)
          .map((json) => Item.fromJson(json))
          .toList();
      return await getListMaterials();
    }
    else {
/*      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );*/
    }
    return false;
  }

  @override
  Future<bool> getListMaterials() async{
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListMaterials,
            method: HttpMethod.GET,
            body: ObjectData()));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListMaterials response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    List<Item> list = List.from(objectResult.response)
        .map((json) => Item.fromJson(json))
        .toList();
    if (objectResult.isOK) {
      return await getListTools();
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return false;
  }

  @override
  Future<bool> getListTools() async{
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListTools,
            method: HttpMethod.GET,
            body: ObjectData()));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListTools response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.isOK) {
      List<Item> list = List.from(objectResult.response)
          .map((json) => Item.fromJson(json))
          .toList();
      return await getListUnits();
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return false;
  }

  @override
  Future<bool> getListUnits() async{
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListUnits,
            method: HttpMethod.GET,
            body: ObjectData()));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListUnits response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.isOK) {
      List<Item> list = List.from(objectResult.response)
          .map((json) => Item.fromJson(json))
          .toList();
      return true;
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return false;
  }


}