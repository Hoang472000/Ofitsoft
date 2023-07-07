/*
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants/shared_preferences_key.dart';
import '../../utils/utils.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final Repository repository;
  final BuildContext context;
  final ImagePicker imagePicker = ImagePicker();
  ProfileBloc(this.context, {required this.repository})
      : super(ProfileState(orgLogo: '')) {
    on<GetProfileEvent>(_getProfile);
    on<UpdateProfileEvent>(_updateProfile);
    on<ValidatePassNew>(_validatePass);
    on<PickImageEvent>((event, emit) async {
      XFile? xFile = await imagePicker.pickImage(
        source: event.source,
        maxWidth: 512,
        maxHeight: 512,
      );
      if(xFile != null) {
        state.userInfo?.orgInfo?.avatarFile=File(xFile.path);
        emit(state.copyWith(avatarFiles: File(xFile.path),orgLogos: "${base64Encode(File(xFile.path).readAsBytesSync().toList())}"));
        // emit(state.copyWith(avatarFiles: state.userInfo?.orgInfo?.avatarFile));
        Logger.loggerDebug(
            " state.userInfo?.orgInfo?.avatarFile = ${File(xFile.path)}");
      }
    },);
    add(GetProfileEvent());
  }

  void _getProfile(GetProfileEvent event, Emitter<ProfileState> emitter) async {
    emitter(state.copyWith(isShowProgress: true));
    final userInfo = await repository.getUserInfo();
    emitter(state.copyWith(
      isShowProgress: false,
      orgLogos: userInfo.orgInfo?.orgLogo,
        userInfos: userInfo,
      orgInfos: userInfo.orgInfo,
      listBanks: userInfo.listbank
    ));
  }
  void _updateProfile(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    final isSuccess = await repository.updateInfoUser(event.userInfo);
    Logger.loggerDebug(" _getProfile   userInfo = $isSuccess");
    if (isSuccess) {
      emit(state.copyWith(orgLogos: event.userInfo.orgInfo?.orgLogo,formStatus: SubmissionSuccess()));
    }
    else{
      emit(state.copyWith(orgLogos: state.orgLogo,formStatus: SubmissionFailed("")));
    }
  }
  FutureOr<void> _validatePass(
      ValidatePassNew event, Emitter<ProfileState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String errorTaxCode = "";
    String errorPhone = "";
    String errorMail = "";


    if(Validator.validatorTaxCode(event.userInfo.orgInfo!.orgTaxCode)==false && event.userInfo.orgInfo!.orgTaxCode!.isNotEmpty) {
      errorTaxCode=S.of(context).tax_code_error;
    }
      if(Validator.validateFormatPhone(event.userInfo.orgInfo?.orgPhone)==false && event.userInfo.orgInfo!.orgPhone!.isNotEmpty){
        errorPhone=S.of(context).phone_error;
      }
    if(Validator.isEmail(event.userInfo.orgInfo!.orgEmail)==false && event.userInfo.orgInfo!.orgEmail!.isNotEmpty){
      errorMail=S.of(context).email_error;
    }
    emit(state.copyWith(
        formStatus: ValidatePassFail(errorTaxCode, errorPhone, errorMail)));
    if (errorMail==""&& errorTaxCode == "" && errorPhone == "" && event.submit==true) {
      add(UpdateProfileEvent(event.userInfo));
    }

  }
  // FutureOr<void> _editProfile(EditProfileEvent event, Emitter<ProfileState> emit) async{
  //   Logger.loggerDebug("nhungltk:${event.isEditProfile}");
  //   emit(state.copyWith(isLoad: false, isEditProfile: event.isEditProfile));
  // }

}

class ProfileEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}
class PickImageEvent extends ProfileEvent {
  final ImageSource source;

  PickImageEvent(this.source);
}
class GetProfileEvent extends ProfileEvent {
  GetProfileEvent();
}

class UpdateProfileEvent extends ProfileEvent {
  final UserInfo userInfo;

  UpdateProfileEvent(this.userInfo);
}


class ValidatePassNew extends ProfileEvent {
  final UserInfo userInfo;
  final bool submit;
  BuildContext context;

  ValidatePassNew(
      {required this.userInfo,
        this.submit= false,
        required this.context});

  @override
  List<Object?> get props => [];
}

class ProfileState extends BlocState {
  @override
  List<Object?> get props => [
      orgLogo,
      userInfo,
      orgInfo,
      listBank,
      avatarFile,
      formStatus,
    isShowProgress
      ];
  final String orgLogo;
  final UserInfo? userInfo;
  final OrgInfo? orgInfo;
  final List<OrgBanks>? listBank;
  File? avatarFile;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;

  ProfileState({
    required this.orgLogo,
     this.userInfo,
    this.orgInfo,
    this.listBank= const[],
    this.avatarFile,
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress=true
  });

  ProfileState copyWith({
    String? orgLogos,
    UserInfo? userInfos,
    OrgInfo? orgInfos,
    List<OrgBanks>? listBanks,
    File? avatarFiles,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress
  }) {
    return ProfileState(
        orgLogo: orgLogos??orgLogo,
        userInfo: userInfos??userInfo,
        orgInfo:orgInfos??orgInfo,
        listBank:listBanks,
        avatarFile: avatarFiles,
      formStatus: formStatus??this.formStatus,
        isShowProgress: isShowProgress ?? this.isShowProgress
    );
  }
}
*/
