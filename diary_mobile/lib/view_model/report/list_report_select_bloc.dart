import 'dart:async';

import 'package:diary_mobile/data/entity/report/report_result_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository.dart';
import '../../../utils/status/form_submission_status.dart';
import '../../data/entity/report/report.dart';
import '../../data/entity/report/report_select.dart';
import '../../data/remote_data/object_model/object_result.dart';
import '../../utils/constants/status_const.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class ListReportSelectBloc extends Bloc<ListReportSelectEvent, ListReportSelectState> {
  final Repository repository;

  ListReportSelectBloc(this.repository) : super(ListReportSelectState()) {
    on<GetListReportSelectEvent>(_getListReportSelect);
  }

  void _getListReportSelect(
      GetListReportSelectEvent event, Emitter<ListReportSelectState> emitter) async {
    emitter(state.copyWith(
      isShowProgress: false,
      formStatus: const InitialFormStatus(),));
    if(event.checkUpdate){
      final listReportSelect = await repository.getListReportSelect();
      if(listReportSelect.isNotEmpty) {
        emitter(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionSuccess(),
            listReport: listReportSelect));
      }
    }else {
      emitter(state.copyWith(
          isShowProgress: false,
          formStatus: const InitialFormStatus(),
          listReport: event.listSelect));
    }
  }

}

class ListReportSelectEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetListReportSelectEvent extends ListReportSelectEvent {
  final List<ReportSelect> listSelect;
  final bool checkUpdate;

  GetListReportSelectEvent( this.listSelect, {this.checkUpdate = false});

  @override
  List<Object?> get props => [ listSelect, checkUpdate];
}



class ListReportSelectState extends BlocState {
  @override
  List<Object?> get props => [
    listReport,
    formStatus,
    isShowProgress,
  ];
  final List<ReportSelect> listReport;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;


  ListReportSelectState({
    this.listReport = const [],
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,

  });

  ListReportSelectState copyWith({
    List<ReportSelect>? listReport,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
  }) {
    return ListReportSelectState(
      listReport: listReport ?? this.listReport,
      formStatus: formStatus ?? this.formStatus,
      isShowProgress: isShowProgress ?? this.isShowProgress,);
  }
}
