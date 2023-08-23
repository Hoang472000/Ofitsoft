import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/diary/diary.dart';

import '../../data/repository.dart';
import '../../utils/form_submission_status.dart';
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
/*    add(GetListDiaryEvent());*/
  }

  void _getListDiary(
      GetListDiaryEvent event, Emitter<ListDiaryState> emitter) async {
    emitter(state.copyWith(isShowProgress: true));
    final listDiary = await repository.getListDiary();
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
        amountSelected: 0));
  }

  FutureOr<void> _addChooseDiary(
      AddChooseDiary event, Emitter<ListDiaryState> emit) {
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
      ];
  final List<List<Diary>> listDiary;
  final List<Diary> listDiarySelected;
  final List<String> listDate;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;
  final List<List<bool>> listSelected;
  final int amountSelected;
  final int lengthDiary;

  ListDiaryState({
    this.listDiarySelected = const [],
    this.listDiary = const [],
    this.listDate = const [],
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.listSelected = const [],
    this.amountSelected = 0,
    this.lengthDiary = -1,
  });

  ListDiaryState copyWith({
    List<List<Diary>>? listDiary,
    List<String>? listDate,
    List<Diary>? listDiarySelected,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    List<List<bool>>? listSelected,
    int? amountSelected,
    int? lengthDiary,
  }) {
    return ListDiaryState(
      listDiary: listDiary ?? this.listDiary,
      listDate: listDate ?? this.listDate,
      formStatus: formStatus ?? this.formStatus,
      isShowProgress: isShowProgress ?? this.isShowProgress,
      listSelected: listSelected ?? this.listSelected,
      amountSelected: amountSelected ?? this.amountSelected,
      lengthDiary: lengthDiary ?? this.lengthDiary,
      listDiarySelected: listDiarySelected ?? this.listDiarySelected,
    );
  }
}
