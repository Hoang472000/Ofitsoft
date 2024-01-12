import 'dart:async';

import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/activity/activity_transaction.dart';
import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:diary_mobile/data/entity/monitor/monitor_diary.dart';
import 'package:diary_mobile/utils/constants/status_const.dart';
import 'package:diary_mobile/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/entity/activity/activity_purchase.dart';
import '../../../../data/entity/diary/diary.dart';
import '../../../../data/entity/item_default/item_expansion.dart';
import '../../../../data/entity/item_default/material_entity.dart';
import '../../../../data/local_data/diary_db.dart';
import '../../../../data/remote_data/object_model/object_result.dart';
import '../../../../data/repository.dart';
import '../../../../utils/constants/shared_preferences_key.dart';
import '../../../../utils/status/form_submission_status.dart';
import '../../../../utils/widgets/dialog/toast_widget.dart';
import '../../../bloc_event.dart';
import '../../../bloc_state.dart';

class ActivityPurchaseBloc extends Bloc<ActivityPurchaseEvent, ActivityPurchaseState> {
  final Repository repository;

  ActivityPurchaseBloc(this.repository) : super(ActivityPurchaseState()) {
    on<GetListActivityPurchaseEvent>(_getListActivityPurchase);
    on<RemoveActivityPurchaseEvent>(_removeActivityPurchase);
    on<ExportPDFEvent>(_exportPDFEvent);
    on<AddChoosePurchaseEvent>(_addChoosePurchase);
    on<FilterEvent>(_filter);
    //add(GetListActivityEvent());
  }

  void _getListActivityPurchase(
      GetListActivityPurchaseEvent event, Emitter<ActivityPurchaseState> emitter) async {
    emitter(state.copyWith(
        isShowProgress: true,
        formStatus: const InitialFormStatus()));
    List<ActivityPurchase> listActivityTransaction = [];
    List<ActivityPurchase> listCallbackTransaction = [];
    final sharedPreferences = await SharedPreferences.getInstance();
    final categoryIdUnitYield =
        sharedPreferences.getInt(SharedPreferencesKey.unitYield) ?? -1;
    final listUnitYield =
    await DiaryDB.instance.getListUnit(categoryIdUnitYield);

      emitter(state.copyWith(
          isShowProgress: true));
      listActivityTransaction = await repository.getListActivityPurchase();
      print("HoangCV: _getListActivityPurchase: ${listActivityTransaction.length}");
      listCallbackTransaction.addAll(listActivityTransaction);
    List<bool> listSelected =
        List.generate(listActivityTransaction.length, (index) => false);
    emitter(state.copyWith(
      isShowProgress: false,
      listActivityTransaction: listActivityTransaction,
      listCallbackTransaction: listCallbackTransaction,
      listActivityTransactionFilter : listActivityTransaction,
      listSelected: listSelected,
      amountSelected: 0,
      listUnit: listUnitYield,
    ));
    String donVi = listUnitYield[listUnitYield
                .indexWhere((element) => (element.convert ?? 1) / 1 == 1)]
            .name ??
        "";
    List<ItemExpansion> listExpansion =
        calculateTotal(listActivityTransaction, listUnitYield, donVi);
    emitter(state.copyWith(
        isShowProgress: false,
        listExpansion: listExpansion,
        donVi: donVi));
  }

  List<ItemExpansion> calculateTotal(List<ActivityPurchase> listCallbackTransaction, List<Unit> listUnit, String donVi) {
    double totalQuantity = listCallbackTransaction.fold(
        0, (previousValue, element) => previousValue + (element.quantity ?? 0) * (listUnit[listUnit.indexWhere((e) => e.id == element.quantityUnitId)].convert ?? 1));
    double totalAmount = listCallbackTransaction.fold(
        0,
        (previousValue, element) =>
            previousValue +
            ((element.quantity ?? 0) * (element.unitPrice ?? 0)));
    int totalTransaction = listCallbackTransaction.length;

    List<ItemExpansion> resultList = [
      ItemExpansion(name: 'Tổng tiền', amount: Utils.formatCurrencyViVn(totalAmount)),
      ItemExpansion(name: 'Tổng giao dịch', amount: "${totalTransaction} giao dịch"),
      ItemExpansion(name: 'Tổng sản lượng', amount: Utils.formatCurrencyViVn(totalQuantity, donVi: donVi)),
    ];

    return resultList;
  }

  FutureOr<void> _removeActivityPurchase(
      RemoveActivityPurchaseEvent event, Emitter<ActivityPurchaseState> emit) async {
    emit(state.copyWith(isShowProgress: true, formStatus: FormSubmitting()));
    ObjectResult objectResult;
    if(event.action.compareTo('sell') == 0 || event.action.compareTo('purchase') == 0) {
      print("HoangCV: bug remove sell: ${event.id}");
      objectResult = await repository.removeActivityTransaction(event.id);
    } else{
      objectResult = await repository.removeActivityDiary(event.id);
    }
    //DiaryDB.instance.getListDiary();
    if (objectResult.responseCode == StatusConst.code00) {
      add(GetListActivityPurchaseEvent());
      emit(state.copyWith(
          isShowProgress: false,
          formStatus: SubmissionSuccess(success: "Xóa hoạt động thành công.")));
    } else if (objectResult.responseCode == StatusConst.code01) {
      emit(state.copyWith(
          isShowProgress: false,
          formStatus: SubmissionFailed(objectResult.message)));
    }
  }

  FutureOr<void> _exportPDFEvent(ExportPDFEvent event, Emitter<ActivityPurchaseState> emit) async {
    emit(state.copyWith(isShowProgress: true, formStatus: FormSubmitting()));
    var objectResult = await repository.getExportPdf(event.ids);

    //DiaryDB.instance.getListDiary();
    if (objectResult.responseCode == StatusConst.code00) {
      Utils.downloadExcelFile(objectResult.response, event.ids.first);
      //add(GetListActivityPurchaseEvent());
      emit(state.copyWith(
          isShowProgress: false,
          formStatus: SubmissionSuccess(success: "Xuất hóa đơn thành công.")));
    } else if (objectResult.responseCode == StatusConst.code01) {
      emit(state.copyWith(
          isShowProgress: false,
          formStatus: SubmissionFailed(objectResult.message)));
    }

  }

  FutureOr<void> _addChoosePurchase(AddChoosePurchaseEvent event, Emitter<ActivityPurchaseState> emit) {
    List<bool> listChoose = state.listSelected;
    bool choose = event.isChoose;
    int amountChoose = state.amountSelected;
    if (choose) {
      amountChoose++;
    } else {
      if (amountChoose > 0) {
        amountChoose--;
        print("HoangCV: amountChoose: $amountChoose}");
      }
    }
    listChoose
        .replaceRange(event.index, event.index + 1, [choose]);
    emit(state.copyWith(
        isShowProgress: false,
        formStatus: const InitialFormStatus(),
        listSelected: listChoose,
        amountSelected: amountChoose));
  }

  FutureOr<void> _filter(FilterEvent event, Emitter<ActivityPurchaseState> emit) {
    print("HoangCV: filter: ${event.result}");
    var startTime = event.result[0]/*.replaceAll("/","-")*/;
    var endTime = event.result[1]/*.replaceAll("/","-")*/;
    var minPrice = double.parse(event.result[2] != "" ? event.result[2] : "-1");
    var maxPrice = double.parse(event.result[3] != "" ? event.result[3] : "-1");
    var minQuantity = double.parse(event.result[4] != "" ? event.result[4] : "-1");
    var maxQuantity = double.parse(event.result[5] != "" ? event.result[5] : "-1");
    var filter0 = event.result[6];
    var filter1 = event.result[7];
    var filter2 = event.result[8];
    var filter3 = event.result[9];
    List<ActivityPurchase> list = state.listActivityTransactionFilter.map((e) => ActivityPurchase.copy(e)).toList();
    //print("HoangCV: filter: ${minPrice} : ${maxPrice}");
    List<ActivityPurchase> filteredList = [];
    for (var activity in list) {
      //String transactionDate = Utils.formatTime(activity.transactionDate ?? "");
      DateTime transactionDate = DateTime.parse(activity.transactionDate ?? "");
      /*print("transactionDate: ${transactionDate} : ${Utils.stringToDate(startTime)}");
      print("DateTime.parse(startTime) : ${!transactionDate.isBefore(Utils.stringToDate(startTime))}");*/
      bool withinStartTime = startTime.isNotEmpty ? !transactionDate.isBefore(Utils.stringToDate(startTime)) : true;
      bool withinEndTime = endTime.isNotEmpty ? !transactionDate.isAfter(Utils.stringToDateEnd(endTime)) : true;
      bool withinMinPrice = minPrice != -1 ? (activity.unitPrice ?? 0) * (activity.quantity ?? 0) >= minPrice : true;
      bool withinMaxPrice = maxPrice != -1 ? (activity.unitPrice ?? 0) * (activity.quantity ?? 0) <= maxPrice : true;
      bool withinMinQuantity = minQuantity != -1 ? (activity.quantity ?? 0) >= minQuantity : true;
      bool withinMaxQuantity = maxQuantity != -1 ? (activity.quantity ?? 0) <= maxQuantity : true;

      //print("HoangCV: $withinStartTime : $withinEndTime : $withinMinPrice : $withinMaxPrice: $withinMinQuantity : $withinMaxQuantity");
      if (withinStartTime && withinEndTime && withinMinPrice && withinMaxPrice && withinMinQuantity && withinMaxQuantity) {
        filteredList.add(activity);
      }
    }
    List<ActivityPurchase> listFilter0 = [];
    List<ActivityPurchase> listFilter1 = [];
    List<ActivityPurchase> listFilter2 = [];
    List<ActivityPurchase> listFilter3 = [];
    if(filter0 != -1) {
      String name = list[list.indexWhere((element) => element.id == filter0)].areaName ?? "";
      listFilter0.addAll(filteredList.where((
          activity) => activity.areaName == name).toList());
    } else{
      listFilter0.addAll(filteredList);
    }
    if(filter1 != -1) {
      listFilter1.addAll(listFilter0.where((
          activity) => activity.seasonFarmId == filter1).toList());
    } else{
      listFilter1.addAll(listFilter0);
    }
    if(filter2 != -1) {
      String name = list[list.indexWhere((element) => element.id == filter2)].farmerName ?? "";
      listFilter2.addAll(listFilter1.where((
          activity) => activity.farmerName == name).toList());
    } else{
      listFilter2.addAll(listFilter1);
    }
    if(filter3 != -1) {
      listFilter3.addAll(listFilter2.where((
          activity) => activity.productId == filter3).toList());
    } else{
      listFilter3.addAll(listFilter2);
    }
    if(listFilter3.length > 0) {
      emit(state.copyWith(
          isShowProgress: false,
          listActivityTransaction: listFilter3
      ));
      List<ItemExpansion> listExpansion = calculateTotal(listFilter3, state.listUnit, state.donVi);
      emit(state.copyWith(
        isShowProgress: false,
        listExpansion: listExpansion,
      ));
    } else{
      Toast.showLongTop("Không tìm thấy thông tin giao dịch phù hợp");
      emit(state.copyWith(
        isShowProgress: false,
      ));
    }
  }
}

class ActivityPurchaseEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetListActivityPurchaseEvent extends ActivityPurchaseEvent {

  GetListActivityPurchaseEvent();

  @override
  List<Object?> get props => [];
}

class AddChoosePurchaseEvent extends ActivityPurchaseEvent {
  AddChoosePurchaseEvent(this.index, this.isChoose);

  final int index;
  final bool isChoose;

  @override
  List<Object?> get props => [isChoose, index];
}


class RemoveActivityPurchaseEvent extends ActivityPurchaseEvent {
  final int id;
  final String action;

  RemoveActivityPurchaseEvent(this.id, this.action);

  @override
  List<Object?> get props => [id, action];
}

class ExportPDFEvent extends ActivityPurchaseEvent {
  final List<int> ids;

  ExportPDFEvent(this.ids);

  @override
  List<Object?> get props => [ids];
}

class FilterEvent extends ActivityPurchaseEvent {
  final dynamic result;

  FilterEvent(this.result);

  @override
  List<Object?> get props => [result];
}

class ActivityPurchaseState extends BlocState {
  @override
  List<Object?> get props => [
    listDiaryActivity,
    formStatus,
    isShowProgress,
    listMaterial,
    listTool,
    listUnit,
    listActivity,
    listDiaryMonitor,
    seasonFarmId,
    diary,
    updateHarvesting,
    listCallback,
    listActivityTransaction,
    listActivityTransactionFilter,
    listCallbackTransaction,
    amountSelected,
    listSelected,
    listExpansion,
    donVi,
  ];
  final List<ActivityDiary> listDiaryActivity;
  final List<MaterialEntity> listMaterial;
  final List<Tool> listTool;
  final List<Unit> listUnit;
  final List<Activity>? listActivity;
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;
  final List<MonitorDiary> listDiaryMonitor;
  final int? seasonFarmId;
  final Diary? diary;
  final bool updateHarvesting;
  final List<ActivityDiary> listCallback;
  final List<ActivityPurchase> listCallbackTransaction;
  final List<ActivityPurchase> listActivityTransaction;
  final List<ActivityPurchase> listActivityTransactionFilter;
  final List<bool> listSelected;
  final int amountSelected;
  final List<ItemExpansion> listExpansion;
  final String donVi;

  ActivityPurchaseState({
    this.listActivityTransaction = const [],
    this.listActivityTransactionFilter = const [],
    this.listDiaryActivity = const [],
    this.listDiaryMonitor = const [],
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.listMaterial = const [],
    this.listTool = const [],
    this.listUnit = const [],
    this.listActivity = const [],
    this.seasonFarmId,
    this.diary,
    this.updateHarvesting = false,
    this.listCallback = const [],
    this.listCallbackTransaction = const [],
    this.listSelected = const [],
    this.amountSelected = 0,
    this.listExpansion = const [],
    this.donVi = "",
  });

  ActivityPurchaseState copyWith({
    List<ActivityDiary>? listDiaryActivity,
    List<MonitorDiary>? listDiaryMonitor,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    List<MaterialEntity>? listMaterial,
    List<Tool>? listTool,
    List<Unit>? listUnit,
    List<Activity>? listActivity,
    int? seasonFarmId,
    Diary? diary,
    bool? updateHarvesting,
    List<ActivityDiary>? listCallback,
    List<ActivityPurchase>? listActivityTransaction,
    List<ActivityPurchase>? listCallbackTransaction,
    List<ActivityPurchase>? listActivityTransactionFilter,
    List<bool>? listSelected,
    int? amountSelected,
    List<ItemExpansion>? listExpansion,
    String? donVi,
  }) {
    return ActivityPurchaseState(
        listDiaryActivity: listDiaryActivity ?? this.listDiaryActivity,
        listDiaryMonitor: listDiaryMonitor ?? this.listDiaryMonitor,
        formStatus: formStatus ?? this.formStatus,
        isShowProgress: isShowProgress ?? this.isShowProgress,
        listMaterial: listMaterial ?? this.listMaterial,
        listTool: listTool ?? this.listTool,
        listUnit: listUnit ?? this.listUnit,
        listActivity: listActivity ?? this.listActivity,
        seasonFarmId: seasonFarmId ?? this.seasonFarmId,
        diary: diary ?? this.diary,
        updateHarvesting: updateHarvesting ?? this.updateHarvesting,
        listActivityTransaction:
        listActivityTransaction ?? this.listActivityTransaction,
        listCallbackTransaction:
        listCallbackTransaction ?? this.listCallbackTransaction,
      listActivityTransactionFilter:
      listActivityTransactionFilter ?? this.listActivityTransactionFilter,
        listCallback: listCallback ?? this.listCallback,
        listSelected: listSelected ?? this.listSelected,
        amountSelected: amountSelected ?? this.amountSelected,
        listExpansion: listExpansion ?? this.listExpansion,
        donVi: donVi ?? this.donVi,
    );
  }
}
