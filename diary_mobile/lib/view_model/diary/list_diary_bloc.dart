
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../data/entity/diary/diary.dart';

import '../../data/repository.dart';
import '../../utils/form_submission_status.dart';
import '../../utils/utils.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class ListDiaryBloc extends Bloc<ListDiaryEvent, ListDiaryState> {
  final Repository repository;
  ListDiaryBloc(this.repository) : super(ListDiaryState()) {
    on<GetListDiaryEvent>(_getListDiary);
/*    add(GetListDiaryEvent());*/
  }
  void _getListDiary(GetListDiaryEvent event, Emitter<ListDiaryState> emitter) async {
    emitter(state.copyWith(isShowProgress: true));
    final listDiary = await repository.getListDiary();
    List<String> distinctMonthsAndYears = [];
    List<Diary> list = [];
    listDiary.sort((a, b) => (b.startDate??"").compareTo((a.startDate??"")));
    for (var task in listDiary) {
      DateTime dateTime = Utils.formatStringToDate(task.startDate??"");
      String monthAndYear = '${dateTime.month}/${dateTime.year}';
      //String taskMonthAndYear = '${dateTime.month}/${dateTime.year}';
      if (!distinctMonthsAndYears.contains(monthAndYear)) {
        distinctMonthsAndYears.add(monthAndYear);
      }
    }
    emitter(state.copyWith(
      isShowProgress: false,
      listDiary: listDiary,
      listDate: distinctMonthsAndYears,
    ));
  }

}

class ListDiaryEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetListDiaryEvent extends ListDiaryEvent {
  GetListDiaryEvent();
}

class UpdateAvataEvent extends ListDiaryEvent {
  //final ImageSource source;
  UpdateAvataEvent();
}

class ListDiaryState extends BlocState {
  @override
  List<Object?> get props => [
    listDiary,
    formStatus,
    isShowProgress,
    listDate
  ];
  final List<Diary> listDiary;
  final List<String> listDate;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;

  ListDiaryState({
    this.listDiary= const [],
    this.listDate= const [],
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress=true
  });

  ListDiaryState copyWith({
    final List<Diary>? listDiary,
    final List<String>? listDate,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress
  }) {
    return ListDiaryState(
        listDiary: listDiary ?? this.listDiary,
        listDate: listDate ?? this.listDate,
        formStatus: formStatus??this.formStatus,
        isShowProgress: isShowProgress ?? this.isShowProgress
    );
  }
}

