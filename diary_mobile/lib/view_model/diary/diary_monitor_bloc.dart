import 'dart:isolate';

import 'package:diary_mobile/resource/assets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../data/repository.dart';
import '../../../utils/status/form_submission_status.dart';
import '../../utils/constants/shared_preferences.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';
import '../diary_activity/activity/info_diary_bloc.dart';

class DiaryMonitorBloc extends Bloc<DiaryMonitorEvent, DiaryMonitorState> {
  final Repository repository;

  DiaryMonitorBloc(this.repository) : super(DiaryMonitorState()) {
    on<GetDiaryMonitorEvent>(_getDiaryMonitor);
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
    var listFarmerDiary = await repository.getListDiary();
    var listBackupDiary = await repository.getListBackupDiary();
    var listMonitorDiary = await repository.getListDiary(monitor: true);
    listBackupDiary.forEach((element) {
      print("HoangCV: listBackupDiary : ${listMonitorDiary.length} :${listBackupDiary.length} : ${element.toJson()}");
    });
    listFarmerDiary.forEach((element) {
      print("HoangCV: listFarmerDiary : ${listFarmerDiary.length} : ${element.toJson()}");
    });
    List<bool> check = await SharedPreDiary.getRole();
    List<ActivityFarm> list = [];
    if (check[0] && check[2] && !check[1]) {
      list.add(ActivityFarm(
          id: 1,
          nameActivity: "Nông hộ",
          iconActivity: ImageAsset.imageDiary,
          action: "farmer"));
      list.add(ActivityFarm(
          id: 1,
          nameActivity: "Ghi hộ",
          iconActivity: ImageAsset.imageDiary,
          action: "record"));
    } else if (check[0] && check[2] && check[1]) {
      list.add(ActivityFarm(
          id: 1,
          nameActivity: "Nông hộ",
          iconActivity: ImageAsset.imageDiary,
          action: "farmer"));
      list.add(ActivityFarm(
          id: 1,
          nameActivity: "Ghi hộ",
          iconActivity: ImageAsset.imageDiary,
          action: "record"));
      list.add(ActivityFarm(
          id: 1,
          nameActivity: "Giám sát",
          iconActivity: ImageAsset.imageDiary,
          action: "monitor"));
    } else if (check[0] && !check[2] && check[1]) {
      list.add(ActivityFarm(
          id: 1,
          nameActivity: "Nông hộ",
          iconActivity: ImageAsset.imageDiary,
          action: "farmer"));
      list.add(ActivityFarm(
          id: 1,
          nameActivity: "Giám sát",
          iconActivity: ImageAsset.imageDiary,
          action: "monitor"));
    } else if (!check[0] && !check[2] && check[1]) {
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
    var listFarmerDiary = await repository.getListDiary();
    var listBackupDiary = await repository.getListBackupDiary();
    var listMonitorDiary = await repository.getListDiary(monitor: true);
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
      ];

  final List<ActivityFarm> listActivityFarm;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;
  final List<Diary> listFarmerDiary;
  final List<Diary> listBackupDiary;
  final List<Diary> listMonitorDiary;

  DiaryMonitorState({
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.listActivityFarm = const [],
    this.listFarmerDiary = const [],
    this.listBackupDiary = const [],
    this.listMonitorDiary = const [],
  });

  DiaryMonitorState copyWith({
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    List<ActivityFarm>? listActivityFarm,
    List<Diary>? listFarmerDiary,
    List<Diary>? listBackupDiary,
    List<Diary>? listMonitorDiary,
  }) {
    return DiaryMonitorState(
        formStatus: formStatus ?? this.formStatus,
        isShowProgress: isShowProgress ?? this.isShowProgress,
        listActivityFarm: listActivityFarm ?? this.listActivityFarm,
        listFarmerDiary: listFarmerDiary ?? this.listFarmerDiary,
        listBackupDiary: listBackupDiary ?? this.listBackupDiary,
        listMonitorDiary: listMonitorDiary ?? this.listMonitorDiary);
  }
}
