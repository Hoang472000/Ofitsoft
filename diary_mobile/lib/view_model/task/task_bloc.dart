
import 'dart:async';

import 'package:diary_mobile/data/entity/notify/notify_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository.dart';
import '../../../utils/status/form_submission_status.dart';
import '../../data/entity/task /task_entity.dart';
import '../../utils/constants/status_const.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/dialog/toast_widget.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final Repository repository;

  TaskBloc(this.repository) : super(TaskState()) {
    on<GetListTaskEvent>(_getlistTask);
    on<EditTaskEvent>(_editNotification);
    on<FilterEvent>(_filter);
    //add(GetListTaskEvent());
  }

  void _getlistTask(
      GetListTaskEvent event, Emitter<TaskState> emitter) async {
    emitter(state.copyWith(
        isShowProgress: true,
        formStatus: const InitialFormStatus()));
    List<TaskEntity> listTask = await repository.getListTaskEntity();

    //print("HoangCV:    listTask.first.isRead: ${    listTask.first.isRead}");
    emitter(state.copyWith(
      isShowProgress: false,
      formStatus: const InitialFormStatus(),
      listTask: listTask,
      listTaskFilter: listTask,
    ));
  }

  Future<FutureOr<void>> _editNotification(EditTaskEvent event, Emitter<TaskState> emit) async {
    final object = await repository.editNotification(event.id);
    if(object.responseCode== StatusConst.code00){
      add(GetListTaskEvent());
    }
  }

  FutureOr<void> _filter(FilterEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(formStatus: const InitialFormStatus()));
    print("HoangCV: filter: ${event.result}");
    var startTime = event.result[0];
    var endTime = event.result[1];
    var filter0 = event.result[2];
    var filter1 = event.result[3];
    List<TaskEntity> listFilter = state.listTaskFilter.map((e) => TaskEntity.copy(e)).toList();
    List<TaskEntity> filteredList = [];
    for (var activity in listFilter) {
      DateTime transactionDate = DateTime.parse(activity.startDate ?? "");
      DateTime transactionDate2 = DateTime.parse(activity.endDate ?? "");
      DateTime transactionDate3 = DateTime.parse(activity.completeDate ?? "");
      bool withinStartTime = startTime.isNotEmpty ? !transactionDate.isBefore(Utils.stringToDate(startTime)) : true;
      bool withinEndTime = endTime.isNotEmpty ? !transactionDate.isAfter(Utils.stringToDateEnd(endTime)) : true;
      bool withinStartTime2 = startTime.isNotEmpty ? !transactionDate2.isBefore(Utils.stringToDate(startTime)) : true;
      bool withinEndTime2 = endTime.isNotEmpty ? !transactionDate2.isAfter(Utils.stringToDateEnd(endTime)) : true;
      bool withinStartTime3 = startTime.isNotEmpty ? !transactionDate3.isBefore(Utils.stringToDate(startTime)) : true;
      bool withinEndTime3 = endTime.isNotEmpty ? !transactionDate3.isAfter(Utils.stringToDateEnd(endTime)) : true;
      if ((withinStartTime && withinEndTime) || (withinStartTime2 && withinEndTime2) ||
          (withinStartTime3 && withinEndTime3)) {
        filteredList.add(activity);
      }
    }
    List<TaskEntity> listFilter0 = [];
    List<TaskEntity> listFilter1 = [];
    if(filter0 != -1) {
      listFilter0.addAll(filteredList.where((
          activity) => activity.activityId == filter0).toList());
    } else{
      listFilter0.addAll(filteredList);
    }
    if(filter1 != -1) {
      String name = listFilter[listFilter.indexWhere((element) =>
      element.id == filter1)].status ?? "";
      listFilter1.addAll(
          listFilter0.where((activity) => activity.status == name).toList());
    } else{
      listFilter1.addAll(listFilter0);
    }
    print("HoangCV: listFilter1: ${listFilter1.length}");

    if(listFilter1.isNotEmpty) {
      emit(state.copyWith(
          isShowProgress: false,
          listTask: listFilter1,));
    }else if(listFilter1.isEmpty) {
      Toast.showLongTop("Không tìm thấy thông tin nhiệm vụ phù hợp.");
      emit(state.copyWith(isShowProgress: false));
    }
  }
}

class TaskEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetListTaskEvent extends TaskEvent {

  GetListTaskEvent();

  @override
  List<Object?> get props => [];
}

class EditTaskEvent extends TaskEvent {

  final int id;

  EditTaskEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class FilterEvent extends TaskEvent {
  final dynamic result;

  FilterEvent(this.result);

  @override
  List<Object?> get props => [result];
}

class TaskState extends BlocState {
  @override
  List<Object?> get props => [
    listTask,
    formStatus,
    isShowProgress,
    listTaskFilter,
  ];
  final List<TaskEntity> listTask;
  final List<TaskEntity> listTaskFilter;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;

  TaskState({
    this.listTask = const [],
    this.listTaskFilter = const [],
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
  });

  TaskState copyWith({
    List<TaskEntity>? listTask,
    List<TaskEntity>? listTaskFilter,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
  }) {
    return TaskState(
      listTask: listTask ?? this.listTask,
      listTaskFilter: listTaskFilter ?? this.listTaskFilter,
      formStatus: formStatus ?? this.formStatus,
      isShowProgress: isShowProgress ?? this.isShowProgress,);
  }
}
