
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../data/entity/diary/diary.dart';

import '../../utils/form_submission_status.dart';
import '../../utils/utils.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class ListDiaryBloc extends Bloc<ListDiaryEvent, ListDiaryState> {
  //final Repository repository;
  ListDiaryBloc() : super(ListDiaryState()) {
    on<GetListDiaryEvent>(_getListDiary);
    add(GetListDiaryEvent());
  }
  void _getListDiary(GetListDiaryEvent event, Emitter<ListDiaryState> emitter) async {
    emitter(state.copyWith(isShowProgress: true));
    //final listDiary = await repository.getListDiary();
    emitter(state.copyWith(
      isShowProgress: false,
      //listDiary: listDiary
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
    isShowProgress
  ];
  final List<Diary>? listDiary;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;

  ListDiaryState({
    this.listDiary= const [],
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress=true
  });

  ListDiaryState copyWith({
    final List<Diary>? listDiary,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress
  }) {
    return ListDiaryState(
        listDiary: listDiary ?? this.listDiary,
        formStatus: formStatus??this.formStatus,
        isShowProgress: isShowProgress ?? this.isShowProgress
    );
  }
}

