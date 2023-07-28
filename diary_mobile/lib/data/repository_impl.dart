
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
import 'package:diary_mobile/utils/constans/status_const.dart';
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
import 'entity/monitor/monitor_diary.dart';
import 'fake_data/fake_repository_impl.dart';
import 'local_data/diary_db.dart';
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
      'login': "0987890987",
      //'login': "ofitsoft@gmail.com",
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
            path: ApiConst.login,
            //method: HttpMethod.POST,
            body: ObjectData(params: object1, isLogin: true),
            header: headers),
        isLogin: true);

    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", true, false);
    print("HoangCV: login response: ${objectResult.response}");
    if (objectResult.responseCode == StatusConst.code00) {
      sharedPreferences.setString(SharedPreferencesKey.token,objectResult.response["token"]);
      sharedPreferences.setInt(SharedPreferencesKey.userId,objectResult.response["user_id"]);
      //sau khi login thanh công gọi danh mục dùng chung
      getListActivities();
      getListMaterials();
      getListUnits(10);
      getListUnits(8);
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

  @override
  Future<bool> checkExpToken() async{
    return true;
  }

  @override
  Future<List<Activity>> getListActivities() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
          path: ApiConst.getListActivities,
            method: HttpMethod.GET,
          body: ObjectData(token: token)));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListActivities response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00) {
      List<Activity> list = List.from(objectResult.response)
          .map((json) => Activity.fromJson(json))
          .toList();
      await DiaryDB.instance.insertListActivity(list);
      return list;
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return FakeRepositoryImpl().getListActivities();
  }

  @override
  Future<List<MaterialEntity>> getListMaterials() async{
    final sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListMaterials,
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListMaterials response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00) {
      List<MaterialEntity> list = List.from(objectResult.response)
          .map((json) => MaterialEntity.fromJson(json))
          .toList();
      DiaryDB.instance.insertListMaterial(list);
      return list;
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return FakeRepositoryImpl().getListMaterials();
  }

  @override
  Future<List<Tool>> getListTools() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListTools,
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListTools response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00) {
      List<Tool> list = List.from(objectResult.response)
          .map((json) => Tool.fromJson(json))
          .toList();
      DiaryDB.instance.insertListTool(list);
      return list;
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return FakeRepositoryImpl().getListTools();
  }

  @override
  Future<List<Unit>> getListUnits(int id) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListUnits,
            method: HttpMethod.GET,
            body: ObjectData(token: token, params: {"sequence": "$id"})));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListUnits response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00) {
      List<Unit> list = List.from(objectResult.response)
          .map((json) => Unit.fromJson(json))
          .toList();
      sharedPreferences.setInt(id == 8 ? SharedPreferencesKey.unitArea : SharedPreferencesKey.unitAmount, list[0].categoryId ?? -1);
      DiaryDB.instance.insertListUnit(list);
      return list;
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return FakeRepositoryImpl().getListUnits(id);
  }

  @override
  Future<List<Diary>> getListDiary() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListDiary + "$userId",
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListDiary response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00) {
      List<Diary> list = List.from(objectResult.response)
          .map((json) => Diary.fromJson(json))
          .toList();
      DiaryDB.instance.insertListDiary(list);
      return list;
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return FakeRepositoryImpl().getListDiary();
  }

  @override
  Future<List<ActivityDiary>> getListActivityDiary(int id) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: "${ApiConst.getListActivity}$id",
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListActivity response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00 || objectResult.responseCode == StatusConst.code02) {
      List<ActivityDiary> list = List.from(objectResult.response)
          .map((json) => ActivityDiary.fromJson(json))
          .toList();
      list.sort((a,b)=> (b.actionTime??"").compareTo((a.actionTime??"")));
      DiaryDB.instance.insertListActivityDiary(list);
      return list;
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return FakeRepositoryImpl().getListActivityDiary(id);
  }

  @override
  Future<ActivityDiary> getDetailDiary(int id) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: "${ApiConst.getListDiary}$id",
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getDetailDiary response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00) {
      ActivityDiary list = ActivityDiary.fromJson(objectResult.response);
      return list;
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return FakeRepositoryImpl().getDetailDiary(id);
  }

  @override
  Future<Diary> getInfoDiary(int id) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: "${ApiConst.getInfoDiary}$id",
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    print("HoangCV: getInfoDiary response: ${objectResult.response}: ${objectResult.isOK}");
    if (objectResult.responseCode == StatusConst.code00 || objectResult.message == "Successfully") {
      Diary list = Diary.fromJson(objectResult.response);
      return list;
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return FakeRepositoryImpl().getInfoDiary(id);
  }

  @override
  Future<UserInfo> getUserInfo(int id) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: "${ApiConst.getUserInfo}$userId",
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    print("HoangCV: getUserInfo response: ${objectResult.response}: ${objectResult.isOK}");
    if (objectResult.responseCode == StatusConst.code00) {
      UserInfo list = UserInfo.fromJson(objectResult.response);
      return list;
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return FakeRepositoryImpl().getUserInfo(id);
  }

  @override
  Future<ObjectResult> addActivityDiary(ActivityDiary diary) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.addActivityDiary,
            method: HttpMethod.GET,
            body: ObjectData(token: token, params: diary.toJson())));
    print("HoangCV: addActivityDiary response: ${objectResult.response}: ${objectResult.isOK}");
    if (objectResult.responseCode == StatusConst.code00) {
      return objectResult;
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

  @override
  Future<ObjectResult> updateActivityDiary(ActivityDiary diary) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: "${ApiConst.updateActivityDiary}${diary.id}",
            method: HttpMethod.GET,
            body: ObjectData(token: token, params: diary.toJson())));
    print("HoangCV: addActivityDiary response: ${objectResult.response}: ${objectResult.isOK}");
    if (objectResult.responseCode == StatusConst.code00) {
      return objectResult;
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

  @override
  Future<ObjectResult> removeActivityDiary(int id) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: "${ApiConst.removeActivityDiary}$id",
            method: HttpMethod.GET,
            body: ObjectData(token: token)));

    print("HoangCV: addActivityDiary response: ${objectResult.response}: ${objectResult.isOK}");

      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    return objectResult;
  }

  @override
  Future<List<MonitorDiary>> getListMonitorDiary(int id) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: "${ApiConst.getListMonitor}$id",
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListMonitorDiary response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00 || objectResult.responseCode == StatusConst.code02) {
      List<MonitorDiary> list = List.from(objectResult.response)
          .map((json) => MonitorDiary.fromJson(json))
          .toList();
      list.sort((a,b)=> (b.actionTime??"").compareTo((a.actionTime??"")));
      DiaryDB.instance.insertListMonitorDiary(list);
      return list;
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return FakeRepositoryImpl().getListMonitorDiary(id);
  }

}