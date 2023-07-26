import 'dart:async';

import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/entity/activity/activity_diary.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../data/entity/image/image_entity.dart';
import '../../../data/entity/item_default/material_entity.dart';
import '../../../data/local_data/diary_db.dart';
import '../../../data/repository.dart';
import '../../../resource/assets.dart';
import '../../../utils/constants/shared_preferences_key.dart';
import '../../../utils/extenstion/extenstions.dart';
import '../../../utils/extenstion/input_register_model.dart';
import '../../../utils/extenstion/service_info_extension.dart';
import '../../../utils/form_submission_status.dart';
import '../../../utils/utils.dart';
import '../../../view/diary_activity/activity/add_activity_sub/add_activity_sub.dart';
import '../../bloc_event.dart';
import '../../bloc_state.dart';

class DetailActivityBloc
    extends Bloc<DetailActivityEvent, DetailActivityState> {
  final Repository repository;

  DetailActivityBloc(this.repository) : super(DetailActivityState()) {
    on<GetDetailActivityEvent>(_getDetailActivity);
    on<ChangeEditActivityEvent>(_changeEditActivity);
    on<ChangeDetailActivityEvent>(_changeDetailActivity);
    on<OnSelectValueEvent>(_onSelectValue);
    on<AddOrDeleteImageEvent>(_addOrDeleteImage);
    //add(GetDetailActivityEvent());
  }

  bool edit = false;

  void _changeViewDetail(Emitter<DetailActivityState> emitter) {
    List<InputRegisterModel> list = [];
    List<InputRegisterModel> listCC = [];
    List<InputRegisterModel> listVT = [];
    list.add(InputRegisterModel<Activity, Activity>(
        title: "Tên công việc",
        isCompulsory: true,
        type: TypeInputRegister.Non,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        listValue: state.listActivity,
        controller: state.nameController,
        typeInputEnum: TypeInputEnum.dmucItem,
        image: ImageAsset.imageActivityFarm));

    list.add(InputRegisterModel(
        title: "Chi tiết công việc",
        isCompulsory: true,
        maxLengthTextInput: 2000,
        type: TypeInputRegister.Non,
        typeInput: TextInputType.text,
        controller: state.moTaController,
        image: ImageAsset.imageFile));

    list.add(InputRegisterModel(
      title: "Người liên quan",
      isCompulsory: false,
      maxLengthTextInput: 200,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.text,
      controller: state.peopleController,
      image: ImageAsset.imageMan,
    ));

    list.add(InputRegisterModel<String, DateTime>(
        title: "Thời gian thực hiện",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Non,
        controller: state.startTimeController,
        image: ImageAsset.imageCalendarBegin,
        icon: Icons.calendar_today));

/*    list.add(InputRegisterModel<String, DateTime>(
        title: "Ngày kết thúc",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Non,
        controller: state.endTimeController,
        image: ImageAsset.imageCalendarEnd,
        icon: Icons.calendar_today));*/

    listVT.add(InputRegisterModel<MaterialEntity, MaterialEntity>(
        title: "Vật tư liên quan",
        isCompulsory: false,
        type: TypeInputRegister.Non,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        typeInputEnum: TypeInputEnum.dmucItem,
        listValue: state.listMaterial,
        image: ImageAsset.imageGardening));

    listCC.add(InputRegisterModel<Tool, Tool>(
      title: "Công cụ sử dụng",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listTool,
      typeInputEnum: TypeInputEnum.dmucItem,
      image: ImageAsset.imageTools,
    ));

    listVT.add(InputRegisterModel(
      title: "Đơn vị:",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listUnitAmount,
      typeInputEnum: TypeInputEnum.dmucItem,
    ));

    listCC.add(InputRegisterModel(
      title: "Đơn vị:",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listUnitAmount,
      typeInputEnum: TypeInputEnum.dmucItem,
    ));

    emitter(state.copyWith(
        listWidget: list, listWidgetVT: listVT, listWidgetCC: listCC));
  }

  void _initViewDetail(Emitter<DetailActivityState> emitter) {
    List<InputRegisterModel> list = [];
    List<InputRegisterModel> listCC = [];
    List<InputRegisterModel> listVT = [];
    list.add(InputRegisterModel<Activity, Activity>(
        title: "Tên công việc",
        isCompulsory: true,
        type: TypeInputRegister.Non,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        listValue: state.listActivity,
        typeInputEnum: TypeInputEnum.dmucItem,
        image: ImageAsset.imageActivityFarm));
    list.add(InputRegisterModel(
        title: "Chi tiết công việc",
        isCompulsory: true,
        maxLengthTextInput: 2000,
        type: TypeInputRegister.Non,
        typeInput: TextInputType.text,
        controller: state.moTaController,
        image: ImageAsset.imageFile));

    list.add(InputRegisterModel(
      title: "Người liên quan",
      isCompulsory: false,
      maxLengthTextInput: 200,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.text,
      controller: state.peopleController,
      image: ImageAsset.imageMan,
    ));

    list.add(InputRegisterModel<String, DateTime>(
        title: "Thời gian thực hiện",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Non,
        // valueSelected: DateTime.now(),
        image: ImageAsset.imageCalendarBegin,
        icon: Icons.calendar_today));

/*    list.add(InputRegisterModel<String, DateTime>(
        title: "Ngày kết thúc",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Non,
        // valueSelected: DateTime.now(),
        image: ImageAsset.imageCalendarEnd,
        icon: Icons.calendar_today));*/

    listVT.add(InputRegisterModel<MaterialEntity, MaterialEntity>(
        title: "Vật tư liên quan",
        isCompulsory: false,
        type: TypeInputRegister.Non,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        typeInputEnum: TypeInputEnum.dmucItem,
        listValue: state.listMaterial,
        image: ImageAsset.imageGardening));

    listCC.add(InputRegisterModel<Tool, Tool>(
      title: "Công cụ sử dụng",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listTool,
      typeInputEnum: TypeInputEnum.dmucItem,
      image: ImageAsset.imageTools,
    ));

    listVT.add(InputRegisterModel(
      title: "Đơn vị:",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listUnitAmount,
      typeInputEnum: TypeInputEnum.dmucItem,
    ));

    listCC.add(InputRegisterModel(
      title: "Đơn vị:",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listUnitAmount,
      typeInputEnum: TypeInputEnum.dmucItem,
    ));
    emitter(state.copyWith(
        listWidget: list, listWidgetVT: listVT, listWidgetCC: listCC));
  }

  void _changeViewEdit(Emitter<DetailActivityState> emitter) {
    List<InputRegisterModel> list = [];
    List<InputRegisterModel> listCC = [];
    List<InputRegisterModel> listVT = [];
    print("HoangCV: state.listMaterial: ${state.listMaterial.length}");
    list.add(InputRegisterModel<Activity, Activity>(
        title: "Tên công việc",
        isCompulsory: true,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: state.indexActivity,
        listValue: state.listActivity,
        valueSelected: state.listActivity[state.indexActivity],
        typeInputEnum: TypeInputEnum.dmucItem,
        image: ImageAsset.imageActivityFarm));
    list.add(InputRegisterModel(
        title: "Chi tiết công việc",
        isCompulsory: true,
        maxLengthTextInput: 2000,
        type: TypeInputRegister.TextField,
        typeInput: TextInputType.text,
        controller: state.moTaController,
        image: ImageAsset.imageFile));

    list.add(InputRegisterModel(
      title: "Người liên quan",
      isCompulsory: false,
      maxLengthTextInput: 200,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      controller: state.peopleController,
      image: ImageAsset.imageMan,
    ));

    list.add(InputRegisterModel<String, DateTime>(
        title: "Thời gian thực hiện",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        valueSelected:
        Utils.stringToDate(state.startTimeController!.text),
        image: ImageAsset.imageCalendarBegin,
        icon: Icons.calendar_today));

/*    list.add(InputRegisterModel<String, DateTime>(
        title: "Ngày kết thúc",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        valueSelected:
        Utils.stringToDate(state.endTimeController!.text),
        image: ImageAsset.imageCalendarEnd,
        icon: Icons.calendar_today));*/

    listVT.add(InputRegisterModel(
        title: "Vật tư liên quan",
        isCompulsory: true,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        typeInputEnum: TypeInputEnum.dmucItem,
        listValue: state.listMaterial,
        image: ImageAsset.imageGardening));

    listCC.add(InputRegisterModel<Tool, Tool>(
      title: "Công cụ sử dụng",
      isCompulsory: true,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      typeInputEnum: TypeInputEnum.dmucItem,
      listValue: state.listTool,
      image: ImageAsset.imageTools,
    ));

    listVT.add(InputRegisterModel(
      title: "Đơn vị:",
      isCompulsory: true,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listUnitAmount,
      typeInputEnum: TypeInputEnum.dmucItem,
    ));

    listCC.add(InputRegisterModel(
      title: "Đơn vị:",
      isCompulsory: true,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listUnitAmount,
      typeInputEnum: TypeInputEnum.dmucItem,
    ));

    emitter(state.copyWith(
        listWidget: list, listWidgetVT: listVT, listWidgetCC: listCC));
  }

  void _getDetailActivity(GetDetailActivityEvent event,
      Emitter<DetailActivityState> emitter) async {
    emitter(state.copyWith(
        isShowProgress: true,
        listWidget: [],
        listWidgetVT: [],
        listWidgetCC: [], listVatTuAdd: [], listCongCuAdd: []));
    final detailActivity = event.activityDiary;
    final listActivity = await DiaryDB.instance.getListActivity();
    final listTool = await DiaryDB.instance.getListTool();
    final listMaterial = await DiaryDB.instance.getListMaterial();
    final sharedPreferences = await SharedPreferences.getInstance();
    final categoryIdUnitArea = sharedPreferences.getInt(SharedPreferencesKey.unitArea) ?? -1;
    final categoryIdUnitAmount = sharedPreferences.getInt(SharedPreferencesKey.unitAmount) ?? -1;
    final listUnitArea = await DiaryDB.instance.getListUnit(categoryIdUnitArea);
    final listUnitAmount = await DiaryDB.instance.getListUnit(categoryIdUnitAmount);
    for (var element in listUnitAmount) {
      print("HoangCV: listUnitAmount: ${element.categoryId} : ${listUnitAmount.length} : ${listUnitArea.length}");
    }
    _initViewDetail(emitter);
    int index = listActivity
        .indexWhere((element) => element.id == detailActivity.activityId);
    //print("HoangCV: detailActivity.description: ${detailActivity.description} : ${detailActivity.media[0].fileContent} : ${listTool.length}");
    double imageWidth = state.imageWidth;
    double imageHeight = state.imageHeight;
    if (detailActivity.media.length < 2) {
      // Tính toán kích thước ảnh để hiển thị full màn hình
      imageWidth = 360;
      imageHeight = 240;
    } else if (detailActivity.media.length < 3) {
      // Tính toán kích thước ảnh để hiển thị full màn hình
      imageWidth = 180;
      imageHeight = 130;
    } else{
      imageWidth = 140;
      imageHeight = 100;
    }
    emitter(state.copyWith(
      isShowProgress: false,
      detailActivity: detailActivity,
      listActivity: listActivity,
      listMaterial: listMaterial,
      listTool: listTool,
        listUnitAmount: listUnitAmount,
      listUnitArea: listUnitArea,
      listVatTuAdd: detailActivity.material,
      listCongCuAdd: detailActivity.tool,
      listImage: detailActivity.media,
      moTaController: TextEditingController(text: detailActivity.description),
      nameController: TextEditingController(text: listActivity[index].name),
      peopleController: TextEditingController(),
      startTimeController: TextEditingController(
          text: Utils.formatDate(detailActivity.actionTime ?? "")),
      endTimeController: TextEditingController(
          text: Utils.formatDate(detailActivity.actionTime ?? "")),
      indexActivity: index,
      imageWidth: imageWidth, imageHeight: imageHeight
    ));
    for (int i = 0; i < state.listWidget.length; i++) {
      if (state.listWidget[i].title.compareTo("Tên công việc") == 0) {
        print("HoangCV: run way: ${index} : ${listActivity[index].name}");
/*        state.listWidget[i].positionSelected = index;
        state.listWidget[i].valueSelected = listActivity[index];
        state.listWidget[i].type = TypeInputRegister.Select;
        state.listWidget[i].listValue = listActivity;*/
        state.listWidget[i].controller = state.nameController;
      }
      if (state.listWidget[i].title.compareTo("Chi tiết công việc") == 0) {
        state.listWidget[i].controller = state.moTaController;
      }
      if (state.listWidget[i].title.compareTo("Người liên quan") == 0) {
        state.listWidget[i].controller = state.peopleController;
      }
      if (state.listWidget[i].title.compareTo("Thời gian thực hiện") == 0) {
        state.listWidget[i].controller = state.startTimeController;
      }
      if (state.listWidget[i].title.compareTo("Ngày kết thúc") == 0) {
        state.listWidget[i].controller = state.endTimeController;
/*        state.listWidget[i].valueSelected =
            Utils.formatStringToDate(detailActivity.actionTime ?? "");
        state.listWidget[i].type = TypeInputRegister.Select;*/
      }
    }
/*    print("HoangCV: state.moTaController: ${state.moTaController}");*/
    emitter(state.copyWith(listWidget: state.listWidget));
/*    for(int i = 0 ; i< state.listWidgetVT.length ; i++){
      int index = listActivity.indexWhere((element) => element.id ==detailActivity.activityId );
      if(state.listWidget[i].title.compareTo("Tên công việc")==0){
        state.listWidget[i].positionSelected = index;
        state.listWidget[i].valueSelected = listActivity[index];
        state.listWidget[i].valueDefault = listActivity[index];
      }
    }*/
  }

  FutureOr<void> _changeEditActivity(ChangeEditActivityEvent event,
      Emitter<DetailActivityState> emit) async {
    _changeViewEdit(emit);
  }

  FutureOr<void> _changeDetailActivity(ChangeDetailActivityEvent event,
      Emitter<DetailActivityState> emit) async {
    _changeViewDetail(emit);
  }

  Future<FutureOr<void>> _onSelectValue(OnSelectValueEvent event, Emitter<DetailActivityState> emit) async {
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
    if (event.list[event.index].valueSelected.runtimeType == DateTime ||
        event.list[event.index].typeInputEnum == TypeInputEnum.date) {
 //     setState(() {
      print("HoangCV: event.list[event.index].valueSelected: ${Utils.formatDateTimeToString(event.list[event.index].valueSelected)} :");
         int result1 = await ServiceInfoExtension().selectValue(event.list[event.index], event.context, (modelInput) {
        });
      print("HoangCV: result1: ${result1} : ${Utils.formatDateTimeToString(event.list[event.index].valueSelected)}" );
         if(result1 == 1) {
           if (event.list[event.index].title.compareTo("Thời gian thực hiện") == 0) {
             print("HoangCV:1 event.list[event.index].valueSelected: ${Utils
                 .formatDateTimeToString(
                 event.list[event.index].valueSelected)}");
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
        event.list[event.index].valueSelected = event.list[event.index].listValue[result];
        event.list[event.index].error = null;
       // });
        if(event.list[event.index].title.compareTo("Tên công việc")== 0){
          emit(state.copyWith(
            nameController: TextEditingController(text: event.list[event.index].valueSelected.name),
          ));
        }
        if(event.list[event.index].title.compareTo("Chi tiết công việc") == 0) {
          emit(state.copyWith(
            moTaController: event.list[event.index].controller,
          ));
        }
        if(event.list[event.index].title.compareTo("Người liên quan") == 0) {
          emit(state.copyWith(
            peopleController: event.list[event.index].controller,
          ));
        }
      }
    }
  }

  FutureOr<void> _addOrDeleteImage(AddOrDeleteImageEvent event, Emitter<DetailActivityState> emit) async{
    print("HoangCV: event. image: ${event.listImage.length}");
    List<ImageEntity> list = List.from(state.listImage);
    if(event.index == -1) {
      list.addAll(event.listImage);
    } else{
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
    } else{
      imageWidth = 140;
      imageHeight = 100;
    }
    emit(state.copyWith(listImage: list, imageWidth: imageWidth, imageHeight: imageHeight));
  }
}

class DetailActivityEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetDetailActivityEvent extends DetailActivityEvent {
  ActivityDiary activityDiary;
  GetDetailActivityEvent(this.activityDiary);
  @override
  List<Object?> get props => [activityDiary];
}

class ChangeEditActivityEvent extends DetailActivityEvent {
  ChangeEditActivityEvent();
}

class ChangeDetailActivityEvent extends DetailActivityEvent {
  ChangeDetailActivityEvent();
}

class OnSelectValueEvent extends DetailActivityEvent {
  List<InputRegisterModel> list;
  int index;
  BuildContext context;
  OnSelectValueEvent(this.list, this.index, this.context);
  @override
  List<Object?> get props => [list, index, context];
}

class AddOrDeleteImageEvent extends DetailActivityEvent {

  final List<ImageEntity> listImage;
  final int index;
  final BuildContext context;
  AddOrDeleteImageEvent(this.listImage, this.index, this.context);
  @override
  List<Object?> get props => [listImage, index, context];
}

class UpdateAvatarEvent extends DetailActivityEvent {
  //final ImageSource source;
  UpdateAvatarEvent();
}

class DetailActivityState extends BlocState {
  @override
  List<Object?> get props =>
      [
        detailActivity,
        formStatus,
        isShowProgress,
        listMaterial,
        listTool,
        listUnitAmount,
        listUnitArea,
        listActivity,
        listWidget,
        listWidgetVT,
        listWidgetCC,
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
        listUnitArea
      ];
  final ActivityDiary? detailActivity;
  final List<MaterialEntity> listMaterial;
  final List<Tool> listTool;
  final List<Unit> listUnitAmount;
  final List<Unit>? listUnitArea;
  final List<Activity> listActivity;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;
  List<InputRegisterModel> listWidget;
  List<InputRegisterModel> listWidgetVT;
  List<InputRegisterModel> listWidgetCC;
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
  bool isEdit;
  int indexActivity;
  double imageWidth;
  double imageHeight;


  DetailActivityState({this.detailActivity,
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
    this.listWidgetVT = const [],
    this.listWidgetCC = const [],
    this.listImage = const [],
    this.nameController,
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
    this.indexActivity = 0});

  DetailActivityState copyWith({
    ActivityDiary? detailActivity,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    List<MaterialEntity>? listMaterial,
    List<Tool>? listTool,
    List<Unit>? listUnitAmount,
    List<Unit>? listUnitArea,
    List<Activity>? listActivity,
    List<InputRegisterModel>? listWidget,
    List<InputRegisterModel>? listWidgetVT,
    List<InputRegisterModel>? listWidgetCC,
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
    bool? isEdit,
    int? indexActivity,
    double? imageWidth,
    double? imageHeight,
  }) {
    return DetailActivityState(
        detailActivity: detailActivity ?? this.detailActivity,
        formStatus: formStatus ?? this.formStatus,
        isShowProgress: isShowProgress ?? this.isShowProgress,
        listMaterial: listMaterial ?? this.listMaterial,
        listTool: listTool ?? this.listTool,
        listUnitArea: listUnitArea ?? this.listUnitArea,
        listUnitAmount: listUnitAmount ?? this.listUnitAmount,
        listActivity: listActivity ?? this.listActivity,
        listWidget: listWidget ?? this.listWidget,
        listWidgetVT: listWidgetVT ?? this.listWidgetVT,
        listWidgetCC: listWidgetCC ?? this.listWidgetCC,
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
        isEdit: isEdit ?? this.isEdit,
        imageWidth: imageWidth ?? this.imageWidth,
        imageHeight: imageHeight ?? this.imageHeight,
        indexActivity: indexActivity ?? this.indexActivity);
  }
}
