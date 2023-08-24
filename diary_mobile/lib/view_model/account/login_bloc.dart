import 'dart:async';
import 'dart:io';

import 'package:diary_mobile/utils/constants/status_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/remote_data/object_model/object_result.dart';
import '../../data/repository.dart';
import '../../generated/l10n.dart';
import '../../utils/constants/shared_preferences_key.dart';
import '../../utils/status/form_submission_status.dart';
import '../../utils/logger.dart';
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
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    String username= sharedPreferences.getString(SharedPreferencesKey.userName) ?? "";
    emit(state.copyWith(username: username));
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
  //Bkav Nhungltk: lay thong tin dang nhap tu event
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
      [username, password, formStatus, isChangePassWordFirstTime];

  final String username;
  final String password;

  final FormSubmissionStatus formStatus;
  final bool isChangePassWordFirstTime;
  final bool isRememberLogin;

  LoginState({
    this.username = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
    this.isRememberLogin = false,
    this.isChangePassWordFirstTime = false
  });

  LoginState copyWith({
    String? username,
    String? pass,
    String? password,
    FormSubmissionStatus? formStatus,
    bool? isRememderPass,
    bool? isChangePassWordFirstTime
  }) {
    return LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus,
        isRememberLogin: isRememderPass ?? isRememberLogin,
        isChangePassWordFirstTime: isChangePassWordFirstTime ??
            this.isChangePassWordFirstTime
    );
  }
}