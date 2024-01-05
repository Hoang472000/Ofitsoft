import 'dart:async';
import 'dart:io' show Platform;

import 'package:diary_mobile/utils/constants/api_const.dart';
import 'package:diary_mobile/utils/constants/status_const.dart';
import 'package:diary_mobile/utils/widgets/dialog/dialog_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/remote_data/object_model/object_result.dart';
import '../../data/repository.dart';
import '../../utils/constants/shared_preferences_key.dart';
import '../../utils/status/form_submission_status.dart';
import '../../utils/logger.dart';
import '../../utils/utils.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Repository repository;
  final BuildContext context;
  final bool isFaceId;
  final bool isFingerprint;
  final String lastUserName;
  LoginBloc(this.context, this.isFaceId, this.isFingerprint, this.lastUserName, this.repository) : super(LoginState()) {
    on<LoginSubmitted>(_loginSubmitted);
    //on<LoginBiometric>(_loginBiometric);
    on<EventFocusTextField>(_eventFocusTextField);
    on<GetUserInfoEvent>(_getUserInfo);
    on<LoginWithGoogle>(_loginGoogle);
    on<UpdateFillEvent>(_fillFirst);
    add(GetUserInfoEvent());
    //on<RememberLoginChanged>(_rememberPassChange);
    /*on<LoginRemember>(_getRememberPassword);
    add(LoginRemember());*/
/*    if(Platform.isAndroid) {
      if (isFingerprint) {
        add(LoginBiometric(lastUserName, BiometricType.fingerprint, context));
      }
    }
    else if(Platform.isIOS){
       if (isFaceId){
        add(LoginBiometric(lastUserName, BiometricType.face, context));
      }else if(isFingerprint){
         add(LoginBiometric(lastUserName, BiometricType.fingerprint, context));
       }
    }*/

  }

  void _eventFocusTextField(
      EventFocusTextField event, Emitter<LoginState> emit) {}

  void _loginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emitter) async {
    FocusManager.instance.primaryFocus?.unfocus();
    emitter(state.copyWith(formStatus: FormSubmitting()));

      // (event.username,  password??event.password, state.isRememberLogin, context);
      final reponse = await repository.login(event.username, event.password);
/*     reponse = ObjectResult(1, '', '', true, false);*/
       Logger.loggerDebug(
          " _loginSubmitted   === reponse = ${reponse.toString()}");
      if (reponse.responseCode == StatusConst.code00) {
        emitter(state.copyWith(
            formStatus: SubmissionSuccess()));
        //HoangLD fix bug sau khi đăng nhập vẫn hiển thị snackbar đăng xuất
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      } else {
        emitter(state.copyWith(formStatus: SubmissionFailed(reponse.message)));
      }
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    if (Platform.isIOS) {
      String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {
        //await FirebaseMessaging.instance.unsubscribeFromTopic("$userId");
        await FirebaseMessaging.instance.subscribeToTopic("$userId");
      } else {
        await Future<void>.delayed(
          const Duration(
            seconds: 3,
          ),
        );
        print("HoangCV: delay 3s");
        apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (apnsToken != null) {
          //await FirebaseMessaging.instance.unsubscribeFromTopic("$userId");
          await FirebaseMessaging.instance.subscribeToTopic("$userId");
        }
      }
    } else {
      DateTime startTime = DateTime.now();
      //await FirebaseMessaging.instance.unsubscribeFromTopic("$userId");
      await FirebaseMessaging.instance.subscribeToTopic("$userId");
      DateTime endTime = DateTime.now();
      Duration elapsedTime = endTime.difference(startTime);
      print("HoangCV: subscribeToTopic: ${elapsedTime} ");
    }
  }
  void _loginGoogle(LoginWithGoogle event,Emitter<LoginState> emitter)async{
    emitter(state.copyWith(formStatus: FormSubmitting()));

    // (event.username,  password??event.password, state.isRememberLogin, context);
    final reponse = ObjectResult(1, '', '', "", true, false);
    Logger.loggerDebug(
        " _loginGoogle_respon = ${reponse.toString()}");
    if (reponse.isOK) {
      emitter(state.copyWith(
          formStatus: SubmissionSuccess()));
      //HoangLD fix bug sau khi đăng nhập vẫn hiển thị snackbar đăng xuất
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    } else {
      emitter(state.copyWith(formStatus: SubmissionFailed(reponse.response)));
    }
  }
/*FutureOr<void> _rememberPassChange(RememberLoginChanged event, Emitter<LoginState> emit) async{
    emit(state.copyWith(isRememderPass: event.isRememberLogin));
    Logger.loggerDebug("check isRemember login : ${event.isRememberLogin}");
    if(event.isRememberLogin==false){
      emit(state.copyWith(username: "", password: "", isRememderPass: false));
      final prefs = await SharedPreferences.getInstance();
      String keyAccount = prefs.getString(SharedPreferencesKey.userName)??"";
      String keyPassword = prefs.getString(SharedPreferencesKey.userId)??"";
      prefs.setBool(SharedPreferencesKey.isRemember, event.isRememberLogin);
      Logger.loggerDebug("check isRemember login : $keyAccount : $keyPassword");
      repository.deleteSecureData(keyAccount);
      repository.deleteSecureData(keyPassword);
     // add(LoginRemember());
    }
  }*/
/*void _getRememberPassword(LoginRemember event, Emitter<LoginState> emitter) async {
    emitter(state.copyWith());
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedPreferencesKey.loginFirst, true);
    String keyAccount = prefs.getString(SharedPreferencesKey.userName)??"";
    String keyPassword = prefs.getString(SharedPreferencesKey.userId)??"";
    bool isRemember = prefs.getBool(SharedPreferencesKey.isRemember)??false;
    final username = await repository.getPassLogin(keyAccount);
    final password = await repository.getPassLogin(keyPassword);
    String? pass;
    String? encodePassword;
    if(password.isNotEmpty) {
      encodePassword = md5.convert(utf8.encode(password)).toString();
      pass = encodePassword.substring(0, 10);
    }
    prefs.setString(SharedPreferencesKey.encodePassword, encodePassword ?? "");
    Logger.loggerDebug(" _getRememberPassword  username = ${username.toString()} : password = ${password.toString()} : isremember = $isRemember : encodePassword = $encodePassword");
    emitter(state.copyWith(username: username, password: pass ?? password, isRememderPass: isRemember
        ));
  }*/


  FutureOr<void> _getUserInfo(GetUserInfoEvent event, Emitter<LoginState> emit) async{
    emit(state.copyWith(formStatus: const InitialFormStatus(), fillFirst: 1));
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    String username= sharedPreferences.getString(SharedPreferencesKey.userName) ?? "";
    String password= sharedPreferences.getString(SharedPreferencesKey.passwordEncode) ?? "";
    emit(state.copyWith(username: username, password: password, formStatus: const InitialFormStatus()));
    ObjectResult objectResult = await repository.getVersionApp();
    if(objectResult.responseCode == StatusConst.code00) {
      Map<String, dynamic> firstResponse = objectResult.response[0];
      if (Platform.isIOS) {
        String iosVersion = sharedPreferences.getString(
            SharedPreferencesKey.iosVersion) ?? "";
        if (iosVersion.compareTo("${firstResponse["version_ios"]}") != 0) {
          DiaLogManager.displayDialog(
              context,
              "Cập nhật phiên bản",
              "Vui lòng cập nhật phiên bản mới nhất để sử dụng. Bấm \"Đồng ý\" để cập nhật.",
                  () {
                Navigator.pop(context);
                Utils.openAppInStore(
                    "https://apps.apple.com/us/app/id${ApiConst.appIdIOS}");
              },
                  () {
                    Navigator.pop(context);
                  },
              "Để sau",
              "Đồng ý",
              dismissible: true);
        }
      } else {
        String androidVersion = sharedPreferences.getString(
            SharedPreferencesKey.androidVersion) ?? "";
        if (androidVersion.compareTo("${firstResponse["version_android"]}") !=
            0) {
          DiaLogManager.displayDialog(
              context,
              "Cập nhật phiên bản",
              "Vui lòng cập nhật phiên bản mới nhất để sử dụng. Bấm \"Đồng ý\" để cập nhật.",
                  () {
                Utils.openAppInStore(
                    "https://play.google.com/store/apps/details?id=com.ofitsoft.diary.diary_mobile");
                if (Get.isLogEnable) {
                  Get.back();
                }
              },
                  () {},
              "",
              "Đồng ý",
              dismissible: false);
        }
      }
    }
  }

  FutureOr<void> _fillFirst(UpdateFillEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(formStatus: const InitialFormStatus(), fillFirst: event.fill));
  }
}

class LoginEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class LoginUserNameChanged extends LoginEvent {
  final String userName;

  LoginUserNameChanged(this.userName);

  @override
  List<Object?> get props => [userName];
}

class UpdateFillEvent extends LoginEvent {
  final int fill;

  UpdateFillEvent(this.fill);

  @override
  List<Object?> get props => [fill];
}

class LoginPasswordChanged extends LoginEvent {
  LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}
class LoginWithGoogle extends LoginEvent {
  final String socialAccessToken;
  final String socialID;
  final String tokenFirebase;
  LoginWithGoogle(this.socialAccessToken,this.socialID,this.tokenFirebase);
  @override
  List<Object?> get props => [socialAccessToken,socialID];
}
class RememberLoginChanged extends LoginEvent {
  final bool isRememberLogin;

  RememberLoginChanged(this.isRememberLogin);

  @override
  List<Object?> get props => [isRememberLogin];
}

class LoginSubmitted extends LoginEvent {
  //HoangCV: lay thong tin dang nhap tu event
  final String username;
  final String password;
  final bool biometric;

  LoginSubmitted(this.username, this.password, this.biometric);
}
class LoginBiometric extends LoginEvent {
  final String username;
  final BuildContext context;
  LoginBiometric(this.username, this.context);
}
class EventFocusTextField extends LoginEvent {
  EventFocusTextField();
}

class GetUserInfoEvent extends LoginEvent{}

class LoginState extends BlocState {
  @override
  List<Object?> get props =>
      [username, password, formStatus, isChangePassWordFirstTime, fillFirst];

  final String username;
  final String password;

  final FormSubmissionStatus formStatus;
  final bool isChangePassWordFirstTime;
  final bool isRememberLogin;
  final int fillFirst;

  LoginState({
    this.username = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
    this.isRememberLogin = false,
    this.isChangePassWordFirstTime = false,
    this.fillFirst = 0,
  });

  LoginState copyWith({
    String? username,
    String? pass,
    String? password,
    FormSubmissionStatus? formStatus,
    bool? isRememderPass,
    bool? isChangePassWordFirstTime,
    int? fillFirst,
  }) {
    return LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus,
        isRememberLogin: isRememderPass ?? isRememberLogin,
        isChangePassWordFirstTime: isChangePassWordFirstTime ??
            this.isChangePassWordFirstTime,
        fillFirst: fillFirst ?? this.fillFirst
    );
  }
}