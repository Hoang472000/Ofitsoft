import 'dart:async';

import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:diary_mobile/data/remote_data/object_model/object_result.dart';
import 'package:diary_mobile/utils/constants/status_const.dart';
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
import '../../../utils/status/form_submission_status.dart';
import '../../../utils/utils.dart';
import '../../bloc_event.dart';
import '../../bloc_state.dart';

class AddActivityBloc extends Bloc<AddActivityEvent, AddActivityState> {
  final Repository repository;

  AddActivityBloc(this.repository) : super(AddActivityState()) {
    on<InitAddActivityEvent>(_initAddActivity);
    on<OnSelectValueEvent>(_onSelectValue);
    on<AddOrDeleteImageEvent>(_addOrDeleteImage);
    on<AddActivityDiaryEvent>(_addActivityDiary);
    on<SaveValueTextFieldEvent>(_saveValueTextField);
    // add(InitAddActivityEvent());
  }

  bool edit = false;

  void _initViewAdd(Emitter<AddActivityState> emitter) {
    List<InputRegisterModel> list = [];
    List<InputRegisterModel> listCC = [];
    List<InputRegisterModel> listVT = [];
    List<InputRegisterModel> listArea = [];
    print(
        "HoangCV:state.listUnitArea: ${state.listUnitArea.length} : ${state.indexArea}  ");
    list.add(InputRegisterModel<Activity, Activity>(
        title: "Tên công việc",
        isCompulsory: true,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        listValue: state.listActivity,
        typeInputEnum: TypeInputEnum.dmucItem,
        hasSearch: true,
        image: ImageAsset.imageActivityFarm));
    list.add(InputRegisterModel(
        title: "Chi tiết công việc",
        isCompulsory: false,
        maxLengthTextInput: 2000,
        type: TypeInputRegister.TextField,
        typeInput: TextInputType.text,
        controller: state.moTaController,
        image: ImageAsset.imageFile));

    list.add(InputRegisterModel<String, DateTime>(
        title: "Thời gian thực hiện",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        valueSelected: DateTime.now(),
        controller: state.startTimeController,
        image: ImageAsset.imageCalendarBegin,
        icon: Icons.calendar_today));

/*    list.add(InputRegisterModel<String, DateTime>(
        title: "Ngày kết thúc",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        valueSelected: DateTime.now(),
        image: ImageAsset.imageCalendarEnd,
        icon: Icons.calendar_today));*/
    listArea.add(InputRegisterModel(
      title: "Diện tích",
      isCompulsory: false,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.number,
      controller: state.areaController,
      maxLengthTextInput: 10,
      image: ImageAsset.imageManagement,
    ));

    listArea.add(InputRegisterModel(
      title: "Đơn vị",
      isCompulsory: false,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listUnitArea,
      //valueSelected: state.listUnitArea[state.indexArea],
      typeInputEnum: TypeInputEnum.dmucItem,
    ));

    listVT.add(InputRegisterModel<MaterialEntity, MaterialEntity>(
        title: "Vật tư liên quan",
        isCompulsory: false,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        typeInputEnum: TypeInputEnum.dmucItem,
        listValue: state.listMaterial,
        image: ImageAsset.imageGardening));

    listCC.add(InputRegisterModel<Tool, Tool>(
      title: "Công cụ sử dụng",
      isCompulsory: false,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listTool,
      typeInputEnum: TypeInputEnum.dmucItem,
      image: ImageAsset.imageTools,
    ));

    listVT.add(InputRegisterModel(
      title: "Đơn vị",
      isCompulsory: false,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listUnitAmount,
      typeInputEnum: TypeInputEnum.dmucItem,
    ));

    listCC.add(InputRegisterModel(
      title: "Đơn vị",
      isCompulsory: false,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listUnitAmount,
      typeInputEnum: TypeInputEnum.dmucItem,
    ));
    emitter(state.copyWith(
        listWidget: list,
        listWidgetVT: listVT,
        listWidgetCC: listCC,
        listWidgetArea: listArea,
        formStatus: const InitialFormStatus()));
  }

  void _initAddActivity(
      InitAddActivityEvent event, Emitter<AddActivityState> emitter) async {
    emitter(state.copyWith(
        isShowProgress: true,
        listWidget: [],
        listWidgetVT: [],
        listWidgetCC: [],
        listWidgetArea: [],
        listCongCuAdd: [],
        listVatTuAdd: []));
    final listActivity = await DiaryDB.instance.getListActivity();
    final listTool = await DiaryDB.instance.getListTool();
    final listMaterial = await DiaryDB.instance.getListMaterial();
    final sharedPreferences = await SharedPreferences.getInstance();
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
/*    listActivity.forEach((element) {
      print("HoangCV: indexArea:`11 ${element.toolIds} : ${element.materialIds}");
    });*/
    int indexAreaUnit = listUnitArea
        .indexWhere((element) => element.id == event.diary.areaUnitId);
    print("HoangCV: indexArea: ${indexAreaUnit} : ${event.diary.areaUnitId}");
    emitter(state.copyWith(
      isShowProgress: false,
      formStatus: const InitialFormStatus(),
       detailActivity: event.diary,
      listActivity: listActivity,
      listMaterial: listMaterial,
      listTool: listTool,
      listMaterialAll: listMaterial,
      listToolAll: listTool,
      listUnitAmount: listUnitAmount,
      listUnitArea: listUnitArea,
      listUnitYield: listUnitYield,
      indexArea: indexAreaUnit,
      seasonId: event.seasonId,
      startTimeController:
          TextEditingController(text: DateTime.now().toString().split('.')[0]),
      areaController: TextEditingController(text: "${event.diary.area ?? 0}"),
      moTaController: TextEditingController(),
      yieldController: TextEditingController(),
      areaMax: (event.diary.area ?? 0.0) * double.parse('${listUnitArea[indexAreaUnit].convert}'),
/*        moTaController: TextEditingController(text: detailActivity.description),
        nameController: TextEditingController(text: listActivity[index].name),
        peopleController: TextEditingController(),
        startTimeController: TextEditingController(
            text: Utils.formatDate(detailActivity.actionTime ?? "")),
        endTimeController: TextEditingController(
            text: Utils.formatDate(detailActivity.actionTime ?? "")),
        indexActivity: index,
        imageWidth: imageWidth, imageHeight: imageHeight*/
    ));
    _initViewAdd(emitter);
    state.listWidgetArea[1].valueSelected = state.listUnitArea[indexAreaUnit];
    state.listWidgetArea[1].positionSelected = indexAreaUnit;
    emit(state.copyWith(listWidgetArea: state.listWidgetArea, indexArea: indexAreaUnit,       isShowProgress: false,));

    emitter(state.copyWith(listWidget: state.listWidget));
    print("state.indexArea: ${state.indexArea} : $indexAreaUnit : ${state.indexActivity} : ${state.detailActivity?.areaUnitId}");
  }

  Future<FutureOr<void>> _onSelectValue(
      OnSelectValueEvent event, Emitter<AddActivityState> emit) async {
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
    emit(state.copyWith(formStatus: const InitialFormStatus()));
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
              indexActivity: result));
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
          List<int> tool = event.list[event.index].valueSelected.toolIds;
          List<int> material = event.list[event.index].valueSelected.materialIds;
          final listTool = <Tool>[];
          listTool.addAll(state.listToolAll.map((tool) => Tool.copy(tool)));
          final listMaterial = <MaterialEntity>[];
          listMaterial.addAll(state.listMaterialAll.map((material) => MaterialEntity.copy(material)));
          listTool.removeWhere((element) => !tool.contains(element.id));
          listMaterial.removeWhere((element) => !material.contains(element.id));
          emit(state.copyWith(listMaterial: listMaterial, listTool: listTool));
          state.listWidgetVT[0].listValue= listMaterial;
          state.listWidgetCC[0].listValue= listTool;
          print("HoangCV: state.listMaterial: ${listMaterial.length} : ${listTool.length} : ${state.listWidgetVT[0].listValue.length}");
        }
        if (event.list[event.index].title.compareTo("Đơn vị") == 0) {
          print("state.indexArea222: ${state.indexArea} : ${state.indexActivity} : ${state.listWidgetArea[1].positionSelected}");
          if((double.parse(state.areaController!.text.isNotEmpty ? state.areaController!.text : "0") * double.parse('${state.listUnitArea[state.listWidgetArea[1].positionSelected].convert}')) > state.areaMax){
            state.listWidgetArea[0].error = "Diện tích phải nhỏ hơn diện tích lô trồng";
          } else{
            state.listWidgetArea[0].error = null;
          }
          emit(state.copyWith(
              donViController: TextEditingController(
                  text: event.list[event.index].valueSelected.name),
              indexArea: result));
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
      }
    }
  }

  FutureOr<void> _addOrDeleteImage(
      AddOrDeleteImageEvent event, Emitter<AddActivityState> emit) async {
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

  FutureOr<void> _addActivityDiary(
      AddActivityDiaryEvent event, Emitter<AddActivityState> emit) async {
    print("HoangCV: state.indexActivity: ${state.indexActivity} : ${state.yieldController!.text.isEmpty}");
    if(state.listWidgetYield.isNotEmpty) {
      state.listWidgetYield[0].error = null;
      state.listWidgetYield[1].error = null;
    }
    emit(state.copyWith(
        isShowProgress: true, formStatus: const InitialFormStatus()));
    List<InputRegisterModel> list = List.from(state.listWidget);
    List<InputRegisterModel> listArea = List.from(state.listWidgetArea);
    bool validate = true;
    if (state.indexActivity == -1) {
      validate = false;
      state.listWidget[0].error = "Vui lòng chọn tên công việc";
    } else if(state.areaController!.text.isEmpty){
      validate = false;
      state.listWidgetArea[0].error = "Vui lòng nhập diện tích";
    }else if(state.areaController!.text.isNotEmpty && double.parse(state.areaController!.text)<=0){
      validate = false;
      state.listWidgetArea[0].error = "Vui lòng nhập diện tích > 0";
    } else if (state.areaController!.text.isNotEmpty && state.listWidgetArea[1].valueSelected == null) {
      validate = false;
      state.listWidgetArea[1].error = "Vui lòng chọn đơn vị";
    } else if(state.areaController!.text.isNotEmpty && state.listWidgetArea[1].valueSelected != null){
      if((double.parse(state.areaController!.text.isNotEmpty ? state.areaController!.text : "0") * double.parse('${state.listUnitArea[state.listWidgetArea[1].positionSelected].convert}')) > state.areaMax){
        validate = false;
        state.listWidgetArea[0].error = "Diện tích phải nhỏ hơn diện tích lô trồng";
      } else{
        state.listWidgetArea[0].error = null;
      }
    }
    if(validate) {
      if ((state.listActivity[state.indexActivity].harvesting ?? false) &&
          state.yieldController!.text.isEmpty) {
        print("HoangCV: state.yieldController!.text.isEmpty");
        validate = false;
        state.listWidgetYield[0].error = "Vui lòng nhập sản lượng";
      } else
      if ((state.listActivity[state.indexActivity].harvesting ?? false) &&
          state.yieldController!.text.isNotEmpty &&
          state.listWidgetYield[1].valueSelected == null) {
        validate = false;
        state.listWidgetYield[1].error = "Vui lòng chọn đơn vị";
      }
    }
    if (!validate) {
      emit(state.copyWith(isShowProgress: false));
      print("HoangCV: state.indexActivity: ${state.indexActivity}");
    } else {
      emit(state.copyWith(isShowProgress: false, formStatus: FormSubmitting()));
      ActivityDiary diary = ActivityDiary(
        seasonFarmId: state.seasonId,
        activityId: state.listActivity[state.indexActivity].id,
        activityName: state.listActivity[state.indexActivity].name,
        actionTime: state.listWidget[2].valueSelected.toString().split('.')[
            0] /* Utils.formatDateTimeToStringFull(state.listWidget[2].valueSelected)*/,
        actionArea: state.areaController!.text.isNotEmpty
            ? double.parse(state.areaController!.text)
            : null,
        actionAreaUnitId: /*state.listWidgetArea[1].valueSelected != null ? */
            state.listWidgetArea[1].valueSelected?.id,
        actionAreaUnitName: state.listWidgetArea[1].valueSelected?.name,
        harvesting: state.listActivity[state.indexActivity].harvesting,
        amount: state.yieldController!.text.isNotEmpty
            ? double.parse(state.yieldController!.text)
            : null,
        amountUnitId: state.listWidgetYield.isNotEmpty ? state.listWidgetYield[1].valueSelected?.id : null,
        amountUnitName: state.listWidgetYield.isNotEmpty ? state.listWidgetYield[1].valueSelected?.name : null,
        description: state.moTaController!.text,
        tool: state.listCongCuAdd,
        material: state.listVatTuAdd,
        media: state.listImage,
      );
      //"is_shown": true,
      ObjectResult objectResult = await repository.addActivityDiary(diary);
      if (objectResult.responseCode == StatusConst.code00) {
        //_changeViewEdit(emit);
      }
      if (objectResult.responseCode == StatusConst.code00 || objectResult.responseCode == StatusConst.code06) {
        //_changeViewEdit(emit);
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionSuccess(success: objectResult.message)));
      } else if (objectResult.responseCode == StatusConst.code01) {
        //_changeViewEdit(emit);
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionFailed(objectResult.message)));
      }
    }
  }

  FutureOr<void> _saveValueTextField(
      SaveValueTextFieldEvent event, Emitter<AddActivityState> emit) {
    print("HoangCV: bug: ${event.text} : ${event.inputRegisterModel.title}");
    if (event.inputRegisterModel.title.compareTo("Chi tiết công việc") == 0) {
      emit(state.copyWith(
          moTaController: TextEditingController(text: event.text)));
    } else if (event.inputRegisterModel.title.compareTo("Diện tích") == 0) {
      print("state.indexArea222: ${state.indexArea} : ${state.indexActivity} : ${state.listWidgetArea[1].positionSelected}");
      if((double.parse(event.text.isNotEmpty ? event.text : "0") * double.parse('${state.listUnitArea[state.listWidgetArea[1].positionSelected].convert}')) > state.areaMax){
        state.listWidgetArea[0].error = "Diện tích phải nhỏ hơn diện tích lô trồng";
      } else{
        state.listWidgetArea[0].error = null;
      }
      emit(state.copyWith(
          areaController: TextEditingController(text: event.text), listWidgetArea: state.listWidgetArea));
    } else if (event.inputRegisterModel.title.compareTo("Sản lượng") == 0) {
      event.inputRegisterModel.error = null;
      emit(state.copyWith(
          yieldController: TextEditingController(text: event.text)));
    }
  }
}

class AddActivityEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class InitAddActivityEvent extends AddActivityEvent {
  int seasonId;
  final Diary diary;

  InitAddActivityEvent(this.seasonId, this.diary);

  @override
  List<Object?> get props => [seasonId, diary];
}

class ChangeEditActivityEvent extends AddActivityEvent {
  ChangeEditActivityEvent();
}


class OnSelectValueEvent extends AddActivityEvent {
  List<InputRegisterModel> list;
  int index;
  BuildContext context;

  OnSelectValueEvent(this.list, this.index, this.context);

  @override
  List<Object?> get props => [list, index, context];
}

class AddOrDeleteImageEvent extends AddActivityEvent {
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

class SaveValueTextFieldEvent extends AddActivityEvent {
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

class AddActivityDiaryEvent extends AddActivityEvent {
  AddActivityDiaryEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAvatarEvent extends AddActivityEvent {
  //final ImageSource source;
  UpdateAvatarEvent();
}

class AddActivityState extends BlocState {
  @override
  List<Object?> get props => [
        detailActivity,
        formStatus,
        isShowProgress,
        listMaterial,
        listTool,
        listUnitArea,
        listUnitAmount,
        listWidgetArea,
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
        areaController,
        isEdit,
        indexActivity,
        indexArea,
        seasonId,
        listWidgetYield,
        listUnitYield,
        yieldController,
        areaMax,
        listMaterialAll,
        listToolAll,
      ];
  final Diary? detailActivity;
  final List<MaterialEntity> listMaterial;
  final List<Tool> listTool;
  final List<MaterialEntity> listMaterialAll;
  final List<Tool> listToolAll;
  final List<Unit> listUnitArea;
  final List<Unit> listUnitAmount;
  final List<Activity> listActivity;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;
  final List<InputRegisterModel> listWidget;
  List<InputRegisterModel> listWidgetVT;
  List<InputRegisterModel> listWidgetCC;
  List<ImageEntity> listImage = [];
  List<MaterialEntity> listVatTuAdd = [];
  List<Tool> listCongCuAdd = [];
  List<InputRegisterModel> listWidgetArea;
  final int seasonId;
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
  List<InputRegisterModel> listWidgetYield;
  final List<Unit> listUnitYield;
  bool isEdit;
  final int indexActivity;
  final int indexArea;
  double imageWidth;
  double imageHeight;
  final double areaMax;

  AddActivityState({
    this.detailActivity,
    this.seasonId = -1,
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.listMaterial = const [],
    this.listTool = const [],
    this.listMaterialAll = const [],
    this.listToolAll = const [],
    this.listUnitArea = const [],
    this.listUnitAmount = const [],
    this.listWidgetArea = const [],
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
    this.areaController,
    this.isEdit = false,
    this.imageWidth = 130,
    this.imageHeight = 100,
    this.indexActivity = -1,
    this.indexArea = -1,
    this.yieldController,
    this.listUnitYield = const [],
    this.listWidgetYield = const [],
    this.areaMax = 0,
  });

  AddActivityState copyWith({
    Diary? detailActivity,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    int? seasonId,
    List<MaterialEntity>? listMaterial,
    List<Tool>? listTool,
    List<MaterialEntity>? listMaterialAll,
    List<Tool>? listToolAll,
    List<Unit>? listUnitArea,
    List<Unit>? listUnitAmount,
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
    List<InputRegisterModel>? listWidgetYield,
    List<Unit>? listUnitYield,
    bool? isEdit,
    int? indexActivity,
    int? indexArea,
    double? imageWidth,
    double? imageHeight,
    double? areaMax,
  }) {
    return AddActivityState(
      detailActivity: detailActivity ?? this.detailActivity,
      formStatus: formStatus ?? this.formStatus,
      isShowProgress: isShowProgress ?? this.isShowProgress,
      listMaterial: listMaterial ?? this.listMaterial,
      listTool: listTool ?? this.listTool,
      listMaterialAll: listMaterialAll ?? this.listMaterialAll,
      listToolAll: listToolAll ?? this.listToolAll,
      listUnitArea: listUnitArea ?? this.listUnitArea,
      listUnitAmount: listUnitAmount ?? this.listUnitAmount,
      seasonId: seasonId ?? this.seasonId,
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
      listUnitYield: listUnitYield ?? this.listUnitYield,
      listWidgetYield: listWidgetYield ?? this.listWidgetYield,
      yieldController: yieldController ?? this.yieldController,
      areaMax: areaMax ?? this.areaMax,
    );
  }
}
