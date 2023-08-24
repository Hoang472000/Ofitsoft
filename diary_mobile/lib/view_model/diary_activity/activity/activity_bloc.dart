import 'dart:async';

import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:diary_mobile/data/entity/monitor/monitor_diary.dart';
import 'package:diary_mobile/utils/constants/status_const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/entity/diary/diary.dart';
import '../../../data/entity/item_default/material_entity.dart';
import '../../../data/local_data/diary_db.dart';
import '../../../data/repository.dart';
import '../../../utils/status/form_submission_status.dart';
import '../../bloc_event.dart';
import '../../bloc_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final Repository repository;

  ActivityBloc(this.repository) : super(ActivityState()) {
    on<GetListActivityEvent>(_getListActivity);
    on<RemoveActivityEvent>(_removeActivity);
    //add(GetListActivityEvent());
  }

  void _getListActivity(
      GetListActivityEvent event, Emitter<ActivityState> emitter) async {
    emitter(state.copyWith(
        isShowProgress: true,
        formStatus: const InitialFormStatus(),
        seasonFarmId: event.id));
    print("HoangCV: runtime1 :event harvesting : ${event.harvesting}");
    if (event.action.compareTo("activity") == 0) {
      final listDiaryActivity = await repository.getListActivityDiary(event.id);
      emitter(state.copyWith(
          isShowProgress: false, listDiaryActivity: listDiaryActivity));
    } else {
      final listDiaryMonitor = await repository.getListMonitorDiary(event.id);

      print("HoangCV: listDiaryMonitor: ${listDiaryMonitor.length}");
      emitter(state.copyWith(
          isShowProgress: false, listDiaryMonitor: listDiaryMonitor));
    }
    if(event.harvesting) {
      repository.getUpdateDiary(event.id);
    }
    //DiaryDB.instance.getListDiary();
  }

  FutureOr<void> _removeActivity(
      RemoveActivityEvent event, Emitter<ActivityState> emit) async {
    emit(state.copyWith(isShowProgress: true, formStatus: FormSubmitting()));
    final objectResult = await repository.removeActivityDiary(event.id);
    //DiaryDB.instance.getListDiary();
    if (objectResult.responseCode == StatusConst.code00) {
      add(GetListActivityEvent(
          state.seasonFarmId ?? 0, event.action, false));
      emit(state.copyWith(
          isShowProgress: false,
          formStatus: SubmissionSuccess(success: objectResult.message)));
    } else if (objectResult.responseCode == StatusConst.code01) {
      emit(state.copyWith(
          isShowProgress: false,
          formStatus: SubmissionFailed(objectResult.message)));
    }
  }
}

class ActivityEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetListActivityEvent extends ActivityEvent {
  final int id;
  final String action;
  final bool harvesting;

  GetListActivityEvent(this.id, this.action, this.harvesting);

  @override
  List<Object?> get props => [id, action, harvesting];
}

class RemoveActivityEvent extends ActivityEvent {
  final int id;
  final String action;

  RemoveActivityEvent(this.id, this.action);

  @override
  List<Object?> get props => [id, action];
}

class RemoveMonitorEvent extends ActivityEvent {
  final int id;

  RemoveMonitorEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ActivityState extends BlocState {
  @override
  List<Object?> get props => [
        listDiaryActivity,
        formStatus,
        isShowProgress,
        listMaterial,
        listTool,
        listUnit,
        listActivity,
        listDiaryMonitor,
        seasonFarmId,
        diary
      ];
  final List<ActivityDiary> listDiaryActivity;
  final List<MaterialEntity> listMaterial;
  final List<Tool> listTool;
  final List<Unit> listUnit;
  final List<Activity>? listActivity;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;
  final List<MonitorDiary> listDiaryMonitor;
  final int? seasonFarmId;
  final Diary? diary;

  ActivityState({
    this.listDiaryActivity = const [],
    this.listDiaryMonitor = const [],
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.listMaterial = const [],
    this.listTool = const [],
    this.listUnit = const [],
    this.listActivity = const [],
    this.seasonFarmId,
    this.diary,
  });

  ActivityState copyWith({
    List<ActivityDiary>? listDiaryActivity,
    List<MonitorDiary>? listDiaryMonitor,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    List<MaterialEntity>? listMaterial,
    List<Tool>? listTool,
    List<Unit>? listUnit,
    List<Activity>? listActivity,
    int? seasonFarmId,
    Diary? diary,
  }) {
    return ActivityState(
      listDiaryActivity: listDiaryActivity ?? this.listDiaryActivity,
      listDiaryMonitor: listDiaryMonitor ?? this.listDiaryMonitor,
      formStatus: formStatus ?? this.formStatus,
      isShowProgress: isShowProgress ?? this.isShowProgress,
      listMaterial: listMaterial ?? this.listMaterial,
      listTool: listTool ?? this.listTool,
      listUnit: listUnit ?? this.listUnit,
      listActivity: listActivity ?? this.listActivity,
      seasonFarmId: seasonFarmId ?? this.seasonFarmId,
      diary: diary ?? this.diary,
    );
  }
}
