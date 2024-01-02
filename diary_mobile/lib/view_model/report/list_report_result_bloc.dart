import 'dart:async';

import 'package:diary_mobile/data/entity/report/report_result_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository.dart';
import '../../../utils/status/form_submission_status.dart';
import '../../data/entity/report/report.dart';
import '../../data/entity/report/report_select.dart';
import '../../data/remote_data/object_model/object_result.dart';
import '../../utils/constants/status_const.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/dialog/toast_widget.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class ListReportResultBloc extends Bloc<ListReportResultEvent, ListReportResultState> {
  final Repository repository;

  ListReportResultBloc(this.repository) : super(ListReportResultState()) {
    on<GetListReportResultEvent>(_getListReportResult);
    on<DeleteReportResultEvent>(_deleteReportResult);
    on<UpdateRadioButtonEvent>(_updateRadioButton);
    on<FilterEvent>(_filter);
  }

  void _getListReportResult(
      GetListReportResultEvent event, Emitter<ListReportResultState> emitter) async {
    emitter(state.copyWith(
        isShowProgress: true,
        formStatus: const InitialFormStatus(),));
    if(event.checkUpdate){
      final listReportResult = await repository.getListReportResult();
      final listReportResultCopy = listReportResult
          .map((report) => ReportResult.copy(report))
          .toList();
      listReportResultCopy.removeWhere((element) =>
      element.isInitialAssessment == true);
      if(listReportResult.isNotEmpty) {
        emitter(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionSuccess(),
            listReportFilter: listReportResult,
            listReport: listReportResultCopy, reportEnum: ReportEnum.report));
      }
    }else {
      final listReportResult = await repository.getListReportResult();
      final listSelect = await repository.getListReportSelect();
      final listReportResultCopy = listReportResult
          .map((report) => ReportResult.copy(report))
          .toList();
      listReportResultCopy.removeWhere((element) =>
      element.isInitialAssessment == true);
      emitter(state.copyWith(
          isShowProgress: false,
          formStatus: const InitialFormStatus(),
          listReport: listReportResultCopy,
          listReportSelect: listSelect,
          listReportFilter: listReportResult,
          reportEnum: ReportEnum.report));
    }
  }


  Future<FutureOr<void>> _deleteReportResult(DeleteReportResultEvent event, Emitter<ListReportResultState> emit) async {
    emit(state.copyWith(
        isShowProgress: true, formStatus: const InitialFormStatus()));

    ObjectResult result = await repository.deleteReport(event.id);

    if (result.responseCode == StatusConst.code00) {
      final listReportResult = await repository.getListReportResult();
      final listReportResultCopy = listReportResult
          .map((report) => ReportResult.copy(report))
          .toList();
      listReportResultCopy.removeWhere((element) =>
      element.isInitialAssessment == true);
      emit(state.copyWith(
          isShowProgress: false,
          formStatus: SubmissionSuccess(success: "Xóa báo cáo khảo sát thành công."),
          listReport: listReportResultCopy,
          listReportFilter: listReportResult));
    } else {
      emit(state.copyWith(
          isShowProgress: false, formStatus: SubmissionFailed(result.message)));
    }
  }

  FutureOr<void> _updateRadioButton(UpdateRadioButtonEvent event, Emitter<ListReportResultState> emit) {
    final listReportResult = state.listReportFilter
        .map((report) => ReportResult.copy(report))
        .toList();
    if(event.reportEnum == ReportEnum.report) {
      listReportResult.removeWhere((element) =>
      element.isInitialAssessment == true);
    } else{
      listReportResult.removeWhere((element) =>
      element.isInitialAssessment == false);
    }
    emit(state.copyWith(
        isShowProgress: false,
        formStatus: const InitialFormStatus(),
        listReport: listReportResult,
        reportEnum: event.reportEnum));
  }

  FutureOr<void> _filter(FilterEvent event, Emitter<ListReportResultState> emit) {
    print("HoangCV: filter: ${event.result}");
    var startTime = event.result[0]/*.replaceAll("/","-")*/;
    var endTime = event.result[1]/*.replaceAll("/","-")*/;
    var filter0 = event.result[2];
    var filter1 = event.result[3];
    var filter2 = event.result[4];
    var filter3 = event.result[5];
    List<ReportResult> list = state.listReportFilter.map((e) => ReportResult.copy(e)).toList();
    //print("HoangCV: filter: ${minPrice} : ${maxPrice}");
    List<ReportResult> filteredList = [];
    for (var activity in list) {
      DateTime transactionDate = DateTime.parse(activity.createDate ?? "");
      bool withinStartTime = startTime.isNotEmpty ? !transactionDate.isBefore(Utils.stringToDate(startTime)) : true;
      bool withinEndTime = endTime.isNotEmpty ? !transactionDate.isAfter(Utils.stringToDateEnd(endTime)) : true;

      if (withinStartTime && withinEndTime) {
        filteredList.add(activity);
      }
    }
    List<ReportResult> listFilter0 = [];
    List<ReportResult> listFilter1 = [];
    List<ReportResult> listFilter2 = [];
    List<ReportResult> listFilter3 = [];
    if(filter0 != -1) {
      //filteredList.indexWhere((element) => element.id == filter0);
      String name = filteredList[filteredList.indexWhere((element) => element.id == filter0)].surveyId ?? "";
      listFilter0.addAll(filteredList.where((
          activity) => activity.surveyId == name).toList());
    } else{
      listFilter0.addAll(filteredList);
    }
    if(filter1 != -1) {
      listFilter1.addAll(listFilter0.where((
          activity) => activity.internalInspectorId == filter1).toList());
    } else{
      listFilter1.addAll(listFilter0);
    }
    if(filter2 != -1) {
      listFilter2.addAll(listFilter1.where((
          activity) => activity.farmerId == filter2).toList());
    } else{
      listFilter2.addAll(listFilter1);
    }
    if(filter3 != -1) {
      String name = filteredList[filteredList.indexWhere((element) => element.id == filter3)].state ?? "";
      listFilter3.addAll(listFilter2.where((
          activity) => activity.state == name).toList());
    } else{
      listFilter3.addAll(listFilter2);
    }
    print("HoangCV: ");
    if(listFilter3.length > 0) {
      emit(state.copyWith(
          isShowProgress: false,
          listReport: listFilter3
      ));
    } else {
      Toast.showLongTop("Không tìm thấy thông tin báo cáo phù hợp.");
      emit(state.copyWith(
          isShowProgress: false,
      ));
    }
  }
}

class ListReportResultEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetListReportResultEvent extends ListReportResultEvent {
  final bool checkUpdate;

  GetListReportResultEvent({this.checkUpdate = false});

  @override
  List<Object?> get props => [checkUpdate];
}

class DeleteReportResultEvent extends ListReportResultEvent {
  final int id;

  DeleteReportResultEvent(this.id);

  @override
  List<Object?> get props => [];
}

class UpdateRadioButtonEvent extends ListReportResultEvent {
  final ReportEnum reportEnum;

  UpdateRadioButtonEvent(this.reportEnum);

  @override
  List<Object?> get props => [reportEnum];
}

class FilterEvent extends ListReportResultEvent {
  final dynamic result;

  FilterEvent(this.result);

  @override
  List<Object?> get props => [result];
}

class ListReportResultState extends BlocState {
  @override
  List<Object?> get props => [
    listReport,
    formStatus,
    isShowProgress,
    listReportSelect,
    reportEnum,
  ];
  final List<ReportResult> listReport;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;
  final List<ReportSelect> listReportSelect;
  final List<ReportResult> listReportFilter;
  ReportEnum reportEnum;


  ListReportResultState({
    this.listReport = const [],
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.listReportSelect = const [],
    this.listReportFilter = const [],
    this.reportEnum = ReportEnum.report,
  });

  ListReportResultState copyWith({
    List<ReportResult>? listReport,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    List<ReportSelect>? listReportSelect,
    List<ReportResult>? listReportFilter,
    ReportEnum? reportEnum,
  }) {
    return ListReportResultState(
      listReport: listReport ?? this.listReport,
        formStatus: formStatus ?? this.formStatus,
        isShowProgress: isShowProgress ?? this.isShowProgress,
        listReportSelect: listReportSelect ?? this.listReportSelect,
        listReportFilter: listReportFilter ?? this.listReportFilter,
        reportEnum: reportEnum ?? this.reportEnum,
    );
  }
}

enum ReportEnum { report, survey }
