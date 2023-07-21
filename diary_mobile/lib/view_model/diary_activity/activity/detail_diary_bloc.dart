import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/entity/activity/activity_diary.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../data/entity/item_default/material_entity.dart';
import '../../../data/local_data/diary_db.dart';
import '../../../data/repository.dart';
import '../../../utils/form_submission_status.dart';
import '../../bloc_event.dart';
import '../../bloc_state.dart';

class DetailDiaryBloc extends Bloc<DetailDiaryEvent, DetailDiaryState> {
  final Repository repository;

  DetailDiaryBloc(this.repository) : super(DetailDiaryState()) {
    on<GetDetailDiaryEvent>(_getDetailDiary);
    add(GetDetailDiaryEvent());
  }

  void _getDetailDiary(
      GetDetailDiaryEvent event, Emitter<DetailDiaryState> emitter) async {
    emitter(state.copyWith(isShowProgress: true));
    final detailDiary = await repository.getInfoDiary(1);
    print("HoangCV: detailDiary: ${detailDiary.name}");
    //DiaryDB.instance.getListDiary();
    emitter(state.copyWith(
        isShowProgress: false,
        detailDiary: detailDiary
    ));
  }
}

class DetailDiaryEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetDetailDiaryEvent extends DetailDiaryEvent {
  GetDetailDiaryEvent();
}

class UpdateAvatarEvent extends DetailDiaryEvent {
  //final ImageSource source;
  UpdateAvatarEvent();
}

class DetailDiaryState extends BlocState {
  @override
  List<Object?> get props => [
    detailDiary,
    formStatus,
    isShowProgress,
    listMaterial,
    listTool,
    listUnit,
    listActivity
  ];
  final Diary? detailDiary;
  final List<MaterialEntity> listMaterial;
  final List<Tool> listTool;
  final List<Unit> listUnit;
  final List<Activity>? listActivity;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;

  DetailDiaryState({
    this.detailDiary,
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.listMaterial = const [],
    this.listTool = const [],
    this.listUnit = const [],
    this.listActivity = const [],
  });

  DetailDiaryState copyWith({
    Diary? detailDiary,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    List<MaterialEntity>? listMaterial,
    List<Tool>? listTool,
    List<Unit>? listUnit,
    List<Activity>? listActivity,
  }) {
    return DetailDiaryState(
      detailDiary: detailDiary ?? this.detailDiary,
      formStatus: formStatus ?? this.formStatus,
      isShowProgress: isShowProgress ?? this.isShowProgress,
      listMaterial: listMaterial ?? this.listMaterial,
      listTool: listTool ?? this.listTool,
      listUnit: listUnit ?? this.listUnit,
      listActivity: listActivity ?? this.listActivity,
    );
  }
}
