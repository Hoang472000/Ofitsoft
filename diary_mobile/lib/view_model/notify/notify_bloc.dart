
import 'dart:async';

import 'package:diary_mobile/data/entity/notify/notify_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository.dart';
import '../../../utils/status/form_submission_status.dart';
import '../../utils/constants/status_const.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class NotifyBloc extends Bloc<NotifyEvent, NotifyState> {
  final Repository repository;

  NotifyBloc(this.repository) : super(NotifyState()) {
    on<GetListNotifyEvent>(_getListNotify);
    on<EditNotificationEvent>(_editNotification);
    //add(GetListNotifyEvent());
  }

  void _getListNotify(
      GetListNotifyEvent event, Emitter<NotifyState> emitter) async {
    emitter(state.copyWith(
        isShowProgress: true,
        formStatus: const InitialFormStatus()));
    List<NotifyEntity> listNotify = await repository.getListNotify();

    //print("HoangCV:    listNotify.first.isRead: ${    listNotify.first.isRead}");
    emitter(state.copyWith(
        isShowProgress: false,
        formStatus: const InitialFormStatus(),
        listNotify: listNotify));
  }

  Future<FutureOr<void>> _editNotification(EditNotificationEvent event, Emitter<NotifyState> emit) async {
    final object = await repository.editNotification(event.id);
    if(object.responseCode== StatusConst.code00){
      add(GetListNotifyEvent());
    }
  }
}

class NotifyEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetListNotifyEvent extends NotifyEvent {

  GetListNotifyEvent();

  @override
  List<Object?> get props => [];
}

class EditNotificationEvent extends NotifyEvent {

  final int id;

  EditNotificationEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class NotifyState extends BlocState {
  @override
  List<Object?> get props => [
    listNotify,
    formStatus,
    isShowProgress,
  ];
  final List<NotifyEntity> listNotify;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;

  NotifyState({
    this.listNotify = const [],
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
  });

  NotifyState copyWith({
    List<NotifyEntity>? listNotify,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
  }) {
    return NotifyState(
      listNotify: listNotify ?? this.listNotify,
      formStatus: formStatus ?? this.formStatus,
      isShowProgress: isShowProgress ?? this.isShowProgress,);
  }
}
