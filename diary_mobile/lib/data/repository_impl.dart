
import 'dart:async';
import 'dart:convert';

import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/diary/detail_diary.dart';
import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/setting/user_info.dart';
import 'package:diary_mobile/data/remote_data/network_processor/http_method.dart';
import 'package:diary_mobile/data/remote_data/network_processor/network_executor.dart';
import 'package:diary_mobile/data/remote_data/object_model/object_result.dart';
import 'package:diary_mobile/utils/constans/api_const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants/shared_preferences_key.dart';
import '../utils/widgets/dialog_manager.dart';
import 'entity/diary/diary.dart';
import 'entity/item_default/item_default.dart';
import 'entity/item_default/material_entity.dart';
import 'entity/item_default/tool.dart';
import 'entity/item_default/unit.dart';
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
/*    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: "/api/login",
            method: HttpMethod.POST,
            body: object1,
            header: headers),
        isLogin: true);*/
    //

    ObjectResult objectResult =  ObjectResult(1, "object", "1", "", true, false);
    print("HoangCV: login response: ${objectResult.response}");
    if (objectResult.isOK) {
      //sharedPreferences.setString(SharedPreferencesKey.accessToken,objectResult.response["access_token"]);
      //sau khi login thanh công gọi danh mục dùng chung
      getListActivities();
      getListMaterials();
      getListUnits();
      getListTools();
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
  Future<List<Activity>> getListActivities() async{
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
          path: ApiConst.getListActivities,
            method: HttpMethod.GET,
            body: {"token": "token"}));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListActivities response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.isOK) {
      List<Activity> list = List.from(objectResult.response)
          .map((json) => Activity.fromJson(json))
          .toList();
      return list;
    }
    else {
/*      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );*/
    }
    return FakeRepositoryImpl().getListActivities();
  }

  @override
  Future<List<MaterialEntity>> getListMaterials() async{
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListMaterials,
            method: HttpMethod.GET,
            body: {"token": "token"}));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListMaterials response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    List<MaterialEntity> list = List.from(objectResult.response)
        .map((json) => MaterialEntity.fromJson(json))
        .toList();
    if (objectResult.isOK) {
      return list;
    }
    else {
/*      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );*/
    }
    return FakeRepositoryImpl().getListMaterials();
  }

  @override
  Future<List<Tool>> getListTools() async{
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListTools,
            method: HttpMethod.GET,
            body: {"token": "token"}));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListTools response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.isOK) {
      List<Tool> list = List.from(objectResult.response)
          .map((json) => Tool.fromJson(json))
          .toList();
      return list;
    }
    else {
/*      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );*/
    }
    return FakeRepositoryImpl().getListTools();
  }

  @override
  Future<List<Unit>> getListUnits() async{
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListUnits,
            method: HttpMethod.GET,
            body: {"token": "token"}));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListUnits response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.isOK) {
      List<Unit> list = List.from(objectResult.response)
          .map((json) => Unit.fromJson(json))
          .toList();
      return list;
    }
    else {
/*      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );*/
    }
    return FakeRepositoryImpl().getListUnits();
  }

  @override
  Future<List<Diary>> getListDiary() async{
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListDiary + "/1",
            method: HttpMethod.GET,
            body: {"token": "token"}));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListUnits response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.isOK) {
      List<Diary> list = List.from(objectResult.response)
          .map((json) => Diary.fromJson(json))
          .toList();
      return list;
    }
    else {
/*      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );*/
    }
    return FakeRepositoryImpl().getListDiary();
  }

  @override
  Future<List<ActivityDiary>> getListActivityDiary() async{
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListActivity + "/1",
            method: HttpMethod.GET,
            body: {"token": "token"}));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListUnits response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.isOK) {
      List<ActivityDiary> list = List.from(objectResult.response)
          .map((json) => ActivityDiary.fromJson(json))
          .toList();
      return list;
    }
    else {
/*      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );*/
    }
    return FakeRepositoryImpl().getListActivityDiary();
  }

  @override
  Future<ActivityDiary> getDetailDiary(int id) async{
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListDiary + "/1",
            method: HttpMethod.GET,
            body: {"token": "token"}));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListUnits response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.isOK) {
      ActivityDiary list = ActivityDiary.fromJson(objectResult.response);
      return list;
    }
    else {
/*      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );*/
    }
    return FakeRepositoryImpl().getDetailDiary(id);
  }

  @override
  Future<Diary> getInfoDiary(int id) async{
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getInfoDiary + "/1",
            method: HttpMethod.GET,
            body: {"token": "token"}));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListUnits response: ${objectResult.response}: ${objectResult.isOK}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.isOK) {
      Diary list = Diary.fromJson(objectResult.response);
      return list;
    }
    else {
/*      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );*/
    }
    return FakeRepositoryImpl().getInfoDiary(id);
  }

  @override
  Future<UserInfo> getUserInfo(int id) async{
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getInfoDiary + "/1",
            method: HttpMethod.GET,
            body: {"token": "token"}));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListUnits response: ${objectResult.response}: ${objectResult.isOK}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.isOK) {
      UserInfo list = UserInfo.fromJson(objectResult.response);
      return list;
    }
    else {
/*      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );*/
    }
    return FakeRepositoryImpl().getUserInfo(id);
  }

}