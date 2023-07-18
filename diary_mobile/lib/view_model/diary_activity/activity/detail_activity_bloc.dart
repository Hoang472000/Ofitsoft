import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/entity/diary/diary.dart';
import '../../../data/entity/image/image_entity.dart';
import '../../../data/entity/item_default/material_entity.dart';
import '../../../data/local_data/diary_db.dart';
import '../../../data/repository.dart';
import '../../../resource/assets.dart';
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
    add(GetDetailActivityEvent());
  }

  bool edit = false;

  void _initView() {
    state.listWidget.add(InputRegisterModel<Activity, Activity>(
        title: "Tên công việc",
        isCompulsory: true,
        type: TypeInputRegister.Non,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        listValue: state.listActivity,
        typeInputEnum: TypeInputEnum.dmucItem,
        image: ImageAsset.imageActivityFarm));
    state.listWidget.add(InputRegisterModel(
        title: "Chi tiết công việc",
        isCompulsory: true,
        maxLengthTextInput: 2000,
        type: TypeInputRegister.Non,
        typeInput: TextInputType.text,
        controller: state.moTaController,
        image: ImageAsset.imageFile));
    state.listWidgetVT.add(InputRegisterModel<MaterialEntity, MaterialEntity>(
        title: "Vật tư liên quan",
        isCompulsory: true,
        type: TypeInputRegister.Non,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        typeInputEnum: TypeInputEnum.dmucItem,
        listValue: state.listMaterial,
        image: ImageAsset.imageGardening));

    state.listWidgetCC.add(InputRegisterModel<Tool, Tool>(
      title: "Công cụ sử dụng",
      isCompulsory: true,
      type: TypeInputRegister.Non,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listTool,
      typeInputEnum: TypeInputEnum.dmucItem,
      image: ImageAsset.imageTools,
    ));

    state.listWidget.add(InputRegisterModel(
      title: "Người liên quan",
      isCompulsory: true,
      maxLengthTextInput: 200,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.text,
      controller: state.peopleController,
      image: ImageAsset.imageMan,
    ));

    state.listWidget.add(InputRegisterModel<String, DateTime>(
        title: "Ngày bắt đầu",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Non,
        // valueSelected: DateTime.now(),
        image: ImageAsset.imageCalendarBegin,
        icon: Icons.calendar_today));

    state.listWidget.add(InputRegisterModel<String, DateTime>(
        title: "Ngày kết thúc",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Non,
        // valueSelected: DateTime.now(),
        image: ImageAsset.imageCalendarEnd,
        icon: Icons.calendar_today));
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
    listVT.add(InputRegisterModel<MaterialEntity, MaterialEntity>(
        title: "Vật tư liên quan",
        isCompulsory: true,
        type: TypeInputRegister.Non,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        //listMutiChoice: listVatTu,
        typeInputEnum: TypeInputEnum.dmucItem,
        listValue: state.listMaterial,
        image: ImageAsset.imageGardening));

    listCC.add(InputRegisterModel<Tool, Tool>(
      title: "Công cụ sử dụng",
      isCompulsory: true,
      type: TypeInputRegister.Non,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      listValue: state.listTool,
      typeInputEnum: TypeInputEnum.dmucItem,
      image: ImageAsset.imageTools,
    ));

    list.add(InputRegisterModel(
      title: "Người liên quan",
      isCompulsory: true,
      maxLengthTextInput: 200,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.text,
      controller: state.peopleController,
      image: ImageAsset.imageMan,
    ));

    list.add(InputRegisterModel<String, DateTime>(
        title: "Ngày bắt đầu",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Non,
        // valueSelected: DateTime.now(),
        image: ImageAsset.imageCalendarBegin,
        icon: Icons.calendar_today));

    list.add(InputRegisterModel<String, DateTime>(
        title: "Ngày kết thúc",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Non,
        // valueSelected: DateTime.now(),
        image: ImageAsset.imageCalendarEnd,
        icon: Icons.calendar_today));
    emitter(state.copyWith(
        listWidget: list, listWidgetVT: listVT, listWidgetCC: listCC));
  }

  void _initViewEdit() {
    state.listWidget.add(InputRegisterModel<Activity, Activity>(
        title: "Tên công việc",
        isCompulsory: true,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        listValue: state.listActivity,
        typeInputEnum: TypeInputEnum.dmucItem,
        image: ImageAsset.imageActivityFarm));
    state.listWidget.add(InputRegisterModel(
        title: "Chi tiết công việc",
        isCompulsory: true,
        maxLengthTextInput: 2000,
        type: TypeInputRegister.TextField,
        typeInput: TextInputType.text,
        controller: state.moTaController,
        image: ImageAsset.imageFile));
    state.listWidgetVT.add(InputRegisterModel(
        title: "Vật tư liên quan",
        isCompulsory: true,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        typeInputEnum: TypeInputEnum.dmucItem,
        listValue: state.listMaterial,
        image: ImageAsset.imageGardening));

    state.listWidgetCC.add(InputRegisterModel<Tool, Tool>(
      title: "Công cụ sử dụng",
      isCompulsory: true,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: -1,
      typeInputEnum: TypeInputEnum.dmucItem,
      listValue: state.listTool,
      image: ImageAsset.imageTools,
    ));

    state.listWidget.add(InputRegisterModel(
      title: "Người liên quan",
      isCompulsory: true,
      maxLengthTextInput: 200,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      controller: state.peopleController,
      image: ImageAsset.imageMan,
    ));

    state.listWidget.add(InputRegisterModel<String, DateTime>(
        title: "Ngày bắt đầu",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        // valueSelected: DateTime.now(),
        image: ImageAsset.imageCalendarBegin,
        icon: Icons.calendar_today));

    state.listWidget.add(InputRegisterModel<String, DateTime>(
        title: "Ngày kết thúc",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        // valueSelected: DateTime.now(),
        image: ImageAsset.imageCalendarEnd,
        icon: Icons.calendar_today));
  }

  void _getDetailActivity(GetDetailActivityEvent event,
      Emitter<DetailActivityState> emitter) async {
    emitter(state.copyWith(
        isShowProgress: true,
        listWidget: [],
        listWidgetVT: [],
        listWidgetCC: []));
    final detailActivity = await repository.getDetailDiary(1);
    final listActivity = await DiaryDB.instance.getListActivity();
    _initViewDetail(emitter);
    int index = listActivity
        .indexWhere((element) => element.id == detailActivity.activityId);
    print("HoangCV: detailActivity.description: ${detailActivity.description}");
    emitter(state.copyWith(
      isShowProgress: false,
      detailActivity: detailActivity,
      listActivity: listActivity,
      moTaController: TextEditingController(text: detailActivity.description),
      nameController: TextEditingController(text: listActivity[index].name),
      peopleController: TextEditingController(),
      startTimeController: TextEditingController(
          text: Utils.formatDate(detailActivity.actionTime ?? "")),
      endTimeController: TextEditingController(
          text: Utils.formatDate(detailActivity.actionTime ?? "")),
    ));
    for (int i = 0; i < state.listWidget.length; i++) {
      if (state.listWidget[i].title.compareTo("Tên công việc") == 0) {
        print("HoangCV: run way: ${index} : ${listActivity[index].name}");
        state.listWidget[i].positionSelected = index;
        state.listWidget[i].valueSelected = listActivity[index];
        //state.listWidget[i].type = TypeInputRegister.Select;
        state.listWidget[i].listValue = listActivity;
        state.listWidget[i].controller = state.nameController;
      }
      if (state.listWidget[i].title.compareTo("Chi tiết công việc") == 0) {
        state.listWidget[i].controller = state.moTaController;
      }
      if (state.listWidget[i].title.compareTo("Người liên quan") == 0) {
        state.listWidget[i].controller = state.peopleController;
      }
      if (state.listWidget[i].title.compareTo("Ngày bắt đầu") == 0) {
        state.listWidget[i].controller = state.startTimeController;
      }
      if (state.listWidget[i].title.compareTo("Ngày kết thúc") == 0) {
        state.listWidget[i].controller = state.endTimeController;
        state.listWidget[i].valueSelected =
            Utils.formatStringToDate(detailActivity.actionTime ?? "");
        state.listWidget[i].type = TypeInputRegister.Select;
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
}

class DetailActivityEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetDetailActivityEvent extends DetailActivityEvent {
  GetDetailActivityEvent();
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
        listUnit,
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
        endTimeController
      ];
  final Diary? detailActivity;
  final List<MaterialEntity> listMaterial;
  final List<Tool> listTool;
  final List<Unit> listUnit;
  final List<Activity> listActivity;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;
  List<InputRegisterModel> listWidget;
  List<InputRegisterModel> listWidgetVT;
  List<InputRegisterModel> listWidgetCC;
  List<ImageEntity> listImage;
  List<VatTu> listVatTuAdd = [];
  List<VatTu> listCongCuAdd = [];
  TextEditingController? nameController = TextEditingController();
  TextEditingController? soCayController = TextEditingController();
  TextEditingController? soLuongController = TextEditingController();
  TextEditingController? moTaController = TextEditingController();
  TextEditingController? donViController = TextEditingController();
  TextEditingController? peopleController = TextEditingController();
  TextEditingController? startTimeController = TextEditingController();
  TextEditingController? endTimeController = TextEditingController();

  DetailActivityState(
      {this.detailActivity,
      this.formStatus = const InitialFormStatus(),
      this.isShowProgress = true,
      this.listMaterial = const [],
      this.listTool = const [],
      this.listUnit = const [],
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
      this.endTimeController});

  DetailActivityState copyWith({
    Diary? detailActivity,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    List<MaterialEntity>? listMaterial,
    List<Tool>? listTool,
    List<Unit>? listUnit,
    List<Activity>? listActivity,
    List<InputRegisterModel>? listWidget,
    List<InputRegisterModel>? listWidgetVT,
    List<InputRegisterModel>? listWidgetCC,
    List<ImageEntity>? listImage,
    List<VatTu>? listVatTuAdd,
    List<VatTu>? listCongCuAdd,
    TextEditingController? nameController,
    TextEditingController? soCayController,
    TextEditingController? soLuongController,
    TextEditingController? moTaController,
    TextEditingController? donViController,
    TextEditingController? peopleController,
    TextEditingController? startTimeController,
    TextEditingController? endTimeController,
  }) {
    return DetailActivityState(
      detailActivity: detailActivity ?? this.detailActivity,
      formStatus: formStatus ?? this.formStatus,
      isShowProgress: isShowProgress ?? this.isShowProgress,
      listMaterial: listMaterial ?? this.listMaterial,
      listTool: listTool ?? this.listTool,
      listUnit: listUnit ?? this.listUnit,
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
    );
  }
}
