
import 'dart:async';
import 'dart:convert';

import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/activity/activity_diary_no_network.dart';
import 'package:diary_mobile/data/entity/activity/activity_transaction.dart';
import 'package:diary_mobile/data/entity/diary/detail_diary.dart';
import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/report/question.dart';
import 'package:diary_mobile/data/entity/report/question_upload.dart';
import 'package:diary_mobile/data/entity/report/report.dart';
import 'package:diary_mobile/data/entity/setting/user_info.dart';
import 'package:diary_mobile/data/remote_data/network_processor/http_method.dart';
import 'package:diary_mobile/data/remote_data/network_processor/network_executor.dart';
import 'package:diary_mobile/data/remote_data/object_model/object_result.dart';
import 'package:diary_mobile/utils/constants/api_const.dart';
import 'package:diary_mobile/utils/constants/status_const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants/shared_preferences.dart';
import '../utils/constants/shared_preferences_key.dart';
import '../utils/widgets/dialog/dialog_manager.dart';
import 'entity/diary/diary.dart';
import 'entity/item_default/item_default.dart';
import 'entity/item_default/material_entity.dart';
import 'entity/item_default/tool.dart';
import 'entity/item_default/unit.dart';
import 'entity/monitor/monitor_diary.dart';
import 'entity/report/answer.dart';
import 'entity/report/report_result.dart';
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
      'login': "managervis2",//"0385672922",//adminvisimex//managervis2
      //'login': "ofitsoft@gmail.com",
      'password': "Abcd@1234",
    };
    var headers = {'Content-Type': 'application/json'};
    print("HoangCV: login data: ${object}");

    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.login,
            //method: HttpMethod.POST,
            body: ObjectData(params: object1, isLogin: true),
            header: headers),
        isLogin: true);

    //ObjectResult objectResult =  ObjectResult(1, "", "1", "00", true, false);
    print("HoangCV: login response: ${objectResult.response}");
    if (objectResult.responseCode == StatusConst.code00) {
      sharedPreferences.setString(SharedPreferencesKey.token, objectResult.response["token"]);
      sharedPreferences.setInt(SharedPreferencesKey.userId, objectResult.response["user_id"]);
      sharedPreferences.setString(SharedPreferencesKey.fullName, objectResult.response["user_name"]);
      sharedPreferences.setString(SharedPreferencesKey.group, objectResult.response["group"]);
      sharedPreferences.setString(SharedPreferencesKey.imageProfile, objectResult.response["image"]??'');
      Map<String, dynamic> roleMap = objectResult.response["role"];
      Map<String, List<bool>> role = {};
      roleMap.forEach((key, value) {
        if (value is List<dynamic> && value.every((item) => item is bool)) {
          role[key] = List<bool>.from(value);
        }
      });
      final roleJson = jsonEncode(role); // Chuyển đổi role thành chuỗi JSON
      await sharedPreferences.setString(SharedPreferencesKey.role, roleJson);
      //sau khi login thanh công gọi danh mục dùng chung
      getListActivities();
      getListMaterials();
      getListUnits(10);
      getListUnits(9);
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

      sharedPreferences.setInt(id == 8 ? SharedPreferencesKey.unitArea : id == 9 ?SharedPreferencesKey.unitYield: SharedPreferencesKey.unitAmount, list[0].categoryId ?? -1);
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
  Future<List<Diary>> getListDiary({bool monitor = false}) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    bool check = await SharedPreDiary.getRole();
    String path = ApiConst.getListDiary;
    if(check || monitor){
      path += "$userId";
    } else{
    }
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: path/*ApiConst.getListDiary + "$userId"*/,
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListDiary response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00) {
      List<Diary> list = List.from(objectResult.response)
          .map((json) => Diary.fromJson(json, userId))
          .toList();
      DiaryDB.instance.insertListDiary(list);
      return list;
    }
    else if (objectResult.responseCode != StatusConst.code02){
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
   /* if (monitor) {
      return [];
    } else {*/
      return DiaryDB.instance.getListDiary(userId);
    //}
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

    return DiaryDB.instance.getListActivityDiary(id);
  }

  //khong dung den
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
 /*   final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: "${ApiConst.getInfoDiary}$id",
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    print("HoangCV: getInfoDiary response: ${objectResult.response}: ${objectResult.isOK}");
    if (objectResult.responseCode == StatusConst.code00 || objectResult.message == "Successfully") {
      Diary list = Diary.fromJson(objectResult.response);
      DiaryDB.instance.insertListDiary([list]);
      return list;
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }*/
    List<Diary> list = await DiaryDB.instance.getInfoDiary(id);
    return list.first;
  }

  @override
  Future<void> getUpdateDiary(int id) async{
       final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
       int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: "${ApiConst.getInfoDiary}$id",
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    print("HoangCV: getInfoDiary response: ${objectResult.response}: ${objectResult.isOK}");
    if (objectResult.responseCode == StatusConst.code00 || objectResult.message == "Successfully") {
      Diary list = Diary.fromJson(objectResult.response, userId);
      DiaryDB.instance.insertListDiary([list]);
      //return list;
    }
   /* else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }*/
    // List<Diary> list = await DiaryDB.instance.getInfoDiary(id);
   // return list.first;
  }

  @override
  Future<UserInfo> getUserInfo() async{
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
      DiaryDB.instance.createOrUpdateUser(list);
      return list;
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    List<UserInfo> list = await DiaryDB.instance.getUserEntity(userId);
    return list.first;
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
    else if(objectResult.responseCode == StatusConst.code06) {
      print("HoangCV: addActivityDiary not network");
      ActDiaryNoNetwork actDiaryNoNetwork = ActDiaryNoNetwork.fromJsonConvert(diary, ApiConst.addActivityDiary);
      DiaryDB.instance.insertListActDiaryNoNetWork([actDiaryNoNetwork]);
      DiaryDB.instance.insertListActivityDiary([diary]);
    /*  DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );*/
    }
    else{
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

    print("HoangCV: addActivityDiary response: ${objectResult.response}: ${objectResult.isOK} : id: $id");
    if (objectResult.responseCode == StatusConst.code00) {
      DiaryDB.instance.removeActivityDiary(id);
    }
/*      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );*/
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
    return DiaryDB.instance.getListMonitorDiary();
  }

  @override
  Future<ObjectResult> updateUserInfo(UserInfo userInfo) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: "${ApiConst.editUserInfo}$userId",
            method: HttpMethod.GET,
            body: ObjectData(token: token, params: userInfo.toJson())));
    print("HoangCV: updateUserInfo response: ${objectResult.response}: ${objectResult.isOK}");
    DiaLogManager.showDialogHTTPError(
      status: objectResult.status,
      resultStatus: objectResult.status,
      resultObject: objectResult.message,
    );
    if (objectResult.responseCode == StatusConst.code00) {
      //UserInfo list = UserInfo.fromJson(objectResult.response);
      return objectResult;
    }
    else {

    }
    return objectResult;
  }

  @override
  Future<ObjectResult> changePassword(String passwordOld, String passwordNew) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    final Map<String, Object> object = {
      'old_password': passwordOld,
      'new_password': passwordNew,
    };
    var headers = {'Content-Type': 'application/json'};
    print("HoangCV: login data: ${object}");

    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: "${ApiConst.changePassword}$userId",
            body: ObjectData(token: token, params: object),
            /*header: headers*/),
        isLogin: true);

    print("HoangCV: login response: ${objectResult.response}");
    if (objectResult.responseCode == StatusConst.code00) {
      sharedPreferences.remove(SharedPreferencesKey.token);
      sharedPreferences.remove(SharedPreferencesKey.userId);
      sharedPreferences.remove(SharedPreferencesKey.fullName);
      sharedPreferences.remove(SharedPreferencesKey.group);
      sharedPreferences.remove(SharedPreferencesKey.imageProfile);
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
  Future<ObjectResult> addManyActivityDiary(ActivityDiary diary) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.addManyActivityDiary,
            method: HttpMethod.GET,
            body: ObjectData(token: token, params: diary.toJson())));
    print("HoangCV: addManyActivityDiary response: ${objectResult.response}: ${objectResult.isOK}");
    if (objectResult.responseCode == StatusConst.code00) {
      return objectResult;
    }
    else if(objectResult.responseCode == StatusConst.code06) {
      print("HoangCV: addManyActivityDiary not network");
      ActDiaryNoNetwork actDiaryNoNetwork = ActDiaryNoNetwork.fromJsonConvert(diary, ApiConst.addManyActivityDiary);
      DiaryDB.instance.insertListActDiaryNoNetWork([actDiaryNoNetwork]);
      DiaryDB.instance.insertListActivityDiary([diary]);
      /*  DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );*/
    }
    else{
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return objectResult;
  }

  @override
  Future<List<ActivityTransaction>> getListActivityTransaction(int id) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: "${ApiConst.getListActivityTransaction}$id",
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListActivity response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00 || objectResult.responseCode == StatusConst.code02) {
      List<ActivityTransaction> list = List.from(objectResult.response)
          .map((json) => ActivityTransaction.fromJson(json))
          .toList();
      list.sort((a,b)=> (b.transactionDate??"").compareTo((a.transactionDate??"")));
      //DiaryDB.instance.insertListActivityDiary(list);
      return list;
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }

    return []/*DiaryDB.instance.getListActivityDiary(id)*/;
  }

  @override
  Future<ObjectResult> addActivityTransaction(ActivityTransaction transaction) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.addActivityTransaction,
            method: HttpMethod.GET,
            body: ObjectData(token: token, params: transaction.toJson())));
    print("HoangCV: addActivityDiary response: ${objectResult.response}: ${objectResult.isOK}");
    if (objectResult.responseCode == StatusConst.code00) {
      return objectResult;
    }
  /*  else if(objectResult.responseCode == StatusConst.code06) {
      print("HoangCV: addActivityDiary not network");
      ActDiaryNoNetwork actDiaryNoNetwork = ActDiaryNoNetwork.fromJsonConvert(diary, ApiConst.addActivityDiary);
      DiaryDB.instance.insertListActDiaryNoNetWork([actDiaryNoNetwork]);
      DiaryDB.instance.insertListActivityDiary([diary]);
    }*/
    else{
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return objectResult;
  }

  @override
  Future<List<Report>> getListActivityReport() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListReport+'1',
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListActivityReport response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00 /*|| objectResult.responseCode == StatusConst.code02*/) {
      List<Report> list = List.from(objectResult.response)
          .map((json) => Report.fromJson(json))
          .toList();
      //assignIdSelected(list[0].questionAndPageIds);
      List<int> idSelectedList = List.generate(list[1].questionAndPageIds.length * 2, (index) => index + 1);
      assignIdSelected(list[1].questionAndPageIds, idSelectedList);
      final hierarchyList = buildReportHierarchy(list);
      hierarchyList.forEach((element) {
        print("HoangCV: hierarchyList: ${element.questionAndPageIds.length} : ${element.toJson()}");
      });
      // list.sort((a,b)=> (b.transactionDate??"").compareTo((a.transactionDate??"")));
      //DiaryDB.instance.insertListActivityDiary(list);
      return hierarchyList;
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }

    return []/*DiaryDB.instance.getListActivityDiary(id)*/;
  }

  void assignIdSelected(List<dynamic> items, List<int> idSelectedList) {
    for (dynamic item in items) {
      if (item is Question || item is Answer) {
        // Assign a unique idSelected value to the current item
        item.idSelected = idSelectedList.removeAt(0);

        // Recursively assign idSelected values to child questions and answers
        assignIdSelected(item.suggestedAnswerIds, idSelectedList);
        assignIdSelected(item.questionAndPageIds, idSelectedList);
      }
    }
  }

  // convert list đánh giá nội bộ
  List<Report> buildReportHierarchy(List<Report> reports) {
    List<Question> list1 = reports[1].questionAndPageIds.map((question) => Question.copy(question)).toList();
    List<Question> list2 = [];
    List<Question> list3 = [];
    for (int i = 0; i < list1.length - 1; i++) {
      bool checkQuestion = true;
      if ((i > 0 && list1[i].pageId != list2.last.id) || i == 0) {
        list2.add(list1[i]);
        //print("HoangCV: list1[i].id[j]: ${list1[i].pageId} : ${list2.last.id}");
        int index = list2.indexWhere((element) => element.id == list1[i].id);
        for (int j = i + 1; j < list1.length; j++) {
          if (list1[i].id == list1[j].pageId) {
            checkQuestion = false;
            list2[index].questionAndPageIds.add(list1[j]);
          }
        }
        if (!checkQuestion) {
          int length = list2
              .where((element) => element.id == list2[index].id)
              .toList()
              .length;
          list2.removeRange(index, index + length - 1);
        }
      }
    }
    List<Question> result = list2.map((question) => Question.copy(question)).toList();
    for(int k = 0 ; k < list2.length ; k++) {
      for (int i = 0; i < list2[k].questionAndPageIds.length - 1; i++) {
          for (int l = i + 1; l < list2[k].questionAndPageIds.length; l++) {
            if ((list2[k].questionAndPageIds[i].id ==
                list2[k].questionAndPageIds[l].triggeringQuestionId)) {
              for (int m = 0; m <
                  list2[k].questionAndPageIds[i].suggestedAnswerIds
                      .length; m++) {
                if ((list2[k].questionAndPageIds[i].suggestedAnswerIds[m].id ==
                    list2[k].questionAndPageIds[l].triggeringAnswerId)) {
                  int index = result[k].questionAndPageIds.indexWhere((
                      element) =>
                  element.id == list2[k].questionAndPageIds[i].id);
                  if (index != -1) {
                    result[k].questionAndPageIds[index].suggestedAnswerIds[m]
                        .questionAndPageIds.
                    add(list2[k].questionAndPageIds[l]);
                  }
                  int indexRemove = result[k].questionAndPageIds.indexWhere((
                      element) =>
                  element.id == list2[k].questionAndPageIds[l].id);
                  if (indexRemove != -1) {
                    result[k].questionAndPageIds.removeAt(indexRemove);
                  }
                }
              }
            }
          }
        }
      for (int i = 0; i < list2[k].questionAndPageIds.length; i++) {
        if (list2[k].questionAndPageIds[i].questionType == "table") {
          for (int m = 0; m <
              list2[k].questionAndPageIds[i].suggestedAnswerIds.length; m++) {
            for (int n = m+1; n <
                list2[k].questionAndPageIds[i].suggestedAnswerIds.length; n++) {
              if ((list2[k].questionAndPageIds[i].suggestedAnswerIds[m].id ==
                  list2[k].questionAndPageIds[i].suggestedAnswerIds[n]
                      .parentColId)) {
                int index = result[k].questionAndPageIds[i].suggestedAnswerIds
                    .indexWhere((element) =>
                element.id ==
                    list2[k].questionAndPageIds[i].suggestedAnswerIds[m].id);
                if (index != -1) {
                  result[k].questionAndPageIds[i].suggestedAnswerIds[index]
                      .suggestedAnswerIds.
                  add(list2[k].questionAndPageIds[i].suggestedAnswerIds[n]);
                }
                int indexRemove = result[k].questionAndPageIds[i]
                    .suggestedAnswerIds.indexWhere((element) =>
                element.id ==
                    list2[k].questionAndPageIds[i].suggestedAnswerIds[n].id);
                if (indexRemove != -1) {
                  result[k].questionAndPageIds[i].suggestedAnswerIds.removeAt(
                      indexRemove);
                }
              }
            }
          }
        }
      }
    }
    result.forEach((element1) {
      print("HoangCV: result: ${result.length} : ${element1.toJson()}");

    });
    result[1].questionAndPageIds.forEach((element1) {
      print("HoangCV: question: ${result.length} : ${element1.toJson()}");

    });
    print("HoangCV: ");
    reports[1].questionAndPageIds = List.from(result);
    return reports;
  }

  @override
  Future<List<Diary>> getListBackupDiary() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListBackupDiary,
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListDiary response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00) {
      List<Diary> list = List.from(objectResult.response)
          .map((json) => Diary.fromJson(json, userId))
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
    return DiaryDB.instance.getListDiary(userId);
  }

  @override
  Future<ObjectResult> uploadQuestion(QuestionUpload questionUpload) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    print("HoangCV: uploadQuestion response: ${questionUpload.list_id_suggested is List}");
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.uploadQuestion,
            method: HttpMethod.GET,
            body: ObjectData(token: token, params: questionUpload.toJson())));
    print("HoangCV: uploadQuestion response: ${objectResult.response}: ${objectResult.isOK}");
    if (objectResult.responseCode == StatusConst.code00) {
      return objectResult;
    }
    /*  else if(objectResult.responseCode == StatusConst.code06) {
      print("HoangCV: addActivityDiary not network");
      ActDiaryNoNetwork actDiaryNoNetwork = ActDiaryNoNetwork.fromJsonConvert(diary, ApiConst.addActivityDiary);
      DiaryDB.instance.insertListActDiaryNoNetWork([actDiaryNoNetwork]);
      DiaryDB.instance.insertListActivityDiary([diary]);
    }*/
    else{
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return objectResult;
  }

  @override
  Future<List<ReportResult>> getListReportResult() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListReportResult,
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    print("HoangCV: getListReportResult response: ${objectResult.response}");
    if (objectResult.responseCode == StatusConst.code00) {
      List<ReportResult> list = List.from(objectResult.response)
          .map((json) => ReportResult.fromJson(json))
          .toList();
      return list;
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return [];
  }
}