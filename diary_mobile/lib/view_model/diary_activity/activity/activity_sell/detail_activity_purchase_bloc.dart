import 'dart:async';
import 'dart:ffi';

import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:diary_mobile/utils/widgets/dialog/dialog_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/entity/activity/activity_diary.dart';
import '../../../../data/entity/activity/activity_purchase.dart';
import '../../../../data/entity/activity/activity_transaction.dart';
import '../../../../data/entity/activity/season_farm.dart';
import '../../../../data/entity/diary/diary.dart';
import '../../../../data/entity/image/image_entity.dart';
import '../../../../data/entity/item_default/material_entity.dart';
import '../../../../data/local_data/diary_db.dart';
import '../../../../data/remote_data/object_model/object_result.dart';
import '../../../../data/repository.dart';
import '../../../../resource/assets.dart';
import '../../../../utils/constants/status_const.dart';
import '../../../../utils/constants/shared_preferences_key.dart';
import '../../../../utils/extenstion/extenstions.dart';
import '../../../../utils/extenstion/input_register_model.dart';
import '../../../../utils/extenstion/service_info_extension.dart';
import '../../../../utils/status/form_submission_status.dart';
import '../../../../utils/utils.dart';
import '../../../bloc_event.dart';
import '../../../bloc_state.dart';

class DetailActivityPurchaseBloc
    extends Bloc<DetailActivityPurchaseEvent, DetailActivityPurchaseState> {
  final Repository repository;

  DetailActivityPurchaseBloc(this.repository) : super(DetailActivityPurchaseState()) {
    on<GetDetailActivityPurchaseEvent>(_getDetailActivityPurchase);
    on<ChangeEditActivityPurchaseEvent>(_changeEditActivityPurchase);
    on<ChangeDetailActivityPurchaseEvent>(_changeDetailActivityPurchase);
    on<OnSelectValueEvent>(_onSelectValue);
    on<SaveValueTextFieldEvent>(_saveValueTextField);
    on<UpdateActivityPurchaseEvent>(_updateActivityPurchase);
    on<BackEvent>(_back);
    //add(GetDetailActivityEvent());
  }

  bool edit = false;

  void _initViewDetail(Emitter<DetailActivityPurchaseState> emitter) {
    List<InputRegisterModel> list = [];
    List<InputRegisterModel> listYield = [];
    List<InputRegisterModel> listVT = [];
    List<InputRegisterModel> listArea = [];

    list.add(InputRegisterModel(
        title: "Mùa vụ lô trồng",
        isCompulsory: false,
        type: TypeInputRegister.Non,
        icon: Icons.arrow_drop_down,
        listValue: state.listSeasonFarm,
        controller: state.seasonFarmController,
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
        title: "Người mua",
        isCompulsory: false,
        maxLengthTextInput: 2000,
        type: TypeInputRegister.Non,
        typeInput: TextInputType.text,
        controller: state.buyerController,
        image: ImageAsset.imageActivityFarm));

    list.add(InputRegisterModel<String, DateTime>(
        title: "Thời gian",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Non,
        //valueSelected: DateTime.now(),
        controller: state.startTimeController,//
        image: ImageAsset.imageCalendarBegin,
        icon: Icons.calendar_today));

    listYield.add(InputRegisterModel(
      title: "Sản lượng:",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.number,
      controller: state.soLuongController,
      maxLengthTextInput: 10,
      image: ImageAsset.imageBudget,
    ));

    listYield.add(InputRegisterModel(
      title: "Đơn vị:",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      icon: Icons.arrow_drop_down,
      positionSelected: -1/*state.indexYield*/,
      listValue: state.listUnitYield,
      controller: state.donViController,
      //valueSelected: state.listUnitYield[state.indexYield],
      typeInputEnum: TypeInputEnum.dmucItem,
    ));

    List<InputRegisterModel> inputDonGia = [
      InputRegisterModel(
        title: "Đơn giá                   ",
        isCompulsory: false,
        maxLengthTextInput: 15,
        type: TypeInputRegister.Non,
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

  void _changeViewEdit(Emitter<DetailActivityPurchaseState> emitter) {

    List<InputRegisterModel> list = [];
    List<InputRegisterModel> listYield = [];
    List<InputRegisterModel> listVT = [];
    List<InputRegisterModel> listArea = [];

    if(state.indexSeasonFarm != -1) {
      list.add(InputRegisterModel(
        title: "Mùa vụ lô trồng",
        isCompulsory: false,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        valueSelected: state.listSeasonFarm[state.indexSeasonFarm],
        listValue: state.listSeasonFarm,
        typeInputEnum: TypeInputEnum.dmucItem,
        image: ImageAsset.imageManagement,
        hasSearch: true,
      ));
    } else{
      list.add(InputRegisterModel(
        title: "Mùa vụ lô trồng",
        isCompulsory: false,
        type: TypeInputRegister.Non,
        icon: Icons.arrow_drop_down,
        //valueSelected: state.listSeasonFarm[state.indexSeasonFarm],
        controller: state.seasonFarmController,
        listValue: state.listSeasonFarm,
        typeInputEnum: TypeInputEnum.dmucItem,
        image: ImageAsset.imageManagement,
        hasSearch: true,
      ));
    }

    list.add(InputRegisterModel(
        title: "Sản phẩm",
        isCompulsory: false,
        maxLengthTextInput: 2000,
        type: TypeInputRegister.Non,
        typeInput: TextInputType.text,
        controller: state.productController,
        image: ImageAsset.imageTree));

    list.add(InputRegisterModel(
        title: "Người mua",
        isCompulsory: false,
        maxLengthTextInput: 2000,
        type: TypeInputRegister.TextField,
        typeInput: TextInputType.text,
        controller: state.buyerController,
        image: ImageAsset.imageActivityFarm));

    list.add(InputRegisterModel<String, DateTime>(
        title: "Thời gian",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        valueSelected: Utils.stringToDate(state.startTimeController!.text),
        //controller: state.startTimeController,
        image: ImageAsset.imageCalendarBegin,
        icon: Icons.calendar_today));

    listYield.add(InputRegisterModel(
      title: "Sản lượng:",
      isCompulsory: false,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.number,
      controller: state.soLuongController,
      maxLengthTextInput: 10,
      image: ImageAsset.imageBudget,
    ));

    listYield.add(InputRegisterModel(
      title: "Đơn vị:",
      isCompulsory: false,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: state.indexYield,
      listValue: state.listUnitYield,
      controller: state.donViController,
      valueSelected: state.listUnitYield[state.indexYield],
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

  void _getDetailActivityPurchase(GetDetailActivityPurchaseEvent event,
      Emitter<DetailActivityPurchaseState> emitter) async {
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
    final listActivity = await DiaryDB.instance.getListActivity();
    List<SeasonFarm> listSeasonFarm = await repository.getSeasonFarm();
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
    _initViewDetail(emitter);
    int indexYield = listUnitYield
        .indexWhere((element) => element.id == detailActivity.quantityUnitId);
    int indexSeasonFarm = listSeasonFarm
        .indexWhere((element) => element.id == detailActivity.seasonFarmId);
    if(indexSeasonFarm != -1) {
      int indexYieldAvailable = listUnitYield.indexWhere((element) =>
      element.id == listSeasonFarm[indexSeasonFarm].unitId);
      if (indexYieldAvailable != -1) {
        emit(state.copyWith(
            availableUnitName: listUnitYield[indexYieldAvailable].name,
            availableQuantity:
            (listSeasonFarm[indexSeasonFarm].availableQuantity ?? 0) +
                ((listUnitYield[indexYield].convert ?? 0) *
                    (detailActivity.quantity ?? 0))));
      }
    }
    emitter(state.copyWith(
      isShowProgress: false,
      detailActivity: detailActivity,
      listActivity: listActivity,
      listUnitAmount: listUnitAmount,
      listUnitArea: listUnitArea,
      listUnitYield: listUnitYield,
        listSeasonFarm: listSeasonFarm,
      indexSeasonFarm: indexSeasonFarm,
      seasonId: detailActivity.seasonFarmId,
      seasonFarmController: TextEditingController(text: "${detailActivity.seasonFarmName}"),
      buyerController:
      TextEditingController(text: "${detailActivity.person ?? 0}"),
      productController:
      TextEditingController(text: "${detailActivity.productName}"),
      donGiaController: TextEditingController(
          text: Utils.convertNumber(detailActivity.unitPrice??0)),
      donViController: TextEditingController(
          text: "${detailActivity.quantityUnitName}"),
      soLuongController:
      TextEditingController(text: "${detailActivity.quantity ?? ''}"),
      startTimeController: TextEditingController(
          text: Utils.formatDate(detailActivity.transactionDate ?? "")),
      yieldController:
      TextEditingController(text: "${detailActivity.quantity ?? ''}"),
      yieldUnitController:
      TextEditingController(text: "${detailActivity.quantityUnitName}"),
      diary: event.diary,
      indexYieldUnit: indexYield, indexYield: indexYield,
      total: (detailActivity.unitPrice ?? 0) * (detailActivity.quantity ?? 0),
    ));
    for (int i = 0; i < state.listWidget.length; i++) {
      if (state.listWidget[i].title.compareTo("Tên công việc") == 0) {
        state.listWidget[i].controller = state.nameController;
        //state.listWidget[i].valueSelected = state.listActivity[index];
      }
      if (state.listWidget[i].title.compareTo("Mùa vụ lô trồng") == 0) {
        if(indexSeasonFarm != -1) {
          state.listWidget[i].valueSelected = listSeasonFarm[indexSeasonFarm];
        }
          state.listWidget[i].controller = state.seasonFarmController;

        //state.listWidget[i].valueSelected = state.listActivity[index];
      }
      if (state.listWidget[i].title.compareTo("Người mua") == 0) {
        state.listWidget[i].controller = state.buyerController;
      }
      if (state.listWidget[i].title.compareTo("Thời gian") == 0) {
        state.listWidget[i].controller = state.startTimeController;
      }
      if (state.listWidget[i].title.compareTo("Sản phẩm") == 0) {
        state.listWidget[i].controller = state.productController;
      }
    }
    for (int i = 0; i < state.listWidgetYield.length; i++) {
      if (state.listWidgetYield[i].title.compareTo("Sản lượng:") == 0) {
        state.listWidgetYield[i].controller = state.yieldController;
      }
      if (state.listWidgetYield[i].title.compareTo("Đơn vị:") == 0) {
        state.listWidgetYield[i].controller = state.yieldUnitController;
      }
    }
    for (int i = 0; i < state.inputDonGia.length; i++) {
      if (state.inputDonGia[i].title.compareTo("Đơn giá                   ") == 0) {
        state.inputDonGia[i].controller = state.donGiaController;
      }
    }

    emitter(state.copyWith(
        listWidget: state.listWidget,
        listWidgetYield: state.listWidgetYield,
        listWidgetArea: state.listWidgetArea,
        listWidgetCC: state.listWidgetCC,
        listWidgetVT: state.listWidgetVT));
  }

  FutureOr<void> _changeEditActivityPurchase(
      ChangeEditActivityPurchaseEvent event, Emitter<DetailActivityPurchaseState> emit) async {
    _changeViewEdit(emit);
  }

  FutureOr<void> _changeDetailActivityPurchase(ChangeDetailActivityPurchaseEvent event,
      Emitter<DetailActivityPurchaseState> emit) async {
    //_changeViewDetail(emit);
    add(GetDetailActivityPurchaseEvent(state.copiedActivityDiary ?? ActivityPurchase(), state.diary ?? Diary(),
        resetView: true));
  }

  Future<FutureOr<void>> _onSelectValue(
      OnSelectValueEvent event, Emitter<DetailActivityPurchaseState> emit) async {
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
        if (event.list[event.index].title.compareTo("Thời gian") == 0) {
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
        double convert = 0;
        if (event.list[event.index].title.compareTo("Đơn vị:") == 0) {
          convert = event.list[event.index].valueSelected.convert;
        }
        event.list[event.index].positionSelected = result;
        event.list[event.index].valueDefault = null;
        event.list[event.index].valueSelected =
        event.list[event.index].listValue[result];
        event.list[event.index].error = null;
        // });
        /*    if (event.list[event.index].title.compareTo("Tên công ty") == 0) {
          emit(state.copyWith(
              companyController: TextEditingController(
                  text: event.list[event.index].valueSelected),
              indexActivity: result));
        }*/
        if (event.list[event.index].title.compareTo("Mùa vụ lô trồng") == 0) {
          state.listWidgetYield[0].error = null;
          emit(state.copyWith(
            seasonFarmController: TextEditingController(
                text: event.list[event.index].valueSelected.name),
            indexSeasonFarm: result,
            seasonId: event.list[event.index].valueSelected.id,
            productController: TextEditingController(
                text: event.list[event.index].valueSelected.productName),));
          print("HoangCV: product name: ${state.productController!.text}");
          state.listWidget[1].controller = state.productController;
          emit(state.copyWith(listWidget: state.listWidget));


          int indexYield = state.listUnitYield.indexWhere((element) =>
          element.id == event.list[event.index].valueSelected.unitId);
          if(indexYield != -1) {
            emit(state.copyWith(
              availableQuantity: event.list[event.index].valueSelected.availableQuantity,
              availableUnitId: event.list[event.index].valueSelected.unitId,
              availableUnitName: state.listUnitYield[indexYield].name));
          }
        }
        if (event.list[event.index].title.compareTo("Chi tiết mua bán") == 0) {
          emit(state.copyWith(
            moTaController: event.list[event.index].controller,
          ));
        }
        if (event.list[event.index].title.compareTo("Đơn vị:") == 0) {
          print(
              "HoangCV: dơn vị : ${convert} : ${(double.parse(state.soLuongController!.text) * convert) / (event.list[event.index].valueSelected.convert)}}");
          double inputValue = double.parse(state.soLuongController!.text);
          double conversionFactor = convert;
          double selectedValue = event.list[event.index].valueSelected.convert;
          double result = (inputValue * conversionFactor) / selectedValue;
          String formattedResult = Utils.formatNumber(result);
          double total = double.parse(state.donGiaController!.text.isEmpty ? '0' : state.donGiaController!.text) *
              double.parse(formattedResult);
          emit(state.copyWith(
              donViController: TextEditingController(
                  text: event.list[event.index].valueSelected.name),
              soLuongController:
              TextEditingController(text: "$formattedResult"),
              total: total));
          state.listWidgetYield[0].controller = state.soLuongController;
        }
        if (event.list[event.index].title.compareTo("Người mua") == 0) {
          emit(state.copyWith(
            buyerController: event.list[event.index].controller,
          ));
        }
      }
    }
  }

  FutureOr<void> _saveValueTextField(
      SaveValueTextFieldEvent event, Emitter<DetailActivityPurchaseState> emit) {
    print("HoangCV: bug: ${event.text} : ${event.inputRegisterModel.title} : ${state.listWidgetYield[0].title}");
    if (event.inputRegisterModel.title.compareTo("Chi tiết công việc") == 0) {
      emit(state.copyWith(
          moTaController: TextEditingController(text: event.text)));
    } else if (event.inputRegisterModel.title.compareTo("Sản lượng:") == 0) {
      print("HoangCV: bug: ${event.text} : ${state.listUnitYield[state.listWidgetYield[1].positionSelected].convert} : ${state.availableQuantity}");
      if ((double.parse(event.text) *
          double.parse('${state.listUnitYield[state.listWidgetYield[1].positionSelected].convert}'))
          > state.availableQuantity) {
        emit(state.copyWith(isShowProgress: true));
        print("HoangCV: bug 1");
        state.listWidgetYield[0].error =
        "Nhập <= sản lượng dự kiến là ${state.availableQuantity} ${state.availableUnitName}";
        event.inputRegisterModel.error =
        "Nhập <= sản lượng dự kiến là ${state.availableQuantity} ${state.availableUnitName}";
        state.listWidgetYield[0] = event.inputRegisterModel;
        emit(state.copyWith(listWidgetYield : state.listWidgetYield,
            isShowProgress: false, formStatus: const InitialFormStatus()));
      } else {
        print("HoangCV: bug 2");
        state.listWidgetYield[0].error = null;
        double total = 0;
        double donGia = double.parse(state.donGiaController!
            .text) /*state.total / double.parse(state.soLuongController!.text)*/;
        total = donGia * double.parse(event.text);
        emit(state.copyWith(
            soLuongController: TextEditingController(text: event.text),
            total: total,
            listWidgetYield : state.listWidgetYield));
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

  FutureOr<void> _updateActivityPurchase(
      UpdateActivityPurchaseEvent event, Emitter<DetailActivityPurchaseState> emit) async {
    print("HoangCV: state.indexActivity: ${state.indexActivity}");
    emit(state.copyWith(
        isShowProgress: true, formStatus: const InitialFormStatus()));
    List<InputRegisterModel> list = List.from(state.listWidget);
    List<InputRegisterModel> listArea = List.from(state.listWidgetArea);
    bool validate = true;
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
    if(validate){
      if ((double.parse(state.yieldController!.text) *
          double.parse('${state.listUnitYield[state.indexYield].convert}'))
          > state.availableQuantity) {
        //emit(state.copyWith(isShowProgress: true));
        print("HoangCV: bug 1");
        state.listWidgetYield[0].error =
        "Nhập <= sản lượng dự kiến là ${state.availableQuantity} ${state.availableUnitName}";
        emit(state.copyWith(listWidgetYield : state.listWidgetYield,
            isShowProgress: false, formStatus: const InitialFormStatus()));
        validate = false;
      }
    }
    if (!validate) {
      emit(state.copyWith(isShowProgress: false));
      print("HoangCV: state.indexActivity: ${state.indexActivity} : ${state.startTimeController!.text}");
    } else {
      emit(state.copyWith(formStatus: FormSubmitting()));
      ActivityTransaction activityPurchase = ActivityTransaction(
        id: state.detailActivity!.id,
        seasonFarmId:  state.seasonId,
        transactionDate: state.startTimeController!.text,
        quantity: Utils.convertStringToDouble(state.soLuongController!.text),
        productId: state.listSeasonFarm[state.indexSeasonFarm].productId,
        quantityUnitId: state.listUnitYield[state.indexYield].id,
        unitPrice: Utils.convertStringToDouble(state.donGiaController!.text.replaceAll('.', '')),
        person: state.buyerController!.text,
      );
      ObjectResult objectResult =
      await repository.updateActivityTransaction(activityPurchase);
      if (objectResult.responseCode == StatusConst.code00) {
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionSuccess(success: "Sửa hoạt động thành công.")));
      }/*else if (objectResult.responseCode == StatusConst.code06) {
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionSuccess(success: "Hoạt động đã được sao lưu. \n Vui lòng truy cập mạng sớm nhất để thêm hoạt động.")));
      }*/ else if (objectResult.responseCode == StatusConst.code01){
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionFailed("Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.")));
      } else{
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: const InitialFormStatus()));
      }
    }
  }

  FutureOr<void> _back(BackEvent event, Emitter<DetailActivityPurchaseState> emit) {
    emit(state.copyWith(
        isShowProgress: false,
        formStatus: const InitialFormStatus()));
    var copiesActivity =
    ActivityPurchase.copy(state.detailActivity ?? ActivityPurchase());
    emit(state.copyWith(
      isShowProgress: true,
      detailActivity: copiesActivity,
    ));
  }
}

class DetailActivityPurchaseEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetDetailActivityPurchaseEvent extends DetailActivityPurchaseEvent {
  ActivityPurchase activityDiary;
  bool resetView;
  Diary diary;

  GetDetailActivityPurchaseEvent(this.activityDiary, this.diary, {this.resetView = false});

  @override
  List<Object?> get props => [activityDiary, resetView, diary];
}

class ChangeEditActivityPurchaseEvent extends DetailActivityPurchaseEvent {
  ChangeEditActivityPurchaseEvent();
}

class ChangeDetailActivityPurchaseEvent extends DetailActivityPurchaseEvent {
  ChangeDetailActivityPurchaseEvent();
}

class BackEvent extends DetailActivityPurchaseEvent {
  ActivityDiary activityDiary;
  List<MaterialEntity> listMtl;
  List<Tool> listTool;

  BackEvent(this.activityDiary, this.listTool, this.listMtl);

  @override
  List<Object?> get props => [activityDiary, listTool, listMtl];
}

class UpdateActivityPurchaseEvent extends DetailActivityPurchaseEvent {
  UpdateActivityPurchaseEvent();
}

class OnSelectValueEvent extends DetailActivityPurchaseEvent {
  List<InputRegisterModel> list;
  int index;
  BuildContext context;

  OnSelectValueEvent(this.list, this.index, this.context);

  @override
  List<Object?> get props => [list, index, context];
}

class SaveValueTextFieldEvent extends DetailActivityPurchaseEvent {
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

class UpdateAvatarEvent extends DetailActivityPurchaseEvent {
  //final ImageSource source;
  UpdateAvatarEvent();
}

class DetailActivityPurchaseState extends BlocState {
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
    listMaterialAll,
    listToolAll,
    buyerController,
    productController,
    indexYield,
    inputDonGia,
    donGiaController,
    total,
    listSeasonFarm,
    indexSeasonFarm,
    seasonId,
    seasonFarmController,
    availableUnitName,
    availableUnitId,
    availableQuantity
  ];
  final Diary? diary;
  final ActivityPurchase? detailActivity;
  final ActivityPurchase? copiedActivityDiary;
  final List<MaterialEntity> listMaterial;
  final List<Tool> listTool;
  final List<MaterialEntity> listMaterialAll;
  final List<Tool> listToolAll;
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
  int seasonId;
  TextEditingController? seasonFarmController = TextEditingController();
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

  TextEditingController? buyerController = TextEditingController();
  TextEditingController? productController = TextEditingController();
  TextEditingController? donGiaController = TextEditingController();
  List<InputRegisterModel> inputDonGia;
  final int indexYield;
  double total;

  List<InputRegisterModel> listWidgetYield;
  final List<Unit> listUnitYield;
  bool isEdit;
  int indexActivity;
  int indexDonViArea;
  int indexYieldUnit;
  double imageWidth;
  double imageHeight;
  double areaMax;
  int indexSeasonFarm;
  final List<SeasonFarm> listSeasonFarm;
  double availableQuantity;
  int availableUnitId;
  String availableUnitName;

  DetailActivityPurchaseState({
    this.seasonId = -1,
    this.seasonFarmController,
    this.listSeasonFarm = const [],
    this.indexSeasonFarm = -1,
    this.buyerController,
    this.productController,
    this.inputDonGia = const [],
    this.indexYield = -1,
    this.donGiaController,
    this.detailActivity,
    this.copiedActivityDiary,
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.listMaterial = const [],
    this.listTool = const [],
    this.listMaterialAll = const [],
    this.listToolAll = const [],
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
    this.total = 0,
    this.availableQuantity = 0,
    this.availableUnitId = -1,
    this.availableUnitName = '',
  });

  DetailActivityPurchaseState copyWith({
    int? seasonId,
    TextEditingController? seasonFarmController,
    int? indexSeasonFarm,
    List<SeasonFarm>? listSeasonFarm,
    ActivityPurchase? detailActivity,
    ActivityPurchase? copiedActivityDiary,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    List<MaterialEntity>? listMaterial,
    List<Tool>? listTool,
    List<MaterialEntity>? listMaterialAll,
    List<Tool>? listToolAll,
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
    TextEditingController? buyerController,
    TextEditingController? productController,
    TextEditingController? donGiaController,
    List<InputRegisterModel>? inputDonGia,
    int? indexYield,
    double? total,
    double? availableQuantity,
    int? availableUnitId,
    String? availableUnitName,
  }) {
    return DetailActivityPurchaseState(
      seasonId: seasonId ?? this.seasonId,
      seasonFarmController: seasonFarmController ?? this.seasonFarmController,
      indexSeasonFarm: indexSeasonFarm ?? this.indexSeasonFarm,
      listSeasonFarm: listSeasonFarm ?? this.listSeasonFarm,
      copiedActivityDiary: copiedActivityDiary ?? this.copiedActivityDiary,
      detailActivity: detailActivity ?? this.detailActivity,
      formStatus: formStatus ?? this.formStatus,
      isShowProgress: isShowProgress ?? this.isShowProgress,
      listMaterial: listMaterial ?? this.listMaterial,
      listTool: listTool ?? this.listTool,
      listMaterialAll: listMaterialAll ?? this.listMaterialAll,
      listToolAll: listToolAll ?? this.listToolAll,
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
      buyerController: buyerController ?? this.buyerController,
      productController: productController ?? this.productController,
      inputDonGia: inputDonGia ?? this.inputDonGia,
      indexYield: indexYield ?? this.indexYield,
      donGiaController: donGiaController ?? this.donGiaController,
      total: total ?? this.total,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      availableUnitId: availableUnitId ?? this.availableUnitId,
      availableUnitName: availableUnitName ?? this.availableUnitName,
    );
  }
}
