import 'dart:async';
import 'package:diary_mobile/data/entity/setting/feedback_info.dart';
import 'package:diary_mobile/data/entity/setting/reply_entity.dart';
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

class DetailFeedbackBloc extends Bloc<DetailFeedbackEvent, DetailFeedbackState> {
  final Repository repository;

  DetailFeedbackBloc(this.repository) : super(DetailFeedbackState()) {
    on<InitDetailFeedbackEvent>(_initDetailFeedback);
    on<GetDetailFeedbackEvent>(_getDetailFeedback);
    on<OnSelectValueEvent>(_onSelectValue);
    on<AddOrDeleteImageEvent>(_addOrDeleteImage);
    on<DetailFeedbackDiaryEvent>(_DetailFeedbackDiary);
    on<SaveValueTextFieldEvent>(_saveValueTextField);
    on<AddReplyEvent>(_addReply);
    on<SaveReplyEvent>(_saveReply);
    // add(InitDetailFeedbackEvent());
  }

  bool edit = false;

  void _initViewAdd(Emitter<DetailFeedbackState> emitter) {
    List<InputRegisterModel> list = [];

    list.add(InputRegisterModel(
      title: "Tiêu đề:",
      isCompulsory: true,
      maxLengthTextInput: 2000,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.text,
      controller: state.titleController,
      //image: ImageAsset.imageFile
    ));

    list.add(InputRegisterModel(
        title: "Ý kiến:",
        isCompulsory: true,
        maxLengthTextInput: 10000,
        type: TypeInputRegister.Non,
        typeInput: TextInputType.text,
        controller: state.moTaController,
        image: ImageAsset.imageFile));

    list.add(InputRegisterModel<String, DateTime>(
        title: "Thời gian:",
        isCompulsory: false,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Non,
        valueSelected: DateTime.now(),
        controller: state.startTimeController,
        //image: ImageAsset.imageCalendarBegin,
        icon: Icons.calendar_today));

    emitter(state.copyWith(
        listWidget: list,
        formStatus: const InitialFormStatus()));
  }

  void _initDetailFeedback(
      InitDetailFeedbackEvent event, Emitter<DetailFeedbackState> emitter) async {
    emitter(state.copyWith(
      isShowProgress: true,
      listWidget: [],));

    FeedbackInfo feedbackInfo = await repository.getDetailFeedbackFarmer(event.id);
    final sharedPreferences = await SharedPreferences.getInstance();
    int userId =
        sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    double imageWidth = state.imageWidth;
    double imageHeight = state.imageHeight;
    if (feedbackInfo.images.length < 2) {
      // Tính toán kích thước ảnh để hiển thị full màn hình
      imageWidth = 360;
      imageHeight = 240;
    } else if (feedbackInfo.images.length < 3) {
      // Tính toán kích thước ảnh để hiển thị full màn hình
      imageWidth = 180;
      imageHeight = 130;
    } else {
      imageWidth = 140;
      imageHeight = 100;
    }
/*    List<ReplyEntity> listReply = [ReplyEntity(id: 1, description: "text 1", createDate: "2023-11-13 09:32:53"),
      ReplyEntity(id: 2, description: "text 2text 2text 2text 2text 2text 2text 2text 2text 2text 2text 2text 2text 2text 2text 2text 2text 2text 2text 2", createDate: "2023-11-14 09:32:53"),
      ReplyEntity(id: 3, description: "text 3", createDate: "2023-11-14 08:32:53"),
      ReplyEntity(id: 4, description: "text 4  2text 2text 2text 2text 2text 2text 2text 2t 2text 2text 2text 2text 2text 2text 2text 2t", createDate: "2023-11-15 10:32:53"),
      ReplyEntity(id: 5, description: "text 5", createDate: "2023-11-15 11:32:53"),];*/
    emitter(state.copyWith(
      isShowProgress: false,
      formStatus: const InitialFormStatus(),
      startTimeController:
      TextEditingController(text: DateTime.now().toString().split('.')[0]),
      moTaController: TextEditingController(text: feedbackInfo.description),
      titleController: TextEditingController(text: feedbackInfo.title),
      replyController: TextEditingController(),
      imageWidth: imageWidth,
      imageHeight: imageHeight,
      listImage: feedbackInfo.images,
      listReply: feedbackInfo.replys,
        feedbackInfo: feedbackInfo,
        userId : userId,
      id: event.id,
    ));
    print("HoangCV: state.listImage.isNotEmpty: ${state.listImage.length} : ${feedbackInfo.images.length} : ${feedbackInfo.replys.length}");
    _initViewAdd(emitter);
  }


  Future<FutureOr<void>> _onSelectValue(OnSelectValueEvent event,
      Emitter<DetailFeedbackState> emit) async {
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
      AddOrDeleteImageEvent event, Emitter<DetailFeedbackState> emit) async {
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

  FutureOr<void> _DetailFeedbackDiary(
      DetailFeedbackDiaryEvent event, Emitter<DetailFeedbackState> emit) async {
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
      state.listWidget[1].error = "Vui lòng nhập ý kiến phản hồi";
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
            formStatus: SubmissionSuccess(success: "Thêm hoạt động thành công.")));
      }else if (objectResult.responseCode == StatusConst.code06) {
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionSuccess(success: "Hoạt động đã được sao lưu. \n Vui lòng truy cập mạng sớm nhất để thêm hoạt động.")));
      } else if (objectResult.responseCode != StatusConst.code01) {
        //_changeViewEdit(emit);
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionFailed(objectResult.message)));
      }
    }
  }

  FutureOr<void> _saveValueTextField(
      SaveValueTextFieldEvent event, Emitter<DetailFeedbackState> emit) {
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

  Future<FutureOr<void>> _addReply(AddReplyEvent event, Emitter<DetailFeedbackState> emit) async {
    emit(state.copyWith(
        isShowProgress: false, formStatus: const InitialFormStatus()));
    bool validate = true;
    if (state.replyController!.text.isEmpty) {
      validate = false;
    }
    if (!validate) {
      emit(state.copyWith(isShowProgress: false));
    } else {
      emit(state.copyWith(isShowProgress: false, formStatus: FormSubmitting()));
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      int? userId = sharedPreferences.getInt(SharedPreferencesKey.userId);
      FeedbackInfo diary = FeedbackInfo(
        id: state.feedbackInfo!.id,
        description: state.replyController!.text,
      );
      //"is_shown": true,
      ObjectResult objectResult = await repository.addReplyFeedback(diary);
      if (objectResult.responseCode == StatusConst.code00) {
        //_changeViewEdit(emit);
      }
      if (objectResult.responseCode == StatusConst.code00) {
        add(GetDetailFeedbackEvent(state.id ?? -1));
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionSuccess(success:"")));
      }else if (objectResult.responseCode == StatusConst.code06) {
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionSuccess(success: "Không có kết nối mạng. Vui lòng thử lại sau!")));
      } else if (objectResult.responseCode != StatusConst.code01) {
        //_changeViewEdit(emit);
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionFailed(objectResult.message)));
      }
    }
  }

  FutureOr<void> _saveReply(SaveReplyEvent event, Emitter<DetailFeedbackState> emit) {
    emit(state.copyWith(
       replyController: TextEditingController(text: event.text)));
  }

  Future<FutureOr<void>> _getDetailFeedback(GetDetailFeedbackEvent event, Emitter<DetailFeedbackState> emit) async {
    emit(state.copyWith(
        isShowProgress: true));

    FeedbackInfo feedbackInfo = await repository.getDetailFeedbackFarmer(event.id);
    emit(state.copyWith(
      isShowProgress: false,
      formStatus: const InitialFormStatus(),
      replyController: TextEditingController(),
      listReply: feedbackInfo.replys,
      id: event.id,
    ));
  }
}

class DetailFeedbackEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class InitDetailFeedbackEvent extends DetailFeedbackEvent {

  final int id;
  InitDetailFeedbackEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class GetDetailFeedbackEvent extends DetailFeedbackEvent {

  final int id;
  GetDetailFeedbackEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ChangeEditFeedbackEvent extends DetailFeedbackEvent {
  ChangeEditFeedbackEvent();
}


class OnSelectValueEvent extends DetailFeedbackEvent {
  List<InputRegisterModel> list;
  int index;
  BuildContext context;

  OnSelectValueEvent(this.list, this.index, this.context);

  @override
  List<Object?> get props => [list, index, context];
}

class AddOrDeleteImageEvent extends DetailFeedbackEvent {
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

class SaveValueTextFieldEvent extends DetailFeedbackEvent {
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

class AddReplyEvent extends DetailFeedbackEvent {
  AddReplyEvent();

  @override
  List<Object?> get props => [];
}

class SaveReplyEvent extends DetailFeedbackEvent {
  final String text;

  SaveReplyEvent(
      this.text,
      );

  @override
  List<Object?> get props => [text];
}

class DetailFeedbackDiaryEvent extends DetailFeedbackEvent {
  DetailFeedbackDiaryEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAvatarEvent extends DetailFeedbackEvent {
  //final ImageSource source;
  UpdateAvatarEvent();
}

class DetailFeedbackState extends BlocState {
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
    feedbackInfo,
    listReply,
    userId,
    replyController,
    id,
  ];
  final FeedbackInfo? feedbackInfo;
  final List<ReplyEntity> listReply;
  final List<Feedback> listFeedback;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;
  final List<InputRegisterModel> listWidget;
  List<ImageEntity> listImage = [];
  final int seasonId;
  TextEditingController? moTaController = TextEditingController();
  TextEditingController? startTimeController = TextEditingController();
  TextEditingController? titleController = TextEditingController();
  TextEditingController? replyController = TextEditingController();
  bool isEdit;
  final int indexFeedback;
  final int indexArea;
  double imageWidth;
  double imageHeight;
  final double areaMax;
  final int? userId;
  final int? id;

  DetailFeedbackState({
    this.id,
    this.userId,
    this.listReply = const [],
    this.feedbackInfo,
    this.seasonId = -1,
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.listFeedback = const [],
    this.listWidget = const [],
    this.listImage = const [],
    this.moTaController,
    this.titleController,
    this.startTimeController,
    this.replyController,
    this.isEdit = false,
    this.imageWidth = 130,
    this.imageHeight = 100,
    this.indexFeedback = -1,
    this.indexArea = -1,
    this.areaMax = 0,
  });

  DetailFeedbackState copyWith({
    int? id,
    int? userId,
    List<ReplyEntity>? listReply,
    FeedbackInfo? feedbackInfo,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    List<Feedback>? listFeedback,
    List<InputRegisterModel>? listWidget,
    List<ImageEntity>? listImage,
    TextEditingController? moTaController,
    TextEditingController? titleController,
    TextEditingController? startTimeController,
    TextEditingController? replyController,
    bool? isEdit,
    int? indexFeedback,
    int? indexArea,
    double? imageWidth,
    double? imageHeight,
    double? areaMax,
  }) {
    return DetailFeedbackState(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      listReply: listReply ?? this.listReply,
      feedbackInfo: feedbackInfo ?? this.feedbackInfo,
      formStatus: formStatus ?? this.formStatus,
      isShowProgress: isShowProgress ?? this.isShowProgress,
      listFeedback: listFeedback ?? this.listFeedback,
      listWidget: listWidget ?? this.listWidget,
      listImage: listImage ?? this.listImage,
      moTaController: moTaController ?? this.moTaController,
      titleController: titleController ?? this.titleController,
      startTimeController: startTimeController ?? this.startTimeController,
      replyController: replyController ?? this.replyController,
      isEdit: isEdit ?? this.isEdit,
      imageWidth: imageWidth ?? this.imageWidth,
      imageHeight: imageHeight ?? this.imageHeight,
      indexFeedback: indexFeedback ?? this.indexFeedback,
      areaMax: areaMax ?? this.areaMax,
    );
  }
}
