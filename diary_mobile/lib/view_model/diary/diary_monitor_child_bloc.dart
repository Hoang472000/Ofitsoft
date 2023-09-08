import 'dart:async';
import 'dart:isolate';

import 'package:diary_mobile/utils/widgets/dialog/dialog_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/diary/diary.dart';

import '../../data/repository.dart';
import '../../utils/status/form_submission_status.dart';
import '../../utils/utils.dart';
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
/*    add(GetListDiaryEvent());*/
  }

  Future<void> _getListDiary(
      GetListDiaryEvent event, Emitter<DiaryMonitorChildState> emitter) async {
    emitter(state.copyWith(isShowProgress: true, formStatus: const InitialFormStatus()));
    final listDiary = event.diary/*await repository.getListDiary()*/;
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
          amountSelected: 0));
      isolateError.kill(priority: Isolate.immediate);
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
        add(GetListDiaryEvent([]));
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
    emit(state.copyWith(listDiary: searchResults, listSelected: searchBoolResult, listDate: newListDate, lengthDiary: totalSublistItems, amountSelected: 0));
  }
}

class DiaryMonitorChildEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetListDiaryEvent extends DiaryMonitorChildEvent {
  final List<Diary> diary;
  GetListDiaryEvent(this.diary);
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
  ];
  final List<List<Diary>> listDiary;
  final List<List<Diary>> listSearchDiary;
  final List<Diary> listDiarySelected;
  final List<String> listSearchDate;
  final List<String> listDate;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;
  final List<List<bool>> listSelected;
  final List<List<bool>> listSearchSelected;
  final int amountSelected;
  final int lengthDiary;
  final int lengthSearchDiary;

  DiaryMonitorChildState(
      {this.listDiarySelected = const [],
        this.listSearchDiary = const [],
        this.listDiary = const [],
        this.listSearchSelected = const [],
        this.listDate = const [],
        this.listSearchDate = const [],
        this.formStatus = const InitialFormStatus(),
        this.isShowProgress = true,
        this.listSelected = const [],
        this.amountSelected = 0,
        this.lengthDiary = -1,
        this.lengthSearchDiary = -1});

  DiaryMonitorChildState copyWith({
    List<List<Diary>>? listDiary,
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
  }) {
    return DiaryMonitorChildState(
      listDiary: listDiary ?? this.listDiary,
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
    );
  }
}
