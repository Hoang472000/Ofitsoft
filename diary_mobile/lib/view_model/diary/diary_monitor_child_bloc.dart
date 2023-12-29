import 'dart:async';
import 'dart:isolate';

import 'package:diary_mobile/utils/widgets/dialog/dialog_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/entity/diary/area_entity.dart';
import '../../data/entity/diary/diary.dart';

import '../../data/local_data/diary_db.dart';
import '../../data/repository.dart';
import '../../utils/constants/shared_preferences_key.dart';
import '../../utils/extenstion/extenstions.dart';
import '../../utils/extenstion/input_register_model.dart';
import '../../utils/extenstion/service_info_extension.dart';
import '../../utils/status/form_submission_status.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/dialog/toast_widget.dart';
import '../../view/diary_activity/activity_writeby/add_activity_writeby.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class DiaryMonitorChildBloc extends Bloc<DiaryMonitorChildEvent, DiaryMonitorChildState> {
  final Repository repository;
  DiaryMonitorChildBloc(this.repository) : super(DiaryMonitorChildState()) {
    on<GetListDiaryEvent>(_getListDiary);
    on<AddChooseDiary>(_addChooseDiary);
    on<AddChooseAllDiary>(_addChooseAllDiary);
    on<GetListDiarySelected>(_getListDiarySelected);
    on<SearchListDiaryEvent>(_searchListDiary);
    on<OnSelectValueEvent>(_selectValue);
    on<FilterEvent>(_filter);
/*    add(GetListDiaryEvent());*/
  }

  void _initViewAdd(Emitter<DiaryMonitorChildState> emitter) {
    List<InputRegisterModel> list = [];

/*    list.add(InputRegisterModel<AreaEntity, AreaEntity>(
      title: "Vùng trồng",
      isCompulsory: true,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: 0,
      listValue: state.listAreaEntity,
      valueSelected: state.listAreaEntity[0],
      typeInputEnum: TypeInputEnum.dmucItem,
      hasSearch: true,));

    list.add(InputRegisterModel<SeasonEntity, SeasonEntity>(
      title: "Mùa vụ",
      isCompulsory: true,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: 0,
      listValue: state.listSeasonEntity,
      valueSelected: state.listSeasonEntity[0],
      typeInputEnum: TypeInputEnum.dmucItem,
      hasSearch: true,));*/

    emitter(state.copyWith(
        listWidget: list, formStatus: const InitialFormStatus()));
  }

  Future<void> _getListDiary(
      GetListDiaryEvent event, Emitter<DiaryMonitorChildState> emitter) async {
    emitter(state.copyWith(isShowProgress: true, formStatus: const InitialFormStatus()));
    final List<Diary> listDiary;
    final sharedPreferences = await SharedPreferences.getInstance();
    int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    print("HoangCV:event.first: ${event.first} ");
    if(event.first == true) {
      listDiary = await repository.getListBackupDiary("record");
      emitter(state.copyWith(
        action: "record"
      ));
      //_initViewAdd(emitter);
    } else{
      listDiary = await DiaryDB.instance.getListDiaryFilter(userId, "record", event.seasonId, event.areaId);
    }
    List<String> distinctMonthsAndYears = [];
    List<List<Diary>> list = [];
    Map<String, List<Diary>> mapTasksByMonthAndYear = {};
    List<List<bool>> listSelected = [];

    if(listDiary.isNotEmpty) {
      var receivePortError = ReceivePort();
      final isolateError = await Isolate.spawn(processData,
      [listDiary, receivePortError.sendPort]);
      var object = await  receivePortError.first;

      distinctMonthsAndYears = object[0] as List<String>;
      mapTasksByMonthAndYear = object[1] as Map<String, List<Diary>>;
      listSelected = object[2] as List<List<bool>>;
      list = object[3] as List<List<Diary>>;

      emitter(state.copyWith(
          isShowProgress: false,
          listDiary: list,
          listDate: distinctMonthsAndYears,
          listSelected: listSelected,
          lengthDiary: listDiary.length,
          listSearchDiary: list,
          listSearchSelected: listSelected,
          listSearchDate: distinctMonthsAndYears,
          lengthSearchDiary: listDiary.length,
          listDiaryFilter: listDiary,
          amountSelected: 0));
      isolateError.kill(priority: Isolate.immediate);
    }else if(listDiary.isEmpty && event.first == false) {
      emitter(state.copyWith(isShowProgress: false, formStatus: SubmissionFailed("Không tìm thấy thông tin nhật ký phù hợp.")));
    }else {
    emitter(state.copyWith(isShowProgress: false, formStatus: SubmissionFailed("Bạn chưa được phân quyền truy cập vào nhật ký.\nVui lòng liên hệ quản trị viên để được hỗ trợ")));
    }

  }

  // Define a function to perform the data processing
  static void processData(List<dynamic> args) async {
    List<Diary> listDiary = args[0] as List<Diary>;
    var sendPort = args[1] as SendPort;

    List<String> distinctMonthsAndYears = [];
    Map<String, List<Diary>> mapTasksByMonthAndYear = {};

    listDiary.sort((a, b) => (b.startDate ?? "").compareTo(a.startDate ?? ""));

    for (var task in listDiary) {
      DateTime dateTime = Utils.formatStringToDate(task.startDate ?? "");
      String monthAndYear = '${dateTime.month}/${dateTime.year}';

      if (!mapTasksByMonthAndYear.containsKey(monthAndYear)) {
        mapTasksByMonthAndYear[monthAndYear] = [];
        distinctMonthsAndYears.add(monthAndYear);
      }
      mapTasksByMonthAndYear[monthAndYear]!.add(task);
    }
    List<List<Diary>> list = [];
    List<List<bool>> listSelected = List.generate(
      distinctMonthsAndYears.length,
          (_) => List.generate(mapTasksByMonthAndYear[distinctMonthsAndYears[_]]?.length ?? 0, (index) => false),
    );

    // Populate listSelected based on mapTasksByMonthAndYear
    for (int i = 0; i < distinctMonthsAndYears.length; i++) {
      String monthAndYear = distinctMonthsAndYears[i];
      List<Diary> tasksForMonthAndYear = mapTasksByMonthAndYear[monthAndYear] ?? [];
      list.add(tasksForMonthAndYear);
    }

    // Send the results back to the main isolate
    sendPort.send([distinctMonthsAndYears, mapTasksByMonthAndYear, listSelected, list ]);
  }

  FutureOr<void> _addChooseDiary(
      AddChooseDiary event, Emitter<DiaryMonitorChildState> emit) {
    List<List<bool>> listChoose = state.listSelected;
    bool choose = event.isChoose;
    int amountChoose = state.amountSelected;
    if (choose) {
      amountChoose++;
    } else {
      if (amountChoose > 0) {
        amountChoose--;
        print("HoangCV: amountChoose: $amountChoose}");
      }
    }
    listChoose[event.indexParent]
        .replaceRange(event.index, event.index + 1, [choose]);
    emit(state.copyWith(
        listDiary: state.listDiary,
        isShowProgress: false,
        listSelected: listChoose,
        amountSelected: amountChoose));
  }

  FutureOr<void> _addChooseAllDiary(
      AddChooseAllDiary event, Emitter<DiaryMonitorChildState> emit) {
    List<List<bool>> listSelected = state.listSelected;
    listSelected.forEach((element) {
      element.replaceRange(0, element.length,
          List.generate(element.length, (index) => !event.isChoose));
    });
    emit(state.copyWith(
        listDiary: state.listDiary,
        isShowProgress: false,
        listSelected: listSelected,
        amountSelected: event.isChoose ? 0 : state.lengthDiary));
  }

  List<Diary> getTasksForMonthAndYear(String monthAndYear, List<Diary> list) {
    List<Diary> tasksForMonthAndYear = [];
    list.sort((a, b) => (b.startDate ?? "").compareTo((a.startDate ?? "")));
    for (var task in list) {
      DateTime dateTime = Utils.formatStringToDate(task.startDate ?? "");
      String taskMonthAndYear = '${dateTime.month}/${dateTime.year}';
      if (taskMonthAndYear == monthAndYear) {
        tasksForMonthAndYear.add(task);
      }
    }
    return tasksForMonthAndYear;
  }

  FutureOr<void> _getListDiarySelected(
      GetListDiarySelected event, Emitter<DiaryMonitorChildState> emit) async{
    List<Diary> listSelected = [];
    for(int i = 0 ; i< state.listDiary.length;i++){
      for(int j = 0; j < state.listDiary[i].length;j++){
        if(state.listSelected[i][j]){
          listSelected.add(state.listDiary[i][j]);
        }
      }
    }
    print("HoangCV: listSelected: ${listSelected.length}");
    var result = await Navigator.of(event.context)
        .push(AddActWriteByPage.route(listSelected));
    if(result != null && result[0]) {
      if (result[1]) {
        add(GetListDiaryEvent());
      } else {
        List<List<bool>> listSelected = state.listSelected;
        for (var element in listSelected) {
          element.replaceRange(0, element.length,
              List.generate(element.length, (index) => false));
        }
        emit(state.copyWith(isShowProgress: false,
            listSelected: listSelected,
            amountSelected: 0));
      }
    }
    emit(state.copyWith(isShowProgress: false, listDiarySelected: listSelected));
  }

  FutureOr<void> _searchListDiary(SearchListDiaryEvent event, Emitter<DiaryMonitorChildState> emit) {
    List<List<Diary>> list = state.listSearchDiary;
    List<String> listDate = state.listSearchDate;
    List<List<Diary>> searchResults = List.generate(list.length, (index) => []);
    for (int i = 0; i < list.length; i++) {
      List<Diary> searchSection = [];
      searchSection.addAll(list[i].where((item) {
        return (Utils.formatText((item.name ?? "").toLowerCase()).contains(Utils.formatText(event.textSearch.toLowerCase())) ||
            Utils.formatText((item.cropName ?? "").toLowerCase()).contains(Utils.formatText(event.textSearch.toLowerCase())) ||
            Utils.formatText((item.farmerName ?? "").toLowerCase()).contains(Utils.formatText(event.textSearch.toLowerCase())) ||
            (Utils.formatTime(item.startDate ?? "")).toLowerCase().contains(event.textSearch.toLowerCase()));
      }).toList());
      searchResults[i] = searchSection; // Lưu kết quả tìm kiếm cho danh sách con tại vị trí tương ứng
    }
    searchResults.removeWhere((element) => element.isEmpty);
    int totalSublistItems = 0;
    for (int i = 0; i < searchResults.length; i++) {
      totalSublistItems += searchResults[i].length; // Cộng tổng số phần tử con
    }
    List<List<bool>> searchBoolResult = List.generate(
      searchResults.length,
          (index) => List.generate(searchResults[index].length, (innerIndex) => false),
    );
    searchBoolResult.removeWhere((element) => element.isEmpty);
    List<String> newListDate = [];
    for (var element in searchResults) {
      for (var item in element) {
        DateTime dateTime = Utils.formatStringToDate(item.startDate ?? "");
        String monthAndYear = '${dateTime.month}/${dateTime.year}';
        //String taskMonthAndYear = '${dateTime.month}/${dateTime.year}';
        if (!newListDate.contains(monthAndYear)) {
          newListDate.add(monthAndYear);
        }
      }
    }
    print("HoangCV: newListDate: ${searchBoolResult.toString()}");

    newListDate.removeWhere((element) => element.isEmpty);
    print("HoangCV: newListDate: ${newListDate.toString()}");
    emit(state.copyWith(
        formStatus: const InitialFormStatus(),
        listDiary: searchResults,
        listSelected: searchBoolResult,
        listDate: newListDate,
        lengthDiary: totalSublistItems,
        amountSelected: 0));
  }

  FutureOr<void> _selectValue(OnSelectValueEvent event, Emitter<DiaryMonitorChildState> emit) async {
    int result;
    bool checkPass = true;
    if(event.index == 0 && state.listAreaEntity.isEmpty) {
      Toast.showLongTop("Không có danh sách vùng trồng");
      checkPass = false;
    }else if(event.index == 1 && state.listSeasonEntity.isEmpty) {
      Toast.showLongTop("Không có danh sách mùa vụ");
      checkPass = false;
    }
    if(checkPass) {
      emit(state.copyWith(formStatus: const InitialFormStatus()));
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
          // });
          if (event.list[event.index].title.compareTo("Vùng trồng") == 0) {
            List<SeasonEntity> listSeasonEntity = [];
            listSeasonEntity.add(SeasonEntity(id: -1, name: "Tất cả"));
            listSeasonEntity.addAll(event.list[event.index].listValue[result].seasons);
            print("HoangCV: event.list[event.index].listValue[result].seasons: ${event.list[event.index].listValue[result].seasons}");
            state.listWidget[1].listValue = listSeasonEntity;
            state.listWidget[1].valueSelected = listSeasonEntity[0];
            state.listWidget[1].positionSelected = 0;
            emit(state.copyWith(
                listSeasonEntity: listSeasonEntity));
            emit(
                state.copyWith(listWidget: state.listWidget));
            add(GetListDiaryEvent(/*event.diary, state.action,*/ first: false, areaId: state.listWidget[0].valueSelected.id , seasonId: -1));
          }
          if (event.list[event.index].title.compareTo("Mùa vụ") == 0) {
            add(GetListDiaryEvent(/*event.diary, state.action,*/ first: false, areaId: state.listWidget[0].valueSelected.id , seasonId: event.list[event.index].listValue[result].id));
          }
      }
    }
  }

  Future<FutureOr<void>> _filter(FilterEvent event, Emitter<DiaryMonitorChildState> emit) async {
    print("HoangCV: filter: ${event.result}");
    var startTime = event.result[0]/*.replaceAll("/","-")*/;
    var endTime = event.result[1]/*.replaceAll("/","-")*/;
    var filter0 = event.result[2];
    var filter1 = event.result[3];
    var filter2 = event.result[4];
    var filter3 = event.result[5];
    List<Diary> listFilter = state.listDiaryFilter.map((e) => Diary.copy(e)).toList();
    //print("HoangCV: filter: ${minPrice} : ${maxPrice}");
    List<Diary> filteredList = [];
    for (var activity in listFilter) {
      //String transactionDate = Utils.formatTime(activity.transactionDate ?? "");
      DateTime transactionDate = DateTime.parse(activity.startDate ?? "");
      /*print("transactionDate: ${transactionDate} : ${Utils.stringToDate(startTime)}");
      print("DateTime.parse(startTime) : ${!transactionDate.isBefore(Utils.stringToDate(startTime))}");*/
      bool withinStartTime = startTime.isNotEmpty ? !transactionDate.isBefore(Utils.stringToDate(startTime)) : true;
      bool withinEndTime = endTime.isNotEmpty ? !transactionDate.isAfter(Utils.stringToDate(endTime)) : true;


      //print("HoangCV: $withinStartTime : $withinEndTime : $withinMinPrice : $withinMaxPrice: $withinMinQuantity : $withinMaxQuantity");
      if (withinStartTime && withinEndTime) {
        filteredList.add(activity);
      }
    }
    List<Diary> listFilter0 = [];
    List<Diary> listFilter1 = [];
    List<Diary> listFilter2 = [];
    List<Diary> listFilter3 = [];
    if(filter0 != -1) {
      listFilter0.addAll(filteredList.where((
          activity) => activity.areaId == filter0).toList());
    } else{
      listFilter0.addAll(filteredList);
    }
    if(filter1 != -1) {
      listFilter1.addAll(listFilter0.where((
          activity) => activity.id == filter1).toList());
    } else{
      listFilter1.addAll(listFilter0);
    }
    if(filter2 != -1) {
      listFilter2.addAll(listFilter1.where((
          activity) => activity.cropId == filter2).toList());
    } else{
      listFilter2.addAll(listFilter1);
    }
    if(filter3 != -1) {
      listFilter3.addAll(listFilter2.where((
          activity) => activity.farmerId == filter3).toList());
    } else{
      listFilter3.addAll(listFilter2);
    }
    List<String> distinctMonthsAndYears = [];
    List<List<Diary>> list = [];
    Map<String, List<Diary>> mapTasksByMonthAndYear = {};
    List<List<bool>> listSelected = [];

    if(listFilter3.isNotEmpty) {
      var receivePortError = ReceivePort();
      final isolateError = await Isolate.spawn(processData,
          [listFilter3, receivePortError.sendPort]);
      var object = await  receivePortError.first;

      distinctMonthsAndYears = object[0] as List<String>;
      mapTasksByMonthAndYear = object[1] as Map<String, List<Diary>>;
      listSelected = object[2] as List<List<bool>>;
      list = object[3] as List<List<Diary>>;

      emit(state.copyWith(
          isShowProgress: false,
          listDiary: list,
          listDate: distinctMonthsAndYears,
          listSelected: listSelected,
          lengthDiary: listFilter3.length,
          listSearchDiary: list,
          listSearchSelected: listSelected,
          listSearchDate: distinctMonthsAndYears,
          lengthSearchDiary: listFilter3.length,
/*          listDiaryFilter: listFilter3,*/
          amountSelected: 0));
      isolateError.kill(priority: Isolate.immediate);
    }else if(listFilter3.isEmpty) {
      emit(state.copyWith(isShowProgress: false, formStatus: SubmissionFailed("Không tìm thấy thông tin nhật ký phù hợp.")));
    }
  }
}

class DiaryMonitorChildEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetListDiaryEvent extends DiaryMonitorChildEvent {
/*  final List<Diary> diary;*/
  final bool first;
/*  final String action;*/
  final int seasonId;
  final int areaId;
  GetListDiaryEvent(/*this.diary, this.action, */{this.first = false, this.seasonId = -1, this.areaId = -1});
}

class AddChooseDiary extends DiaryMonitorChildEvent {
  AddChooseDiary(this.indexParent, this.index, this.isChoose, this.diary);

  final int index;
  final int indexParent;
  final bool isChoose;
  final Diary diary;

  @override
  List<Object?> get props => [isChoose, diary, index, indexParent];
}

class AddChooseAllDiary extends DiaryMonitorChildEvent {
  AddChooseAllDiary(this.isChoose);

  final bool isChoose;

  @override
  List<Object?> get props => [isChoose];
}

class OnSelectValueEvent extends DiaryMonitorChildEvent {
  List<InputRegisterModel> list;
  int index;
  BuildContext context;
/*  final List<Diary> diary;*/

  OnSelectValueEvent(this.list, this.index, this.context/*, this.diary*/);

  @override
  List<Object?> get props => [list, index, context, /*diary*/];
}

class GetListDiarySelected extends DiaryMonitorChildEvent {
  GetListDiarySelected(this.context);

  final BuildContext context;
  @override

  List<Object?> get props => [context];
}

class SearchListDiaryEvent extends DiaryMonitorChildEvent {
  SearchListDiaryEvent(this.textSearch);

  final String textSearch;

  @override
  List<Object?> get props => [textSearch];
}

class FilterEvent extends DiaryMonitorChildEvent {
  final dynamic result;

  FilterEvent(this.result);

  @override
  List<Object?> get props => [result];
}

class DiaryMonitorChildState extends BlocState {
  @override
  List<Object?> get props => [
    listDiary,
    formStatus,
    isShowProgress,
    listDate,
    listSelected,
    amountSelected,
    lengthDiary,
    listDiarySelected,
    listSearchDiary,
    listSearchSelected,
    listSearchDate,
    lengthSearchDiary,
    listAreaEntity,
    listWidget,
    listSeasonEntity,
    action,
    listDiaryFilter,
  ];
  final List<List<Diary>> listDiary;
  final List<List<Diary>> listSearchDiary;
  final List<Diary> listDiarySelected;
  List<Diary> listDiaryFilter;
  final List<String> listSearchDate;
  final List<String> listDate;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;
  final List<List<bool>> listSelected;
  final List<List<bool>> listSearchSelected;
  final int amountSelected;
  final int lengthDiary;
  final int lengthSearchDiary;
  final List<AreaEntity> listAreaEntity;
  final List<SeasonEntity> listSeasonEntity;
  final List<InputRegisterModel> listWidget;
  final String action;

  DiaryMonitorChildState(
      {this.listDiarySelected = const [],
        this.listSearchDiary = const [],
        this.listDiary = const [],
        this.listDiaryFilter = const [],
        this.listSearchSelected = const [],
        this.listDate = const [],
        this.listSearchDate = const [],
        this.formStatus = const InitialFormStatus(),
        this.isShowProgress = true,
        this.listSelected = const [],
        this.amountSelected = 0,
        this.lengthDiary = -1,
        this.lengthSearchDiary = -1,
        this.listAreaEntity = const [],
        this.listWidget = const [],
        this.listSeasonEntity = const [],
        this.action = "farmer"
      });

  DiaryMonitorChildState copyWith({
    List<List<Diary>>? listDiary,
    List<Diary>? listDiaryFilter,
    List<List<Diary>>? listSearchDiary,
    List<String>? listDate,
    List<String>? listSearchDate,
    List<Diary>? listDiarySelected,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    List<List<bool>>? listSelected,
    List<List<bool>>? listSearchSelected,
    int? amountSelected,
    int? lengthDiary,
    int? lengthSearchDiary,
    List<AreaEntity>? listAreaEntity,
    List<InputRegisterModel>? listWidget,
    List<SeasonEntity>? listSeasonEntity,
    String? action,
  }) {
    return DiaryMonitorChildState(
      listDiary: listDiary ?? this.listDiary,
      listDiaryFilter: listDiaryFilter ?? this.listDiaryFilter,
      listDate: listDate ?? this.listDate,
      formStatus: formStatus ?? this.formStatus,
      isShowProgress: isShowProgress ?? this.isShowProgress,
      listSelected: listSelected ?? this.listSelected,
      amountSelected: amountSelected ?? this.amountSelected,
      lengthDiary: lengthDiary ?? this.lengthDiary,
      listDiarySelected: listDiarySelected ?? this.listDiarySelected,
      listSearchDiary: listSearchDiary ?? this.listSearchDiary,
      listSearchSelected: listSearchSelected ?? this.listSearchSelected,
      listSearchDate: listSearchDate ?? this.listSearchDate,
      lengthSearchDiary: lengthSearchDiary ?? this.lengthSearchDiary,
        listAreaEntity: listAreaEntity ?? this.listAreaEntity,
        listSeasonEntity: listSeasonEntity ?? this.listSeasonEntity,
        listWidget: listWidget ?? this.listWidget,
        action: action ?? this.action,
    );
  }
}
