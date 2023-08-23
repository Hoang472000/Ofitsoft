import 'dart:async';

import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:diary_mobile/data/remote_data/object_model/object_result.dart';
import 'package:diary_mobile/utils/constans/status_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/entity/activity/activity_diary.dart';
import '../../../../data/entity/diary/diary.dart';
import '../../../../data/entity/image/image_entity.dart';
import '../../../../data/entity/item_default/material_entity.dart';
import '../../../../data/local_data/diary_db.dart';
import '../../../../data/repository.dart';
import '../../../../resource/assets.dart';
import '../../../../utils/constants/shared_preferences_key.dart';
import '../../../../utils/extenstion/extenstions.dart';
import '../../../../utils/extenstion/input_register_model.dart';
import '../../../../utils/extenstion/service_info_extension.dart';
import '../../../../utils/form_submission_status.dart';
import '../../../../utils/utils.dart';
import '../../../bloc_event.dart';
import '../../../bloc_state.dart';

class AddActivitySellBloc
    extends Bloc<AddActivitySellEvent, AddActivitySellState> {
  final Repository repository;

  AddActivitySellBloc(this.repository) : super(AddActivitySellState()) {
    on<InitAddActivitySellEvent>(_initAddActivitySell);
    on<OnSelectValueEvent>(_onSelectValue);
    on<AddActivitySellDiaryEvent>(_addActivitySellDiary);
    on<SaveValueTextFieldEvent>(_saveValueTextField);
    on<OnChangeDonGiaEvent>(_changeDonGia);
    // add(InitAddActivityEvent());
  }

  bool edit = false;

  void _initViewAdd(Emitter<AddActivitySellState> emitter) {
    List<InputRegisterModel> list = [];
    List<InputRegisterModel> listYield = [];
    List<InputRegisterModel> listVT = [];
    List<InputRegisterModel> listArea = [];
    print(
        "HoangCV:state.listUnitArea: ${state.listUnitArea.length} : ${state.indexArea}  ");
    list.add(InputRegisterModel<String, String>(
        title: "Tên công ty",
        isCompulsory: true,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        listValue: state.listActivity,
        //typeInputEnum: TypeInputEnum.dmucItem,
        image: ImageAsset.imageCompany));
    list.add(InputRegisterModel(
        title: "Người bán",
        isCompulsory: false,
        maxLengthTextInput: 2000,
        type: TypeInputRegister.TextField,
        typeInput: TextInputType.text,
        controller: state.buyerController,
        image: ImageAsset.imageActivityFarm));
/*    list.add(InputRegisterModel(
        title: "Chi tiết mua bán",
        isCompulsory: false,
        maxLengthTextInput: 2000,
        type: TypeInputRegister.TextField,
        typeInput: TextInputType.text,
        controller: state.moTaController,
        image: ImageAsset.imageFile));*/

    list.add(InputRegisterModel<String, DateTime>(
        title: "Thời gian",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        valueSelected: DateTime.now(),
        controller: state.startTimeController,
        image: ImageAsset.imageCalendarBegin,
        icon: Icons.calendar_today));
    list.add(InputRegisterModel(
        title: "Sản phẩm",
        isCompulsory: false,
        maxLengthTextInput: 2000,
        type: TypeInputRegister.TextField,
        typeInput: TextInputType.text,
        controller: state.productController,
        //noBorder: true
        image: ImageAsset.imageTree));
    listArea.add(InputRegisterModel(
      title: "Sản lượng:",
      isCompulsory: false,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.number,
      controller: state.soLuongController,
      maxLengthTextInput: 10,
      //isFormatText: true,
      //noBorder: true,
      //noUnder: true,
      image: ImageAsset.imageBudget,
    ));

    listArea.add(InputRegisterModel(
      title: "Đơn vị:",
      isCompulsory: false,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: state.indexYield,
      listValue: state.listUnitYield,
      controller: state.donGiaController,
      valueSelected: state.listUnitYield[state.indexYield],
      typeInputEnum: TypeInputEnum.dmucItem,
      //noBorder: true
    ));

    emitter(state.copyWith(
        listWidget: list,
        listWidgetVT: listVT,
        listWidgetYield: listYield,
        listWidgetArea: listArea,
        formStatus: const InitialFormStatus()));
  }

  void _initAddActivitySell(InitAddActivitySellEvent event,
      Emitter<AddActivitySellState> emitter) async {
    emitter(state.copyWith(
        isShowProgress: true,
        listWidget: [],
        listWidgetVT: [],
        listWidgetCC: [],
        listWidgetArea: [],
        listCongCuAdd: [],
        listVatTuAdd: []));
    //final listActivity = await DiaryDB.instance.getListActivity();
    final List<String> listActivity = ["Visimex", "Angimex", "Ofitsoft"];
    final listTool = await DiaryDB.instance.getListTool();
    final listMaterial = await DiaryDB.instance.getListMaterial();
    final sharedPreferences = await SharedPreferences.getInstance();
    final categoryIdUnitYield =
        sharedPreferences.getInt(SharedPreferencesKey.unitYield) ?? -1;
    final listUnitYield =
        await DiaryDB.instance.getListUnit(categoryIdUnitYield);
    int indexYield = listUnitYield.indexWhere(
        (element) => element.id == event.activityDiary[0].amountUnitId);
    emitter(state.copyWith(
      isShowProgress: false,
      formStatus: const InitialFormStatus(),
      detailActivity: event.diary,
      activityDiary: event.activityDiary,
      listActivity: listActivity,
      listMaterial: listMaterial,
      listTool: listTool,
      listUnitYield: listUnitYield,
      seasonId: event.seasonId,
      indexYield: indexYield,
      total: 0,
      startTimeController:
          TextEditingController(text: DateTime.now().toString().split('.')[0]),
      buyerController:
          TextEditingController(text: "${event.diary.farmerName ?? 0}"),
      productController: TextEditingController(text: "${event.diary.cropName}"),
      moTaController: TextEditingController(),
      donViController: TextEditingController(
          text: "${event.activityDiary[0].amountUnitName}"),
      soLuongController: TextEditingController(text: "${event.activityDiary[0].amount}"),
      donGiaController: TextEditingController(text: ''),
    ));
    _initViewAdd(emitter);

    emit(state.copyWith(
      listWidgetArea: state.listWidgetArea,
      isShowProgress: false,
    ));

    emitter(state.copyWith(listWidget: state.listWidget));
  }

  Future<FutureOr<void>> _onSelectValue(
      OnSelectValueEvent event, Emitter<AddActivitySellState> emit) async {
    int result;
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
        if (event.list[event.index].title.compareTo("Thời gian mua bán") == 0) {
          print(
              "HoangCV:1 event.list[event.index].valueSelected: ${Utils.formatDateTimeToString(event.list[event.index].valueSelected)}");
          emit(state.copyWith(
            startTimeController: TextEditingController(
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
        if (event.list[event.index].title.compareTo("Tên công ty") == 0) {
          emit(state.copyWith(
              companyController: TextEditingController(
                  text: event.list[event.index].valueSelected),
              indexActivity: result));
        }
        if (event.list[event.index].title.compareTo("Chi tiết mua bán") == 0) {
          emit(state.copyWith(
            moTaController: event.list[event.index].controller,
          ));
        }
        if (event.list[event.index].title.compareTo("Đơn vị:") == 0) {
          emit(state.copyWith(
              donViController: TextEditingController(
                  text: event.list[event.index].valueSelected.name)));
        }
        if (event.list[event.index].title.compareTo("Người bán") == 0) {
          emit(state.copyWith(
            buyerController: event.list[event.index].controller,
          ));
        }
      }
    }
  }


  FutureOr<void> _addActivitySellDiary(AddActivitySellDiaryEvent event,
      Emitter<AddActivitySellState> emit) async {
    if (state.listWidgetYield.isNotEmpty) {
      state.listWidgetYield[0].error = null;
      state.listWidgetYield[1].error = null;
    }
    emit(state.copyWith(
        isShowProgress: true, formStatus: const InitialFormStatus()));
    List<InputRegisterModel> list = List.from(state.listWidget);
    List<InputRegisterModel> listArea = List.from(state.listWidgetArea);
    bool validate = true;
    if (!validate) {
      emit(state.copyWith(isShowProgress: false));
      print("HoangCV: state.indexActivity: ${state.indexActivity}");
    } else {
      emit(state.copyWith(
          isShowProgress: false,
          formStatus:
              SubmissionSuccess(success: "Thêm hoạt động thu bán sản phẩm thành công")));
    }
  }

  FutureOr<void> _saveValueTextField(
      SaveValueTextFieldEvent event, Emitter<AddActivitySellState> emit) {

    print("HoangCV: bug: ${event.text} : ${event.inputRegisterModel.title}");
    if (event.inputRegisterModel.title.compareTo("Chi tiết công việc") == 0) {
      emit(state.copyWith(
          moTaController: TextEditingController(text: event.text)));
    } else if (event.inputRegisterModel.title.compareTo("Sản lượng:") == 0) {
      event.inputRegisterModel.error = null;
      double total = 0;
      double donGia = state.total / double.parse(state.soLuongController!.text);
      total = donGia * double.parse(event.text);
      emit(state.copyWith(
          soLuongController: TextEditingController(text: event.text), total: total));
    }
  }

  FutureOr<void> _changeDonGia(OnChangeDonGiaEvent event, Emitter<AddActivitySellState> emit) {
    print("HoangCV: _changeDonGia: ${event.donGia} : ${state.soLuongController!.text}");
    double total = 0;
    total = double.parse(event.donGia) * double.parse(state.soLuongController!.text);
    emit(state.copyWith(total: total));
  }
}

class AddActivitySellEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class InitAddActivitySellEvent extends AddActivitySellEvent {
  int seasonId;
  final Diary diary;
  final List<ActivityDiary> activityDiary;

  InitAddActivitySellEvent(this.seasonId, this.diary, this.activityDiary);

  @override
  List<Object?> get props => [seasonId, diary, activityDiary];
}

class ChangeEditActivitySellEvent extends AddActivitySellEvent {
  ChangeEditActivitySellEvent();
}

class ChangeDetailActivitySellEvent extends AddActivitySellEvent {
  ChangeDetailActivitySellEvent();
}

class OnSelectValueEvent extends AddActivitySellEvent {
  List<InputRegisterModel> list;
  int index;
  BuildContext context;

  OnSelectValueEvent(this.list, this.index, this.context);

  @override
  List<Object?> get props => [list, index, context];
}

class OnChangeDonGiaEvent extends AddActivitySellEvent {
  String donGia;

  OnChangeDonGiaEvent(this.donGia);

  @override
  List<Object?> get props => [donGia];
}

class AddOrDeleteImageEvent extends AddActivitySellEvent {
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

class SaveValueTextFieldEvent extends AddActivitySellEvent {
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

class AddActivitySellDiaryEvent extends AddActivitySellEvent {
  AddActivitySellDiaryEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAvatarEvent extends AddActivitySellEvent {
  //final ImageSource source;
  UpdateAvatarEvent();
}

class AddActivitySellState extends BlocState {
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
        companyController,
        soLuongController,
        moTaController,
        donViController,
        donGiaController,
        startTimeController,
        buyerController,
        totalController,
        isEdit,
        indexActivity,
        indexArea,
        seasonId,
        listWidgetYield,
        listUnitYield,
        areaMax,
        productController,
        activityDiary,
        indexYield,
        total,
      ];
  final Diary? detailActivity;
  final List<ActivityDiary> activityDiary;
  final List<MaterialEntity> listMaterial;
  final List<Tool> listTool;
  final List<Unit> listUnitArea;
  final List<Unit> listUnitAmount;
  final List<String> listActivity;
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
  TextEditingController? companyController = TextEditingController();
  TextEditingController? totalController = TextEditingController();
  TextEditingController? moTaController = TextEditingController();
  TextEditingController? soLuongController = TextEditingController();
  TextEditingController? productController = TextEditingController();
  TextEditingController? donGiaController = TextEditingController();
  TextEditingController? donViController = TextEditingController();
  TextEditingController? buyerController = TextEditingController();
  TextEditingController? startTimeController = TextEditingController();
  List<InputRegisterModel> listWidgetYield;
  final List<Unit> listUnitYield;
  bool isEdit;
  final int indexActivity;
  final int indexYield;
  final int indexArea;
  double imageWidth;
  double imageHeight;
  final double areaMax;
  double total;

  AddActivitySellState({
    this.detailActivity,
    this.activityDiary = const [],
    this.seasonId = -1,
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.listMaterial = const [],
    this.listTool = const [],
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
    this.companyController,
    this.totalController,
    this.soLuongController,
    this.moTaController,
    this.donViController,
    this.buyerController,
    this.startTimeController,
    this.donGiaController,
    this.productController,
    this.isEdit = false,
    this.imageWidth = 130,
    this.imageHeight = 100,
    this.indexActivity = -1,
    this.indexArea = -1,
    this.listUnitYield = const [],
    this.listWidgetYield = const [],
    this.areaMax = 0,
    this.indexYield = -1,
    this.total = 0,
  });

  AddActivitySellState copyWith({
    Diary? detailActivity,
    List<ActivityDiary>? activityDiary,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    int? seasonId,
    List<MaterialEntity>? listMaterial,
    List<Tool>? listTool,
    List<Unit>? listUnitArea,
    List<Unit>? listUnitAmount,
    List<String>? listActivity,
    List<InputRegisterModel>? listWidget,
    List<InputRegisterModel>? listWidgetVT,
    List<InputRegisterModel>? listWidgetCC,
    List<InputRegisterModel>? listWidgetArea,
    List<ImageEntity>? listImage,
    List<MaterialEntity>? listVatTuAdd,
    List<Tool>? listCongCuAdd,
    TextEditingController? companyController,
    TextEditingController? totalController,
    TextEditingController? moTaController,
    TextEditingController? soLuongController,
    TextEditingController? donGiaController,
    TextEditingController? donViController,
    TextEditingController? buyerController,
    TextEditingController? productController,
    TextEditingController? startTimeController,
    List<InputRegisterModel>? listWidgetYield,
    List<Unit>? listUnitYield,
    bool? isEdit,
    int? indexActivity,
    int? indexArea,
    int? indexYield,
    double? imageWidth,
    double? imageHeight,
    double? areaMax,
    double? total,
  }) {
    return AddActivitySellState(
        detailActivity: detailActivity ?? this.detailActivity,
        activityDiary: activityDiary ?? this.activityDiary,
        formStatus: formStatus ?? this.formStatus,
        isShowProgress: isShowProgress ?? this.isShowProgress,
        listMaterial: listMaterial ?? this.listMaterial,
        listTool: listTool ?? this.listTool,
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
        companyController: companyController ?? this.companyController,
        totalController: totalController ?? this.totalController,
        soLuongController: soLuongController ?? this.soLuongController,
        moTaController: moTaController ?? this.moTaController,
        donViController: donViController ?? this.donViController,
        donGiaController: donGiaController ?? this.donGiaController,
        startTimeController: startTimeController ?? this.startTimeController,
        productController: productController ?? this.productController,
        buyerController: buyerController ?? this.buyerController,
        isEdit: isEdit ?? this.isEdit,
        imageWidth: imageWidth ?? this.imageWidth,
        imageHeight: imageHeight ?? this.imageHeight,
        indexActivity: indexActivity ?? this.indexActivity,
        listUnitYield: listUnitYield ?? this.listUnitYield,
        listWidgetYield: listWidgetYield ?? this.listWidgetYield,
        areaMax: areaMax ?? this.areaMax,
        total: total ?? this.total,
        indexYield: indexYield ?? this.indexYield);
  }
}
