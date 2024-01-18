import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../generated/l10n.dart';
import '../resource/assets.dart';
import '../utils/constants/shared_preferences.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';
import 'diary_activity/activity/info_diary_bloc.dart';

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


    List<ActivityFarm> list = [];
    List<bool> check = await SharedPreDiary.getRole();
    if(check[4]) {
      list.add(ActivityFarm(
          id: 1,
          nameActivity: S.of(context).purchase_transaction,
          iconActivity: ImageAsset.imageSelling));
    } if(check[3]){
      list.add(ActivityFarm(
          id: 2,
          nameActivity: S.of(context).survey_review,
          iconActivity: ImageAsset.imageManager));
    }
    if(check[3] || check[4]) {
      list.add(ActivityFarm(
          id: 3,
          nameActivity: S.of(context).trace,
          iconActivity: ImageAsset.imageQrCode));
    }
    list.add(ActivityFarm(
        id: 7,
        nameActivity: S.of(context).create_diary,
        iconActivity: ImageAsset.imageDiary));
    list.add(ActivityFarm(
        id: 8,
        nameActivity: S.of(context).history_activity,
        iconActivity: ImageAsset.imageHistoryActivity));
    list.add(ActivityFarm(
        id: 4,
        nameActivity: S.of(context).communication,
        iconActivity: ImageAsset.imageReply));
    list.add(ActivityFarm(
        id: 5,
        nameActivity: S.of(context).er_manual,
        iconActivity: ImageAsset.imageManual));
    list.add(ActivityFarm(
        id: 6,
        nameActivity: S.of(context).contact,
        iconActivity: ImageAsset.imagePhone));
    emit(state.copyWith(listActivityFarm: list));
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
  List<Object?> get props => [listActivityFarm];
  final List<ActivityFarm> listActivityFarm;

  HomeState({this.listActivityFarm = const []});

  HomeState copyWith({List<ActivityFarm>? listActivityFarm}) {
    return HomeState(
        listActivityFarm: listActivityFarm ?? this.listActivityFarm);
  }
}
