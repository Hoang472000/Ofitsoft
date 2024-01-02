import 'dart:async';

import 'package:diary_mobile/utils/widgets/dialog/toast_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/diary/diary.dart';

import '../../data/repository.dart';
import '../../utils/status/form_submission_status.dart';
import '../../utils/utils.dart';
import '../../view/diary_activity/activity_writeby/add_activity_writeby.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class ListDiaryBloc extends Bloc<ListDiaryEvent, ListDiaryState> {
  final Repository repository;

  ListDiaryBloc(this.repository) : super(ListDiaryState()) {
    on<GetListDiaryEvent>(_getListDiary);
    on<AddChooseDiary>(_addChooseDiary);
    on<AddChooseAllDiary>(_addChooseAllDiary);
    on<GetListDiarySelected>(_getListDiarySelected);
    on<SearchListDiaryEvent>(_searchListDiary);
    on<FilterEvent>(_filter);
/*    add(GetListDiaryEvent());*/
  }

  void _getListDiary(
      GetListDiaryEvent event, Emitter<ListDiaryState> emitter) async {
    emitter(state.copyWith(isShowProgress: true, formStatus: const InitialFormStatus()));
    final listDiary = await repository.getListDiary("farmer");
    List<String> distinctMonthsAndYears = [];
    List<List<Diary>> list = [];
    listDiary
        .sort((a, b) => (b.startDate ?? "").compareTo((a.startDate ?? "")));
    for (var task in listDiary) {
      DateTime dateTime = Utils.formatStringToDate(task.startDate ?? "");
      String monthAndYear = '${dateTime.month}/${dateTime.year}';
      //String taskMonthAndYear = '${dateTime.month}/${dateTime.year}';
      if (!distinctMonthsAndYears.contains(monthAndYear)) {
        distinctMonthsAndYears.add(monthAndYear);
      }
    }
    List<List<bool>> listSelected = List.generate(
      distinctMonthsAndYears.length,
      (_) => [],
    );
    for (int i = 0; i < distinctMonthsAndYears.length; i++) {
      String monthAndYear = distinctMonthsAndYears[i];
      List<Diary> tasksForMonthAndYear =
          getTasksForMonthAndYear(monthAndYear, listDiary);
      list.add(tasksForMonthAndYear);
      listSelected[i]
          .addAll(List.generate(tasksForMonthAndYear.length, (index) => false));
    }
    // khoi tao list choose ban dau voi gia tri la false => khong chon
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
  }

  FutureOr<void> _addChooseDiary(
      AddChooseDiary event, Emitter<ListDiaryState> emit) {
    emit(state.copyWith(formStatus: const InitialFormStatus()));
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
      AddChooseAllDiary event, Emitter<ListDiaryState> emit) {
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
      GetListDiarySelected event, Emitter<ListDiaryState> emit) async{
    emit(state.copyWith(formStatus: const InitialFormStatus()));
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

  FutureOr<void> _searchListDiary(SearchListDiaryEvent event, Emitter<ListDiaryState> emit) {
    emit(state.copyWith(formStatus: const InitialFormStatus()));
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

  FutureOr<void> _filter(FilterEvent event, Emitter<ListDiaryState> emit) async {
    emit(state.copyWith(formStatus: const InitialFormStatus()));
    print("HoangCV: filter: ${event.result}");
    var startTime = event.result[0];
    var endTime = event.result[1];
    var filter0 = event.result[2];
    var filter1 = event.result[3];
    var filter2 = event.result[4];
    var filter3 = event.result[5];
    List<Diary> listFilter = state.listDiaryFilter.map((e) => Diary.copy(e)).toList();
    List<Diary> filteredList = [];
    for (var activity in listFilter) {
      DateTime transactionDate = DateTime.parse(activity.startDate ?? "");
      bool withinStartTime = startTime.isNotEmpty ? !transactionDate.isBefore(Utils.stringToDate(startTime)) : true;
      bool withinEndTime = endTime.isNotEmpty ? !transactionDate.isAfter(Utils.stringToDateEnd(endTime)) : true;
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
          activity) => activity.seasonId == filter1).toList());
    } else{
      listFilter1.addAll(listFilter0);
    }
    print("HoangCV: listFilter1: ${listFilter1.length}");
    if(filter2 != -1) {
      listFilter2.addAll(listFilter1.where((
          activity) => activity.cropId == filter2).toList());
    } else{
      listFilter2.addAll(listFilter1);
    }
    print("HoangCV: listFilter2: ${listFilter2.length} : ${filter3}");
    if(filter3 != -1) {
      listFilter3.addAll(listFilter2.where((
          activity) => activity.farmerId == filter3).toList());
    } else{
      listFilter3.addAll(listFilter2);
    }
    print("HoangCV: listFilter3: ${listFilter3.length}");

    if(listFilter3.isNotEmpty) {
      List<String> distinctMonthsAndYears = [];
      List<List<Diary>> list = [];
      listFilter3
          .sort((a, b) => (b.startDate ?? "").compareTo((a.startDate ?? "")));
      for (var task in listFilter3) {
        DateTime dateTime = Utils.formatStringToDate(task.startDate ?? "");
        String monthAndYear = '${dateTime.month}/${dateTime.year}';
        //String taskMonthAndYear = '${dateTime.month}/${dateTime.year}';
        if (!distinctMonthsAndYears.contains(monthAndYear)) {
          distinctMonthsAndYears.add(monthAndYear);
        }
      }
      List<List<bool>> listSelected = List.generate(
        distinctMonthsAndYears.length,
            (_) => [],
      );
      for (int i = 0; i < distinctMonthsAndYears.length; i++) {
        String monthAndYear = distinctMonthsAndYears[i];
        List<Diary> tasksForMonthAndYear =
        getTasksForMonthAndYear(monthAndYear, listFilter3);
        list.add(tasksForMonthAndYear);
        listSelected[i]
            .addAll(List.generate(tasksForMonthAndYear.length, (index) => false));
      }
      // khoi tao list choose ban dau voi gia tri la false => khong chon
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
          amountSelected: 0));
    }else if(listFilter3.isEmpty) {
      Toast.showLongTop("Không tìm thấy thông tin nhật ký phù hợp.");
      emit(state.copyWith(isShowProgress: false, formStatus: SubmissionFailed("Không tìm thấy thông tin nhật ký phù hợp.")));
    }
  }
}

class ListDiaryEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetListDiaryEvent extends ListDiaryEvent {
  GetListDiaryEvent();
}

class AddChooseDiary extends ListDiaryEvent {
  AddChooseDiary(this.indexParent, this.index, this.isChoose, this.diary);

  final int index;
  final int indexParent;
  final bool isChoose;
  final Diary diary;

  @override
  List<Object?> get props => [isChoose, diary, index, indexParent];
}

class AddChooseAllDiary extends ListDiaryEvent {
  AddChooseAllDiary(this.isChoose);

  final bool isChoose;

  @override
  List<Object?> get props => [isChoose];
}

class GetListDiarySelected extends ListDiaryEvent {
  GetListDiarySelected(this.context);

  final BuildContext context;
  @override

  List<Object?> get props => [context];
}

class SearchListDiaryEvent extends ListDiaryEvent {
  SearchListDiaryEvent(this.textSearch);

  final String textSearch;

  @override
  List<Object?> get props => [textSearch];
}

class FilterEvent extends ListDiaryEvent {
  final dynamic result;

  FilterEvent(this.result);

  @override
  List<Object?> get props => [result];
}

class ListDiaryState extends BlocState {
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
    listDiaryFilter,
      ];
  final List<List<Diary>> listDiary;
  final List<Diary> listDiaryFilter;
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

  ListDiaryState(
      {this.listDiarySelected = const [],
        this.listDiaryFilter = const [],
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

  ListDiaryState copyWith({
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
  }) {
    return ListDiaryState(
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
    );
  }
}
