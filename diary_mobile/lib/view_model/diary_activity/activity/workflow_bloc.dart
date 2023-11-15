import 'package:diary_mobile/data/entity/activity/activity_transaction.dart';
import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:diary_mobile/data/entity/report/report_result_title.dart';
import 'package:diary_mobile/data/entity/workflow/workflow.dart';
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

class WorkflowBloc extends Bloc<WorkflowEvent, WorkflowState> {
  final Repository repository;

  WorkflowBloc(this.repository) : super(WorkflowState()) {
    on<GetWorkflowEvent>(_getWorkflow);
  }

  void _getWorkflow(
      GetWorkflowEvent event, Emitter<WorkflowState> emitter) async {
    emitter(state.copyWith(isShowProgress: true));
    final workflow = await DiaryDB.instance.getListWorkflow(event.id);
    print("HoangCV: workflow : ${workflow.first.toJson()}");
    workflow.first.processStageIds.forEach((element) {
      print("HoangCV: processStageIds : ${element.toJson()}");
    });
    emitter(state.copyWith(
      isShowProgress: false,
      workflow: workflow.first,
    ));
  }
}

class WorkflowEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetWorkflowEvent extends WorkflowEvent {
  int id;

  GetWorkflowEvent(this.id);
}

class UpdateAvatarEvent extends WorkflowEvent {
  //final ImageSource source;
  UpdateAvatarEvent();
}

class WorkflowState extends BlocState {
  @override
  List<Object?> get props => [
    workflow,
    formStatus,
    isShowProgress,
  ];
  final Workflow? workflow;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;

  WorkflowState({
    this.workflow,
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
  });

  WorkflowState copyWith({
    Workflow? workflow,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,

  }) {
    return WorkflowState(
        workflow: workflow ?? this.workflow,
        formStatus: formStatus ?? this.formStatus,
        isShowProgress: isShowProgress ?? this.isShowProgress,);
  }
}

