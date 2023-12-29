

import 'dart:async';

import 'package:diary_mobile/data/entity/activity/activity_purchase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/entity/diary/area_entity.dart';
import '../../data/entity/diary/diary.dart';
import '../../data/local_data/diary_db.dart';
import '../../data/repository.dart';
import '../../utils/constants/shared_preferences_key.dart';
import '../../utils/extenstion/extenstions.dart';
import '../../utils/extenstion/input_register_model.dart';
import '../../utils/extenstion/service_info_extension.dart';
import '../../utils/status/form_submission_status.dart';
import '../../utils/utils.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final Repository repository;

  FilterBloc(this.repository) : super(FilterState()) {
    on<InitFilterEvent>(_initFilter);
    on<OnSelectValueEvent>(_onSelectValue);
    on<OnChangeDateTime>(_onChangeDateTime);
    on<FilterDiaryEvent>(_filterDiary);
    on<SaveValueTextFieldEvent>(_saveValueTextField);
    on<SaveValueTextEvent>(_saveValueText);
    // add(InitFilterEvent());
  }

  Future<void> initFilterDiary(Emitter<FilterState> emit, List<dynamic> listInput) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    List<ItemFilter> itemFilters = [ItemFilter(-1, "Tất cả")];
    List<ItemFilter> cropFilters = [ItemFilter(-1, "Tất cả")];
    List<ItemFilter> peopleFilters = [ItemFilter(-1, "Tất cả")];
    List<ItemFilter> areaFilter = [ItemFilter(-1, "Tất cả")];
   // areaFilter.addAll(await DiaryDB.instance.getListItemFilter(userId));

      itemFilters.addAll(listInput.map((object) {
        int id = object.id;
        String name = object.name;
        return ItemFilter(id, name);
      }).toList());

    Set areaValues = listInput.map((obj) => obj.areaName).toSet();
    areaValues.forEach((value) {
      dynamic? correspondingObject = listInput.firstWhere((obj) => obj.areaName == value);
      areaFilter.add(ItemFilter(correspondingObject.areaId, correspondingObject.areaName));
    });

      Set cropValues = listInput.map((obj) => obj.cropName).toSet();
      cropValues.forEach((value) {
        dynamic? correspondingObject = listInput.firstWhere((obj) => obj.cropName == value);
        cropFilters.add(ItemFilter(correspondingObject.cropId, correspondingObject.cropName));
      });

      Set peopleValues = listInput.map((obj) => obj.farmerName).toSet();
      peopleValues.forEach((value) {
        dynamic? correspondingObject = listInput.firstWhere((obj) => obj.farmerName == value);
        peopleFilters.add(ItemFilter(correspondingObject.farmerId, correspondingObject.farmerName));
      });
 /*     peopleFilters.forEach((element) {
        print("HoangCV:element: ${element.id}");
      });*/

    List<InputRegisterModel> list = [];
    list.add(InputRegisterModel<ItemFilter, ItemFilter>(
      title: "Vùng trồng",
      isCompulsory: false,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: 0,
      listValue: areaFilter,
      valueSelected: areaFilter[0],
      typeInputEnum: TypeInputEnum.dmucItem,
      hasSearch: true,));
    list.add(InputRegisterModel<ItemFilter, ItemFilter>(
      title: "Mùa vụ",
      isCompulsory: false,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: 0,
      valueSelected: itemFilters[0],
      listValue: itemFilters,
      typeInputEnum: TypeInputEnum.dmucItem,
      hasSearch: true,
    ));
    if(cropFilters.isNotEmpty) {
      list.add(InputRegisterModel<ItemFilter, ItemFilter>(
        title: "Cây trồng",
        isCompulsory: false,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: 0,
        valueSelected: cropFilters[0],
        listValue: cropFilters,
        typeInputEnum: TypeInputEnum.dmucItem,
        hasSearch: true,
      ));
    }
    if(peopleFilters.isNotEmpty) {
      list.add(InputRegisterModel<ItemFilter, ItemFilter>(
        title: "Nông hộ",
        isCompulsory: false,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: 0,
        valueSelected: peopleFilters[0],
        listValue: peopleFilters,
        typeInputEnum: TypeInputEnum.dmucItem,
        hasSearch: true,
      ));
    }
    emit(state.copyWith(
      list: list,
      isShowProgress: false,
      listFilter: itemFilters,
    ));
  }

  Future<void> initFilterReport(Emitter<FilterState> emit, List<dynamic> listInput) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    int userId = sharedPreferences.getInt(SharedPreferencesKey.userId) ?? -1;
    List<ItemFilter> itemFilter = [ItemFilter(-1, "Tất cả")];
    List<ItemFilter> inspectorFilter = [ItemFilter(-1, "Tất cả")];
    List<ItemFilter> peopleFilter = [ItemFilter(-1, "Tất cả")];
    List<ItemFilter> statusFilter = [ItemFilter(-1, "Tất cả")];
    // areaFilter.addAll(await DiaryDB.instance.getListItemFilter(userId));

/*    itemFilters.addAll(listInput.map((object) {
      int id = object.id;
      String name = object.surveyId;
      return ItemFilter(id, name);
    }).toList());*/

    Set itemValues = listInput.map((obj) => obj.surveyId).toSet();
    itemValues.forEach((value) {
      dynamic? correspondingObject = listInput.firstWhere((obj) => obj.surveyId == value);
      itemFilter.add(ItemFilter(correspondingObject.id, correspondingObject.surveyId));
    });

    Set inspectorValues = listInput.map((obj) => obj.internalInspector).toSet();
    inspectorValues.forEach((value) {
      dynamic? correspondingObject = listInput.firstWhere((obj) => obj.internalInspector == value);
      inspectorFilter.add(ItemFilter(correspondingObject.internalInspectorId, correspondingObject.internalInspector));
    });

    Set peopleValues = listInput.map((obj) => obj.farmerId).toSet();
    peopleValues.forEach((value) {
      dynamic? correspondingObject = listInput.firstWhere((obj) => obj.farmerId == value);
      peopleFilter.add(ItemFilter(correspondingObject.farmerId, correspondingObject.farmerName));
    });

    Set statusValues = listInput.map((obj) => obj.state).toSet();
    statusValues.forEach((value) {
      dynamic? correspondingObject = listInput.firstWhere((obj) => obj.state == value);
      statusFilter.add(ItemFilter(correspondingObject.id, correspondingObject.state == "done" ? "Hoàn thành" : "Chưa hoàn thành"));
    });

    List<InputRegisterModel> list = [];
    list.add(InputRegisterModel<ItemFilter, ItemFilter>(
      title: "Mẫu khảo sát",
      isCompulsory: false,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: 0,
      listValue: itemFilter,
      valueSelected: itemFilter[0],
      typeInputEnum: TypeInputEnum.dmucItem,
      hasSearch: true,));
    list.add(InputRegisterModel<ItemFilter, ItemFilter>(
      title: "Thanh tra",
      isCompulsory: false,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: 0,
      valueSelected: inspectorFilter[0],
      listValue: inspectorFilter,
      typeInputEnum: TypeInputEnum.dmucItem,
      hasSearch: true,
    ));
    list.add(InputRegisterModel<ItemFilter, ItemFilter>(
      title: "Nông hộ",
      isCompulsory: false,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: 0,
      valueSelected: peopleFilter[0],
      listValue: peopleFilter,
      typeInputEnum: TypeInputEnum.dmucItem,
      hasSearch: true,
    ));
    list.add(InputRegisterModel<ItemFilter, ItemFilter>(
      title: "Trạng thái",
      isCompulsory: false,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: 0,
      valueSelected: statusFilter[0],
      listValue: statusFilter,
      typeInputEnum: TypeInputEnum.dmucItem,
      hasSearch: true,
    ));
    emit(state.copyWith(
      list: list,
      isShowProgress: false,
      //listFilter: itemFilters,
    ));
  }

  Future<void> initFilterPurchase(Emitter<FilterState> emit, List<dynamic> listInput) async{
    List<ItemFilter> itemFilters = [ItemFilter(-1, "Tất cả")];
    List<ItemFilter> productFilters = [ItemFilter(-1, "Tất cả")];
    List<ItemFilter> peopleFilters = [ItemFilter(-1, "Tất cả")];

    itemFilters.addAll(listInput.map((object) {
      int id = object.seasonFarmId;
      String name = (object as ActivityPurchase).seasonFarmName ?? "";
      return ItemFilter(id, name);
    }).toList());

    Set productValues = listInput.map((obj) => obj.productName).toSet();
    productValues.forEach((value) {
      dynamic? correspondingObject = listInput.firstWhere((obj) => obj.productName == value);
      productFilters.add(ItemFilter(correspondingObject.productId, correspondingObject.productName));
    });

/*    Set peopleValues = listInput.map((obj) => obj.farmName).toSet();
    peopleValues.forEach((value) {
      dynamic? correspondingObject = listInput.firstWhere((obj) => obj.farmName == value);
      peopleFilters.add(ItemFilter(correspondingObject.farmId, correspondingObject.farmName));
    });*/

    List<InputRegisterModel> list = [];
    list.add(InputRegisterModel<ItemFilter, ItemFilter>(
      title: "Mùa vụ",
      isCompulsory: false,
      type: TypeInputRegister.Select,
      icon: Icons.arrow_drop_down,
      positionSelected: 0,
      valueSelected: itemFilters[0],
      listValue: itemFilters,
      typeInputEnum: TypeInputEnum.dmucItem,
      hasSearch: true,
    ));
    if(productFilters.isNotEmpty) {
      list.add(InputRegisterModel<ItemFilter, ItemFilter>(
        title: "Sản phẩm",
        isCompulsory: false,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: 0,
        valueSelected: productFilters[0],
        listValue: productFilters,
        typeInputEnum: TypeInputEnum.dmucItem,
        hasSearch: true,
      ));
    }
    /*if(peopleFilters.isNotEmpty) {
      list.add(InputRegisterModel<ItemFilter, ItemFilter>(
        title: "Điều kiện 3",
        isCompulsory: false,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: 0,
        valueSelected: peopleFilters[0],
        listValue: peopleFilters,
        typeInputEnum: TypeInputEnum.dmucItem,
        hasSearch: true,
      ));
    }*/
    emit(state.copyWith(
      list: list,
      isShowProgress: false,
      listFilter: itemFilters,
    ));
  }

  FutureOr<void> _initFilter(InitFilterEvent event, Emitter<FilterState> emit) {
    emit(state.copyWith(
      isShowProgress: true,
      startTime: "",
      endTime: "",
      minPriceFocus: FocusNode(),
      maxPriceFocus: FocusNode(),
      minQuantityFocus: FocusNode(),
      maxQuantityFocus: FocusNode(),
      minPrice: TextEditingController(),
      maxPrice: TextEditingController(),
      minQuantity: TextEditingController(),
      maxQuantity: TextEditingController(),
      indexFilter0: -1,
      indexFilter1: -1,
      indexFilter2: -1,
      indexFilter3: -1,
    ));
    print("HoangCV: event.type:0 ${event.type}");
    if(event.type.compareTo("diary") == 0) {
      initFilterDiary(emit, event.list);
    } else if(event.type.compareTo("season") == 0)  {
      initFilterPurchase(emit, event.list);
    } else if(event.type.compareTo("report") == 0)  {
      initFilterReport(emit, event.list);
    }
  }


  FutureOr<void> _onSelectValue(OnSelectValueEvent event, Emitter<FilterState> emit) async {
    int result;
    bool checkPass = true;
/*    if (event.index == 0 && state.listFarmer.isEmpty) {
      Toast.showLongTop("Không có danh sách nông hộ");
      checkPass = false;
    } else if (event.index == 4 && state.listFarm.isEmpty) {
      Toast.showLongTop("Không có danh sách lô trồng");
      checkPass = false;
    }*/
    /*else if(event.index == 2 && state.listInspector.isEmpty) {
      Toast.showLongTop("Không có danh sách thanh tra viên");
      checkPass = false;
    }*/
    if (checkPass) {
      if (event.list[event.index].valueSelected.runtimeType == DateTime ||
          event.list[event.index].typeInputEnum == TypeInputEnum.date) {
        //     setState(() {
        int result1 = await ServiceInfoExtension()
            .selectValue(
            event.list[event.index], event.context, (modelInput) {});
      } else {
        print("HoangCV: event.list[event.index].listValue: ${event
            .index} : ${event.list[event.index].toString()} : ${event.list[event
            .index].listValue.length} ");
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

          if (event.index == 0) {
            emit(state.copyWith(
              indexFilter0: event.list[event.index].listValue[result].id
            ));

          } else if (event.index == 1) {
            emit(state.copyWith(
                indexFilter1: event.list[event.index].listValue[result].id
            ));

          } else if (event.index == 2) {
            emit(state.copyWith(
                indexFilter2: event.list[event.index].listValue[result].id
            ));

          } else if (event.index == 3) {
          emit(state.copyWith(
              indexFilter3: event.list[event.index].listValue[result].id
          ));

        }
        }
      }
    }
  }


  FutureOr<void> _filterDiary(FilterDiaryEvent event, Emitter<FilterState> emit) {
  }


  FutureOr<void> _saveValueTextField(SaveValueTextFieldEvent event, Emitter<FilterState> emit) {
  }


  FutureOr<void> _onChangeDateTime(OnChangeDateTime event, Emitter<FilterState> emit) async {
    emit(state.copyWith(
      startTime: event.startTime.isNotEmpty
          ? event.startTime
          : Utils.formatDateToString(DateTime.now()),
      endTime: event.endTime.isNotEmpty
          ? event.endTime
          : Utils.formatDateToString(DateTime.now()),
    ));
  }

  FutureOr<void> _saveValueText(SaveValueTextEvent event, Emitter<FilterState> emit) {
    if(event.type == "minPrice") {
      emit(state.copyWith(
          minPrice: TextEditingController(text: event.text)));
    } else if(event.type == "maxPrice") {
      emit(state.copyWith(
          maxPrice: TextEditingController(text: event.text)));
    } else if(event.type == "minQuantity") {
      emit(state.copyWith(
          minQuantity: TextEditingController(text: event.text)));
    } else if(event.type == "maxQuantity") {
      emit(state.copyWith(
          maxQuantity: TextEditingController(text: event.text)));
    }
  }
}

class FilterEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class InitFilterEvent extends FilterEvent {
  String type;
  List<dynamic> list;

  InitFilterEvent(this.type, this.list);

  @override
  List<Object?> get props => [type, list];
}

class ChangeEditActivityEvent extends FilterEvent {
  ChangeEditActivityEvent();
}


class OnSelectValueEvent extends FilterEvent {
  List<InputRegisterModel> list;
  int index;
  BuildContext context;

  OnSelectValueEvent(this.list, this.index, this.context);

  @override
  List<Object?> get props => [list, index, context];
}

class SaveValueTextFieldEvent extends FilterEvent {
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

class FilterDiaryEvent extends FilterEvent {
  FilterDiaryEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAvatarEvent extends FilterEvent {
  //final ImageSource source;
  UpdateAvatarEvent();
}

class OnChangeDateTime extends FilterEvent {
  OnChangeDateTime(this.startTime, this.endTime);

  final String startTime;
  final String endTime;

  @override
  List<Object?> get props => [startTime, endTime];
}

class SaveValueTextEvent extends FilterEvent {
  final String type;
  final String text;

  SaveValueTextEvent(
      this.text,
      this.type,
      );

  @override
  List<Object?> get props => [text, type];
}

class FilterState extends BlocState {
  @override
  List<Object?> get props => [
    formStatus,
    isShowProgress,
    startTime,
    endTime,
    list,
    listFilter,
    minQuantity,
    maxQuantity, 
    minPrice, 
    maxPrice,
    indexFilter0,
    indexFilter1,
    indexFilter2,
    indexFilter3,
  ];

  final FormSubmissionStatus formStatus;
  final bool isShowProgress;
  String startTime;
  String endTime;
  List<InputRegisterModel> list;
  List<ItemFilter> listFilter;
  TextEditingController? minQuantity = TextEditingController();
  TextEditingController? maxQuantity = TextEditingController();
  TextEditingController? minPrice = TextEditingController();
  TextEditingController? maxPrice = TextEditingController();
  FocusNode? minQuantityFocus = FocusNode();
  FocusNode? maxQuantityFocus = FocusNode();
  FocusNode? minPriceFocus = FocusNode();
  FocusNode? maxPriceFocus = FocusNode();
  int indexFilter0 = -1;
  int indexFilter1 = -1;
  int indexFilter2 = -1;
  int indexFilter3 = -1;

  FilterState({
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.startTime =  '',
    this.endTime = '',
    this.list = const [],
    this.listFilter = const [],
    this.minQuantity, 
    this.maxQuantity, 
    this.minPrice, 
    this.maxPrice,
    this.minQuantityFocus,
    this.maxQuantityFocus,
    this.minPriceFocus,
    this.maxPriceFocus,
    this.indexFilter0 = -1,
    this.indexFilter1 = -1,
    this.indexFilter2 = -1,
    this.indexFilter3 = -1,
  });

  FilterState copyWith({
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    String? startTime,
    String? endTime,
    List<InputRegisterModel>? list,
    List<ItemFilter>? listFilter,
  TextEditingController? minQuantity,
  TextEditingController? maxQuantity,
  TextEditingController? minPrice,
  TextEditingController? maxPrice,
  FocusNode? minQuantityFocus,
  FocusNode? maxQuantityFocus,
  FocusNode? minPriceFocus,
  FocusNode? maxPriceFocus,
    int? indexFilter0,
    int? indexFilter1,
    int? indexFilter2,
    int? indexFilter3
  }) {
    return FilterState(
      formStatus: formStatus ?? this.formStatus,
      isShowProgress: isShowProgress ?? this.isShowProgress,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        list: list ?? this.list,
        listFilter: listFilter ?? this.listFilter,
      minQuantity: minQuantity ?? this.minQuantity,
      maxQuantity: maxQuantity ?? this.maxQuantity,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
        minQuantityFocus: minQuantityFocus ?? this.minQuantityFocus,
        maxQuantityFocus: maxQuantityFocus ?? this.maxQuantityFocus,
        minPriceFocus: minPriceFocus ?? this.minPriceFocus,
        maxPriceFocus: maxPriceFocus ?? this.maxPriceFocus,
        indexFilter0: indexFilter0 ?? this.indexFilter0,
        indexFilter1: indexFilter1 ?? this.indexFilter1,
        indexFilter2: indexFilter2 ?? this.indexFilter2,
        indexFilter3: indexFilter3 ?? this.indexFilter3,
    );
  }
}

class ItemFilter {
  int id;
  String name;
  String image;
  List<ItemFilter> list;

  ItemFilter(this.id, this.name, {this.image = "", this.list = const []});

  factory ItemFilter.fromJson(Map<String, dynamic> json) {
    return ItemFilter(
      json['id'] ?? -1,
      json['name'] ?? "",
      list: json['list'] != null
          ? (json['list'] as List<dynamic>)
          .map((itemJson) => ItemFilter.fromJson(itemJson))
          .toList()
          : [],
    );
  }
}