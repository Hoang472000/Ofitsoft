import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_event.dart';
import 'bloc_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  //final Repository repository;
  final BuildContext context;

  HomeBloc(this.context, /*{required this.repository}*/) : super(HomeState()) {
    on<HomeStartEvent>(_getListSalesSlip);
    //on<ChangeRadioUserOrgEvent>(_changeRadioOrg);
    add(HomeStartEvent());
  }

  ///Lay danh sach phieu ban hang
  FutureOr<void> _getListSalesSlip(
      HomeStartEvent event, Emitter<HomeState> emit) async {
    // lay danh sach org(đơn vị) cua user
  /*  final prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString(SharedPreferencesKey.userId) ?? "";
    List<UserORG> listUserOrg =
        await AiBookDb.instance.getListUserOrg(userId).get();
    if (listUserOrg.isNotEmpty) {
      // emit them org cua ok de hien thi len giao dien trang chu
      emit(state.copyWith(lOrg: listUserOrg, orgOk: state.userOrgChoose));
    }

    // Todo HanhNTHe: cho nay de fake sau thuc hien dung repository
    ReportData data = await FakeDataSource().fetchReportData(RequestReportData(
        dataTypeID: 1,
        fromDate: '',
        itemGUID: '',
        reportGUID: '',
        storeGUID: '',
        toDate: ''));
    // print (" reportMouthData = ---------------------------- ${data.chartForms.length}");
    emit(state.copyWith(charts: data.chartForms));

    // lay danh sach bao cao
    ReportData reportTodayData = await repository.fetchTodayReportData(
        RequestReportData(
            reportGUID: "",
            fromDate: "2022-01-01",
            toDate: "2022-05-29",
            dataTypeID: 0,
            storeGUID: "",
            itemGUID: ""));
    List<TableFormsTodayData> list =
        reportTodayData.tableForms.cast<TableFormsTodayData>();
    // print(" ----------- list = ${list.toString()}");
    for (var i in list) {
      // test
      if (i.xName == '25/05') {
        emit(state.copyWith(data: i));
      }
    }
  }

  FutureOr<void> _changeRadioOrg(
      ChangeRadioUserOrgEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(userORG: event.userOrg));*/
  }
}

class HomeEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class HomeStartEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class ChangeRadioUserOrgEvent extends HomeEvent {


  ChangeRadioUserOrgEvent();

  @override
  List<Object?> get props => [];
}

class HomeState extends BlocState {
  @override
  List<Object?> get props =>[];

  HomeState();

  HomeState copyWith() {
    return HomeState();
  }
}
