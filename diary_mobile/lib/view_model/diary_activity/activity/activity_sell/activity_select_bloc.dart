import 'dart:async';

import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/material_entity.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:diary_mobile/data/entity/monitor/monitor_diary.dart';
import 'package:diary_mobile/utils/constants/status_const.dart';
import 'package:diary_mobile/view/diary_activity/activity_sell/add_activity_sell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/entity/diary/diary.dart';
import '../../../../data/repository.dart';
import '../../../../utils/status/form_submission_status.dart';
import '../../../bloc_event.dart';
import '../../../bloc_state.dart';

class ActivitySelectBloc
    extends Bloc<ActivitySelectEvent, ActivitySelectState> {
  final Repository repository;

  ActivitySelectBloc(this.repository) : super(ActivitySelectState()) {
    on<GetListActivitySelectEvent>(_getListActivitySelect);
    on<AddChooseDiary>(_addChooseDiary);
    on<AddChooseAllDiary>(_addChooseAllDiary);
    on<GetListDiarySelected>(_getListDiarySelected);
    //add(GetListActivityEvent());
  }

  void _getListActivitySelect(GetListActivitySelectEvent event,
      Emitter<ActivitySelectState> emitter) async {
    emitter(state.copyWith(
        isShowProgress: true, formStatus: const InitialFormStatus()));

    List<ActivityDiary> listHarvesting = event.list.map((diary) => ActivityDiary.copy(diary)).toList();
    listHarvesting.removeWhere((element) => element.harvesting == false);
    List<bool> listSelected =
    List.generate(listHarvesting.length, (index) => false);
    emitter(state.copyWith(
      isShowProgress: false,
      formStatus: const InitialFormStatus(),
      listDiaryActivity: listHarvesting,
      listSelected: listSelected,
      diary: event.diary
    ));
  }

  FutureOr<void> _addChooseDiary(AddChooseDiary event,
      Emitter<ActivitySelectState> emit) {
    List<bool> listChoose = state.listSelected;
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
    listChoose
        .replaceRange(event.index, event.index + 1, [choose]);
    emit(state.copyWith(
        isShowProgress: false,
        listSelected: listChoose,
        amountSelected: amountChoose));
  }

  FutureOr<void> _addChooseAllDiary(AddChooseAllDiary event,
      Emitter<ActivitySelectState> emit) {
    List<bool>
    listSelected = List.generate(
        state.listSelected.length, (index) => !event.isChoose);
    emit(state.copyWith(
        isShowProgress: false,
        listSelected: listSelected,
        amountSelected: event.isChoose ? 0 : state.listDiaryActivity.length));
  }

  FutureOr<void> _getListDiarySelected(GetListDiarySelected event,
      Emitter<ActivitySelectState> emit) async {
    List<ActivityDiary> listSelected = [];
    for (int i = 0; i < state.listDiaryActivity.length; i++) {
      if (state.listSelected[i]) {
        listSelected.add(state.listDiaryActivity[i]);
      }
    }
    print("HoangCV: listSelected: ${listSelected.length}");
    var result = await Navigator.of(event.context)
        .push(AddActivitySellPage.route(
        1, listSelected, state.diary ?? Diary()));
    if (result != null && (result is List) && result[0]) {
      if (!result[0]) {
        //add(GetListDiaryEvent());
      } else {
        Navigator.pop(event.context, [true]);
        List<bool> listSelected =
        List.generate(state.listDiaryActivity.length, (index) => false);
        emit(state.copyWith(isShowProgress: false,
            listSelected: listSelected,
            amountSelected: 0));
      }
    }
    emit(
        state.copyWith(isShowProgress: false, listDiarySelected: listSelected));
  }
}

class ActivitySelectEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetListActivitySelectEvent extends ActivitySelectEvent {
  final List<ActivityDiary> list;
  final Diary diary;

  GetListActivitySelectEvent(this.list, this.diary);

  @override
  List<Object?> get props => [list, diary];
}

class AddChooseDiary extends ActivitySelectEvent {
  AddChooseDiary(this.index, this.isChoose, this.diary);

  final int index;
  final bool isChoose;
  final ActivityDiary diary;

  @override
  List<Object?> get props => [isChoose, diary, index];
}

class AddChooseAllDiary extends ActivitySelectEvent {
  AddChooseAllDiary(this.isChoose);

  final bool isChoose;

  @override
  List<Object?> get props => [isChoose];
}

class GetListDiarySelected extends ActivitySelectEvent {
  GetListDiarySelected(this.context);

  final BuildContext context;

  @override
  List<Object?> get props => [context];
}

class ActivitySelectState extends BlocState {
  @override
  List<Object?> get props =>
      [
        listDiaryActivity,
        formStatus,
        isShowProgress,
        seasonFarmId,
        listDiarySelected,
        listSelected,
        amountSelected,
        diary,
      ];
  final Diary? diary;
  final List<ActivityDiary> listDiaryActivity;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;
  final int? seasonFarmId;
  final List<ActivityDiary> listDiarySelected;
  final List<bool> listSelected;
  final int amountSelected;

  ActivitySelectState({
    this.listDiaryActivity = const [],
    this.diary,
    this.listDiarySelected = const [],
    this.listSelected = const [],
    this.amountSelected = 0,
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.seasonFarmId,
  });

  ActivitySelectState copyWith({
    List<ActivityDiary>? listDiaryActivity,
    FormSubmissionStatus? formStatus,
    Diary? diary,
    bool? isShowProgress,
    int? seasonFarmId,
    List<ActivityDiary>? listDiarySelected,
    List<bool>? listSelected,
    int? amountSelected,
  }) {
    return ActivitySelectState(
      listDiaryActivity: listDiaryActivity ?? this.listDiaryActivity,
      listDiarySelected: listDiarySelected ?? this.listDiarySelected,
      diary: diary ?? this.diary,
      listSelected: listSelected ?? this.listSelected,
      amountSelected: amountSelected ?? this.amountSelected,
      formStatus: formStatus ?? this.formStatus,
      isShowProgress: isShowProgress ?? this.isShowProgress,
      seasonFarmId: seasonFarmId ?? this.seasonFarmId,
    );
  }
}
