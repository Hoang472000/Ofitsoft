import 'dart:async';
import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/diary/detail_diary.dart';
import 'package:diary_mobile/data/remote_data/object_model/object_result.dart';

import 'entity/diary/diary.dart';
import 'entity/item_default/activity.dart';
import 'entity/item_default/item_default.dart';
import 'entity/item_default/material_entity.dart';
import 'entity/item_default/tool.dart';
import 'entity/item_default/unit.dart';
import 'entity/setting/user_info.dart';



/// Bkav DucLQ cac trang thai xac thuc cua tai khoan
enum AuthenticationStatus { unknown, authenticated, unauthenticated }

///
/// Bkav HoangLD cac trang thai khi lay mat khau dang nhap tai khoan bang biometric
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

  Future<List<Diary>> getListDiary();

  Future<List<ActivityDiary>> getListActivityDiary(int id);

  Future<List<Unit>> getListUnits(int id);

  Future<List<Tool>> getListTools();

  Future<List<MaterialEntity>> getListMaterials();

  Future<List<Activity>> getListActivities();

  Future<ActivityDiary> getDetailDiary(int id);

  Future<Diary> getInfoDiary(int id);

  Future<UserInfo> getUserInfo(int id);

  Future<ObjectResult> addActivityDiary(ActivityDiary diary);
}
