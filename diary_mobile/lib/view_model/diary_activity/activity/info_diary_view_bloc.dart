import 'package:diary_mobile/data/entity/activity/activity_transaction.dart';
import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:diary_mobile/data/entity/report/report_result_title.dart';
import 'package:diary_mobile/generated/l10n.dart';
import 'package:diary_mobile/resource/assets.dart';
import 'package:diary_mobile/utils/constants/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/entity/activity/activity_diary.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../data/entity/item_default/material_entity.dart';
import '../../../data/entity/report/report.dart';
import '../../../data/local_data/diary_db.dart';
import '../../../data/repository.dart';
import '../../../utils/constants/shared_preferences_key.dart';
import '../../../utils/status/form_submission_status.dart';
import '../../bloc_event.dart';
import '../../bloc_state.dart';

class InfoDiaryViewBloc extends Bloc<InfoDiaryViewEvent, InfoDiaryViewState> {
  final Repository repository;

  InfoDiaryViewBloc(this.repository) : super(InfoDiaryViewState()) {
    on<GetInfoDiaryViewEvent>(_getInfoDiaryView);
  }

  void _getInfoDiaryView(
      GetInfoDiaryViewEvent event, Emitter<InfoDiaryViewState> emitter) async {
    emitter(state.copyWith(isShowProgress: true));
    final listActivity = await repository.getListActivityDiary(event.id);
      emitter(state.copyWith(
        isShowProgress: false,
          listActivity: listActivity,));
  }
}

class InfoDiaryViewEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetInfoDiaryViewEvent extends InfoDiaryViewEvent {
  int id;

  GetInfoDiaryViewEvent(this.id,);
}

class UpdateAvatarEvent extends InfoDiaryViewEvent {
  //final ImageSource source;
  UpdateAvatarEvent();
}

class InfoDiaryViewState extends BlocState {
  @override
  List<Object?> get props => [
    formStatus,
    isShowProgress,
    listActivity,
  ];
  
  final List<ActivityDiary>? listActivity;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;

  InfoDiaryViewState({
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.listActivity = const [],
  });

  InfoDiaryViewState copyWith({
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    List<ActivityDiary>? listActivity,
  }) {
    return InfoDiaryViewState(
        formStatus: formStatus ?? this.formStatus,
        isShowProgress: isShowProgress ?? this.isShowProgress,
        listActivity: listActivity ?? this.listActivity,);
  }
}

