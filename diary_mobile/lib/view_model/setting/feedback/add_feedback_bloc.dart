import 'dart:async';
import 'package:diary_mobile/data/entity/setting/feedback_info.dart';
import 'package:diary_mobile/data/remote_data/object_model/object_result.dart';
import 'package:diary_mobile/utils/constants/status_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/entity/image/image_entity.dart';
import '../../../data/repository.dart';
import '../../../resource/assets.dart';
import '../../../utils/constants/shared_preferences_key.dart';
import '../../../utils/extenstion/input_register_model.dart';
import '../../../utils/extenstion/service_info_extension.dart';
import '../../../utils/status/form_submission_status.dart';
import '../../../utils/utils.dart';
import '../../bloc_event.dart';
import '../../bloc_state.dart';

class AddFeedbackBloc extends Bloc<AddFeedbackEvent, AddFeedbackState> {
  final Repository repository;

  AddFeedbackBloc(this.repository) : super(AddFeedbackState()) {
    on<InitAddFeedbackEvent>(_initAddFeedback);
    on<OnSelectValueEvent>(_onSelectValue);
    on<AddOrDeleteImageEvent>(_addOrDeleteImage);
    on<AddFeedbackDiaryEvent>(_addFeedbackDiary);
    on<SaveValueTextFieldEvent>(_saveValueTextField);
    // add(InitAddFeedbackEvent());
  }

  bool edit = false;

  void _initViewAdd(Emitter<AddFeedbackState> emitter) {
    List<InputRegisterModel> list = [];

    list.add(InputRegisterModel(
        title: "Tiêu đề:",
        isCompulsory: true,
        maxLengthTextInput: 2000,
        type: TypeInputRegister.TextField,
        typeInput: TextInputType.text,
        controller: state.titleController,
        //image: ImageAsset.imageFile
    ));

    list.add(InputRegisterModel(
        title: "Ý kiến:",
        isCompulsory: true,
        maxLengthTextInput: 10000,
        type: TypeInputRegister.TextField,
        typeInput: TextInputType.text,
        controller: state.moTaController,
        image: ImageAsset.imageFile));

    list.add(InputRegisterModel<String, DateTime>(
        title: "Thời gian:",
        isCompulsory: false,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        valueSelected: DateTime.now(),
        controller: state.startTimeController,
        //image: ImageAsset.imageCalendarBegin,
        icon: Icons.calendar_today));

    emitter(state.copyWith(
        listWidget: list,
        formStatus: const InitialFormStatus()));
  }

  void _initAddFeedback(
      InitAddFeedbackEvent event, Emitter<AddFeedbackState> emitter) async {
    emitter(state.copyWith(
        isShowProgress: true,
        listWidget: [],));

    emitter(state.copyWith(
      isShowProgress: false,
      formStatus: const InitialFormStatus(),
      startTimeController:
      TextEditingController(text: DateTime.now().toString().split('.')[0]),
      moTaController: TextEditingController(),
      titleController: TextEditingController(),
    ));
    _initViewAdd(emitter);
  }

  Future<FutureOr<void>> _onSelectValue(OnSelectValueEvent event,
      Emitter<AddFeedbackState> emit) async {
    emit(state.copyWith(formStatus: const InitialFormStatus()));
    if (event.list[event.index].valueSelected.runtimeType == DateTime ||
        event.list[event.index].typeInputEnum == TypeInputEnum.date) {
      print(
          "HoangCV: event.list[event.index].valueSelected: ${Utils
              .formatDateTimeToString(
              event.list[event.index].valueSelected)} :");
      int result1 = await ServiceInfoExtension()
          .selectValue(
          event.list[event.index], event.context, (modelInput) {});
      print(
          "HoangCV: result1: ${result1} : ${Utils.formatDateTimeToString(
              event.list[event.index].valueSelected)}");
      if (result1 == 1) {
        if (event.list[event.index].title.compareTo("Thời gian:") ==
            0) {
          print(
              "HoangCV:1 event.list[event.index].valueSelected: ${Utils
                  .formatDateTimeToString(
                  event.list[event.index].valueSelected)}");
          emit(state.copyWith(
            startTimeController: TextEditingController(
                text: Utils.formatDateTimeToString(
                    event.list[event.index].valueSelected)),
          ));
        }
      }
    }
  }

  FutureOr<void> _addOrDeleteImage(
      AddOrDeleteImageEvent event, Emitter<AddFeedbackState> emit) async {
    print("HoangCV: event. image: ${event.listImage.length}");
    List<ImageEntity> list = List.from(state.listImage);
    event.listImage.forEach((element) {
      print("HoangCV: event. fileContent: ${element.fileName} : ${element.filePath}");
    });
    if (event.index == -1) {
      list.addAll(event.listImage);
    } else {
      list.removeAt(event.index);
    }
    double imageWidth = state.imageWidth;
    double imageHeight = state.imageHeight;
    if (list.length < 2) {
      // Tính toán kích thước ảnh để hiển thị full màn hình
      imageWidth = 360;
      imageHeight = 240;
    } else if (list.length < 3) {
      // Tính toán kích thước ảnh để hiển thị full màn hình
      imageWidth = 180;
      imageHeight = 130;
    } else {
      imageWidth = 140;
      imageHeight = 100;
    }
    emit(state.copyWith(
        listImage: list,
        imageWidth: imageWidth,
        imageHeight: imageHeight,
        formStatus: const InitialFormStatus()));
  }

  FutureOr<void> _addFeedbackDiary(
      AddFeedbackDiaryEvent event, Emitter<AddFeedbackState> emit) async {
    emit(state.copyWith(
        isShowProgress: true, formStatus: const InitialFormStatus()));
    state.listWidget[0].error = null;
    state.listWidget[1].error = null;
    List<InputRegisterModel> list = List.from(state.listWidget);
    bool validate = true;
    print("HOangCV: bugL state.titleController!.text: ${state.titleController!.text}");
    if (state.titleController!.text.isEmpty) {
      validate = false;
      state.listWidget[0].error = "Vui lòng nhập tiêu đề phản hồi";
    } else if (state.moTaController!.text.isEmpty) {
      validate = false;
      state.listWidget[1].error = "Vui lòng nhập nội dung";
    }

    if (!validate) {
      emit(state.copyWith(isShowProgress: false));
    } else {
      emit(state.copyWith(isShowProgress: false, formStatus: FormSubmitting()));
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      int? userId = sharedPreferences.getInt(SharedPreferencesKey.userId);
      FeedbackInfo diary = FeedbackInfo(
        farmerId: userId,
        title: state.titleController!.text,
        description: state.moTaController!.text,
        images: state.listImage,
      );
      //"is_shown": true,
      ObjectResult objectResult = await repository.addFarmerFeedback(diary);
      if (objectResult.responseCode == StatusConst.code00) {
        //_changeViewEdit(emit);
      }
      if (objectResult.responseCode == StatusConst.code00) {
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionSuccess(success: "Gửi phản hồi thành công.")));
      }/*else if (objectResult.responseCode == StatusConst.code06) {
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionSuccess(success: "Hoạt động đã được sao lưu. \n Vui lòng truy cập mạng sớm nhất để thêm hoạt động.")));
      }*/ else if (objectResult.responseCode != StatusConst.code01) {
        //_changeViewEdit(emit);
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionFailed(objectResult.message)));
      } else{
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: const InitialFormStatus()));
      }
    }
  }

  FutureOr<void> _saveValueTextField(
      SaveValueTextFieldEvent event, Emitter<AddFeedbackState> emit) {
    print("HoangCV: bug: ${event.text} : ${event.inputRegisterModel.title}");
    if (event.inputRegisterModel.title.compareTo("Ý kiến:") == 0) {
      emit(state.copyWith(
          moTaController: TextEditingController(text: event.text)));
    }
    if (event.inputRegisterModel.title.compareTo("Tiêu đề:") == 0) {
      emit(state.copyWith(
          titleController: TextEditingController(text: event.text)));
    }
  }
}

class AddFeedbackEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class InitAddFeedbackEvent extends AddFeedbackEvent {

  InitAddFeedbackEvent();

  @override
  List<Object?> get props => [];
}

class ChangeEditFeedbackEvent extends AddFeedbackEvent {
  ChangeEditFeedbackEvent();
}


class OnSelectValueEvent extends AddFeedbackEvent {
  List<InputRegisterModel> list;
  int index;
  BuildContext context;

  OnSelectValueEvent(this.list, this.index, this.context);

  @override
  List<Object?> get props => [list, index, context];
}

class AddOrDeleteImageEvent extends AddFeedbackEvent {
  final List<ImageEntity> listImage;
  final int index;
  final BuildContext context;

  AddOrDeleteImageEvent(
      this.listImage,
      this.index,
      this.context,
      );

  @override
  List<Object?> get props => [
    listImage,
    index,
    context,
  ];
}

class SaveValueTextFieldEvent extends AddFeedbackEvent {
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

class AddFeedbackDiaryEvent extends AddFeedbackEvent {
  AddFeedbackDiaryEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAvatarEvent extends AddFeedbackEvent {
  //final ImageSource source;
  UpdateAvatarEvent();
}

class AddFeedbackState extends BlocState {
  @override
  List<Object?> get props => [
    formStatus,
    isShowProgress,
    listFeedback,
    listWidget,
    listImage,
    moTaController,
    titleController,
    startTimeController,
    isEdit,
  ];
  final List<Feedback> listFeedback;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;
  final List<InputRegisterModel> listWidget;
  List<ImageEntity> listImage = [];
  final int seasonId;
  TextEditingController? moTaController = TextEditingController();
  TextEditingController? startTimeController = TextEditingController();
  TextEditingController? titleController = TextEditingController();
  bool isEdit;
  final int indexFeedback;
  final int indexArea;
  double imageWidth;
  double imageHeight;
  final double areaMax;

  AddFeedbackState({
    this.seasonId = -1,
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.listFeedback = const [],
    this.listWidget = const [],
    this.listImage = const [],
    this.moTaController,
    this.titleController,
    this.startTimeController,
    this.isEdit = false,
    this.imageWidth = 130,
    this.imageHeight = 100,
    this.indexFeedback = -1,
    this.indexArea = -1,
    this.areaMax = 0,
  });

  AddFeedbackState copyWith({
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    List<Feedback>? listFeedback,
    List<InputRegisterModel>? listWidget,
    List<ImageEntity>? listImage,
    TextEditingController? moTaController,
    TextEditingController? titleController,
    TextEditingController? startTimeController,
    bool? isEdit,
    int? indexFeedback,
    int? indexArea,
    double? imageWidth,
    double? imageHeight,
    double? areaMax,
  }) {
    return AddFeedbackState(
      formStatus: formStatus ?? this.formStatus,
      isShowProgress: isShowProgress ?? this.isShowProgress,
      listFeedback: listFeedback ?? this.listFeedback,
      listWidget: listWidget ?? this.listWidget,
      listImage: listImage ?? this.listImage,
      moTaController: moTaController ?? this.moTaController,
      titleController: titleController ?? this.titleController,
      startTimeController: startTimeController ?? this.startTimeController,
      isEdit: isEdit ?? this.isEdit,
      imageWidth: imageWidth ?? this.imageWidth,
      imageHeight: imageHeight ?? this.imageHeight,
      indexFeedback: indexFeedback ?? this.indexFeedback,
      areaMax: areaMax ?? this.areaMax,
    );
  }
}
