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

class DetailDiaryBloc extends Bloc<DetailDiaryEvent, DetailDiaryState> {
  final Repository repository;

  DetailDiaryBloc(this.repository) : super(DetailDiaryState()) {
    on<GetDetailDiaryEvent>(_getDetailDiary);
  }

  void _getDetailDiary(
      GetDetailDiaryEvent event, Emitter<DetailDiaryState> emitter) async {
    emitter(state.copyWith(isShowProgress: true));
    print("HoangCV: detailDiary: id : ${event.id}");
      final detailDiary = await repository.getInfoDiary(event.id);
      print("HoangCV: detailDiary: ${detailDiary.name} : ${event.id}");
      emitter(state.copyWith(
          isShowProgress: false,
          detailDiary: detailDiary));
  }
}

class DetailDiaryEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetDetailDiaryEvent extends DetailDiaryEvent {
  int id;
  bool updateHarvesting;
  List<ActivityDiary> list;
  List<ActivityTransaction> listTransaction;
  List<ReportResult> listReport;

  GetDetailDiaryEvent(this.id,
      {this.updateHarvesting = false, this.list = const [], this.listTransaction = const [], this.listReport = const []});
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
        listActivity,
        listActivityFarm,
        listActivityDiary,
        listActivityTransaction,
        listReportResult,
    listReportSelect,
      ];
  final Diary? detailDiary;
  final List<MaterialEntity> listMaterial;
  final List<Tool> listTool;
  final List<Unit> listUnit;
  final List<Activity>? listActivity;
  final List<ActivityDiary> listActivityDiary;
  final List<ActivityTransaction> listActivityTransaction;
  final List<ActivityFarm> listActivityFarm;
  final List<ReportResult> listReportResult;
  final List<Report> listReportSelect;
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
    this.listActivityFarm = const [],
    this.listActivityDiary = const [],
    this.listActivityTransaction = const [],
    this.listReportResult = const [],
    this.listReportSelect = const [],
  });

  DetailDiaryState copyWith({
    Diary? detailDiary,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    List<MaterialEntity>? listMaterial,
    List<Tool>? listTool,
    List<Unit>? listUnit,
    List<Activity>? listActivity,
    List<ActivityDiary>? listActivityDiary,
    List<ActivityTransaction>? listActivityTransaction,
    List<ActivityFarm>? listActivityFarm,
    List<ReportResult>? listReportResult,
    List<Report>? listReportSelect,
  }) {
    return DetailDiaryState(
        detailDiary: detailDiary ?? this.detailDiary,
        formStatus: formStatus ?? this.formStatus,
        isShowProgress: isShowProgress ?? this.isShowProgress,
        listMaterial: listMaterial ?? this.listMaterial,
        listTool: listTool ?? this.listTool,
        listUnit: listUnit ?? this.listUnit,
        listActivity: listActivity ?? this.listActivity,
        listActivityFarm: listActivityFarm ?? this.listActivityFarm,
        listActivityTransaction:
            listActivityTransaction ?? this.listActivityTransaction,
        listActivityDiary: listActivityDiary ?? this.listActivityDiary,
        listReportSelect: listReportSelect ?? this.listReportSelect,
        listReportResult: listReportResult ?? this.listReportResult);
  }
}

class ActivityFarm {
  final int id;
  final String nameActivity;
  final String iconActivity;
  final String action;

  ActivityFarm(
      {required this.id,
      required this.nameActivity,
      required this.iconActivity, this.action = ''});
}
