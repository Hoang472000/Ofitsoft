import 'dart:async';
import 'dart:ffi';

import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:diary_mobile/utils/widgets/dialog_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/entity/activity/activity_diary.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../data/entity/image/image_entity.dart';
import '../../../data/entity/item_default/material_entity.dart';
import '../../../data/local_data/diary_db.dart';
import '../../../data/remote_data/object_model/object_result.dart';
import '../../../data/repository.dart';
import '../../../resource/assets.dart';
import '../../../utils/constants/status_const.dart';
import '../../../utils/constants/shared_preferences_key.dart';
import '../../../utils/extenstion/extenstions.dart';
import '../../../utils/extenstion/input_register_model.dart';
import '../../../utils/extenstion/service_info_extension.dart';
import '../../../utils/status/form_submission_status.dart';
import '../../../utils/utils.dart';
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
    on<SaveValueTextFieldEvent>(_saveValueTextField);
    on<UpdateActivityEvent>(_updateActivity);
    on<BackEvent>(_back);
    //add(GetDetailActivityEvent());
  }

  bool edit = false;

  void _changeViewDetail(Emitter<DetailActivityState> emitter) {
    List<InputRegisterModel> list = [];
    List<InputRegisterModel> listCC = [];
    List<InputRegisterModel> listVT = [];
    List<InputRegisterModel> listArea = [];
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
        isCompulsory: false,
        maxLengthTextInput: 2000,
        type: TypeInputRegister.Non,
        typeInput: TextInputType.text,
        controller: state.moTaController,
        image: ImageAsset.imageFile));

/*    list.add(InputRegisterModel(
      title: "Người liên quan",
      isCompulsory: false,
      maxLengthTextInput: 200,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.text,
      controller: state.peopleController,
      image: ImageAsset.imageMan,
    ));*/

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

    listArea.add(InputRegisterModel(
      title: "Diện tích",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.number,
      controller: state.areaController,
      image: ImageAsset.imageManagement,
    ));

    listArea.add(InputRegisterModel(
      title: "Đơn vị",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listUnitArea,
      typeInputEnum: TypeInputEnum.dmucItem,
      controller: state.donViController,
    ));

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
      title: "Đơn vị",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listUnitAmount,
      typeInputEnum: TypeInputEnum.dmucItem,
    ));

    listCC.add(InputRegisterModel(
      title: "Đơn vị",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listUnitAmount,
      typeInputEnum: TypeInputEnum.dmucItem,
    ));

    emitter(state.copyWith(
        formStatus: const InitialFormStatus(),
        listWidget: list,
        listWidgetVT: listVT,
        listWidgetCC: listCC,
        listWidgetArea: listArea));
  }

  void _initViewDetail(Emitter<DetailActivityState> emitter, int id) {
    List<InputRegisterModel> list = [];
    List<InputRegisterModel> listCC = [];
    List<InputRegisterModel> listVT = [];
    List<InputRegisterModel> listArea = [];
    List<InputRegisterModel> listYield = [];
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
        isCompulsory: false,
        maxLengthTextInput: 2000,
        type: TypeInputRegister.Non,
        typeInput: TextInputType.text,
        controller: state.moTaController,
        image: ImageAsset.imageFile));

/*    list.add(InputRegisterModel(
      title: "Người liên quan",
      isCompulsory: false,
      maxLengthTextInput: 200,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.text,
      controller: state.peopleController,
      image: ImageAsset.imageMan,
    ));*/

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

    listArea.add(InputRegisterModel(
      title: "Diện tích",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.number,
      controller: state.areaController,
      maxLengthTextInput: 12,
      image: ImageAsset.imageManagement,
    ));

    listArea.add(InputRegisterModel(
      title: "Đơn vị",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listUnitArea,
      typeInputEnum: TypeInputEnum.dmucItem,
      controller: state.donViController,
    ));
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
      title: "Đơn vị",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listUnitAmount,
      typeInputEnum: TypeInputEnum.dmucItem,
    ));

    listCC.add(InputRegisterModel(
      title: "Đơn vị",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listUnitAmount,
      typeInputEnum: TypeInputEnum.dmucItem,
    ));
    if (id == 20) {
      listYield.add(InputRegisterModel(
        title: "Sản lượng",
        isCompulsory: false,
        type: TypeInputRegister.Non,
        typeInput: TextInputType.number,
        controller: state.yieldController,
        maxLengthTextInput: 10,
        image: ImageAsset.imageBudget,
      ));

      listYield.add(InputRegisterModel(
        title: "Đơn vị",
        isCompulsory: false,
        type: TypeInputRegister.Non,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        listValue: state.listUnitYield,
        typeInputEnum: TypeInputEnum.dmucItem,
        controller: state.yieldUnitController
      ));
    }
    emitter(state.copyWith(
        formStatus: const InitialFormStatus(),
        listWidget: list,
        listWidgetVT: listVT,
        listWidgetCC: listCC,
        listWidgetArea: listArea,
        listWidgetYield: listYield));
  }

  void _changeViewEdit(Emitter<DetailActivityState> emitter, int id) {
    List<InputRegisterModel> list = [];
    List<InputRegisterModel> listCC = [];
    List<InputRegisterModel> listVT = [];
    List<InputRegisterModel> listArea = [];
    List<InputRegisterModel> listYield = [];
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
        isCompulsory: false,
        maxLengthTextInput: 2000,
        type: TypeInputRegister.TextField,
        typeInput: TextInputType.text,
        controller: state.moTaController,
        image: ImageAsset.imageFile));

/*
    list.add(InputRegisterModel(
      title: "Người liên quan",
      isCompulsory: false,
      maxLengthTextInput: 200,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      controller: state.peopleController,
      image: ImageAsset.imageMan,
    ));
*/

    list.add(InputRegisterModel<String, DateTime>(
        title: "Thời gian thực hiện",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        valueSelected: Utils.stringToDate(state.startTimeController!.text),
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

    listArea.add(InputRegisterModel(
      title: "Diện tích",
      isCompulsory: false,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.number,
      controller: state.areaController,
      maxLengthTextInput: 12,
      image: ImageAsset.imageManagement,
    ));
    if (state.indexDonViArea != -1) {
      listArea.add(InputRegisterModel<Unit, Unit>(
        title: "Đơn vị",
        isCompulsory: false,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        listValue: state.listUnitArea,
        typeInputEnum: TypeInputEnum.dmucItem,
        positionSelected: state.indexDonViArea,
        valueSelected: state.listUnitArea[state.indexDonViArea],
      ));
    } else {
      listArea.add(InputRegisterModel<Unit, Unit>(
        title: "Đơn vị",
        isCompulsory: false,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        listValue: state.listUnitArea,
        typeInputEnum: TypeInputEnum.dmucItem,
        positionSelected: state.indexDonViArea,
      ));
    }

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
      title: "Đơn vị",
      isCompulsory: true,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listUnitAmount,
      typeInputEnum: TypeInputEnum.dmucItem,
    ));

    listCC.add(InputRegisterModel(
      title: "Đơn vị",
      isCompulsory: true,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listUnitAmount,
      typeInputEnum: TypeInputEnum.dmucItem,
    ));
    if (id == 20) {
      listYield.add(InputRegisterModel(
        title: "Sản lượng",
        isCompulsory: false,
        type: TypeInputRegister.TextField,
        typeInput: TextInputType.number,
        controller: state.yieldController,
        maxLengthTextInput: 10,
        image: ImageAsset.imageBudget,
      ));
      if (state.indexYieldUnit != -1) {
        listYield.add(InputRegisterModel<Unit, Unit>(
          title: "Đơn vị",
          isCompulsory: false,
          type: TypeInputRegister.Select,
          icon: Icons.arrow_drop_down,
          listValue: state.listUnitYield,
          typeInputEnum: TypeInputEnum.dmucItem,
          positionSelected: state.indexYieldUnit,
          valueSelected: state.listUnitYield[state.indexYieldUnit],
        ));
      } else {
        listYield.add(InputRegisterModel<Unit, Unit>(
          title: "Đơn vị",
          isCompulsory: false,
          type: TypeInputRegister.Select,
          icon: Icons.arrow_drop_down,
          listValue: state.listUnitYield,
          typeInputEnum: TypeInputEnum.dmucItem,
          positionSelected: state.indexYieldUnit,
        ));
      }
    }
    emitter(state.copyWith(
        formStatus: const InitialFormStatus(),
        listWidget: list,
        listWidgetVT: listVT,
        listWidgetCC: listCC,
        listWidgetArea: listArea,
        listWidgetYield: listYield
    ));
  }

  void _getDetailActivity(GetDetailActivityEvent event,
      Emitter<DetailActivityState> emitter) async {
    if (event.resetView) {
      emitter(state.copyWith(
          isShowProgress: true,
          formStatus: const InitialFormStatus(),
          listVatTuAdd: [],
          listCongCuAdd: []));
    } else {
      emitter(state.copyWith(
          isShowProgress: true,
          formStatus: const InitialFormStatus(),
          listWidget: [],
          listWidgetVT: [],
          listWidgetCC: [],
          listVatTuAdd: [],
          listCongCuAdd: []));
    }
    final detailActivity = event.activityDiary;
    final copiedActivityDiary = ActivityDiary.copy(detailActivity);
    print(
        "HoangCV: copiedActivityDiary: ${copiedActivityDiary.material.length}  : detailActivity.description: ${detailActivity.description}");
    final listActivity = await DiaryDB.instance.getListActivity();
    final listTool = await DiaryDB.instance.getListTool();
    final listMaterial = await DiaryDB.instance.getListMaterial();
    final sharedPreferences = await SharedPreferences.getInstance();
    final listCopiesVTAdd = <MaterialEntity>[];
    listCopiesVTAdd.addAll(detailActivity.material
        .map((material) => MaterialEntity.copy(material)));
    final listCopiesCCAdd = <Tool>[];
    listCopiesCCAdd.addAll(detailActivity.tool.map((tool) => Tool.copy(tool)));
    final categoryIdUnitArea =
        sharedPreferences.getInt(SharedPreferencesKey.unitArea) ?? -1;
    final categoryIdUnitAmount =
        sharedPreferences.getInt(SharedPreferencesKey.unitAmount) ?? -1;
    final categoryIdUnitYield =
        sharedPreferences.getInt(SharedPreferencesKey.unitYield) ?? -1;
    final listUnitArea = await DiaryDB.instance.getListUnit(categoryIdUnitArea);
    final listUnitAmount =
        await DiaryDB.instance.getListUnit(categoryIdUnitAmount);
    final listUnitYield =
        await DiaryDB.instance.getListUnit(categoryIdUnitYield);
    _initViewDetail(emitter, detailActivity.activityId ?? -1);
    int index = listActivity
        .indexWhere((element) => element.id == detailActivity.activityId);
    int indexArea = listUnitArea
        .indexWhere((element) => element.id == detailActivity.actionAreaUnitId);
    int indexAreaMax = listUnitArea
        .indexWhere((element) => element.id == event.diary.areaUnitId);
    int indexYield = listUnitYield
        .indexWhere((element) => element.id == detailActivity.amountUnitId);
/*    int indexYield = listUnitYield
        .indexWhere((element) => element.id == detailActivity.actionAreaUnitId);*/
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
    } else {
      imageWidth = 140;
      imageHeight = 100;
    }
    emitter(state.copyWith(
        isShowProgress: false,
        detailActivity: detailActivity,
        copiedActivityDiary: copiedActivityDiary,
        listActivity: listActivity,
        listMaterial: listMaterial,
        listTool: listTool,
        listUnitAmount: listUnitAmount,
        listUnitArea: listUnitArea,
        listVatTuAdd: listCopiesVTAdd,
        listCongCuAdd: listCopiesCCAdd,
        listUnitYield: listUnitYield,
        listImage: detailActivity.media,
        moTaController: TextEditingController(text: detailActivity.description),
        nameController: TextEditingController(text: listActivity[index].name),
        peopleController: TextEditingController(),
        areaController:
            TextEditingController(text: "${detailActivity.actionArea ?? ''}"),
        donViController:
            TextEditingController(text: "${detailActivity.actionAreaUnitName}"),
        startTimeController: TextEditingController(
            text: Utils.formatDate(detailActivity.actionTime ?? "")),
        endTimeController: TextEditingController(
            text: Utils.formatDate(detailActivity.actionTime ?? "")),
        yieldController:
            TextEditingController(text: "${detailActivity.amount ?? ''}"),
        yieldUnitController:
            TextEditingController(text: "${detailActivity.amountUnitName}"),
        diary: event.diary,
        areaMax: (event.diary.area ?? 0.0) * double.parse('${listUnitArea[indexAreaMax].convert}'),
        indexActivity: index,
        indexDonViArea: indexArea,
        indexYieldUnit: indexYield,
        imageWidth: imageWidth,
        imageHeight: imageHeight));
    for (int i = 0; i < state.listWidget.length; i++) {
      if (state.listWidget[i].title.compareTo("Tên công việc") == 0) {
        state.listWidget[i].controller = state.nameController;
        state.listWidget[i].valueSelected = state.listActivity[index];
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
      }
    }
    for (int i = 0; i < state.listWidgetArea.length; i++) {
      print(
          "HoangCV: listWidgetArea run way: ${index} : ${listActivity[index].name}");
      if (state.listWidgetArea[i].title.compareTo("Diện tích") == 0) {
        state.listWidgetArea[i].controller = state.areaController;
      }
      if (state.listWidgetArea[i].title.compareTo("Đơn vị") == 0) {
        state.listWidgetArea[i].controller = state.donViController;
      }
    }
    for (int i = 0; i < state.listWidgetYield.length; i++) {
      print(
          "HoangCV: listWidgetArea run way: ${index} : ${listActivity[index].name}");
      if (state.listWidgetYield[i].title.compareTo("Sản lượng") == 0) {
        state.listWidgetYield[i].controller = state.yieldController;
      }
      if (state.listWidgetYield[i].title.compareTo("Đơn vị") == 0) {
        state.listWidgetYield[i].controller = state.yieldUnitController;
      }
    }
    for (int i = 0; i < state.listWidgetVT.length; i++) {
      if (state.listWidgetVT[i].title.compareTo("Vật tư") == 0) {
        //state.listWidgetVT[i].controller = state.areaController;
        //state.listWidget[i].valueSelected = state.listActivity[index];
      }
    }
    for (int i = 0; i < state.listWidgetCC.length; i++) {
      if (state.listWidgetCC[i].title.compareTo("Công cụ") == 0) {
        // state.listWidgetCC[i].controller = state.areaController;
        //state.listWidget[i].valueSelected = state.listActivity[index];
      }
    }
    print(
        "HoangCV: listWidgetArea run way: ${index} : ${listActivity[index].name}");
    emitter(state.copyWith(
        listWidget: state.listWidget,
        listWidgetArea: state.listWidgetArea,
        listWidgetCC: state.listWidgetCC,
        listWidgetVT: state.listWidgetVT));
  }

  FutureOr<void> _changeEditActivity(
      ChangeEditActivityEvent event, Emitter<DetailActivityState> emit) async {
    _changeViewEdit(emit, state.detailActivity!.activityId ?? -1);
  }

  FutureOr<void> _changeDetailActivity(ChangeDetailActivityEvent event,
      Emitter<DetailActivityState> emit) async {
    //_changeViewDetail(emit);
    add(GetDetailActivityEvent(state.copiedActivityDiary ?? ActivityDiary(), state.diary ?? Diary(),
        resetView: true));
  }

  Future<FutureOr<void>> _onSelectValue(
      OnSelectValueEvent event, Emitter<DetailActivityState> emit) async {
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
    bool harvesting = false;
    if (event.list[event.index].title.compareTo("Tên công việc") == 0) {
      if (state.detailActivity?.harvesting != null &&
          (state.detailActivity!.harvesting ?? false)) {
        if (state.detailActivity?.amount != null &&
            (state.detailActivity!.amount ?? 0) > 0) {
          harvesting = true;
          DiaLogManager.showDialogSuccess(
              event.context, "Không thể thay đổi hoạt động thu hoạch", () {
            Get.back();
          });
        }
      }
    }
    if (!harvesting) {
      emit(state.copyWith(
        formStatus: const InitialFormStatus(),
      ));
      if (event.list[event.index].valueSelected.runtimeType == DateTime ||
          event.list[event.index].typeInputEnum == TypeInputEnum.date) {
        //     setState(() {
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
          if (event.list[event.index].title.compareTo("Thời gian thực hiện") ==
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
              indexActivity: result,
            ));
            if (event.list[event.index].listValue[result].id == 20) {
              List<InputRegisterModel> listYield = [];
              listYield.add(InputRegisterModel(
                title: "Sản lượng",
                isCompulsory: false,
                type: TypeInputRegister.TextField,
                typeInput: TextInputType.number,
                controller: state.yieldController,
                maxLengthTextInput: 10,
                image: ImageAsset.imageBudget,
              ));

              listYield.add(InputRegisterModel(
                title: "Đơn vị",
                isCompulsory: false,
                type: TypeInputRegister.Select,
                icon: Icons.arrow_drop_down,
                positionSelected: -1,
                listValue: state.listUnitYield,
                typeInputEnum: TypeInputEnum.dmucItem,
              ));
              emit(state.copyWith(listWidgetYield: listYield));
            } else {
              emit(state.copyWith(listWidgetYield: []));
            }
          }
          if (event.list[event.index].title.compareTo("Đơn vị") == 0) {
            print("state.indexArea222: ${state.indexDonViArea} : ${state
                .indexActivity} : ${state.listWidgetArea[1].positionSelected}");
            if ((double.parse(
                state.areaController!.text.isNotEmpty ? state.areaController!
                    .text : "0") * double.parse(
                '${state.listUnitArea[state.listWidgetArea[1].positionSelected]
                    .convert}')) > state.areaMax) {
              state.listWidgetArea[0].error =
              "Diện tích phải nhỏ hơn diện tích lô trồng";
            } else {
              state.listWidgetArea[0].error = null;
            }
            emit(state.copyWith(
                donViController: TextEditingController(
                    text: event.list[event.index].valueSelected.name),
                indexDonViArea: result));
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
              indexDonViArea: result,
            ));
          }
          /*       if (event.list[event.index].title.compareTo("S") == 0) {
          emit(state.copyWith(
            areaController: event.list[event.index].controller,
            indexDonViArea: result,
          ));
        }*/
        }
      }
    }
  }

  FutureOr<void> _addOrDeleteImage(
      AddOrDeleteImageEvent event, Emitter<DetailActivityState> emit) async {
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
      SaveValueTextFieldEvent event, Emitter<DetailActivityState> emit) {
    emit(state.copyWith(formStatus: const InitialFormStatus()));
    print("HoangCV: bug111: ${event.text} : ${event.inputRegisterModel.title} : ${state.areaMax} : ${(double.parse(event.text.isNotEmpty ? event.text : "0") * double.parse('${state.listUnitArea[state.listWidgetArea[1].positionSelected].convert}'))> state.areaMax}");
    if (event.inputRegisterModel.title.compareTo("Chi tiết công việc") == 0) {
      emit(state.copyWith(
          moTaController: TextEditingController(text: event.text)));
    } else if (event.inputRegisterModel.title.compareTo("Diện tích") == 0) {
      emit(state.copyWith(
          areaController: TextEditingController(text: event.text)));
      if((double.parse(event.text.isNotEmpty ? event.text : "0") * double.parse('${state.listUnitArea[state.listWidgetArea[1].positionSelected].convert}')) > state.areaMax){
        state.listWidgetArea[0].error = "Diện tích phải nhỏ hơn diện tích lô trồng";
      } else{
        state.listWidgetArea[0].error = null;
      }
      emit(state.copyWith(
          areaController: TextEditingController(text: event.text)));
    }
  }

  FutureOr<void> _updateActivity(
      UpdateActivityEvent event, Emitter<DetailActivityState> emit) async {
    print("HoangCV: state.indexActivity: ${state.indexActivity}");
    emit(state.copyWith(
        isShowProgress: true, formStatus: const InitialFormStatus()));
    List<InputRegisterModel> list = List.from(state.listWidget);
    List<InputRegisterModel> listArea = List.from(state.listWidgetArea);
    bool validate = true;
    if (state.indexActivity == -1) {
      validate = false;
      state.listWidget[0].error = "Vui lòng chọn tên công việc";
    }
    else if(state.areaController!.text.isEmpty){
      validate = false;
      state.listWidgetArea[0].error = "Vui lòng nhập diện tích";
    }else if(state.areaController!.text.isNotEmpty && double.parse(state.areaController!.text)<=0){
      validate = false;
      state.listWidgetArea[0].error = "Vui lòng nhập diện tích > 0";
    }
    else if (state.areaController!.text.isNotEmpty &&
        double.parse(state.areaController!.text) > 0 &&
        state.listWidgetArea[1].valueSelected == null) {
      validate = false;
      state.listWidgetArea[1].error = "Vui lòng chọn đơn vị";
    }else if(state.areaController!.text.isNotEmpty &&
        state.listWidgetArea[1].valueSelected != null){
      if((double.parse(state.areaController!.text.isNotEmpty ? state.areaController!.text : "0") * double.parse('${state.listUnitArea[state.listWidgetArea[1].positionSelected].convert}')) > state.areaMax){
        validate = false;
        state.listWidgetArea[0].error = "Diện tích phải nhỏ hơn diện tích lô trồng";
      } else{
        state.listWidgetArea[0].error = null;
      }
    }
    if(validate) {
      if ((state.listActivity[state.indexActivity].harvesting ??
          false) && state.yieldController!.text.isEmpty) {
        validate = false;
        state.listWidgetYield[0].error = "Vui lòng nhập sản lượng";
      } else if ((state.listActivity[state.indexActivity].harvesting ??
          false) && state.yieldController!.text.isNotEmpty &&
              state.listWidgetYield[1].valueSelected == null) {
        validate = false;
        state.listWidgetYield[1].error = "Vui lòng chọn đơn vị";
      }
    }
    if (!validate) {
      emit(state.copyWith(isShowProgress: false));
      print("HoangCV: state.indexActivity: ${state.indexActivity}");
    } else {
      emit(state.copyWith(formStatus: FormSubmitting()));
      ActivityDiary diary = ActivityDiary(
        id: state.detailActivity!.id,
        activityId: state.listActivity[state.indexActivity].id,
        activityName: state.listActivity[state.indexActivity].name,
        actionTime: state.listWidget[2].valueSelected.toString().split('.')[
            0] /* Utils.formatDateTimeToStringFull(state.listWidget[2].valueSelected)*/,
        actionArea: state.areaController!.text.isNotEmpty
            ? double.parse(state.areaController!.text)
            : null,
        actionAreaUnitId: state.listWidgetArea[1].valueSelected?.id,
        actionAreaUnitName: state.listWidgetArea[1].valueSelected?.name,
        description: state.moTaController!.text,
        harvesting: state.listActivity[state.indexActivity].harvesting,
        amount: state.yieldController!.text.isNotEmpty
            ? double.parse(state.yieldController!.text)
            : null,
        amountUnitId: state.listWidgetYield.isNotEmpty ? state.listWidgetYield[1].valueSelected?.id : null,
        amountUnitName: state.listWidgetYield.isNotEmpty ? state.listWidgetYield[1].valueSelected?.name : null,
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

  FutureOr<void> _back(BackEvent event, Emitter<DetailActivityState> emit) {
    emit(state.copyWith(
        isShowProgress: false,
        formStatus: const InitialFormStatus(),
        listVatTuAdd: [],
        listCongCuAdd: []));
    print(
        "HoangCV: state.copiedActivityDiary!.material: ${state.copiedActivityDiary!.material.length} : ${state.listVatTuAdd.length}");
    print(
        "HoangCV: event.listMtl.length: ${event.listMtl.length} : ${event.listTool.length}");
    state.copiedActivityDiary!.material = event.listMtl;
    state.copiedActivityDiary!.tool = event.listTool;
    var copiesActivity =
        ActivityDiary.copy(state.detailActivity ?? ActivityDiary());
    copiesActivity.tool = event.listTool;
    copiesActivity.material = event.listMtl;
    emit(state.copyWith(
      isShowProgress: true,
      detailActivity: copiesActivity,
      listVatTuAdd: event.listMtl,
      listCongCuAdd: event.listTool,
    ));
    print("HoangCV:1111 : ${state.detailActivity!.material.length}");
  }
}

class DetailActivityEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetDetailActivityEvent extends DetailActivityEvent {
  ActivityDiary activityDiary;
  bool resetView;
  Diary diary;

  GetDetailActivityEvent(this.activityDiary, this.diary, {this.resetView = false});

  @override
  List<Object?> get props => [activityDiary, resetView, diary];
}

class ChangeEditActivityEvent extends DetailActivityEvent {
  ChangeEditActivityEvent();
}

class ChangeDetailActivityEvent extends DetailActivityEvent {
  ChangeDetailActivityEvent();
}

class BackEvent extends DetailActivityEvent {
  ActivityDiary activityDiary;
  List<MaterialEntity> listMtl;
  List<Tool> listTool;

  BackEvent(this.activityDiary, this.listTool, this.listMtl);

  @override
  List<Object?> get props => [activityDiary, listTool, listMtl];
}

class UpdateActivityEvent extends DetailActivityEvent {
  UpdateActivityEvent();
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

class SaveValueTextFieldEvent extends DetailActivityEvent {
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

class UpdateAvatarEvent extends DetailActivityEvent {
  //final ImageSource source;
  UpdateAvatarEvent();
}

class DetailActivityState extends BlocState {
  @override
  List<Object?> get props => [
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
        listUnitArea,
        listWidgetArea,
        areaController,
        indexDonViArea,
        copiedActivityDiary,
        listWidgetYield,
        listUnitYield,
        yieldController,
        indexYieldUnit,
        areaMax,
    diary,
      ];
  final Diary? diary;
  final ActivityDiary? detailActivity;
  final ActivityDiary? copiedActivityDiary;
  final List<MaterialEntity> listMaterial;
  final List<Tool> listTool;
  final List<Unit> listUnitAmount;
  final List<Unit> listUnitArea;
  final List<Activity> listActivity;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;
  List<InputRegisterModel> listWidget;
  List<InputRegisterModel> listWidgetVT;
  List<InputRegisterModel> listWidgetCC;
  List<InputRegisterModel> listWidgetArea;
  List<ImageEntity> listImage = [];
  final List<MaterialEntity> listVatTuAdd;
  final List<Tool> listCongCuAdd;
  TextEditingController? nameController = TextEditingController();
  TextEditingController? soCayController = TextEditingController();
  TextEditingController? soLuongController = TextEditingController();
  TextEditingController? moTaController = TextEditingController();
  TextEditingController? donViController = TextEditingController();
  TextEditingController? peopleController = TextEditingController();
  TextEditingController? startTimeController = TextEditingController();
  TextEditingController? endTimeController = TextEditingController();
  TextEditingController? areaController = TextEditingController();
  TextEditingController? yieldController = TextEditingController();
  TextEditingController? yieldUnitController = TextEditingController();
  List<InputRegisterModel> listWidgetYield;
  final List<Unit> listUnitYield;
  bool isEdit;
  int indexActivity;
  int indexDonViArea;
  int indexYieldUnit;
  double imageWidth;
  double imageHeight;
  double areaMax;

  DetailActivityState({
    this.detailActivity,
    this.copiedActivityDiary,
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
    this.listWidgetArea = const [],
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
    this.yieldController,
    this.yieldUnitController,
    this.listUnitYield = const [],
    this.listWidgetYield = const [],
    this.indexYieldUnit = 0,
    this.areaMax = 0,
    this.diary,
  });

  DetailActivityState copyWith({
    ActivityDiary? detailActivity,
    ActivityDiary? copiedActivityDiary,
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
    List<InputRegisterModel>? listWidgetArea,
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
    TextEditingController? yieldController,
    TextEditingController? yieldUnitController,
    List<InputRegisterModel>? listWidgetYield,
    List<Unit>? listUnitYield,
    bool? isEdit,
    int? indexActivity,
    int? indexDonViArea,
    int? indexYieldUnit,
    double? imageWidth,
    double? imageHeight,
    double? areaMax,
    Diary? diary,
  }) {
    return DetailActivityState(
      copiedActivityDiary: copiedActivityDiary ?? this.copiedActivityDiary,
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
      listWidgetArea: listWidgetArea ?? this.listWidgetArea,
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
      listUnitYield: listUnitYield ?? this.listUnitYield,
      yieldUnitController: yieldUnitController ?? this.yieldUnitController,
      listWidgetYield: listWidgetYield ?? this.listWidgetYield,
      yieldController: yieldController ?? this.yieldController,
      indexYieldUnit: indexYieldUnit ?? this.indexYieldUnit,
        areaMax: areaMax ?? this.areaMax,
        diary: diary ?? this.diary,
    );
  }
}
