/*
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/utils.dart';

class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  final Repository repository;
  final BuildContext context;
  final ImagePicker imagePicker = ImagePicker();
  AvatarBloc(this.context, {required this.repository}) : super(AvatarState()) {
    on<GetAvataEvent>(_getAvatar);
    on<UpdateAvataEvent>(_updateAvatar);
    add(GetAvataEvent());
  }
  void _getAvatar(GetAvataEvent event, Emitter<AvatarState> emitter) async {
    emitter(state.copyWith(isShowProgress: true));
    final userInfo = await repository.getUserInfo();
    Logger.loggerDebug(
        " _getProfile   userguid = ${userInfo.userGUID}");
    Logger.loggerDebug(
        " _getProfile   orgguid = ${userInfo.listbank}");
    emitter(state.copyWith(
      isShowProgress: false,
      avatarFiles: userInfo.orgInfo!.avatarFile,
        orgLogos: userInfo.orgInfo!.orgLogo,
        userInfos: userInfo,
        orgInfos: userInfo.orgInfo,
        listBanks: userInfo.listbank
    ));
  }
  void _updateAvatar(
      UpdateAvataEvent event, Emitter<AvatarState> emit) async {
    XFile? xFile = await imagePicker.pickImage(
      source: event.source,
      maxWidth: 512,
      maxHeight: 512,
    );
    if(xFile != null) {
      state.userInfo?.orgInfo?.avatarFile=File(xFile.path);
      Logger.loggerDebug(
          " state.userInfo?.orgInfo?.avatarFile = ${File(xFile.path)}");
      final isSuccess = await repository.updateInfoUser(state.userInfo!);
      if (isSuccess) {
        emit(state.copyWith(avatarFiles: state.avatarFile,orgLogos: state.userInfo?.orgInfo?.orgLogo));
      }
      else{
        emit(state.copyWith(avatarFiles: state.avatarFile));
      }
    }


  }

}

class AvatarEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetAvataEvent extends AvatarEvent {
  GetAvataEvent();
}

class UpdateAvataEvent extends AvatarEvent {
  final ImageSource source;
  UpdateAvataEvent(this.source);
}

class AvatarState extends BlocState {
  @override
  List<Object?> get props => [
    orgLogo,
    userInfo,
    orgInfo,
    listBank,
    avatarFile,
    formStatus
  ];
  final String orgLogo;
  final UserInfo? userInfo;
  final OrgInfo? orgInfo;
  final List<OrgBanks>? listBank;
  File? avatarFile;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;

  AvatarState({
    this.orgLogo="",
    this.userInfo,
    this.orgInfo,
    this.listBank= const[],
    this.avatarFile,
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress=true
  });

  AvatarState copyWith({
    String? orgLogos,
    UserInfo? userInfos,
    OrgInfo? orgInfos,
    List<OrgBanks>? listBanks,
    File? avatarFiles,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress
  }) {
    return AvatarState(
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
