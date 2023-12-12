
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:diary_mobile/data/entity/access/detail_product_batch.dart';
import 'package:diary_mobile/data/entity/access/product_batch.dart';
import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/activity/activity_diary_no_network.dart';
import 'package:diary_mobile/data/entity/activity/activity_transaction.dart';
import 'package:diary_mobile/data/entity/activity/no_network/activity_purchase_no_network.dart';
import 'package:diary_mobile/data/entity/diary/area_entity.dart';
import 'package:diary_mobile/data/entity/diary/detail_diary.dart';
import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/notify/notify_entity.dart';
import 'package:diary_mobile/data/entity/report/question.dart';
import 'package:diary_mobile/data/entity/report/question_upload.dart';
import 'package:diary_mobile/data/entity/report/report.dart';
import 'package:diary_mobile/data/entity/setting/user_info.dart';
import 'package:diary_mobile/data/entity/workflow/workflow.dart';
import 'package:diary_mobile/data/remote_data/network_processor/http_method.dart';
import 'package:diary_mobile/data/remote_data/network_processor/network_executor.dart';
import 'package:diary_mobile/data/remote_data/object_model/object_result.dart';
import 'package:diary_mobile/utils/constants/api_const.dart';
import 'package:diary_mobile/utils/constants/status_const.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../utils/constants/shared_preferences.dart';
import '../utils/constants/shared_preferences_key.dart';
import '../utils/widgets/dialog/dialog_manager.dart';
import 'entity/activity/activity_purchase.dart';
import 'entity/activity/no_network/activity_transaction_no_network.dart';
import 'entity/activity/season_farm.dart';
import 'entity/diary/diary.dart';
import 'entity/item_default/item_default.dart';
import 'entity/item_default/material_entity.dart';
import 'entity/item_default/tool.dart';
import 'entity/item_default/unit.dart';
import 'entity/monitor/monitor_diary.dart';
import 'entity/report/answer.dart';
import 'entity/report/report_result_title.dart';
import 'entity/report/report_select.dart';
import 'entity/report/survey_report_result.dart';
import 'entity/setting/feedback_info.dart';
import 'fake_data/fake_repository_impl.dart';
import 'local_data/diary_db.dart';
import 'remote_data/api_model/api_base_generator.dart';
import 'remote_data/object_model/object_command_data.dart';
import 'repository.dart';

import "package:http/http.dart" as http;
import 'package:crypto/crypto.dart' as crypto;

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
    String password = sharedPreferences.getString(SharedPreferencesKey.password) ?? "";
    String passEncode = sharedPreferences.getString(SharedPreferencesKey.passwordEncode) ?? "";
    if(passEncode.compareTo(pass) == 0){
      pass = password;
    }
    final Map<String, Object> object = {
      'login': userName.removeAllWhitespace.toLowerCase(),
      'password': pass,
    };
    final Map<String, Object> object1 = {
      //'login': "managervis2",//"0385672922",//adminvisimex//managervis2
      //'login': "ofitsoft@gmail.com",
      'login': "managervis2",
      'password': "Abcd@1234",
    };
    var headers = {'Content-Type': 'application/json'};
    print("HoangCV: login data: ${object}");

    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.login,
            //method: HttpMethod.POST,
            body: ObjectData(params: object, isLogin: true),
            header: headers),
        isLogin: true);

    //ObjectResult objectResult =  ObjectResult(1, "", "1", "00", true, false);
    print("HoangCV: login response: ${objectResult.response}");
    DiaryDB.instance.deleteEverything();
    if (objectResult.responseCode == StatusConst.code00) {
      if (Platform.isIOS) {
        String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (apnsToken != null) {
          await FirebaseMessaging.instance.subscribeToTopic("${objectResult.response["user_id"]}");
        } else {
          await Future<void>.delayed(
            const Duration(
              seconds: 3,
            ),
          );
          apnsToken = await FirebaseMessaging.instance.getAPNSToken();
          if (apnsToken != null) {
            await FirebaseMessaging.instance.subscribeToTopic("${objectResult.response["user_id"]}");
          }
        }
      } else {
        await FirebaseMessaging.instance.subscribeToTopic("${objectResult.response["user_id"]}");
      }
      //await FirebaseMessaging.instance.subscribeToTopic("${objectResult.response["user_id"]}");
      sharedPreferences.setString(SharedPreferencesKey.userName, userName);
      sharedPreferences.setString(SharedPreferencesKey.password, pass);
      String md5Password = crypto.md5.convert(utf8.encode(pass)).toString();
      sharedPreferences.setString(SharedPreferencesKey.passwordEncode, md5Password.substring(0, 20));
      sharedPreferences.setInt(SharedPreferencesKey.userId, objectResult.response["user_id"]);
      sharedPreferences.setString(SharedPreferencesKey.token, objectResult.response["token"]);
      sharedPreferences.setString(SharedPreferencesKey.fullName, objectResult.response["user_name"] ?? '');
      sharedPreferences.setString(SharedPreferencesKey.group, objectResult.response["group"] ?? '');
      sharedPreferences.setString(SharedPreferencesKey.imageProfile, objectResult.response["image"] ?? '');
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
      getListWorkflow();
      getListAreaEntity();
    }
    else if (objectResult.responseCode == StatusConst.code01) {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: "Đăng nhập thất bại! \n Tên đăng nhập hoặc mật khẩu không chính xác.",
      );
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
    if (objectResult.responseCode == StatusConst.code00 || objectResult.responseCode == StatusConst.code02) {

      print("HoangCV: getListActivities response: ${objectResult.response}");
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
    return [];
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
    if (objectResult.responseCode == StatusConst.code00 || objectResult.responseCode == StatusConst.code02) {
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
    return [];
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
    if (objectResult.responseCode == StatusConst.code00 || objectResult.responseCode == StatusConst.code02) {
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
    return [];
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
    } else if(objectResult.responseCode == StatusConst.code02){
      return [];
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

  @override
  Future<List<Diary>> getListDiary(String action, {bool monitor = false}) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    List<bool> check = await SharedPreDiary.getRole();
    bool isAllTrueExceptFirst = check[0] == true &&
        check.skip(1).every((element) => element == false);
    String path = ApiConst.getListDiary;
    if(isAllTrueExceptFirst || monitor){
      path += "$userId";
    } else{
    }
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: path/*ApiConst.getListDiary + "$userId"*/,
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListDiary response: ${objectResult.response} : $monitor : $isAllTrueExceptFirst : ${objectResult.responseCode}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00 || objectResult.responseCode == StatusConst.code02) {
      List<Diary> list = List.from(objectResult.response)
          .map((json) => Diary.fromJson(json, userId, action))
          .toList();
      DiaryDB.instance.insertListDiary(list);
      print("HoangCV: getListDiary response: ${list.length}");
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
      return DiaryDB.instance.getListDiary(userId, action);
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
      /////
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
  Future<void> getUpdateDiary(String action, int id) async{
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
      Diary list = Diary.fromJson(objectResult.response, userId, action);
      DiaryDB.instance.insertListDiary([list]);
      //return list;
    }else if (objectResult.responseCode == StatusConst.code01) {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: "Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.",
      );
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
    print("HoangCV: addActivityDiary response: ${objectResult.responseCode}: ${objectResult.isOK}");
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
    }else if (objectResult.responseCode == StatusConst.code01) {

      print("HoangCV: addActivityDiary11 response: ${objectResult.responseCode}: ${objectResult.isOK}");
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: "Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.",
      );
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
    }else if (objectResult.responseCode == StatusConst.code01) {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: "Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.",
      );
    }else {
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
    if (objectResult.responseCode == StatusConst.code00) {
      //UserInfo list = UserInfo.fromJson(objectResult.response);
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: "Cập nhật thông tin tài khoản thành công.",
      );
      return objectResult;
    }else if (objectResult.responseCode == StatusConst.code01) {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: "Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.",
      );
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
      sharedPreferences.remove(SharedPreferencesKey.password);
      sharedPreferences.remove(SharedPreferencesKey.passwordEncode);
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
      await DiaryDB.instance.removeActivityTransaction();
      DiaryDB.instance.insertListActivityTransaction(list);
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

    return DiaryDB.instance.getListActivityTransaction();
  }

  @override
  Future<ObjectResult> addActivityTransaction(ActivityTransaction transaction) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.addActivityTransaction,
            method: HttpMethod.GET,
            body: ObjectData(token: token, params: transaction.toJson())));
    print("HoangCV: addActivityDiary response: ${objectResult.response}: ${objectResult.isOK}");
    if (objectResult.responseCode == StatusConst.code00) {
      return objectResult;
    }
    else if(objectResult.responseCode == StatusConst.code06) {
      print("HoangCV: addActivityTransaction not network");
      var uuid = Uuid();
      String idOffline = uuid.v1();
      transaction.uuid = idOffline;
      ActivityTransactionNoNetwork actDiaryNoNetwork = ActivityTransactionNoNetwork.fromJsonConvert(transaction, ApiConst.addActivityTransaction);
      DiaryDB.instance.insertListActivityTransactionNoNetwork([actDiaryNoNetwork]);
      DiaryDB.instance.insertListActivityTransaction([transaction]);
    }
    else if (objectResult.responseCode != StatusConst.code01) {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return objectResult;
  }

  @override
  Future<ObjectResult> updateActivityTransaction(ActivityTransaction transaction)async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: "${ApiConst.updateActivityTransaction}${transaction.id}",
            method: HttpMethod.GET,
            body: ObjectData(token: token, params: transaction.toJson())));
    print("HoangCV: updateActivityTransaction response: ${objectResult.response}: ${objectResult.isOK}");
    if (objectResult.responseCode == StatusConst.code00) {
      return objectResult;
    }
    else if (objectResult.responseCode != StatusConst.code01) {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return objectResult;
  }

  @override
  Future<ObjectResult> removeActivityTransaction(int id) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: "${ApiConst.removeActivityTransaction}$id",
            method: HttpMethod.GET,
            body: ObjectData(token: token)));

    print("HoangCV: removeActivityTransaction response: ${objectResult.response}: ${objectResult.isOK} : id: $id");
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
  Future<List<Report>> getListActivityReport(int id) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: '${ApiConst.getListReport}$id',
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListActivityReport response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00 /*|| objectResult.responseCode == StatusConst.code02*/) {
      List<Report> list = List.from(objectResult.response)
          .map((json) => Report.fromJson(json))
          .toList();//
      list[1].listFarmers = list[0].listFarmers;
      DiaryDB.instance.insertListReport([list[1]]);
      //assignIdSelected(list[0].questionAndPageIds);
      ///Bug: đoạn này đang gen sai số lượng idSelect /// Cần xem lại
      List<int> idSelectedList = List.generate(list[1].questionAndPageIds.length * 10, (index) => index + 1);

      print("HoangCV: idSelectedList: ${idSelectedList.length}");
      assignIdSelected(list[1].questionAndPageIds, idSelectedList);
      final hierarchyList = buildReportHierarchy(list);
   /*   hierarchyList.forEach((element) {
        print("HoangCV: hierarchyList: ${element.questionAndPageIds.length} : ${element.toJson()}");
      });*/
      // list.sort((a,b)=> (b.transactionDate??"").compareTo((a.transactionDate??"")));
      //DiaryDB.instance.insertListActivityDiary(list);
  /*    hierarchyList[1].questionAndPageIds.forEach((element) {
        print("HoangCV: hierarchyList: ${element.questionAndPageIds.length} : ${element.toJson()}");
      });*/
      hierarchyList[1].questionAndPageIds[6].questionAndPageIds[0].suggestedAnswerIds.forEach((element) {
        print("HoangCV: hierarchyList: ${element.questionAndPageIds.length} : ${element.toJson()}");
      });
      return [hierarchyList[1]];
    } else if(objectResult.responseCode == StatusConst.code02) {

    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }

    List<Report> list = await DiaryDB.instance.getListReport(id);
    list.add(list[0]);
    List<int> idSelectedList = List.generate(list[1].questionAndPageIds.length * 10, (index) => index + 1);
    assignIdSelected(list[1].questionAndPageIds, idSelectedList);
    final hierarchyList = buildReportHierarchy(list);
    hierarchyList.forEach((element) {
      print("HoangCV: hierarchyList: ${element.questionAndPageIds.length} : ${element.toJson()}");
    });
    return [list[1]];
  }

  void assignIdSelected(List<dynamic> items, List<int> idSelectedList) {
    for (dynamic item in items) {
      if (item is Question || item is Answer) {
        // Assign a unique idSelected value to the current item
        if(idSelectedList.isNotEmpty) {
          item.idSelected = idSelectedList.removeAt(0);

          // Recursively assign idSelected values to child questions and answers
          assignIdSelected(item.suggestedAnswerIds, idSelectedList);
          assignIdSelected(item.questionAndPageIds, idSelectedList);
          if(item is Question) {
            assignIdSelected(item.userInputLines, idSelectedList);
          }
        }
      } else if (item is RowLine) {
          // Recursively assign idSelected values to items inside RowLine
          assignIdSelected(item.userInputLineId, idSelectedList);
      }
    }
  }

  // convert list đánh giá nội bộ
  List<Report> buildReportHierarchy(List<Report> reports) {
    List<Question> list1 = reports[1].questionAndPageIds.map((question) => Question.copy(question)).toList();
    List<Question> list2 = [];
    print("HoangCV: list1 length: ${list1.length}");
    for (int i = 0; i < list1.length - 1; i++) {
      bool checkQuestion = true;
      if(i>0)
      print("HoangCV: list111 length: ${list1[i].pageId} : ${list2.last.id}");
      if ((i > 0 && list1[i].pageId != list2.last.id) || i == 0) {
        list2.add(list1[i]);
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
    print("HoangCV: list2 length: ${list2.length}");
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
          if (list2[k].questionAndPageIds[i].suggestedAnswerIds.any((element) =>
          element.linkingField != null && element.linkingField != -1)) {
            result[k].questionAndPageIds[i].questionType = "table_field";
            print("HoangCV: list2 length table_field: ${list2[k].questionAndPageIds[i].questionType}");
          }
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
    print("HoangCV: result length: ${result.length}");
    List<Question> list3 = result.map((question) => Question.copy(question)).toList();
    for(int k = 0 ; k < result.length ; k++) {
      for (int i = 0; i < result[k].questionAndPageIds.length - 1; i++) {
        for (int l = i + 1; l < result[k].questionAndPageIds.length; l++) {
          if ((result[k].questionAndPageIds[i].id ==
              result[k].questionAndPageIds[l].parentTitleId)) {
            int index = list3[k].questionAndPageIds.indexWhere((
                element) =>
            element.id == result[k].questionAndPageIds[i].id);
            if (index != -1) {
              list3[k].questionAndPageIds[index].questionAndPageIds.
              add(result[k].questionAndPageIds[l]);
            }
            int indexRemove = list3[k].questionAndPageIds.indexWhere((
                element) =>
            element.id == result[k].questionAndPageIds[l].id);
            if (indexRemove != -1) {
              list3[k].questionAndPageIds.removeAt(indexRemove);
            }
          }
        }
      }

    }
    print("HoangCV: ");
    reports[1].questionAndPageIds = List.from(list3);
    return reports;
  }

  @override
  Future<List<Diary>> getListBackupDiary(String action,) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListBackupDiary,
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListBackupDiary response: ${objectResult.response} : ${userId}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00 || objectResult.responseCode == StatusConst.code02) {
      List<Diary> list = List.from(objectResult.response)
          .map((json) => Diary.fromJson(json, userId, action))
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
    return DiaryDB.instance.getListDiary(userId, action);
  }

  @override
  Future<ObjectResult> uploadQuestion(QuestionUpload questionUpload) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    print("HoangCV: uploadQuestion response: ${questionUpload.listIdSuggested is List}");
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.uploadQuestion,
            method: HttpMethod.GET,
            body: ObjectData(token: token, params: questionUpload.toJson())));
    print("HoangCV: uploadQuestion response: ${objectResult.response}: ${objectResult.isOK}");
    if (objectResult.responseCode == StatusConst.code00) {
      return objectResult;
    }
    else if(objectResult.responseCode == StatusConst.code06) {
      print("HoangCV: addActivityDiary not network");
      QuestionUpload qsNoNetwork = QuestionUpload.fromJson(questionUpload, ApiConst.uploadQuestionOffline);
      DiaryDB.instance.insertQuestionUploadNoNetWork([qsNoNetwork]);
    }
    else if (objectResult.responseCode != StatusConst.code01) {
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
    if (objectResult.responseCode == StatusConst.code00 || objectResult.responseCode == StatusConst.code02) {
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

  @override
  Future<List<SurveyRpRlt>> getDetailReport(int id) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: '${ApiConst.getDetailReport}$id',
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListActivityReport response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00 /*|| objectResult.responseCode == StatusConst.code02*/) {
      List<SurveyRpRlt> list = List.from(objectResult.response)
          .map((json) => SurveyRpRlt.fromJson(json))
          .toList();
      //assignIdSelected(list[0].questionAndPageIds);
      print("HoangCV: getListActivityReport: ${list[1].surveyId[0].questionAndPageIds.length}");
      List<int> idSelectedList = List.generate(list[1].surveyId[0].questionAndPageIds.length * 10, (index) => index + 1);
      assignIdSelected(list[1].surveyId[0].questionAndPageIds, idSelectedList);
      final hierarchyList = buildReportResult(list[1].surveyId);
      hierarchyList.forEach((element) {
        print("HoangCV: hierarchyList: ${element.questionAndPageIds.length} : ${element.toJson()}");
      });
      List<SurveyRpRlt> listResult= [];
      listResult.add(list[0]);
      listResult.add(SurveyRpRlt(surveyId:hierarchyList));
      // list.sort((a,b)=> (b.transactionDate??"").compareTo((a.transactionDate??"")));
      //DiaryDB.instance.insertListActivityDiary(list);
      return listResult;
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

  List<Report> buildReportResult(List<Report> reports) {
    List<Question> list1 = reports[0].questionAndPageIds.map((question) => Question.copy(question)).toList();
    List<Question> list2 = [];
    print("HoangCV: list1 length: ${list1.length}");
    for (int i = 0; i < list1.length - 1; i++) {
      bool checkQuestion = true;
      if ((i > 0 && list1[i].pageId != list2.last.id) || i == 0) {
        list2.add(list1[i]);
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
    print("HoangCV: list2 length: ${list2.length}");
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
          if (list2[k].questionAndPageIds[i].suggestedAnswerIds.any((element) =>
          element.linkingField != null && element.linkingField != -1)) {
            result[k].questionAndPageIds[i].questionType = "table_field";
            print("HoangCV: list2 length table_field1: ${result[k].questionAndPageIds[i].questionType}");
          }
          for (int m = 0; m <
              list2[k].questionAndPageIds[i].suggestedAnswerIds.length; m++) {
            for (int n = m + 1; n <
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
          for (int b = 0; b <
              list2[k].questionAndPageIds[i].userInputLines.length; b++) {
            var userInputLines = list2[k].questionAndPageIds[i].userInputLines[b];
            List<Answer> listAs = [];
            for (int m = 0; m <
                userInputLines.userInputLineId.length; m++) {
              for (int n = m + 1; n <
                  userInputLines.userInputLineId
                      .length; n++) {
                if ((userInputLines.userInputLineId[m].suggestedAnswerId ==
                    userInputLines.userInputLineId[n]
                        .parentColId)) {
                  int index = result[k].questionAndPageIds[i].userInputLines[b].userInputLineId
                      .indexWhere((element) => element.suggestedAnswerId ==
                      userInputLines.userInputLineId[m].suggestedAnswerId);
                  if (index != -1) {
                    Answer as = Answer.copy(userInputLines.userInputLineId[n]);
                    result[k].questionAndPageIds[i].userInputLines[b].userInputLineId[index]
                        .suggestedAnswerIds.add(userInputLines.userInputLineId[n]);
                  }
                  int indexRemove = result[k].questionAndPageIds[i].userInputLines[b].userInputLineId
                      .indexWhere((element) => element.suggestedAnswerId ==
                      userInputLines.userInputLineId[n].suggestedAnswerId);
                  if (indexRemove != -1) {
                    result[k].questionAndPageIds[i].userInputLines[b].userInputLineId.removeAt(
                        indexRemove);
                  }
                }
              }
            }
          }
        }
      }
    }
    print("HoangCV: result length: ${result.length}");
    List<Question> list3 = result.map((question) => Question.copy(question)).toList();
    for(int k = 0 ; k < result.length ; k++) {
      for (int i = 0; i < result[k].questionAndPageIds.length - 1; i++) {
        for (int l = i + 1; l < result[k].questionAndPageIds.length; l++) {
          if ((result[k].questionAndPageIds[i].id ==
              result[k].questionAndPageIds[l].parentTitleId)) {
            int index = list3[k].questionAndPageIds.indexWhere((
                element) =>
            element.id == result[k].questionAndPageIds[i].id);
            if (index != -1) {
              list3[k].questionAndPageIds[index].questionAndPageIds.
              add(result[k].questionAndPageIds[l]);
            }
            int indexRemove = list3[k].questionAndPageIds.indexWhere((
                element) =>
            element.id == result[k].questionAndPageIds[l].id);
            if (indexRemove != -1) {
              list3[k].questionAndPageIds.removeAt(indexRemove);
            }
          }
        }
      }

    }


/*    list3.forEach((element1) {
      print("HoangCV: result: ${list3.length} : ${element1.toJson()}");
    });*/
    print("HoangCV: ");
    reports[0].questionAndPageIds = List.from(list3);
    return reports;
  }

  @override
  Future<ObjectResult> editFarmerInspector(FarmerInspectorUpload farmerInspector) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    print("HoangCV: uploadQuestion response: ${farmerInspector.state}");
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.editFarmerInspector,
            method: HttpMethod.GET,
            body: ObjectData(token: token, params: farmerInspector.state != null ? farmerInspector.toJsonSubmit() : farmerInspector.toJson())));
    print("HoangCV: editFarmerInspector response: ${objectResult.response}: ${objectResult.isOK}");
    if (objectResult.responseCode == StatusConst.code00 && objectResult.responseCode == StatusConst.code01) {
      return objectResult;
    }
    else if(objectResult.responseCode == StatusConst.code06) {
      print("HoangCV: addActivityDiary not network");
      FarmerInspectorUpload farmerInspectorUploadNoNetwork = FarmerInspectorUpload.fromJsonConvert(farmerInspector, ApiConst.editFarmerInspectorOffline);
      DiaryDB.instance.insertFarmerInspectorUploaddNoNetWork([farmerInspectorUploadNoNetwork]);
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
  Future<List<ReportSelect>> getListReportSelect() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListReportSelect,
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    print("HoangCV: getListReportSelect response: ${objectResult.response}");
    if (objectResult.responseCode == StatusConst.code00 || objectResult.responseCode == StatusConst.code02) {
      List<ReportSelect> list = List.from(objectResult.response)
          .map((json) => ReportSelect.fromJson(json))
          .toList();
      DiaryDB.instance.insertListReportSelect(list);
      return list;
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return DiaryDB.instance.getListReportSelect();
  }

  @override
  Future<ObjectResult> deleteReport(int id) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: "${ApiConst.deleteReport}$id",
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    print("HoangCV: deleteReport response: ${objectResult.response}: ${objectResult.isOK}");
    if (objectResult.responseCode == StatusConst.code00) {
      return objectResult;
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
  Future<List<SeasonFarm>> getSeasonFarm() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getSeasonFarm,
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    if (objectResult.responseCode == StatusConst.code00 || objectResult.responseCode == StatusConst.code02) {
      List<SeasonFarm> list = List.from(objectResult.response)
          .map((json) => SeasonFarm.fromJson(json, userId))
          .toList();
      print("HoangCV: getListDiary response: ${list.length}");
      DiaryDB.instance.insertListSeasonFarm(list);
      return list;
    }
    else if (objectResult.responseCode != StatusConst.code02){
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return DiaryDB.instance.getListSeasonFarm(userId);
    //}
  }

  @override
  Future<List<ActivityPurchase>> getListActivityPurchase() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListActivityPurchase,
            method: HttpMethod.GET,
            body: ObjectData(token: token, params: {"id":"3"})));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListActivityPurchase response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00 || objectResult.responseCode == StatusConst.code02) {
      List<ActivityPurchase> list = List.from(objectResult.response)
          .map((json) => ActivityPurchase.fromJson(json, userId))
          .toList();
      list.sort((a,b)=> (b.transactionDate??"").compareTo((a.transactionDate??"")));
      await DiaryDB.instance.removeActivityPurchase();
      DiaryDB.instance.insertListActivityPurchase(list);
      return list;
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }

    return DiaryDB.instance.getListActivityPurchase(userId);
  }

  @override
  Future<ObjectResult> addActivityPurchase(ActivityPurchase transaction) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.addActivityTransaction,
            method: HttpMethod.GET,
            body: ObjectData(token: token, params: transaction.toJson())));
    print("HoangCV: addActivityDiary response: ${objectResult.response}: ${objectResult.isOK}");
    if (objectResult.responseCode == StatusConst.code00) {
      return objectResult;
    }
    else if(objectResult.responseCode == StatusConst.code06) {
      var uuid = Uuid();
      String idOffline = uuid.v1();
      transaction.userId = userId;
      transaction.uuid = idOffline;
      print("HoangCV: addActivityPurchase not network : ${transaction.userId}");
      ActivityPurchaseNoNetWork actDiaryNoNetwork = ActivityPurchaseNoNetWork.fromJsonConvert(transaction, ApiConst.addActivityTransaction);
      DiaryDB.instance.insertListActivityPurchaseNoNetwork([actDiaryNoNetwork]);
      DiaryDB.instance.insertListActivityPurchase([transaction]);
    }
    else if (objectResult.responseCode != StatusConst.code01) {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }
    return objectResult;
  }

  //
  @override
  Future<ObjectResult> addFarmerFeedback(FeedbackInfo feedback) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.addFarmerFeedback,
            method: HttpMethod.GET,
            body: ObjectData(token: token, params: feedback.toJson())));
    print("HoangCV: addActivityDiary response: ${objectResult.responseCode}: ${objectResult.isOK}");
    if (objectResult.responseCode == StatusConst.code00) {
      return objectResult;
    }
    else if(objectResult.responseCode == StatusConst.code06) {
      /*print("HoangCV: addActivityDiary not network");
      ActDiaryNoNetwork actDiaryNoNetwork = ActDiaryNoNetwork.fromJsonConvert(diary, ApiConst.addActivityDiary);
      DiaryDB.instance.insertListActDiaryNoNetWork([actDiaryNoNetwork]);
      DiaryDB.instance.insertListActivityDiary([diary]);*/
        /*DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );*/
    }else if (objectResult.responseCode == StatusConst.code01) {

      print("HoangCV: addActivityDiary11 response: ${objectResult.responseCode}: ${objectResult.isOK}");
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: "Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.",
      );
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
  Future<List<FeedbackInfo>> getListFeedbackFarmer() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListFarmerFeedback+"/"+"$userId",
            method: HttpMethod.GET,
            body: ObjectData(token: token, params: {})));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListActivityPurchase response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00 || objectResult.responseCode == StatusConst.code02) {
      List<FeedbackInfo> list = List.from(objectResult.response)
          .map((json) => FeedbackInfo.fromJson(json))
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

  @override
  Future<FeedbackInfo> getDetailFeedbackFarmer(int id) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getFarmerFeedback+"/"+"$id",
            method: HttpMethod.GET,
            body: ObjectData(token: token, params: {})));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListActivityPurchase response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00 || objectResult.responseCode == StatusConst.code02) {
      List<FeedbackInfo> list = List.from(objectResult.response)
          .map((json) => FeedbackInfo.fromJson(json))
          .toList();
      return list[0];
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }

    return FeedbackInfo();
  }

  @override
  Future<ObjectResult> addReplyFeedback(FeedbackInfo feedback) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.addReplyFeedback,
            method: HttpMethod.GET,
            body: ObjectData(token: token, params: feedback.toJson())));
    print("HoangCV: addActivityDiary response: ${objectResult.responseCode}: ${objectResult.isOK}");
    if (objectResult.responseCode == StatusConst.code00) {
      return objectResult;
    }
    else if(objectResult.responseCode == StatusConst.code06) {
      /*print("HoangCV: addActivityDiary not network");
      ActDiaryNoNetwork actDiaryNoNetwork = ActDiaryNoNetwork.fromJsonConvert(diary, ApiConst.addActivityDiary);
      DiaryDB.instance.insertListActDiaryNoNetWork([actDiaryNoNetwork]);
      DiaryDB.instance.insertListActivityDiary([diary]);*/
      /*DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );*/
    }else if (objectResult.responseCode == StatusConst.code01) {

      print("HoangCV: addActivityDiary11 response: ${objectResult.responseCode}: ${objectResult.isOK}");
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: "Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.",
      );
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
  Future<List<Workflow>> getListWorkflow() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListWorkflow,
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListWorkflow response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00) {
      List<Workflow> list = List.from(objectResult.response)
          .map((json) => Workflow.fromJson(json))
          .toList();
      DiaryDB.instance.insertListWorkflow(list);
      return list;
    }
    else if(objectResult.responseCode == StatusConst.code02){

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

  @override
  Future<List<NotifyEntity>> getListNotify() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListNotify,
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    print("HoangCV: getListNotify response: ${objectResult.response}");
    if (objectResult.responseCode == StatusConst.code00 || objectResult.responseCode == StatusConst.code02) {
      List<NotifyEntity> list = List.from(objectResult.response)
          .map((json) => NotifyEntity.fromJson(json))
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

  @override
  Future<ObjectResult> editNotification(int id) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: "${ApiConst.editNotification}$id",
            method: HttpMethod.GET,
            body: ObjectData(token: token, params: {"is_read" : true})));
    print("HoangCV: editNotification response: ${objectResult.responseCode}: ${objectResult.isOK}");
    if (objectResult.responseCode == StatusConst.code00) {
      return objectResult;
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
  Future<List<AreaEntity>> getListAreaEntity() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListAreaEntity,
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    print("HoangCV: getListWorkflow response: ${objectResult.response}");
    if (objectResult.responseCode == StatusConst.code00) {
      List<AreaEntity> list = List.from(objectResult.response)
          .map((json) => AreaEntity.fromJson(json, userId))
          .toList();
      DiaryDB.instance.insertListAreaEntity(list);
      return list;
    }
    else if(objectResult.responseCode == StatusConst.code02){

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

  @override
  Future<ObjectResult> getExportPdf(List<int> ids) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.exportPdf,
            method: HttpMethod.GET,
            body: ObjectData(token: token, params: {"list_id": ids}
            )));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getListWorkflow response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00) {
      return objectResult;
    }
    else if(objectResult.responseCode == StatusConst.code02){

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
  Future<List<ProductBatch>> getListProductBatch() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getListProductBatch,
            method: HttpMethod.GET,
            body: ObjectData(token: token)));
    print("HoangCV: getListProductBatch response: ${objectResult.response}");
    if (objectResult.responseCode == StatusConst.code00) {
      List<ProductBatch> list = List.from(objectResult.response)
          .map((json) => ProductBatch.fromJson(json, userId))
          .toList();
      //DiaryDB.instance.insertListAreaEntity(list);
      return list;
    }
    else if(objectResult.responseCode == StatusConst.code02){

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

  @override
  Future<DetailProductBatch> getDetailProductBatch(int id) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: "${ApiConst.getDetailProductBatch}$id",
            method: HttpMethod.GET,
            body: ObjectData(token: token, params: {})));
    //ObjectResult objectResult =  ObjectResult(1, "object", "1", "", false, false);
    print("HoangCV: getDetailProductBatch response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00 || objectResult.responseCode == StatusConst.code02) {
      List<DetailProductBatch> list = List.from(objectResult.response)
          .map((json) => DetailProductBatch.fromJson(json))
          .toList();
      return list[0];
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }

    return DetailProductBatch();
  }

  @override
  Future<ObjectResult> getVersionApp() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferencesKey.token) ?? "";
    ObjectResult objectResult = await networkExecutor.request(
        route: ApiBaseGenerator(
            path: ApiConst.getVersionApp,
            method: HttpMethod.GET,
            body: ObjectData(token: token, params: {}
            )));
    print("HoangCV: getVersionApp response: ${objectResult.response}");
    //Map<String, dynamic> jsonData = jsonDecode(objectResult.response);
    if (objectResult.responseCode == StatusConst.code00) {
      return objectResult;
    }
    /*else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.message,
      );
    }*/
    return objectResult;
  }

}