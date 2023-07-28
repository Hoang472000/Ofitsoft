import 'dart:async';

import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/activity_monitor.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/entity/activity/activity_diary.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../data/entity/image/image_entity.dart';
import '../../../data/entity/item_default/material_entity.dart';
import '../../../data/entity/monitor/monitor_diary.dart';
import '../../../data/local_data/diary_db.dart';
import '../../../data/remote_data/object_model/object_result.dart';
import '../../../data/repository.dart';
import '../../../resource/assets.dart';
import '../../../utils/constans/status_const.dart';
import '../../../utils/constants/shared_preferences_key.dart';
import '../../../utils/extenstion/extenstions.dart';
import '../../../utils/extenstion/input_register_model.dart';
import '../../../utils/extenstion/service_info_extension.dart';
import '../../../utils/form_submission_status.dart';
import '../../../utils/utils.dart';
import '../../../view/diary_activity/activity/add_activity_sub/add_activity_sub.dart';
import '../../bloc_event.dart';
import '../../bloc_state.dart';

class DetailMonitorBloc
    extends Bloc<DetailMonitorEvent, DetailMonitorState> {
  final Repository repository;

  DetailMonitorBloc(this.repository) : super(DetailMonitorState()) {
    on<GetDetailMonitorEvent>(_getDetailMonitor);
    on<ChangeEditMonitorEvent>(_changeEditMonitor);
    on<ChangeDetailMonitorEvent>(_changeDetailMonitor);
    on<OnSelectValueEvent>(_onSelectValue);
    on<AddOrDeleteImageEvent>(_addOrDeleteImage);
    on<SaveValueTextFieldEvent>(_saveValueTextField);
    on<UpdateMonitorEvent>(_updateMonitor);
    //add(GetDetailActivityEvent());
  }

  bool edit = false;

  void _initViewDetail(Emitter<DetailMonitorState> emitter) {
    List<InputRegisterModel> list = [];
    List<InputRegisterModel> listBP = [];
    list.add(InputRegisterModel<ActivityMonitor, ActivityMonitor>(
        title: "Các hoạt động",
        isCompulsory: true,
        type: TypeInputRegister.Non,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        controller: state.nameController,
        listValue: state.listActivity,
        image: ImageAsset.imageActivityFarm
    ));
    list.add(InputRegisterModel<String, DateTime>(
        title: "Thời gian thực hiện",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Non,
        // valueSelected: DateTime.now(),
        image: ImageAsset.imageCalendarBegin,
        icon: Icons.calendar_today));
    list.add(InputRegisterModel(
      title: "Nội dung cần chú ý",
      isCompulsory: false,
      maxLengthTextInput: 2000,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.text,
      image: ImageAsset.imageFile,
      controller: state.moTaController,
    ));

    listBP.add(InputRegisterModel<ActivityMonitor, ActivityMonitor>(
        title: "Biện pháp khắc phục",
        isCompulsory: false,
        type: TypeInputRegister.Non,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        image: ImageAsset.imageTherapy,
      listValue: state.listActivity,
    ));
    listBP.add(InputRegisterModel<String, DateTime>(
      title: "Thời gian khắc phục",
      isCompulsory: false,
      maxLengthTextInput: 50,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.text,
      image: ImageAsset.imageCalendarPick,
      controller: state.startTimeController,));

    listBP.add(InputRegisterModel(
      title: "Mô tả",
      isCompulsory: false,
      maxLengthTextInput: 2000,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.text,
      controller: state.moTaController,
      image: ImageAsset.imageFile,
    ));

    emitter(state.copyWith(
        listWidget: list,
        listWidgetBP: listBP));
  }

  void _changeViewEdit(Emitter<DetailMonitorState> emitter) {
    List<InputRegisterModel> list = [];
    List<InputRegisterModel> listBP = [];

    list.add(InputRegisterModel<ActivityMonitor, ActivityMonitor>(
        title: "Các hoạt động",
        isCompulsory: true,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: state.indexActivity,
        valueSelected: state.listActivity[state.indexActivity],
        listValue: state.listActivity,
        typeInputEnum: TypeInputEnum.dmucItem,
        image: ImageAsset.imageActivityFarm
    ));

    list.add(InputRegisterModel<String, DateTime>(
        title: "Thời gian thực hiện",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        valueSelected: Utils.stringToDate(state.startTimeController!.text),
        image: ImageAsset.imageCalendarBegin,
        icon: Icons.calendar_today));

    list.add(InputRegisterModel(
      title: "Nội dung cần chú ý",
      isCompulsory: false,
      maxLengthTextInput: 2000,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      image: ImageAsset.imageFile,
      controller: state.moTaController,
    ));

    if (state.indexActivity != -1) {
      listBP.add(InputRegisterModel<ActivityMonitor, ActivityMonitor>(
        title: "Biện pháp khắc phục",
        isCompulsory: true,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: state.indexActivity,
        valueSelected: state.listActivity[state.indexActivity],
        listValue: state.listActivity,
        typeInputEnum: TypeInputEnum.dmucItem,
        image: ImageAsset.imageTherapy,
      ));
    } else {
      listBP.add(InputRegisterModel<ActivityMonitor, ActivityMonitor>(
        title: "Biện pháp khắc phục",
        isCompulsory: true,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: state.indexDonViArea,
        image: ImageAsset.imageTherapy,
        listValue: state.listActivity,
      ));
    }

    listBP.add(InputRegisterModel<String, DateTime>(
      title: "Thời gian khắc phục",
      isCompulsory: true,
      maxLengthTextInput: 50,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      image: ImageAsset.imageCalendarPick,
      controller: state.startTimeController,));

    listBP.add(InputRegisterModel(
      title: "Mô tả",
      isCompulsory: true,
      maxLengthTextInput: 2000,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      controller: state.moTaController,
      image: ImageAsset.imageFile,
    ));


    emitter(state.copyWith(
        formStatus: const InitialFormStatus(),
        listWidget: list,
        listWidgetBP: listBP
    ));
  }

  void _getDetailMonitor(GetDetailMonitorEvent event,
      Emitter<DetailMonitorState> emitter) async {
    if(event.resetView){
      emitter(state.copyWith(
          isShowProgress: true,
          formStatus: const InitialFormStatus(),
          listVatTuAdd: [],
          listCongCuAdd: []));
    }else{
      emitter(state.copyWith(
          isShowProgress: true,
          formStatus: const InitialFormStatus(),
          listWidget: [],
          listWidgetBP: [],
          listVatTuAdd: [],
          listCongCuAdd: []));
    }
    final detailMonitor = event.monitorDiary;
    var copiedMonitorDiary = MonitorDiary.copy(detailMonitor);
    //final listActivity = await DiaryDB.instance.getListActivity();
    final listActivity = [ActivityMonitor(id: 15, diaryMonitorId: 1, activityId: 1, activity: "Kiểm tra xem có làm vườn", checkNo: false, checkYes: true),
      ActivityMonitor(id: 16, diaryMonitorId: 1, activityId: 1, activity: "Kiểm tra xem có kiểm soát sâu bệnh", checkNo: false, checkYes: true),
      ActivityMonitor(id: 17, diaryMonitorId: 1, activityId: 1, activity: "Kiểm tra xem có chăm sóc cây", checkNo: false, checkYes: true),
      ActivityMonitor(id: 18, diaryMonitorId: 1, activityId: 1, activity: "Kiểm tra xem có thông thoáng sân vườn", checkNo: false, checkYes: true)];
    _initViewDetail(emitter);
    int index = listActivity
        .indexWhere((element) => element.id == detailMonitor.activityIds[0].activityId);
    double imageWidth = state.imageWidth;
    double imageHeight = state.imageHeight;
    if (detailMonitor.diaryMediaIds.length < 2) {
      // Tính toán kích thước ảnh để hiển thị full màn hình
      imageWidth = 360;
      imageHeight = 240;
    } else if (detailMonitor.diaryMediaIds.length < 3) {
      // Tính toán kích thước ảnh để hiển thị full màn hình
      imageWidth = 180;
      imageHeight = 130;
    } else {
      imageWidth = 140;
      imageHeight = 100;
    }
    emitter(state.copyWith(
        isShowProgress: false,
        detailMonitor: detailMonitor,
        copiedMonitorDiary: copiedMonitorDiary,
        listActivity: listActivity,
        listImage: detailMonitor.diaryMediaIds,
        moTaController: TextEditingController(text: detailMonitor.description),
        nameController: TextEditingController(text: listActivity[index].activity),
        peopleController: TextEditingController(),
        startTimeController: TextEditingController(
            text: Utils.formatDate(detailMonitor.actionTime ?? "")),
        indexActivity: index,
        imageWidth: imageWidth,
        imageHeight: imageHeight));
    for (int i = 0; i < state.listWidget.length; i++) {
      if (state.listWidget[i].title.compareTo("Các hoạt động") == 0) {
        state.listWidget[i].controller = state.nameController;
      }
      if (state.listWidget[i].title.compareTo("Nội dung cần chú ý") == 0) {
        state.listWidget[i].controller = state.moTaController;
      }
      if (state.listWidget[i].title.compareTo("Người liên quan") == 0) {
        state.listWidget[i].controller = state.peopleController;
      }
      if (state.listWidget[i].title.compareTo("Thời gian thực hiện") == 0) {
        state.listWidget[i].controller = state.startTimeController;
      }
    }
    emitter(state.copyWith(
        listWidget: state.listWidget,));
  }

  FutureOr<void> _changeEditMonitor(
      ChangeEditMonitorEvent event, Emitter<DetailMonitorState> emit) async {
    _changeViewEdit(emit);
  }

  FutureOr<void> _changeDetailMonitor(ChangeDetailMonitorEvent event,
      Emitter<DetailMonitorState> emit) async {
    //_changeViewDetail(emit);
    add(GetDetailMonitorEvent(state.copiedMonitorDiary?? MonitorDiary(), resetView: true));
  }

  Future<FutureOr<void>> _onSelectValue(
      OnSelectValueEvent event, Emitter<DetailMonitorState> emit) async {
    int result;
/*    if(inputRegisterModel.typeInputEnum == TypeInputEnum.dmucTinh && dMucTinhResponse.tinh == null) {
      Toast.showLongTop("Không có danh mục tỉnh");
      return;
    }else if(inputRegisterModel.typeInputEnum == TypeInputEnum.dmucHuyen && dMucHuyenResponse.dmucHuyenTPS == null) {
      Toast.showLongTop("Không có danh mục huyện");
      return;
    }else if(inputRegisterModel.typeInputEnum == TypeInputEnum.dmucXa && dMucXaResponse.dmucXaTPS == null) {
      Toast.showLongTop("Không có danh mục xã");
      return;
    }*/
    emit(state.copyWith(
      formStatus: const InitialFormStatus(),
    ));
    if (event.list[event.index].valueSelected.runtimeType == DateTime ||
        event.list[event.index].typeInputEnum == TypeInputEnum.date) {
      //     setState(() {
      print(
          "HoangCV: event.list[event.index].valueSelected: ${Utils.formatDateTimeToString(event.list[event.index].valueSelected)} :");
      int result1 = await ServiceInfoExtension()
          .selectValue(event.list[event.index], event.context, (modelInput) {});
      print(
          "HoangCV: result1: ${result1} : ${Utils.formatDateTimeToString(event.list[event.index].valueSelected)}");
      if (result1 == 1) {
        if (event.list[event.index].title.compareTo("Thời gian thực hiện") ==
            0) {
          print(
              "HoangCV:1 event.list[event.index].valueSelected: ${Utils.formatDateTimeToString(event.list[event.index].valueSelected)}");
          emit(state.copyWith(
            startTimeController: TextEditingController(
                text: Utils.formatDateTimeToString(
                    event.list[event.index].valueSelected)),
          ));
        }
        if (event.list[event.index].title.compareTo("Ngày kết thúc") == 0) {
          emit(state.copyWith(
            endTimeController: TextEditingController(
                text: Utils.formatDateTimeToString(
                    event.list[event.index].valueSelected)),
          ));
        }
      }
//      });
    } else {
      result = await Extension().showBottomSheetSelection(
          event.context,
          event.list[event.index].listValue,
          event.list[event.index].positionSelected,
          "${event.list[event.index].title}",
          hasSearch: event.list[event.index].hasSearch ?? false);
      if (result != -1) {
        //   setState(() {
        event.list[event.index].positionSelected = result;
        event.list[event.index].valueDefault = null;
        event.list[event.index].valueSelected =
        event.list[event.index].listValue[result];
        event.list[event.index].error = null;
        // });
        if (event.list[event.index].title.compareTo("Tên công việc") == 0) {
          emit(state.copyWith(
            nameController: TextEditingController(
                text: event.list[event.index].valueSelected.name),
          ));
        }
        if (event.list[event.index].title.compareTo("Chi tiết công việc") ==
            0) {
          emit(state.copyWith(
            moTaController: event.list[event.index].controller,
          ));
        }
        if (event.list[event.index].title.compareTo("Người liên quan") == 0) {
          emit(state.copyWith(
            peopleController: event.list[event.index].controller,
          ));
        }
        if (event.list[event.index].title.compareTo("Diện tích") == 0) {
          emit(state.copyWith(
            areaController: event.list[event.index].controller,
          ));
        }
      }
    }
  }

  FutureOr<void> _addOrDeleteImage(
      AddOrDeleteImageEvent event, Emitter<DetailMonitorState> emit) async {
    print("HoangCV: event. image: ${event.listImage.length}");
    List<ImageEntity> list = List.from(state.listImage);
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
        formStatus: const InitialFormStatus(),
        listImage: list,
        imageWidth: imageWidth,
        imageHeight: imageHeight));
  }

  FutureOr<void> _saveValueTextField(
      SaveValueTextFieldEvent event, Emitter<DetailMonitorState> emit) {
    print("HoangCV: bug: ${event.text}");
    if (event.inputRegisterModel.title.compareTo("Chi tiết công việc") == 0) {
      emit(state.copyWith(
          moTaController: TextEditingController(text: event.text)));
    } else if (event.inputRegisterModel.title.compareTo("Diện tích") == 0) {
      emit(state.copyWith(
          areaController: TextEditingController(text: event.text)));
    }
  }

  FutureOr<void> _updateMonitor(
      UpdateMonitorEvent event, Emitter<DetailMonitorState> emit) async {
    print("HoangCV: state.indexActivity: ${state.indexActivity}");
    emit(state.copyWith(
      isShowProgress: true,
    ));
    List<InputRegisterModel> list = List.from(state.listWidget);
    //List<InputRegisterModel> listArea = List.from(state.listWidgetArea);
    bool validate = true;
    if (state.indexActivity == -1) {
      validate = false;
      state.listWidget[0].error = "Vui lòng chọn tên công việc";
    }
    /*else if(state.areaController!.text.isEmpty){
      validate = false;
      listArea[1].error = "Vui lòng nhập diện tích";
    }*/
    /*else if (state.areaController!.text.isNotEmpty &&
        state.listWidgetArea[1].valueSelected == null) {
      validate = false;
      state.listWidgetArea[1].error = "Vui lòng chọn đơn vị";
    }*/
    if (!validate) {
      emit(state.copyWith(isShowProgress: false));
      print("HoangCV: state.indexActivity: ${state.indexActivity}");
    } else {
      ActivityDiary diary = ActivityDiary(
        id: state.detailMonitor!.id,
        activityId: state.listActivity[state.indexActivity].id,
        activityName: state.listActivity[state.indexActivity].activity,
        actionTime: state.listWidget[2].valueSelected.toString().split('.')[
        0] /* Utils.formatDateTimeToStringFull(state.listWidget[2].valueSelected)*/,
        actionArea: double.parse("${state.areaController!.text}"),
        description: state.moTaController!.text,
        tool: state.listCongCuAdd,
        material: state.listVatTuAdd,
        media: state.listImage,
      );
      //"is_shown": true,
      ObjectResult objectResult = await repository.updateActivityDiary(diary);
      if (objectResult.responseCode == StatusConst.code00) {
        // _changeViewDetail(emit);
      }
      if (objectResult.responseCode == StatusConst.code00) {
        //_changeViewDetail(emit);
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionSuccess(success: objectResult.message)));
      } else if (objectResult.responseCode == StatusConst.code01) {
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionFailed(objectResult.message)));
      }
    }
  }
}

class DetailMonitorEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetDetailMonitorEvent extends DetailMonitorEvent {
  MonitorDiary monitorDiary;
  bool resetView;

  GetDetailMonitorEvent(this.monitorDiary, {this.resetView = false});

  @override
  List<Object?> get props => [monitorDiary, resetView];
}

class ChangeEditMonitorEvent extends DetailMonitorEvent {
  ChangeEditMonitorEvent();
}

class ChangeDetailMonitorEvent extends DetailMonitorEvent {
  ChangeDetailMonitorEvent();
}

class UpdateMonitorEvent extends DetailMonitorEvent {
  UpdateMonitorEvent();
}

class OnSelectValueEvent extends DetailMonitorEvent {
  List<InputRegisterModel> list;
  int index;
  BuildContext context;

  OnSelectValueEvent(this.list, this.index, this.context);

  @override
  List<Object?> get props => [list, index, context];
}

class AddOrDeleteImageEvent extends DetailMonitorEvent {
  final List<ImageEntity> listImage;
  final int index;
  final BuildContext context;

  AddOrDeleteImageEvent(this.listImage, this.index, this.context);

  @override
  List<Object?> get props => [listImage, index, context];
}

class SaveValueTextFieldEvent extends DetailMonitorEvent {
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

class UpdateAvatarEvent extends DetailMonitorEvent {
  //final ImageSource source;
  UpdateAvatarEvent();
}

class DetailMonitorState extends BlocState {
  @override
  List<Object?> get props => [
    detailMonitor,
    formStatus,
    isShowProgress,
    listMaterial,
    listTool,
    listUnitAmount,
    listUnitArea,
    listActivity,
    listWidget,
    listImage,
    listVatTuAdd,
    listCongCuAdd,
    nameController,
    soCayController,
    soLuongController,
    moTaController,
    donViController,
    peopleController,
    startTimeController,
    endTimeController,
    isEdit,
    indexActivity,
    listUnitArea,
    areaController,
    indexDonViArea,
    copiedMonitorDiary,
  ];
  final MonitorDiary? detailMonitor;
  final MonitorDiary? copiedMonitorDiary;
  final List<MaterialEntity> listMaterial;
  final List<Tool> listTool;
  final List<Unit> listUnitAmount;
  final List<Unit> listUnitArea;
  final List<ActivityMonitor> listActivity;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;
  List<InputRegisterModel> listWidget;
  List<InputRegisterModel> listWidgetBP;
  List<ImageEntity> listImage = [];
  List<MaterialEntity> listVatTuAdd = [];
  List<Tool> listCongCuAdd = [];
  TextEditingController? nameController = TextEditingController();
  TextEditingController? soCayController = TextEditingController();
  TextEditingController? soLuongController = TextEditingController();
  TextEditingController? moTaController = TextEditingController();
  TextEditingController? donViController = TextEditingController();
  TextEditingController? peopleController = TextEditingController();
  TextEditingController? startTimeController = TextEditingController();
  TextEditingController? endTimeController = TextEditingController();
  TextEditingController? areaController = TextEditingController();
  bool isEdit;
  int indexActivity;
  int indexDonViArea;
  double imageWidth;
  double imageHeight;

  DetailMonitorState({
    this.detailMonitor,
    this.copiedMonitorDiary,
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.listMaterial = const [],
    this.listTool = const [],
    this.listUnitArea = const [],
    this.listUnitAmount = const [],
    this.listActivity = const [],
    this.listCongCuAdd = const [],
    this.listVatTuAdd = const [],
    this.listWidget = const [],
    this.listWidgetBP = const [],
    this.listImage = const [],
    this.nameController,
    this.areaController,
    this.soCayController,
    this.soLuongController,
    this.moTaController,
    this.donViController,
    this.peopleController,
    this.startTimeController,
    this.endTimeController,
    this.isEdit = false,
    this.imageWidth = 130,
    this.imageHeight = 100,
    this.indexActivity = 0,
    this.indexDonViArea = 0,
  });

  DetailMonitorState copyWith({
    MonitorDiary? detailMonitor,
    MonitorDiary? copiedMonitorDiary,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    List<MaterialEntity>? listMaterial,
    List<Tool>? listTool,
    List<Unit>? listUnitAmount,
    List<Unit>? listUnitArea,
    List<ActivityMonitor>? listActivity,
    List<InputRegisterModel>? listWidget,
    List<InputRegisterModel>? listWidgetBP,
    List<ImageEntity>? listImage,
    List<MaterialEntity>? listVatTuAdd,
    List<Tool>? listCongCuAdd,
    TextEditingController? nameController,
    TextEditingController? soCayController,
    TextEditingController? soLuongController,
    TextEditingController? moTaController,
    TextEditingController? donViController,
    TextEditingController? peopleController,
    TextEditingController? startTimeController,
    TextEditingController? endTimeController,
    TextEditingController? areaController,
    bool? isEdit,
    int? indexActivity,
    int? indexDonViArea,
    double? imageWidth,
    double? imageHeight,
  }) {
    return DetailMonitorState(
      copiedMonitorDiary: copiedMonitorDiary ?? this.copiedMonitorDiary,
      detailMonitor: detailMonitor ?? this.detailMonitor,
      formStatus: formStatus ?? this.formStatus,
      isShowProgress: isShowProgress ?? this.isShowProgress,
      listMaterial: listMaterial ?? this.listMaterial,
      listTool: listTool ?? this.listTool,
      listUnitArea: listUnitArea ?? this.listUnitArea,
      listUnitAmount: listUnitAmount ?? this.listUnitAmount,
      listActivity: listActivity ?? this.listActivity,
      listWidget: listWidget ?? this.listWidget,
      listWidgetBP: listWidgetBP ?? this.listWidgetBP,
      listImage: listImage ?? this.listImage,
      listVatTuAdd: listVatTuAdd ?? this.listVatTuAdd,
      listCongCuAdd: listCongCuAdd ?? this.listCongCuAdd,
      nameController: nameController ?? this.nameController,
      soCayController: soCayController ?? this.soCayController,
      soLuongController: soLuongController ?? this.soLuongController,
      moTaController: moTaController ?? this.moTaController,
      donViController: donViController ?? this.donViController,
      peopleController: peopleController ?? this.peopleController,
      startTimeController: startTimeController ?? this.startTimeController,
      endTimeController: endTimeController ?? this.endTimeController,
      areaController: areaController ?? this.areaController,
      isEdit: isEdit ?? this.isEdit,
      imageWidth: imageWidth ?? this.imageWidth,
      imageHeight: imageHeight ?? this.imageHeight,
      indexActivity: indexActivity ?? this.indexActivity,
      indexDonViArea: indexDonViArea ?? this.indexDonViArea,
    );
  }
}
