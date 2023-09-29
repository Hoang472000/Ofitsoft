import 'dart:async';

import 'package:diary_mobile/data/entity/report/report_result_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository.dart';
import '../../../utils/status/form_submission_status.dart';
import '../../data/entity/report/report.dart';
import '../../data/remote_data/object_model/object_result.dart';
import '../../utils/constants/status_const.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class ListReportResultBloc extends Bloc<ListReportResultEvent, ListReportResultState> {
  final Repository repository;

  ListReportResultBloc(this.repository) : super(ListReportResultState()) {
    on<GetListReportResultEvent>(_getListReportResult);
    on<DeleteReportResultEvent>(_deleteReportResult);
  }

  void _getListReportResult(
      GetListReportResultEvent event, Emitter<ListReportResultState> emitter) async {
    emitter(state.copyWith(
        isShowProgress: true,
        formStatus: const InitialFormStatus(),));
    if(event.checkUpdate){
      final listReportResult = await repository.getListReportResult();
      if(listReportResult.isNotEmpty) {
        emitter(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionSuccess(),
            listReport: listReportResult));
      }
    }else {
      emitter(state.copyWith(
          isShowProgress: false,
          formStatus: const InitialFormStatus(),
          listReport: event.list));
    }
  }


  Future<FutureOr<void>> _deleteReportResult(DeleteReportResultEvent event, Emitter<ListReportResultState> emit) async {
    emit(state.copyWith(
        isShowProgress: true, formStatus: const InitialFormStatus()));

    ObjectResult result = await repository.deleteReport(event.id);

    if (result.responseCode == StatusConst.code00) {
      final listReportResult = await repository.getListReportResult();
      emit(state.copyWith(
          isShowProgress: false,
          formStatus: SubmissionSuccess(success: result.message),
          listReport: listReportResult));
    } else {
      emit(state.copyWith(
          isShowProgress: false, formStatus: SubmissionFailed(result.message)));
    }
  }
}

class ListReportResultEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetListReportResultEvent extends ListReportResultEvent {
  final List<ReportResult> list;
  final List<Report> listSelect;
  final bool checkUpdate;

  GetListReportResultEvent(this.list, this.listSelect, {this.checkUpdate = false});

  @override
  List<Object?> get props => [list, listSelect, checkUpdate];
}

class DeleteReportResultEvent extends ListReportResultEvent {
  final int id;

  DeleteReportResultEvent(this.id);

  @override
  List<Object?> get props => [];
}

class ListReportResultState extends BlocState {
  @override
  List<Object?> get props => [
    listReport,
    formStatus,
    isShowProgress,
  ];
  final List<ReportResult> listReport;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;


  ListReportResultState({
    this.listReport = const [],
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,

  });

  ListReportResultState copyWith({
    List<ReportResult>? listReport,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
  }) {
    return ListReportResultState(
      listReport: listReport ?? this.listReport,
        formStatus: formStatus ?? this.formStatus,
        isShowProgress: isShowProgress ?? this.isShowProgress,);
  }
}
