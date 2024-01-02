import 'dart:async';

import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/activity/activity_transaction.dart';
import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:diary_mobile/data/entity/monitor/monitor_diary.dart';
import 'package:diary_mobile/utils/constants/status_const.dart';
import 'package:diary_mobile/utils/widgets/dialog/toast_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/entity/diary/diary.dart';
import '../../../data/entity/item_default/material_entity.dart';
import '../../../data/local_data/diary_db.dart';
import '../../../data/remote_data/object_model/object_result.dart';
import '../../../data/repository.dart';
import '../../../utils/constants/shared_preferences_key.dart';
import '../../../utils/status/form_submission_status.dart';
import '../../../utils/utils.dart';
import '../../bloc_event.dart';
import '../../bloc_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final Repository repository;

  ActivityBloc(this.repository) : super(ActivityState()) {
    on<GetListActivityEvent>(_getListActivity);
    on<RemoveActivityEvent>(_removeActivity);
    on<FilterEvent>(_filter);
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
    bool saveDB = false;
    print("HoangCV: listActivity: ${event.list.length} : ${event.id}");
    if (event.action.compareTo("activity") == 0 ||
        event.action.compareTo("harvesting") == 0) {
      if (event.list.isNotEmpty) {
        listDiaryActivity.addAll(event.list);
      } else {
        listDiaryActivity
            .addAll(await repository.getListActivityDiary(event.id));
        saveDB = true;
        listCallback.addAll(listDiaryActivity);
        event.callBack(listCallback);
      }
      if (event.action.compareTo("activity") == 0) {
        listDiaryActivity.removeWhere((element) => element.harvesting == true);
      } else if (event.action.compareTo("harvesting") == 0) {
        listDiaryActivity.removeWhere((element) => element.harvesting == false);
      }
      emitter(state.copyWith(
          isShowProgress: false, listDiaryActivity: listDiaryActivity,
          listDiaryActivityFilter: listDiaryActivity));
      if(saveDB){
        DiaryDB.instance.insertListActivityDiary(listDiaryActivity);
      }
    }

    emit(state.copyWith(isShowProgress: false, listCallback: listCallback));
    if (event.harvesting) {// bug
      repository.getUpdateDiary((state.diary?? Diary()).action??"", event.id);
      emit(state.copyWith(updateHarvesting: true));
    }
    if(event.first == true){
      final sharedPreferences = await SharedPreferences.getInstance();
      final categoryIdUnitAmount =
          sharedPreferences.getInt(SharedPreferencesKey.unitYield) ?? -1;
      final listUnitYield =
      await DiaryDB.instance.getListUnit(categoryIdUnitAmount);
      emit(state.copyWith(listUnit: listUnitYield));
    }
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
          state.seasonFarmId ?? 0, event.action,event.action.compareTo('harvesting') == 0 ? true : false, [], [], (listCallback){
        event.callBack(listCallback);}));
      emit(state.copyWith(
          isShowProgress: false,
          formStatus: SubmissionSuccess(success: "Xóa hoạt động thành công.")));
    } else if (objectResult.responseCode == StatusConst.code01) {
      emit(state.copyWith(
          isShowProgress: false,
          formStatus: SubmissionFailed(objectResult.message)));
    }
  }

  FutureOr<void> _filter(FilterEvent event, Emitter<ActivityState> emit) {
    print("HoangCV: filter: ${event.result} : ${event.type}");
    var startTime = event.result[0];
    var endTime = event.result[1];
    //dynamic minQuantity, maxQuantity, filter0, filter1 = -1;
    var minQuantity = double.parse(event.result[2] != "" ? event.result[2] : "-1");
    var maxQuantity = double.parse(event.result[3] != "" ? event.result[3] : "-1");
    var filter0 = event.result[4];
    var filter1 = event.result[5];
    List<ActivityDiary> list = state.listDiaryActivityFilter.map((e) => ActivityDiary.copy(e)).toList();
    state.listUnit.forEach((element) {
      print("HoangCV: filter listUnit:: ${element.toJson()}");
    });

    List<ActivityDiary> filteredList = [];
    for (var activity in list) {
      int index = state.listUnit.indexWhere((element) => element.id == activity.amountUnitId);
      DateTime actionTime = DateTime.parse(activity.actionTime ?? "");
      bool withinStartTime = startTime.isNotEmpty ? !actionTime.isBefore(Utils.stringToDate(startTime)) : true;
      bool withinEndTime = endTime.isNotEmpty ? !actionTime.isAfter(Utils.stringToDateEnd(endTime)) : true;
      bool withinMinQuantity = true, withinMaxQuantity = true;
      if(index != -1 && event.type == "harvesting") {
        withinMinQuantity = minQuantity != -1 ? (activity.amount ?? 0) * (state.listUnit[index].convert ?? 1) >=
            minQuantity : true;
        withinMaxQuantity = maxQuantity != -1 ? (activity.amount ?? 0) * (state.listUnit[index].convert ?? 1) <=
            maxQuantity : true;
        print("HoangCV: result: ${(activity.amount ?? 0) * (state.listUnit[index].convert ?? 1)} : "
            "${maxQuantity} : ${withinMaxQuantity} : ${Utils.stringToDate(startTime)} : ${Utils.stringToDateEnd(endTime)}");
      }
      //print("HoangCV: $withinStartTime : $withinEndTime : $withinMinPrice : $withinMaxPrice: $withinMinQuantity : $withinMaxQuantity");
      if (withinStartTime && withinEndTime && withinMinQuantity && withinMaxQuantity) {
        filteredList.add(activity);
      }
    }
    List<ActivityDiary> listFilter0 = [];
    List<ActivityDiary> listFilter1 = [];
    if(filter0 != -1) {
      listFilter0.addAll(filteredList.where((
          activity) => activity.activityId == filter0).toList());
    } else{
      listFilter0.addAll(filteredList);
    }
/*    if(filter1 != -1) {
      listFilter1.addAll(listFilter0.where((
          activity) => activity.productId == filter1).toList());
    } else{
      listFilter1.addAll(listFilter0);
    }*/
    if(listFilter0.length > 0) {
      emit(state.copyWith(
          isShowProgress: false,
          listDiaryActivity: listFilter0
      ));
    } else{
      Toast.showLongTop("Không tìm thấy thông tin hoạt động phù hợp");
      emit(state.copyWith(
        isShowProgress: false,
      ));
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
  Function(List<ActivityDiary>) callBack;
  final bool? first;

  GetListActivityEvent(
      this.id, this.action, this.harvesting, this.list, this.listTransaction, this.callBack, {this.first = false});

  @override
  List<Object?> get props => [id, action, harvesting, list, listTransaction, callBack, first];
}

class RemoveActivityEvent extends ActivityEvent {
  final int id;
  final String action;
  Function(List<ActivityDiary>) callBack;

  RemoveActivityEvent(this.id, this.action, this.callBack);

  @override
  List<Object?> get props => [id, action, callBack];
}

class RemoveMonitorEvent extends ActivityEvent {
  final int id;

  RemoveMonitorEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class FilterEvent extends ActivityEvent {
  final dynamic result;
  final String type;

  FilterEvent(this.result, this.type);

  @override
  List<Object?> get props => [result, type];
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
    listDiaryActivityFilter,
      ];
  final List<ActivityDiary> listDiaryActivity;
  final List<ActivityDiary> listDiaryActivityFilter;
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
    this.listDiaryActivityFilter = const [],
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
    List<ActivityDiary>? listDiaryActivityFilter,
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
        listDiaryActivityFilter: listDiaryActivityFilter ?? this.listDiaryActivityFilter,
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
