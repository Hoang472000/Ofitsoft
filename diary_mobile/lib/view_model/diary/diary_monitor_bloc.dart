import 'dart:isolate';

import 'package:diary_mobile/data/entity/diary/area_entity.dart';
import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:diary_mobile/resource/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../data/repository.dart';
import '../../../utils/status/form_submission_status.dart';
import '../../utils/constants/shared_preferences.dart';
import '../../utils/constants/shared_preferences_key.dart';
import '../../utils/extenstion/input_register_model.dart';
import '../../utils/extenstion/service_info_extension.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';
import '../diary_activity/activity/info_diary_bloc.dart';

class DiaryMonitorBloc extends Bloc<DiaryMonitorEvent, DiaryMonitorState> {
  final Repository repository;

  DiaryMonitorBloc(this.repository) : super(DiaryMonitorState()) {
    on<GetDiaryMonitorEvent>(_getDiaryMonitor);
  }

  void _initViewAdd(Emitter<DiaryMonitorState> emitter) {
    List<InputRegisterModel> list = [];

    list.add(InputRegisterModel<AreaEntity, AreaEntity>(
        title: "Vùng trồng",
        isCompulsory: true,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        listValue: state.listAreaEntity,
        typeInputEnum: TypeInputEnum.dmucItem,
        hasSearch: true,));

    list.add(InputRegisterModel<SeasonEntity, SeasonEntity>(
      title: "Mùa vụ",
      isCompulsory: true,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listSeasonEntity,
      typeInputEnum: TypeInputEnum.dmucItem,
      hasSearch: true,));

    emitter(state.copyWith(
        listWidget: list, formStatus: const InitialFormStatus()));
  }

  void _getDiaryMonitor(
      GetDiaryMonitorEvent event, Emitter<DiaryMonitorState> emitter) async {
    emitter(state.copyWith(isShowProgress: true));
/*    var receivePort = ReceivePort();
    var isolate = await Isolate.spawn(process,
        [repository, receivePort.sendPort]);
    var object = await receivePort.first;

    List<Diary> listFarmer = object[0] as List<Diary>;
    List<Diary> listBackup = object[1] as List<Diary>;
    List<Diary> listMonitor = object[2] as List<Diary>;
    //final listDiary = await repository.getListDiary();
    isolate.kill(priority: Isolate.immediate);*/
    var listFarmerDiary = await repository.getListDiary("farmer");
    var listBackupDiary = await repository.getListBackupDiary("record");
    var listMonitorDiary = await repository.getListDiary("monitor", monitor: true);
  /*  listBackupDiary.forEach((element) {
      print("HoangCV: listBackupDiary : ${listMonitorDiary.length} :${listBackupDiary.length} : ${element.toJson()}");
    });
    listFarmerDiary.forEach((element) {
      print("HoangCV: listFarmerDiary : ${listFarmerDiary.length} : ${element.toJson()}");
    });*/
    List<bool> check = await SharedPreDiary.getRole();
    List<ActivityFarm> list = [];
    if (check[0]) {
      list.add(ActivityFarm(
          id: 1,
          nameActivity: "Nông hộ",
          iconActivity: ImageAsset.imageDiary,
          action: "farmer"));
    }
    if (check[2]) {
      list.add(ActivityFarm(
          id: 1,
          nameActivity: "Ghi hộ",
          iconActivity: ImageAsset.imageDiary,
          action: "record"));
    }
    if (check[1]) {
      list.add(ActivityFarm(
          id: 1,
          nameActivity: "Giám sát",
          iconActivity: ImageAsset.imageDiary,
          action: "monitor"));
    }

    emitter(state.copyWith(
      isShowProgress: false,
      listActivityFarm: list,
      listFarmerDiary: listFarmerDiary,
      listBackupDiary: listBackupDiary,
      listMonitorDiary: listMonitorDiary,
    ));
  }

  // Define a function to perform the data processing
 static void process(List<dynamic> args) async {
    var repository = args[0] as Repository;
    var sendPort = args[1] as SendPort;
    print("HoangCV212312:");
    var listFarmerDiary = await repository.getListDiary("farmer");
    var listBackupDiary = await repository.getListBackupDiary("record");
    var listMonitorDiary = await repository.getListDiary("monitor", monitor: true);
    // Send the results back to the main isolate
    sendPort.send([listFarmerDiary, listBackupDiary, listMonitorDiary]);
  }
}

class DiaryMonitorEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetDiaryMonitorEvent extends DiaryMonitorEvent {
  GetDiaryMonitorEvent();
}

class DiaryMonitorState extends BlocState {
  @override
  List<Object?> get props => [
        formStatus,
        isShowProgress,
        listActivityFarm,
        listFarmerDiary,
        listBackupDiary,
        listMonitorDiary,
    listAreaEntity,
    listWidget,
    listSeasonEntity,
      ];

  final List<ActivityFarm> listActivityFarm;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;
  final List<Diary> listFarmerDiary;
  final List<Diary> listBackupDiary;
  final List<Diary> listMonitorDiary;
  final List<AreaEntity> listAreaEntity;
  final List<SeasonEntity> listSeasonEntity;
  final List<InputRegisterModel> listWidget;

  DiaryMonitorState({
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.listActivityFarm = const [],
    this.listFarmerDiary = const [],
    this.listBackupDiary = const [],
    this.listMonitorDiary = const [],
    this.listAreaEntity = const [],
    this.listWidget = const [],
    this.listSeasonEntity = const [],
  });

  DiaryMonitorState copyWith({
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    List<ActivityFarm>? listActivityFarm,
    List<Diary>? listFarmerDiary,
    List<Diary>? listBackupDiary,
    List<Diary>? listMonitorDiary,
    List<AreaEntity>? listAreaEntity,
    List<InputRegisterModel>? listWidget,
    List<SeasonEntity>? listSeasonEntity,
  }) {
    return DiaryMonitorState(
        formStatus: formStatus ?? this.formStatus,
        isShowProgress: isShowProgress ?? this.isShowProgress,
        listActivityFarm: listActivityFarm ?? this.listActivityFarm,
        listFarmerDiary: listFarmerDiary ?? this.listFarmerDiary,
        listBackupDiary: listBackupDiary ?? this.listBackupDiary,
        listMonitorDiary: listMonitorDiary ?? this.listMonitorDiary,
        listAreaEntity: listAreaEntity ?? this.listAreaEntity,
        listSeasonEntity: listSeasonEntity ?? this.listSeasonEntity,
        listWidget: listWidget ?? this.listWidget);
  }
}
