import 'dart:async';
import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/activity/activity_transaction.dart';
import 'package:diary_mobile/data/entity/diary/detail_diary.dart';
import 'package:diary_mobile/data/entity/monitor/monitor_diary.dart';
import 'package:diary_mobile/data/entity/report/report.dart';
import 'package:diary_mobile/data/entity/report/report_result_title.dart';
import 'package:diary_mobile/data/remote_data/object_model/object_result.dart';

import 'entity/activity/season_farm.dart';
import 'entity/diary/diary.dart';
import 'entity/item_default/activity.dart';
import 'entity/item_default/item_default.dart';
import 'entity/item_default/material_entity.dart';
import 'entity/item_default/tool.dart';
import 'entity/item_default/unit.dart';
import 'entity/report/question_upload.dart';
import 'entity/report/report_select.dart';
import 'entity/report/survey_report_result.dart';
import 'entity/setting/user_info.dart';



/// cac trang thai xac thuc cua tai khoan
enum AuthenticationStatus { unknown, authenticated, unauthenticated }

///
/// cac trang thai khi lay mat khau dang nhap tai khoan bang biometric
enum GetPasswordBiometricStatus { successful, failure, moreThan3, none }

///
abstract class Repository {
  final controllerAuthentication = StreamController<AuthenticationStatus>();
  final controllerCheckTime = StreamController<bool>();


  Stream<AuthenticationStatus> get status async* {
    //await Future.delayed(const Duration(seconds: 2));
    bool isExpToken = /*(await getListActivities()).isNotEmpty*/false ? true : false;
    yield !isExpToken
        ? AuthenticationStatus.unauthenticated
        : AuthenticationStatus.authenticated;
    yield* controllerAuthentication.stream;
  }

  void dispose() {
    controllerAuthentication.close();
    controllerCheckTime.close();
  }

  /// kiem tra xem token con han khong
  Future<bool> checkExpToken();

  Future<ObjectResult> login(String userName, String pass);

  Future<ObjectResult> changePassword(String passwordOld, String passwordNew);

  Future<List<Diary>> getListDiary(String action,{bool monitor = false});

  Future<List<ActivityDiary>> getListActivityDiary(int id);

  Future<List<MonitorDiary>> getListMonitorDiary(int id);

  Future<List<Unit>> getListUnits(int id);

  Future<List<Tool>> getListTools();

  Future<List<MaterialEntity>> getListMaterials();

  Future<List<Activity>> getListActivities();

  Future<ActivityDiary> getDetailDiary(int id);

  Future<void> getUpdateDiary(String action, int id);

  Future<Diary> getInfoDiary(int id);

  Future<UserInfo> getUserInfo();

  Future<ObjectResult> updateUserInfo(UserInfo userInfo);

  Future<ObjectResult> addActivityDiary(ActivityDiary diary);

  Future<ObjectResult> updateActivityDiary(ActivityDiary diary);

  Future<ObjectResult> removeActivityDiary(int id);

  Future<ObjectResult> addManyActivityDiary(ActivityDiary diary);

  Future<List<ActivityTransaction>> getListActivityTransaction(int id);

  Future<ObjectResult> addActivityTransaction(ActivityTransaction transaction);

  Future<List<Report>> getListActivityReport(int id);

  Future<List<Diary>> getListBackupDiary(String action,);

  Future<ObjectResult> uploadQuestion(QuestionUpload questionUpload);

  Future<List<ReportResult>> getListReportResult();

  Future<List<ReportSelect>> getListReportSelect();

  Future<List<SurveyRpRlt>> getDetailReport(int id);

  Future<ObjectResult> editFarmerInspector(FarmerInspectorUpload farmerInspector);

  Future<ObjectResult> deleteReport(int id);

  Future<ObjectResult> updateActivityTransaction(ActivityTransaction transaction);

  Future<ObjectResult> removeActivityTransaction(int id);

  Future<List<SeasonFarm>> getSeasonFarm();

  Future<List<ActivityTransaction>> getListActivityPurchase();
}
