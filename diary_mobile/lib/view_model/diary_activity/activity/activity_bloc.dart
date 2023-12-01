import 'dart:async';

import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/activity/activity_transaction.dart';
import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:diary_mobile/data/entity/monitor/monitor_diary.dart';
import 'package:diary_mobile/utils/constants/status_const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/entity/diary/diary.dart';
import '../../../data/entity/item_default/material_entity.dart';
import '../../../data/local_data/diary_db.dart';
import '../../../data/remote_data/object_model/object_result.dart';
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
    List<ActivityDiary> listDiaryActivity = [];
    List<ActivityDiary> listCallback = [];
    List<ActivityTransaction> listActivityTransaction = [];
    List<ActivityTransaction> listCallbackTransaction = [];
    print("HoangCV: listActivity: ${event.list.length}");
    if (event.action.compareTo("activity") == 0 ||
        event.action.compareTo("harvesting") == 0) {
      if (event.list.isNotEmpty) {
        listDiaryActivity.addAll(event.list);
      } else {
        listDiaryActivity
            .addAll(await repository.getListActivityDiary(event.id));
        listCallback.addAll(listDiaryActivity);
      }
      if (event.action.compareTo("activity") == 0) {
        listDiaryActivity.removeWhere((element) => element.harvesting == true);
      } else if (event.action.compareTo("harvesting") == 0) {
        listDiaryActivity.removeWhere((element) => element.harvesting == false);
      }
      emitter(state.copyWith(
          isShowProgress: false, listDiaryActivity: listDiaryActivity));
    } else if (event.action.compareTo("sell") == 0) {
      listDiaryActivity.addAll(event.list);
      listDiaryActivity.removeWhere((element) => element.harvesting == false);
      /*if (event.harvesting) {*/
        emitter(state.copyWith(
            isShowProgress: true));
        listActivityTransaction
            .addAll(await repository.getListActivityTransaction(event.id));
        listActivityTransaction.removeWhere((element) => element.isPurchase == true);
        print("HoangCV: listActivityTransaction: ${listActivityTransaction.length}");
        listCallbackTransaction.addAll(listActivityTransaction);
        emitter(state.copyWith(
            isShowProgress: false,
            listActivityTransaction: listActivityTransaction,
            listCallbackTransaction: listCallbackTransaction,
            listDiaryActivity: listDiaryActivity));
    }
    else if (event.action.compareTo("purchase") == 0) {
        emitter(state.copyWith(
            isShowProgress: true));
        listActivityTransaction
            .addAll(await repository.getListActivityTransaction(event.id));
        listActivityTransaction.removeWhere((element) => element.isPurchase == false);
        print("HoangCV: listActivityTransaction: ${listActivityTransaction.length}");
        listCallbackTransaction.addAll(listActivityTransaction);
        emitter(state.copyWith(
            isShowProgress: false,
            listActivityTransaction: listActivityTransaction,
            listCallbackTransaction: listCallbackTransaction,));
    }
    else {
      final listDiaryMonitor = await repository.getListMonitorDiary(event.id);

      print("HoangCV: listDiaryMonitor: ${listDiaryMonitor.length}");
      emitter(state.copyWith(listDiaryMonitor: listDiaryMonitor));
    }
    if (event.harvesting) {// bug
      repository.getUpdateDiary((state.diary?? Diary()).action??"", event.id);
      emit(state.copyWith(updateHarvesting: true));
    }
    emit(state.copyWith(isShowProgress: false, listCallback: listCallback, listCallbackTransaction: listCallbackTransaction));
    //DiaryDB.instance.getListDiary();
  }

  FutureOr<void> _removeActivity(
      RemoveActivityEvent event, Emitter<ActivityState> emit) async {
    emit(state.copyWith(isShowProgress: true, formStatus: FormSubmitting()));
    ObjectResult objectResult;
    if(event.action.compareTo('sell') == 0 || event.action.compareTo('purchase') == 0) {
      objectResult = await repository.removeActivityTransaction(event.id);
    } else{
      objectResult = await repository.removeActivityDiary(event.id);
    }
    //DiaryDB.instance.getListDiary();
    if (objectResult.responseCode == StatusConst.code00) {
      add(GetListActivityEvent(
          state.seasonFarmId ?? 0, event.action, false, [], []));
      emit(state.copyWith(
          isShowProgress: false,
          formStatus: SubmissionSuccess(success: "Xóa hoạt động thành công.")));
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
  final List<ActivityDiary> list;
  final List<ActivityTransaction> listTransaction;

  GetListActivityEvent(
      this.id, this.action, this.harvesting, this.list, this.listTransaction);

  @override
  List<Object?> get props => [id, action, harvesting, list, listTransaction];
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
        diary,
        updateHarvesting,
        listCallback,
        listActivityTransaction,
        listCallbackTransaction,
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
  final bool updateHarvesting;
  final List<ActivityDiary> listCallback;
  final List<ActivityTransaction> listCallbackTransaction;
  final List<ActivityTransaction> listActivityTransaction;

  ActivityState({
    this.listActivityTransaction = const [],
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
    this.updateHarvesting = false,
    this.listCallback = const [],
    this.listCallbackTransaction = const [],
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
    bool? updateHarvesting,
    List<ActivityDiary>? listCallback,
    List<ActivityTransaction>? listActivityTransaction,
    List<ActivityTransaction>? listCallbackTransaction,
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
        updateHarvesting: updateHarvesting ?? this.updateHarvesting,
        listActivityTransaction:
            listActivityTransaction ?? this.listActivityTransaction,
        listCallbackTransaction:
            listCallbackTransaction ?? this.listCallbackTransaction,
        listCallback: listCallback ?? this.listCallback);
  }
}
