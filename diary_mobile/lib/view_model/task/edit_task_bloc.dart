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

class EditTaskBloc extends Bloc<EditTaskEvent, EditTaskState> {
  final Repository repository;

  EditTaskBloc(this.repository) : super(EditTaskState()) {
    on<GetEditTaskEvent>(_getDetailTask);
    on<UpdateTaskEvent>(_updateActivity);
    on<OnSelectValueEvent>(_onSelectValue);
    on<SaveValueTextFieldEvent>(_saveValueTextField);
  }

  bool edit = false;

  void _getDetailTask(
      GetEditTaskEvent event, Emitter<EditTaskState> emitter) async {
    emitter(state.copyWith(
      isShowProgress: true,
      formStatus: const InitialFormStatus(),
    ));
    List<InputRegisterModel> list = [];
    list.add(InputRegisterModel(
        title: "Kết quả",
        isCompulsory: false,
        maxLengthTextInput: 2000,
        type: TypeInputRegister.TextField,
        typeInput: TextInputType.text,
        controller: state.resultController,
        image: ImageAsset.imageFile));
    list.add(InputRegisterModel<String, DateTime>(
        title: "Thời gian hoàn thành",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        controller: state.completeTimeController,
        image: ImageAsset.imageCalendarBegin,
        icon: Icons.calendar_today));



    emitter(state.copyWith(
        isShowProgress: false,
        taskEntity: event.taskEntity,
        idTask: event.id,
        completeTimeController: TextEditingController(text: DateTime.now().toString().split('.')[0]),
        resultController: TextEditingController(),
        listWidget: list));
  }

  FutureOr<void> _updateActivity(
      UpdateTaskEvent event, Emitter<EditTaskState> emit) async {
    emit(state.copyWith(
        isShowProgress: true, formStatus: const InitialFormStatus()));
    emit(state.copyWith(formStatus: FormSubmitting()));
    print("result: ${state.completeTimeController!.text} : ${state.resultController!.text}");
    ObjectResult objectResult = await repository.editTask(
        Utils.stringToFormattedString(state.completeTimeController!.text),
        Utils.stringToFormattedString(state.resultController!.text),
        state.idTask);
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
      OnSelectValueEvent event, Emitter<EditTaskState> emit) async {
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
          print("Hoang Thafn: ${state.completeTimeController!.text} : ${event.list[event.index].valueSelected}");
        }
      }
    }
  }

  FutureOr<void> _saveValueTextField(
      SaveValueTextFieldEvent event, Emitter<EditTaskState> emit) {
    emit(state.copyWith(formStatus: const InitialFormStatus()));
    if (event.inputRegisterModel.title.compareTo("Kết quả") == 0) {
      event.inputRegisterModel.error = null;
      emit(state.copyWith(
          resultController: TextEditingController(text: event.text)));
      print("ket qua: ${state.resultController!.text} : ${event.text}");
    }
  }
}

class EditTaskEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetEditTaskEvent extends EditTaskEvent {
  int id;
  TaskEntity taskEntity;

  GetEditTaskEvent(this.taskEntity, this.id);

  @override
  List<Object?> get props => [taskEntity, id];
}

class UpdateTaskEvent extends EditTaskEvent {
  String result;
  String date;
  UpdateTaskEvent(this.result, this.date);
  @override
  List<Object?> get props => [result, date];
}

class OnSelectValueEvent extends EditTaskEvent {
  List<InputRegisterModel> list;
  int index;
  BuildContext context;

  OnSelectValueEvent(this.list, this.index, this.context);

  @override
  List<Object?> get props => [list, index, context];
}

class SaveValueTextFieldEvent extends EditTaskEvent {
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

class EditTaskState extends BlocState {
  @override
  List<Object?> get props => [
    taskEntity,
    formStatus,
    isShowProgress,
    idTask,
    seasonFarmIds,
    listWidget,
    resultController,
    completeTimeController
  ];
  final TaskEntity? taskEntity;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;
  final int idTask;
  final String seasonFarmIds;
  List<InputRegisterModel> listWidget;
  TextEditingController? resultController = TextEditingController();
  TextEditingController? completeTimeController = TextEditingController();

  EditTaskState(
      {this.formStatus = const InitialFormStatus(),
        this.isShowProgress = true,
        this.idTask = 0,
        this.taskEntity,
        this.listWidget = const [],
        this.resultController,
        this.completeTimeController,
        this.seasonFarmIds = ""});

  EditTaskState copyWith({
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    int? idTask,
    TaskEntity? taskEntity,
    String? seasonFarmIds,
    List<InputRegisterModel>? listWidget,
    TextEditingController? resultController,
    TextEditingController? completeTimeController,
  }) {
    return EditTaskState(
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
