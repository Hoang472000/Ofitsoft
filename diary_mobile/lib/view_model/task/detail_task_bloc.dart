import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository.dart';
import '../../../utils/status/form_submission_status.dart';
import '../../data/entity/task /task_entity.dart';
import '../../data/remote_data/object_model/object_result.dart';
import '../../resource/assets.dart';
import '../../utils/constants/status_const.dart';
import '../../utils/extenstion/input_register_model.dart';
import '../../utils/extenstion/service_info_extension.dart';
import '../../utils/utils.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class DetailTaskBloc extends Bloc<DetailTaskEvent, DetailTaskState> {
  final Repository repository;

  DetailTaskBloc(this.repository) : super(DetailTaskState()) {
    on<GetDetailTaskEvent>(_getDetailTask);
    on<UpdateTaskEvent>(_updateActivity);
    on<OnSelectValueEvent>(_onSelectValue);
    on<SaveValueTextFieldEvent>(_saveValueTextField);
  }

  bool edit = false;

  void _getDetailTask(
      GetDetailTaskEvent event, Emitter<DetailTaskState> emitter) async {
    emitter(state.copyWith(
      isShowProgress: true,
      formStatus: const InitialFormStatus(),
    ));
    List<InputRegisterModel> list = [];

    TaskEntity taskEntity = await repository.getDetailTask(event.id);
    String seasonFarmIds = "";
    for (int i = 0; i < taskEntity.seasonFarmIds.length; i++) {
      if (i == taskEntity.seasonFarmIds.length - 1) {
        seasonFarmIds += "${taskEntity.seasonFarmIds[i].name}";
      } else {
        seasonFarmIds += "${taskEntity.seasonFarmIds[i].name}" "\n";
      }
    }

    emitter(state.copyWith(
        isShowProgress: false,
        taskEntity: taskEntity,
        idTask: event.id,
        seasonFarmIds: seasonFarmIds,
        listWidget: list));
    if(event.update == true){
      emitter(state.copyWith(
          isShowProgress: false,
          formStatus: SubmissionSuccess()));
    }
  }

  FutureOr<void> _updateActivity(
      UpdateTaskEvent event, Emitter<DetailTaskState> emit) async {
    emit(state.copyWith(
        isShowProgress: true, formStatus: const InitialFormStatus()));
    emit(state.copyWith(formStatus: FormSubmitting()));
    print("");
      ObjectResult objectResult = await repository.editTask(state.completeTimeController!.text, state.resultController!.text, state.idTask);
      if (objectResult.responseCode == StatusConst.code00) {
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionSuccess(success: "Thêm hoạt động thành công.")));
      }else if (objectResult.responseCode == StatusConst.code06) {
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionSuccess(success: "Hoạt động đã được sao lưu. \n Vui lòng truy cập mạng sớm nhất để thêm hoạt động.")));
      } else if (objectResult.responseCode == StatusConst.code01) {
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionFailed(objectResult.message)));
      }
  }

  FutureOr<void> _onSelectValue(
      OnSelectValueEvent event, Emitter<DetailTaskState> emit) async {
    emit(state.copyWith(
      isShowProgress: false,
      formStatus: const InitialFormStatus(),
    ));
    if (event.list[event.index].valueSelected.runtimeType == DateTime ||
        event.list[event.index].typeInputEnum == TypeInputEnum.date) {
      //     setState(() {
      int result1 = await ServiceInfoExtension()
          .selectValue(event.list[event.index], event.context, (modelInput) {});
      if (result1 == 1) {
        if (event.list[event.index].title.compareTo("Thời gian hoàn thành") ==
            0) {
          emit(state.copyWith(
            completeTimeController: TextEditingController(
                text: Utils.formatDateTimeToString(
                    event.list[event.index].valueSelected)),
          ));
        }
      }
    }
  }

  FutureOr<void> _saveValueTextField(
      SaveValueTextFieldEvent event, Emitter<DetailTaskState> emit) {
    emit(state.copyWith(formStatus: const InitialFormStatus()));
    if (event.inputRegisterModel.title.compareTo("Kết quả") == 0) {
      event.inputRegisterModel.error = null;
      emit(state.copyWith(
          resultController: TextEditingController(text: event.text)));
    }
  }
}

class DetailTaskEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetDetailTaskEvent extends DetailTaskEvent {
  int id;
  TaskEntity taskEntity;
  bool update;

  GetDetailTaskEvent(this.taskEntity, this.id, {this.update = false});

  @override
  List<Object?> get props => [taskEntity, id, update];
}

class UpdateTaskEvent extends DetailTaskEvent {
  UpdateTaskEvent();
}

class OnSelectValueEvent extends DetailTaskEvent {
  List<InputRegisterModel> list;
  int index;
  BuildContext context;

  OnSelectValueEvent(this.list, this.index, this.context);

  @override
  List<Object?> get props => [list, index, context];
}

class SaveValueTextFieldEvent extends DetailTaskEvent {
  final InputRegisterModel inputRegisterModel;
  final String text;
  final int index;

  SaveValueTextFieldEvent(
    this.text,
    this.inputRegisterModel,
    this.index,
  );

  @override
  List<Object?> get props => [
        inputRegisterModel,
        index,
      ];
}

class DetailTaskState extends BlocState {
  @override
  List<Object?> get props => [
        taskEntity,
        formStatus,
        isShowProgress,
        idTask,
        seasonFarmIds,
        listWidget
      ];
  final TaskEntity? taskEntity;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;
  final int idTask;
  final String seasonFarmIds;
  List<InputRegisterModel> listWidget;
  TextEditingController? resultController = TextEditingController();
  TextEditingController? completeTimeController = TextEditingController();

  DetailTaskState(
      {this.formStatus = const InitialFormStatus(),
      this.isShowProgress = true,
      this.idTask = 0,
      this.taskEntity,
      this.listWidget = const [],
      this.resultController,
      this.completeTimeController,
      this.seasonFarmIds = ""});

  DetailTaskState copyWith({
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    int? idTask,
    TaskEntity? taskEntity,
    String? seasonFarmIds,
    List<InputRegisterModel>? listWidget,
    TextEditingController? resultController,
    TextEditingController? completeTimeController,
  }) {
    return DetailTaskState(
      formStatus: formStatus ?? this.formStatus,
      isShowProgress: isShowProgress ?? this.isShowProgress,
      idTask: idTask ?? this.idTask,
      taskEntity: taskEntity ?? this.taskEntity,
      seasonFarmIds: seasonFarmIds ?? this.seasonFarmIds,
      listWidget: listWidget ?? this.listWidget,
      resultController: resultController ?? this.resultController,
      completeTimeController:
          completeTimeController ?? this.completeTimeController,
    );
  }
}
