import 'dart:async';

import 'package:diary_mobile/data/entity/activity/activity_purchase.dart';
import 'package:diary_mobile/data/entity/activity/activity_transaction.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:diary_mobile/data/remote_data/object_model/object_result.dart';
import 'package:diary_mobile/utils/constants/status_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/entity/activity/activity_diary.dart';
import '../../../../data/entity/activity/season_farm.dart';
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
import '../../../../utils/status/form_submission_status.dart';
import '../../../../utils/utils.dart';
import '../../../../utils/widgets/dialog/toast_widget.dart';
import '../../../bloc_event.dart';
import '../../../bloc_state.dart';

class AddActivityPurchaseBloc
    extends Bloc<AddActivityPurchaseEvent, AddActivityPurchaseState> {
  final Repository repository;

  AddActivityPurchaseBloc(this.repository) : super(AddActivityPurchaseState()) {
    on<InitAddActivityPurchaseEvent>(_initAddActivityPurchase);
    on<OnSelectValueEvent>(_onSelectValue);
    on<AddActivityPurchaseDiaryEvent>(_addActivityPurchaseDiary);
    on<SaveValueTextFieldEvent>(_saveValueTextField);
    // add(InitAddActivityEvent());
  }

  bool edit = false;

  void _initViewAdd(Emitter<AddActivityPurchaseState> emitter) {
    List<InputRegisterModel> list = [];
    List<InputRegisterModel> listYield = [];
    List<InputRegisterModel> listVT = [];
    List<InputRegisterModel> listArea = [];

    list.add(InputRegisterModel(
      title: "Mùa vụ lô trồng",
      isCompulsory: false,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      listValue: state.listSeasonFarm,
      typeInputEnum: TypeInputEnum.dmucItem,
      image: ImageAsset.imageManagement,
      hasSearch: true,
    ));
    list.add(InputRegisterModel(
        title: "Sản phẩm",
        isCompulsory: false,
        maxLengthTextInput: 2000,
        type: TypeInputRegister.Non,
        typeInput: TextInputType.text,
        controller: state.productController,
        image: ImageAsset.imageTree));
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
      listValue: state.listUnitYield,
      controller: state.donViController,
      typeInputEnum: TypeInputEnum.dmucItem,
    ));
    List<InputRegisterModel> inputDonGia = [
      InputRegisterModel(
        title: "Đơn giá                   ",
        isCompulsory: false,
        maxLengthTextInput: 15,
        type: TypeInputRegister.TextField,
        typeInput: TextInputType.number,
        controller: state.donGiaController,
        isFormatText: true,
        noUnder: true,
        noBorder: true,
/*        noBorder: true,
        noUnder: true,*/
      )
    ];
    emitter(state.copyWith(
        listWidget: list,
        listWidgetVT: listVT,
        listWidgetYield: listYield,
        listWidgetArea: listArea,
        inputDonGia: inputDonGia,
        formStatus: const InitialFormStatus()));
  }

  void _initAddActivityPurchase(InitAddActivityPurchaseEvent event,
      Emitter<AddActivityPurchaseState> emitter) async {
    emitter(state.copyWith(
        isShowProgress: true,
        listWidget: [],
        listWidgetVT: [],
        listWidgetCC: [],
        listWidgetArea: [],
        inputDonGia: [],
        listCongCuAdd: [],
        listVatTuAdd: []));
    //final listActivity = await DiaryDB.instance.getListActivity();
    List<SeasonFarm> listSeasonFarm = await repository.getSeasonFarm();
    final List<String> listActivity = ["Visimex", "Angimex", "Ofitsoft"];
    final listTool = await DiaryDB.instance.getListTool();
    final listMaterial = await DiaryDB.instance.getListMaterial();
    final sharedPreferences = await SharedPreferences.getInstance();
    final categoryIdUnitYield =
        sharedPreferences.getInt(SharedPreferencesKey.unitYield) ?? -1;
    final listUnitYield =
        await DiaryDB.instance.getListUnit(categoryIdUnitYield);
    emitter(state.copyWith(
      isShowProgress: false,
      formStatus: const InitialFormStatus(),
      listSeasonFarm: listSeasonFarm,
      listActivity: listActivity,
      listMaterial: listMaterial,
      listTool: listTool,
      listUnitYield: listUnitYield,
      total: 0,
      startTimeController:
          TextEditingController(text: DateTime.now().toString().split('.')[0]),
      buyerController:
          TextEditingController(),
      productController:
          TextEditingController(),
      moTaController: TextEditingController(text: ''),
      donViController: TextEditingController(text: ''),
      soLuongController: TextEditingController(text: ''),
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
      OnSelectValueEvent event, Emitter<AddActivityPurchaseState> emit) async {
    int result;
    bool checkPass = true;
    emit(state.copyWith(formStatus: const InitialFormStatus()));
    if(event.index == 0 && state.listSeasonFarm.isEmpty) {
      Toast.showLongTop("Không có danh sách mùa vụ lô trồng");
      checkPass = false;
    }
    if(checkPass) {
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
          if (event.list[event.index].title.compareTo("Thời gian") == 0) {
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
          double convert = 0;
          if (event.list[event.index].title.compareTo("Đơn vị:") == 0) {
            if (event.list[event.index].valueSelected != null) {
              convert = event.list[event.index].valueSelected.convert;
            }
          }
          event.list[event.index].positionSelected = result;
          event.list[event.index].valueDefault = null;
          event.list[event.index].valueSelected =
          event.list[event.index].listValue[result];
          event.list[event.index].error = null;
          // });
          if (event.list[event.index].title.compareTo("Mùa vụ lô trồng") == 0) {
            emit(state.copyWith(
              seasonFarmController: TextEditingController(
                  text: event.list[event.index].valueSelected.name),
              indexSeasonFarm: result,
              seasonId: event.list[event.index].valueSelected.id,
              productController: TextEditingController(
                  text: event.list[event.index].valueSelected.productName),
              availableQuantity:
                  event.list[event.index].valueSelected.availableQuantity,
              availableUnitId: event.list[event.index].valueSelected.unitId,
            ));
            int indexYield = state.listUnitYield.indexWhere((element) =>
            element.id == event.list[event.index].valueSelected.unitId);
            if(indexYield != -1) {
              emit(state.copyWith(listWidget: state.listWidget));
              emit(state.copyWith(
                  indexYield: indexYield,
                  donViController: TextEditingController(
                      text: state.listUnitYield[indexYield].name),
              availableUnitName: state.listUnitYield[indexYield].name));
              state.listWidgetArea[1].controller = state.donViController;
              state.listWidgetArea[1].positionSelected = indexYield;
              state.listWidgetArea[1].valueSelected =
              state.listUnitYield[indexYield];
              emit(state.copyWith(listWidgetArea: state.listWidgetArea));
            }
            print("HoangCV: product name: ${state.productController!.text}");
            state.listWidget[1].controller = state.productController;
            emit(state.copyWith(listWidget: state.listWidget));
          }
          if (event.list[event.index].title.compareTo("Chi tiết mua bán") ==
              0) {
            emit(state.copyWith(
              moTaController: event.list[event.index].controller,
            ));
          }
          if (event.list[event.index].title.compareTo("Đơn vị:") == 0) {
            double inputValue = double.parse(
                (state.soLuongController!.text.isEmpty ? '0'
                    : state.soLuongController!.text));
            double conversionFactor = convert;
            double selectedValue = event.list[event.index].valueSelected
                .convert;
            double result = (inputValue * conversionFactor) / selectedValue;
            String formattedResult = Utils.formatNumber(result);
            double total = double.parse(state.donGiaController!.text.isEmpty
                ? '0'
                : state.donGiaController!.text) *
                double.parse(formattedResult);
            emit(state.copyWith(
                indexYield: event.list[event.index].positionSelected,
                donViController: TextEditingController(
                    text: event.list[event.index].valueSelected.name),
                soLuongController:
                TextEditingController(text: "$formattedResult"),
                total: total));
            state.listWidgetArea[0].controller = state.soLuongController;
          }
          if (event.list[event.index].title.compareTo("Người bán") == 0) {
            emit(state.copyWith(
              buyerController: event.list[event.index].controller,
            ));
          }
        }
      }
    }
  }

  FutureOr<void> _addActivityPurchaseDiary(AddActivityPurchaseDiaryEvent event,
      Emitter<AddActivityPurchaseState> emit) async {
    emit(state.copyWith(
        isShowProgress: true, formStatus: const InitialFormStatus()));
    bool validate = true;
    if (state.listWidgetYield.isNotEmpty) {
      state.listWidgetArea[0].error = null;
      state.listWidgetArea[1].error = null;
      state.inputDonGia[0].error = null;
    }
    if (state.soLuongController!.text.isEmpty) {
      validate = false;
      state.listWidgetArea[0].error = "Vui lòng nhập sản lượng";
    } else if (state.soLuongController!.text.isNotEmpty &&
        double.parse(state.soLuongController!.text) <= 0) {
      validate = false;
      state.listWidgetArea[0].error = "Vui lòng nhập sản lượng > 0";
    } else if (state.soLuongController!.text.isNotEmpty &&
        state.listWidgetArea[1].valueSelected == null) {
      validate = false;
      state.listWidgetArea[1].error = "Vui lòng chọn đơn vị";
    }
    /*else if(state.soLuongController!.text.isNotEmpty && state.listWidgetYield[1].valueSelected != null){
      if((double.parse(state.soLuongController!.text.isNotEmpty ? state.soLuongController!.text : "0") * double.parse('${state.listUnitArea[state.listWidgetArea[1].positionSelected].convert}')) > state.areaMax){
        validate = false;
        state.listWidgetArea[0].error = "Diện tích phải nhỏ hơn diện tích lô trồng";
      } else{
        state.listWidgetArea[0].error = null;
      }
    }*/
    else if (state.donGiaController!.text.isEmpty) {
      validate = false;
      state.inputDonGia[0].error = "Vui lòng nhập đơn giá";
    }
    if (!validate) {
      emit(state.copyWith(isShowProgress: false));
      print("HoangCV: state.indexActivity: ${state.indexActivity}");
    } else {
      print(
          "HoangCV: state. state.listUnitYield[state.indexYield].id: ${state.listUnitYield[state.indexYield].id}");
      ActivityPurchase activityTransaction = ActivityPurchase(
        id: -1,
        seasonFarmId: state.seasonId,
        seasonFarmName: state.listSeasonFarm[state.indexSeasonFarm].name,
        transactionDate: state.startTimeController!.text,
        productName: state.listSeasonFarm[state.indexSeasonFarm].productName,
        quantity: Utils.convertStringToDouble(state.soLuongController!.text),
        quantityUnitId: state.listUnitYield[state.indexYield].id,
        quantityUnitName: state.listUnitYield[state.indexYield].name,
        unitPrice: Utils.convertStringToDouble(state.donGiaController!.text.replaceAll('.', '')),
        person: state.buyerController!.text,
        isPurchase: true,
      );
      ObjectResult objectResult =
          await repository.addActivityPurchase(activityTransaction);
      if (objectResult.responseCode == StatusConst.code00) {
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionSuccess(success: "Thêm hoạt động thành công.")));
      }else if (objectResult.responseCode == StatusConst.code06) {
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionSuccess(success: "Hoạt động đã được sao lưu. \n Vui lòng truy cập mạng sớm nhất để thêm hoạt động.")));
      } else if (objectResult.responseCode == StatusConst.code01){
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionFailed("Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.")));
      }
    }
  }

  FutureOr<void> _saveValueTextField(
      SaveValueTextFieldEvent event, Emitter<AddActivityPurchaseState> emit) {
    print("HoangCV: bug: ${event.text} : ${event.inputRegisterModel.title}");
    if (event.inputRegisterModel.title.compareTo("Chi tiết công việc") == 0) {
      emit(state.copyWith(
          moTaController: TextEditingController(text: event.text)));
    } else if (event.inputRegisterModel.title.compareTo("Sản lượng:") == 0) {
      if ((double.parse(event.text) *
          double.parse('${state.listUnitYield[state.listWidgetArea[1].positionSelected].convert}'))
          > state.availableQuantity) {
        state.listWidgetArea[0].error =
        "Nhập nhỏ hơn sản lượng thực tế là ${state.availableQuantity} ${state.availableUnitName}";
        emit(state.copyWith(listWidgetArea : state.listWidgetArea));
      } else {
        state.listWidgetArea[0].error = null;
        event.inputRegisterModel.error = null;
        double total = 0;
        double donGia =
        double.parse(
            state.donGiaController!.text.isEmpty ? '0' : state.donGiaController!
                .text);
        total = donGia * double.parse(event.text);
        emit(state.copyWith(
            soLuongController: TextEditingController(text: event.text),
            total: total,
            listWidgetArea: state.listWidgetArea));
      }
    } else if (event.inputRegisterModel.title.compareTo("Đơn giá                   ") == 0) {
      print(
          "HoangCV: event.inputRegisterModel.error: ${event.inputRegisterModel.error}");
      event.inputRegisterModel.error = null;
      double total = 0;
      total = double.parse(state.soLuongController!.text) *
          double.parse(event.text.replaceAll('.', ''));
      emit(state.copyWith(
          donGiaController: TextEditingController(text: event.text),
          total: total));
    }
  }
}

class AddActivityPurchaseEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class InitAddActivityPurchaseEvent extends AddActivityPurchaseEvent {

  InitAddActivityPurchaseEvent();

  @override
  List<Object?> get props => [];
}

class ChangeDetailActivitySellEvent extends AddActivityPurchaseEvent {
  ChangeDetailActivitySellEvent();
}

class OnSelectValueEvent extends AddActivityPurchaseEvent {
  List<InputRegisterModel> list;
  int index;
  BuildContext context;

  OnSelectValueEvent(this.list, this.index, this.context);

  @override
  List<Object?> get props => [list, index, context];
}

class AddOrDeleteImageEvent extends AddActivityPurchaseEvent {
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

class SaveValueTextFieldEvent extends AddActivityPurchaseEvent {
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

class AddActivityPurchaseDiaryEvent extends AddActivityPurchaseEvent {
  AddActivityPurchaseDiaryEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAvatarEvent extends AddActivityPurchaseEvent {
  //final ImageSource source;
  UpdateAvatarEvent();
}

class AddActivityPurchaseState extends BlocState {
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
        inputDonGia,
    listSeasonFarm,
    seasonFarmController,
    indexSeasonFarm,
    availableUnitName,
    availableUnitId,
    availableQuantity
      ];
  final List<SeasonFarm> listSeasonFarm;
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
  List<InputRegisterModel> inputDonGia;
  List<ImageEntity> listImage = [];
  List<MaterialEntity> listVatTuAdd = [];
  List<Tool> listCongCuAdd = [];
  List<InputRegisterModel> listWidgetArea;
  final int seasonId;
  TextEditingController? seasonFarmController = TextEditingController();
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
  final int indexSeasonFarm;
  final int indexYield;
  final int indexArea;
  double imageWidth;
  double imageHeight;
  final double areaMax;
  double total;
  double availableQuantity;
  int availableUnitId;
  String availableUnitName;

  AddActivityPurchaseState({
    this.listSeasonFarm = const [],
    this.inputDonGia = const [],
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
    this.indexSeasonFarm = -1,
    this.seasonFarmController,
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
    this.availableQuantity = 0,
    this.availableUnitId = -1,
    this.availableUnitName = '',
  });

  AddActivityPurchaseState copyWith({
    List<SeasonFarm>? listSeasonFarm,
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
    TextEditingController? seasonFarmController,
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
    int? indexSeasonFarm,
    int? indexArea,
    int? indexYield,
    double? imageWidth,
    double? imageHeight,
    double? areaMax,
    double? total,
    List<InputRegisterModel>? inputDonGia,
    double? availableQuantity,
    int? availableUnitId,
    String? availableUnitName,
  }) {
    return AddActivityPurchaseState(
      listSeasonFarm: listSeasonFarm ?? this.listSeasonFarm,
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
      seasonFarmController: seasonFarmController ?? this.seasonFarmController,
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
      indexYield: indexYield ?? this.indexYield,
      indexSeasonFarm: indexSeasonFarm ?? this.indexSeasonFarm,
      inputDonGia: inputDonGia ?? this.inputDonGia,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      availableUnitId: availableUnitId ?? this.availableUnitId,
      availableUnitName: availableUnitName ?? this.availableUnitName,
    );
  }
}
