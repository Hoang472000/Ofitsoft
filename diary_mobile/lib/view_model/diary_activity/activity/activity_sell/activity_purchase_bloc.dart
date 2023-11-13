import 'dart:async';

import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/activity/activity_transaction.dart';
import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:diary_mobile/data/entity/monitor/monitor_diary.dart';
import 'package:diary_mobile/utils/constants/status_const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/entity/activity/activity_purchase.dart';
import '../../../../data/entity/diary/diary.dart';
import '../../../../data/entity/item_default/material_entity.dart';
import '../../../../data/remote_data/object_model/object_result.dart';
import '../../../../data/repository.dart';
import '../../../../utils/status/form_submission_status.dart';
import '../../../bloc_event.dart';
import '../../../bloc_state.dart';

class ActivityPurchaseBloc extends Bloc<ActivityPurchaseEvent, ActivityPurchaseState> {
  final Repository repository;

  ActivityPurchaseBloc(this.repository) : super(ActivityPurchaseState()) {
    on<GetListActivityPurchaseEvent>(_getListActivityPurchase);
    on<RemoveActivityPurchaseEvent>(_removeActivityPurchase);
    //add(GetListActivityEvent());
  }

  void _getListActivityPurchase(
      GetListActivityPurchaseEvent event, Emitter<ActivityPurchaseState> emitter) async {
    emitter(state.copyWith(
        isShowProgress: true,
        formStatus: const InitialFormStatus()));
    List<ActivityPurchase> listActivityTransaction = [];
    List<ActivityPurchase> listCallbackTransaction = [];

      emitter(state.copyWith(
          isShowProgress: true));
      listActivityTransaction = await repository.getListActivityPurchase();
      print("HoangCV: _getListActivityPurchase: ${listActivityTransaction.length}");
      listCallbackTransaction.addAll(listActivityTransaction);
      emitter(state.copyWith(
        isShowProgress: false,
        listActivityTransaction: listActivityTransaction,
        listCallbackTransaction: listCallbackTransaction,));
  }

  FutureOr<void> _removeActivityPurchase(
      RemoveActivityPurchaseEvent event, Emitter<ActivityPurchaseState> emit) async {
    emit(state.copyWith(isShowProgress: true, formStatus: FormSubmitting()));
    ObjectResult objectResult;
    if(event.action.compareTo('sell') == 0 || event.action.compareTo('purchase') == 0) {
      print("HoangCV: bug remove sell: ${event.id}");
      objectResult = await repository.removeActivityTransaction(event.id);
    } else{
      objectResult = await repository.removeActivityDiary(event.id);
    }
    //DiaryDB.instance.getListDiary();
    if (objectResult.responseCode == StatusConst.code00) {
      add(GetListActivityPurchaseEvent());
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

class ActivityPurchaseEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetListActivityPurchaseEvent extends ActivityPurchaseEvent {

  GetListActivityPurchaseEvent();

  @override
  List<Object?> get props => [];
}

class RemoveActivityPurchaseEvent extends ActivityPurchaseEvent {
  final int id;
  final String action;

  RemoveActivityPurchaseEvent(this.id, this.action);

  @override
  List<Object?> get props => [id, action];
}

class ActivityPurchaseState extends BlocState {
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
  final List<ActivityPurchase> listCallbackTransaction;
  final List<ActivityPurchase> listActivityTransaction;

  ActivityPurchaseState({
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

  ActivityPurchaseState copyWith({
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
    List<ActivityPurchase>? listActivityTransaction,
    List<ActivityPurchase>? listCallbackTransaction,
  }) {
    return ActivityPurchaseState(
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
