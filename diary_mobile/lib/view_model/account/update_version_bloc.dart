/*

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_version_plus/new_version_plus.dart';

import '../../data/repository.dart';
import '../../utils/constans/api_const.dart';
import '../../utils/utils.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class UpdateVersionBloc extends Bloc<UpdateVersionEvent, UpdateVersionState> {
  final Repository repository;
  final BuildContext context;
  bool canupdate=true;

  UpdateVersionBloc(this.context, {required this.repository}) : super(UpdateVersionState()) {
    on<NewVersionEvent>(_getUpdateVersion);
    add(NewVersionEvent());
  }

  void _getUpdateVersion(
      NewVersionEvent event, Emitter<UpdateVersionState> emitter) async {

    final newVersion= NewVersionPlus(
      iOSId: ApiConst.packageIdIOS,
      iOSAppStoreCountry: "VN",
      androidId: ApiConst.packageIdANDROID,
      //  androidId: 'com.snapchat.android',
    );
    VersionStatus? status;
    try{
       status = await newVersion.getVersionStatus();
       if(status==null){
         String version= await Utils.getVersionApp();
         emitter(state.copyWith(
           newVersion: version,
           currentVersion: version,
         ));
       }
       else{
         emitter(state.copyWith(
           newVersion: (status.canUpdate == false)
               ? status.localVersion
               : (status.storeVersion),
           currentVersion: status.localVersion,
           releaseNote: status.releaseNotes
         )
         );
       }
    }catch(e){
      String version= await Utils.getVersionApp();
      emitter(state.copyWith(
          newVersion: version,
          currentVersion: version,
      ));
    }
  }
}

class UpdateVersionEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class NewVersionEvent extends UpdateVersionEvent {
  NewVersionEvent();
}

class UpdateVersionState extends BlocState {
  @override
  List<Object?> get props =>
      [newVersionUpdate, currentVersionUpdate,releaseNotes];

  final String newVersionUpdate;
  final String currentVersionUpdate;
  final String releaseNotes;

  UpdateVersionState({
    this.newVersionUpdate="",
    this.currentVersionUpdate="",
    this.releaseNotes=""
  });

  UpdateVersionState copyWith({String? newVersion, String? currentVersion,String? releaseNote}) {
    return UpdateVersionState(
      newVersionUpdate: newVersion ?? newVersionUpdate,
      currentVersionUpdate: currentVersion ?? currentVersionUpdate,
      releaseNotes: releaseNote??releaseNotes
    );
  }
}
*/
