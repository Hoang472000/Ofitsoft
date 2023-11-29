import 'dart:async';

import 'package:diary_mobile/data/entity/access/product_batch.dart';
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

class AccessOriginBloc extends Bloc<AccessOriginEvent, AccessOriginState> {
  final Repository repository;

  AccessOriginBloc(this.repository) : super(AccessOriginState()) {
    on<GetAccessOriginEvent>(_getAccessOrigin);
  }

  void _getAccessOrigin(
      GetAccessOriginEvent event, Emitter<AccessOriginState> emitter) async {
    emitter(state.copyWith(
      isShowProgress: true,
      formStatus: const InitialFormStatus(),
    ));
    final accessOrigin = await repository.getListProductBatch();
    emitter(state.copyWith(
        isShowProgress: false,
        formStatus: SubmissionSuccess(),
        listAccessOrigin: accessOrigin));
  }
}

class AccessOriginEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetAccessOriginEvent extends AccessOriginEvent {

  GetAccessOriginEvent();

  @override
  List<Object?> get props => [];
}

class AccessOriginState extends BlocState {
  @override
  List<Object?> get props => [
    listAccessOrigin,
    formStatus,
    isShowProgress,
  ];
  final List<ProductBatch> listAccessOrigin;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;


  AccessOriginState({
    this.listAccessOrigin = const [],
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,

  });

  AccessOriginState copyWith({
    List<ProductBatch>? listAccessOrigin,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
  }) {
    return AccessOriginState(
        listAccessOrigin: listAccessOrigin ?? this.listAccessOrigin,
        formStatus: formStatus ?? this.formStatus,
        isShowProgress: isShowProgress ?? this.isShowProgress,);
  }
}
