import 'dart:async';

import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../../data/entity/diary/diary.dart';
import '../../../../data/repository.dart';
import '../../../../utils/status/form_submission_status.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class ItemTestBloc extends Bloc<ItemTestEvent, ItemTestState> {
  final Repository repository;

  ItemTestBloc(this.repository) : super(ItemTestState()) {
    on<GetListItemTestEvent>(_getListItemTest);
    on<AddChooseDiary>(_addChooseDiary);
  }

  void _getListItemTest(
      GetListItemTestEvent event, Emitter<ItemTestState> emitter) async {
    emitter(state.copyWith(
        isShowProgress: true, formStatus: const InitialFormStatus()));

    List<int> listSelected = List.generate(30, (index) => index);
    AutoScrollController autoScrollController = AutoScrollController();
    emitter(state.copyWith(
      isShowProgress: false,
      formStatus: const InitialFormStatus(),
      listSelected: listSelected,
        controller : autoScrollController,
    ));
  }

  FutureOr<void> _addChooseDiary(
      AddChooseDiary event, Emitter<ItemTestState> emit) {

    state.controller!.scrollToIndex(event.index,
        preferPosition: AutoScrollPosition.begin);

    emit(state.copyWith(
      isShowProgress: false,
      controller: state.controller,
    ));
    print("HoangCV: _addChooseDiary : ${state.controller}");
  }
}

class ItemTestEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetListItemTestEvent extends ItemTestEvent {
  GetListItemTestEvent();

  @override
  List<Object?> get props => [];
}

class AddChooseDiary extends ItemTestEvent {
  AddChooseDiary(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

class ItemTestState extends BlocState {
  @override
  List<Object?> get props => [
        listDiaryActivity,
        formStatus,
        isShowProgress,
        seasonFarmId,
        listDiarySelected,
        listSelected,
        amountSelected,
        diary,
        controller,
      ];
  final Diary? diary;
  final List<ActivityDiary> listDiaryActivity;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;
  final int? seasonFarmId;
  final List<ActivityDiary> listDiarySelected;
  final List<int> listSelected;
  final int amountSelected;
  AutoScrollController? controller = AutoScrollController();

  ItemTestState({
    this.listDiaryActivity = const [],
    this.diary,
    this.listDiarySelected = const [],
    this.listSelected = const [],
    this.amountSelected = 0,
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.seasonFarmId,
    this.controller,
  });

  ItemTestState copyWith({
    List<ActivityDiary>? listDiaryActivity,
    FormSubmissionStatus? formStatus,
    Diary? diary,
    bool? isShowProgress,
    int? seasonFarmId,
    List<ActivityDiary>? listDiarySelected,
    List<int>? listSelected,
    int? amountSelected,
    AutoScrollController? controller,
  }) {
    return ItemTestState(
      listDiaryActivity: listDiaryActivity ?? this.listDiaryActivity,
      listDiarySelected: listDiarySelected ?? this.listDiarySelected,
      diary: diary ?? this.diary,
      listSelected: listSelected ?? this.listSelected,
      amountSelected: amountSelected ?? this.amountSelected,
      formStatus: formStatus ?? this.formStatus,
      isShowProgress: isShowProgress ?? this.isShowProgress,
      seasonFarmId: seasonFarmId ?? this.seasonFarmId,
      controller: controller ?? this.controller,
    );
  }
}
