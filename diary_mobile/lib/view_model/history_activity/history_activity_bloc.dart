import 'dart:async';

import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/activity/activity_transaction.dart';
import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/item_basic.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:diary_mobile/data/entity/monitor/monitor_diary.dart';
import 'package:diary_mobile/utils/constants/status_const.dart';
import 'package:diary_mobile/utils/widgets/dialog/toast_widget.dart';
import 'package:flutter/material.dart';
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
import '../../resource/assets.dart';
import '../../utils/constants/shared_preferences.dart';
import '../../utils/extenstion/extenstions.dart';
import '../../utils/extenstion/input_register_model.dart';
import '../../utils/extenstion/service_info_extension.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class HistoryActivityBloc extends Bloc<HistoryActivityEvent, HistoryActivityState> {
  final Repository repository;

  HistoryActivityBloc(this.repository) : super(HistoryActivityState()) {
    on<GetListHistoryActivityEvent>(_getListActivity);
    on<RemoveHistoryActivityEvent>(_removeActivity);
    on<OnSelectValueEvent>(_onSelectValue);
    on<FilterEvent>(_filter);
    on<SubmitEvent>(_submit);
    //add(GetListHistoryActivityEvent());
  }

  void _initViewAdd(Emitter<HistoryActivityState> emitter) {
    List<InputRegisterModel> list = [];
      list.add(InputRegisterModel<ItemBasic, ItemBasic>(
          title: "Ngày",
          isCompulsory: true,
          type: TypeInputRegister.Select,
          icon: Icons.arrow_drop_down,
          positionSelected: 0,
          valueSelected: state.listYear[state.indexYear],
          listValue: state.listYear,
          typeInputEnum: TypeInputEnum.dmucItem,
          hasSearch: true,
          image: ImageAsset.imageCalendarPick));
      if(state.indexSeason != -1) {
        list.add(InputRegisterModel<Diary, Diary>(
            title: "Mùa vụ",
            isCompulsory: true,
            type: TypeInputRegister.Select,
            icon: Icons.arrow_drop_down,
            positionSelected: 0,
            valueSelected: state.listSeason[state.indexSeason],
            listValue: state.listSeason,
            typeInputEnum: TypeInputEnum.dmucItem,
            hasSearch: true,
            image: ImageAsset.imageDiary));
      } else{
        list.add(InputRegisterModel<Diary, Diary>(
            title: "Mùa vụ",
            isCompulsory: true,
            type: TypeInputRegister.Select,
            icon: Icons.arrow_drop_down,
            positionSelected: -1,
            listValue: state.listSeason,
            typeInputEnum: TypeInputEnum.dmucItem,
            hasSearch: true,
            image: ImageAsset.imageDiary));
      }



    emitter(state.copyWith(
        listWidget: list,
        formStatus: const InitialFormStatus()));
  }
  void _getListActivity(
      GetListHistoryActivityEvent event, Emitter<HistoryActivityState> emitter) async {
    emitter(state.copyWith(
        isShowProgress: true,
        formStatus: const InitialFormStatus()));
    List<ActivityDiary> listDiaryActivity = [];
    List<ActivityDiary> listCallback = [];
    bool saveDB = false;
    List<bool> check = await SharedPreDiary.getRole();
    List<Diary> list = [];
    List<ItemBasic> listYear = [];
    int indexYear = 0;
    int indexSeason = -1;
    listYear.addAll([
      ItemBasic(id: 0, name: "Hôm nay"),
      ItemBasic(id: 1, name: "Hôm qua"),
      ItemBasic(id: 2, name: "7 ngày trước"),
      ItemBasic(id: 3, name: "28 ngày trước"),
      ItemBasic(id: 4, name: "30 ngày trước"),
      ItemBasic(id: 5, name: "90 ngày trước"),
      ItemBasic(id: 6, name: "12 tháng trước"),
      ItemBasic(id: 7, name: "24 tháng trước"),
      ItemBasic(id: 8, name: "36 tháng trước"),
      ItemBasic(id: 9, name: "Từ trước đến nay"),
    ]);
    if(check[0] == true) {
      list.addAll(await repository.getListDiary("farmer"));
    } else{
      list.addAll(await repository.getListBackupDiary("record"));
    }
    if(list.isNotEmpty){
      indexSeason = 0;
    }
    //listDiaryActivity.addAll(await repository.getListActivityDiary());
    //saveDB = true;
    emitter(state.copyWith(
        isShowProgress: false,
        listDiaryActivity: listDiaryActivity,
        listDiaryActivityFilter: listDiaryActivity,
        listDiaryActivitySave: listDiaryActivity,
        listSeason: list,
        listYear: listYear,
        indexYear: indexYear,
        indexSeason: indexSeason));
    if (saveDB) {
      DiaryDB.instance.insertListActivityDiary(listDiaryActivity);
    }
    _initViewAdd(emitter);

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
      RemoveHistoryActivityEvent event, Emitter<HistoryActivityState> emit) async {
    emit(state.copyWith(isShowProgress: true, formStatus: FormSubmitting()));
    ObjectResult objectResult;
    if(event.action.compareTo('sell') == 0 || event.action.compareTo('purchase') == 0) {
      objectResult = await repository.removeActivityTransaction(event.id);
    } else{
      objectResult = await repository.removeActivityDiary(event.id);
    }
    //DiaryDB.instance.getListDiary();
    if (objectResult.responseCode == StatusConst.code00) {
      add(GetListHistoryActivityEvent());
      emit(state.copyWith(
          isShowProgress: false,
          formStatus: SubmissionSuccess(success: "Xóa hoạt động thành công.")));
    } else if (objectResult.responseCode == StatusConst.code01) {
      emit(state.copyWith(
          isShowProgress: false,
          formStatus: SubmissionFailed(objectResult.message)));
    }
  }

  FutureOr<void> _filter(FilterEvent event, Emitter<HistoryActivityState> emit) {
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

  Future<FutureOr<void>> _onSelectValue(OnSelectValueEvent event, Emitter<HistoryActivityState> emit) async {
    int result;
    bool checkPass = true;
    if (event.index == 1 && state.listSeason.isEmpty) {
      Toast.showLongTop("Không có danh sách mùa vụ");
      checkPass = false;
    }
    if (checkPass) {
      if (event.list[event.index].valueSelected.runtimeType == DateTime ||
          event.list[event.index].typeInputEnum == TypeInputEnum.date) {
        //     setState(() {
        int result1 = await ServiceInfoExtension()
            .selectValue(
            event.list[event.index], event.context, (modelInput) {});
      } else {
        print("HoangCV: event.list[event.index].listValue: ${event
            .index} : ${event.list[event.index].toString()} : ${event.list[event
            .index].listValue.length} ");
        result = await Extension().showBottomSheetSelection(
            event.context,
            event.list[event.index].listValue,
            event.list[event.index].positionSelected,
            "${event.list[event.index].title}",
            hasSearch: event.list[event.index].hasSearch ?? false);
        if (result != -1) {
          //   setState(() {
          event.list[event.index].positionSelected = result;
          event.list[event.index].valueDefault = null;
          event.list[event.index].valueSelected =
          event.list[event.index].listValue[result];
          event.list[event.index].error = null;
          if(event.index == 0) {
            emit(state.copyWith(
                indexYear: result
            ));
          } else if(event.index == 1){
            emit(state.copyWith(
                indexSeason: result
            ));
          }
        }
      }
    }
  }

  Future<FutureOr<void>> _submit(SubmitEvent event, Emitter<HistoryActivityState> emit) async {
    List<ActivityDiary> list = [];
    if(state.indexSeasonCurrent == -1 || state.indexSeasonCurrent != state.indexSeason) {
      emit(state.copyWith(
          indexSeasonCurrent: state.indexSeason
      ));
      list.addAll(await repository
          .getListActivityDiary(state.listSeason[state.indexSeason].id ?? -1));
      emit(state.copyWith(
          listDiaryActivitySave: list,
          listDiaryActivityFilter: list
      ));
    } else{
      list.addAll(state.listDiaryActivitySave);
    }
    //print("HoangCV: startTime: ${state.indexSeasonCurrent} : ${state.indexSeason} : ${list.length}");
      List<ActivityDiary> listFilter = [];
      var startTime = "";
      var endTime = "";
    int endYear = DateTime.now().year;
    int endMonth = DateTime.now().month;
    int endDay = DateTime.now().day;
    endTime = "$endDay/$endMonth/$endYear";
    if (list.isNotEmpty) {
        if (state.indexYear == 0) {
          startTime = "${DateTime.now()}";
        } else if (state.indexYear == 1) {
          startTime = Utils.calculateStartTime(1);
        } else if (state.indexYear == 2) {
          startTime = Utils.calculateStartTime(7);
        } else if (state.indexYear == 3) {
          startTime = Utils.calculateStartTime(28);
        } else if (state.indexYear == 4) {
          startTime = Utils.calculateStartTime(30);
        } else if (state.indexYear == 5) {
          startTime = Utils.calculateStartTime(90);
        } else if (state.indexYear == 6) {
          startTime = Utils.calculateStartTime(365);
        } else if (state.indexYear == 7) {
          startTime = Utils.calculateStartTime(730);
        } else if (state.indexYear == 8) {
          startTime = Utils.calculateStartTime(1095);
        } else if (state.indexYear == 9) {
          startTime = Utils.calculateStartTime(1);
        }
        for (var activity in list) {
          DateTime actionTime = DateTime.parse(activity.actionTime ?? "");
          bool withinStartTime = state.indexYear == 9 ? true : startTime.isNotEmpty ? !actionTime.isBefore(
              Utils.stringToDate(startTime)) : true;
          bool withinEndTime = endTime.isNotEmpty ? !actionTime.isAfter(
              Utils.stringToDateEnd(endTime)) : true;
          //print("HoangCV: startTime: ${Utils.stringToDate(startTime)} : ${Utils.stringToDateEnd(endTime)} : ${actionTime} : $withinStartTime : $withinEndTime");
          if (withinStartTime && withinEndTime) {
            listFilter.add(activity);
          }
        }
      }
    if(listFilter.isNotEmpty) {
      emit(state.copyWith(
          listDiaryActivity: listFilter,
          listDiaryActivityFilter: listFilter
      ));
    } else{
      Toast.showLongTop("Không tìm thấy thông tin hoạt động phù hợp");
      emit(state.copyWith(
        isShowProgress: false,
      ));
    }
  }
}

class HistoryActivityEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetListHistoryActivityEvent extends HistoryActivityEvent {

  final bool? first;

  GetListHistoryActivityEvent({this.first = false});

  @override
  List<Object?> get props => [first];
}

class RemoveHistoryActivityEvent extends HistoryActivityEvent {
  final int id;
  final String action;
  Function(List<ActivityDiary>) callBack;

  RemoveHistoryActivityEvent(this.id, this.action, this.callBack);

  @override
  List<Object?> get props => [id, action, callBack];
}

class RemoveMonitorEvent extends HistoryActivityEvent {
  final int id;

  RemoveMonitorEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class FilterEvent extends HistoryActivityEvent {
  final dynamic result;
  final String type;

  FilterEvent(this.result, this.type);

  @override
  List<Object?> get props => [result, type];
}

class SubmitEvent extends HistoryActivityEvent {
  SubmitEvent();
}

class OnSelectValueEvent extends HistoryActivityEvent {
  List<InputRegisterModel> list;
  int index;
  BuildContext context;

  OnSelectValueEvent(this.list, this.index, this.context);

  @override
  List<Object?> get props => [list, index, context];
}

class HistoryActivityState extends BlocState {
  @override
  List<Object?> get props => [
    listYear,
    listSeason,
    listWidget,
    indexYear,
    indexSeason,
    indexSeasonCurrent,
    listDiaryActivitySave,
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
  final List<ItemBasic> listYear;
  final List<Diary> listSeason;
  final List<InputRegisterModel> listWidget;
  final int indexYear;
  final int indexSeason;
  final int indexSeasonCurrent;
  final List<ActivityDiary> listDiaryActivity;
  final List<ActivityDiary> listDiaryActivityFilter;
  final List<ActivityDiary> listDiaryActivitySave;
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

  HistoryActivityState({
    this.listYear = const [],
    this.listSeason = const [],
    this.listWidget = const [],
    this.indexYear = -1,
    this.indexSeason = -1,
    this.indexSeasonCurrent = -1,
    this.listDiaryActivitySave = const [],
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

  HistoryActivityState copyWith({
    List<ItemBasic>? listYear,
    List<Diary>? listSeason,
    List<InputRegisterModel>? listWidget,
    int? indexYear,
    int? indexSeason,
    int? indexSeasonCurrent,
    List<ActivityDiary>? listDiaryActivitySave,
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
    return HistoryActivityState(
        listYear: listYear ?? this.listYear,
        listSeason: listSeason ?? this.listSeason,
        listWidget: listWidget ?? this.listWidget,
        indexYear: indexYear ?? this.indexYear,
        indexSeason: indexSeason ?? this.indexSeason,
        listDiaryActivitySave: listDiaryActivitySave ?? this.listDiaryActivitySave,
        indexSeasonCurrent: indexSeasonCurrent ?? this.indexSeasonCurrent,
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
