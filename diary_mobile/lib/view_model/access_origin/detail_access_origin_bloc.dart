import 'package:diary_mobile/data/entity/access/product_batch.dart';
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
import '../../data/entity/access/detail_product_batch.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class DetailAccessOriginBloc
    extends Bloc<DetailAccessOriginEvent, DetailAccessOriginState> {
  final Repository repository;

  DetailAccessOriginBloc(this.repository) : super(DetailAccessOriginState()) {
    on<GetDetailAccessOriginEvent>(_getDetailAccessOrigin);
  }

  void _getDetailAccessOrigin(GetDetailAccessOriginEvent event,
      Emitter<DetailAccessOriginState> emitter) async {
    emitter(state.copyWith(isShowProgress: true));

    final detailAccessOrigin = await repository.getDetailProductBatch(event.id);
    print("HoangCV: DetailAccessOrigin: ${detailAccessOrigin.name}");
    emitter(state.copyWith(
        isShowProgress: false, detailAccessOrigin: detailAccessOrigin));
  }
}

class DetailAccessOriginEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetDetailAccessOriginEvent extends DetailAccessOriginEvent {
  int id;
  bool updateHarvesting;
  List<ActivityDiary> list;
  List<ActivityTransaction> listTransaction;
  List<ReportResult> listReport;

  GetDetailAccessOriginEvent(this.id,
      {this.updateHarvesting = false,
      this.list = const [],
      this.listTransaction = const [],
      this.listReport = const []});
}

class UpdateAvatarEvent extends DetailAccessOriginEvent {
  //final ImageSource source;
  UpdateAvatarEvent();
}

class DetailAccessOriginState extends BlocState {
  @override
  List<Object?> get props => [
        detailAccessOrigin,
        formStatus,
        isShowProgress,
      ];
  final DetailProductBatch? detailAccessOrigin;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;

  DetailAccessOriginState({
    this.detailAccessOrigin,
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
  });

  DetailAccessOriginState copyWith({
    DetailProductBatch? detailAccessOrigin,
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
    return DetailAccessOriginState(
      detailAccessOrigin: detailAccessOrigin ?? this.detailAccessOrigin,
      formStatus: formStatus ?? this.formStatus,
      isShowProgress: isShowProgress ?? this.isShowProgress,
    );
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
      required this.iconActivity,
      this.action = ''});
}
