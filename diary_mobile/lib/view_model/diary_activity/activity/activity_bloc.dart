import 'dart:async';

import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:diary_mobile/utils/constans/status_const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/entity/diary/diary.dart';
import '../../../data/entity/item_default/material_entity.dart';
import '../../../data/local_data/diary_db.dart';
import '../../../data/repository.dart';
import '../../../utils/form_submission_status.dart';
import '../../bloc_event.dart';
import '../../bloc_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final Repository repository;

  ActivityBloc(this.repository) : super(ActivityState()) {
    on<GetListActivityEvent>(_getListActivity);
    on<RemoveActivityEvent>(_removeActivity);
    //add(GetListActivityEvent());
  }

  void _getListActivity(
      GetListActivityEvent event, Emitter<ActivityState> emitter) async {
    emitter(state.copyWith(
        isShowProgress: true, formStatus: const InitialFormStatus()));
    final listDiaryActivity = await repository.getListActivityDiary(event.id);
    DiaryDB.instance.getListDiary();
    emitter(state.copyWith(
        isShowProgress: false, listDiaryActivity: listDiaryActivity));
  }

  FutureOr<void> _removeActivity(
      RemoveActivityEvent event, Emitter<ActivityState> emit) async {
    emit(state.copyWith(isShowProgress: true, formStatus: FormSubmitting()));
    final objectResult = await repository.removeActivityDiary(event.id);
    //DiaryDB.instance.getListDiary();
    if (objectResult.responseCode == StatusConst.code00) {
      emit(state.copyWith(
          isShowProgress: false,
          formStatus: SubmissionSuccess(success: objectResult.message)));
    } else if (objectResult.responseCode == StatusConst.code01) {
      emit(state.copyWith(
          isShowProgress: false,
          formStatus: SubmissionFailed(objectResult.message)));
    }
  }
}

class ActivityEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetListActivityEvent extends ActivityEvent {
  final int id;

  GetListActivityEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class RemoveActivityEvent extends ActivityEvent {
  final int id;

  RemoveActivityEvent(this.id);

  @override
  List<Object?> get props => [id];
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
        listActivity
      ];
  final List<ActivityDiary> listDiaryActivity;
  final List<MaterialEntity> listMaterial;
  final List<Tool> listTool;
  final List<Unit> listUnit;
  final List<Activity>? listActivity;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;

  ActivityState({
    this.listDiaryActivity = const [],
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.listMaterial = const [],
    this.listTool = const [],
    this.listUnit = const [],
    this.listActivity = const [],
  });

  ActivityState copyWith({
    List<ActivityDiary>? listDiaryActivity,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    List<MaterialEntity>? listMaterial,
    List<Tool>? listTool,
    List<Unit>? listUnit,
    List<Activity>? listActivity,
  }) {
    return ActivityState(
      listDiaryActivity: listDiaryActivity ?? this.listDiaryActivity,
      formStatus: formStatus ?? this.formStatus,
      isShowProgress: isShowProgress ?? this.isShowProgress,
      listMaterial: listMaterial ?? this.listMaterial,
      listTool: listTool ?? this.listTool,
      listUnit: listUnit ?? this.listUnit,
      listActivity: listActivity ?? this.listActivity,
    );
  }
}
