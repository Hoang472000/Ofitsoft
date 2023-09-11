import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/entity/activity/activity_diary.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../data/entity/item_default/material_entity.dart';
import '../../../data/local_data/diary_db.dart';
import '../../../data/repository.dart';
import '../../data/entity/report/report.dart';
import '../../utils/status/form_submission_status.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class AddReportBloc extends Bloc<AddReportEvent, AddReportState> {
  final Repository repository;

  AddReportBloc(this.repository) : super(AddReportState()) {
    on<GetAddReportEvent>(_getAddReport);
  }

  void _getAddReport(
      GetAddReportEvent event, Emitter<AddReportState> emitter) async {
    emitter(state.copyWith(isShowProgress: true));
    final report = await repository.getListActivityReport();
    print("HoangCV: report: result: ${report[0].questionAndPageIds[0].toJson()}");
    report[0].questionAndPageIds[0].questionAndPageIds.forEach((element) {

      print("HoangCV: report: elemetn: ${element.toJson()}");
    });
    emitter(state.copyWith(
      isShowProgress: false,
      detailDiary: event.diary,
      listReport: report,
    ));
  }
}

class AddReportEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetAddReportEvent extends AddReportEvent {
  final Diary diary;

  GetAddReportEvent(this.diary);

  @override
  List<Object?> get props => [diary];
}

class UpdateAvatarEvent extends AddReportEvent {
  //final ImageSource source;
  UpdateAvatarEvent();
}

class AddReportState extends BlocState {
  @override
  List<Object?> get props =>
      [detailDiary, formStatus, isShowProgress, listReport];
  final Diary? detailDiary;
  final List<Report> listReport;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;

  AddReportState({
    this.detailDiary,
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.listReport = const [],
  });

  AddReportState copyWith({
    Diary? detailDiary,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    List<Report>? listReport,
  }) {
    return AddReportState(
      detailDiary: detailDiary ?? this.detailDiary,
      formStatus: formStatus ?? this.formStatus,
      isShowProgress: isShowProgress ?? this.isShowProgress,
      listReport: listReport ?? this.listReport,
    );
  }
}
