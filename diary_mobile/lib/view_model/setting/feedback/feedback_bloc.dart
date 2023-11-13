import 'dart:async';

import 'package:diary_mobile/data/entity/monitor/monitor_diary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/entity/setting/feedback_info.dart';
import '../../../data/repository.dart';
import '../../../utils/status/form_submission_status.dart';
import '../../bloc_event.dart';
import '../../bloc_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final Repository repository;

  FeedbackBloc(this.repository) : super(FeedbackState()) {
    on<GetListFeedbackEvent>(_getListFeedback);
    //add(GetListFeedbackEvent());
  }

  void _getListFeedback(
      GetListFeedbackEvent event, Emitter<FeedbackState> emitter) async {
    emitter(state.copyWith(
        isShowProgress: true,
        formStatus: const InitialFormStatus()));
    List<FeedbackInfo> listFeedback = await repository.getListFeedbackFarmer();
    emitter(state.copyWith(
        isShowProgress: false,
        formStatus: const InitialFormStatus(),
        listFeedback: listFeedback));
  }
}

class FeedbackEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetListFeedbackEvent extends FeedbackEvent {

  GetListFeedbackEvent();

  @override
  List<Object?> get props => [];
}

class FeedbackState extends BlocState {
  @override
  List<Object?> get props => [
    listFeedback,
    formStatus,
    isShowProgress,
  ];
  final List<FeedbackInfo> listFeedback;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;

  FeedbackState({
    this.listFeedback = const [],
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
  });

  FeedbackState copyWith({
    List<FeedbackInfo>? listFeedback,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
  }) {
    return FeedbackState(
      listFeedback: listFeedback ?? this.listFeedback,
        formStatus: formStatus ?? this.formStatus,
        isShowProgress: isShowProgress ?? this.isShowProgress,);
  }
}
