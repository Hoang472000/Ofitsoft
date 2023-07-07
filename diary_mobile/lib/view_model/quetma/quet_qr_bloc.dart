import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../utils/form_submission_status.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class BarcodeBloc extends Bloc<BarcodeEvent, BarcodeState> {
  ///final Repository repository;
  final BuildContext context;

  BarcodeBloc(this.context, )
      : super(BarcodeState()) {
    on<GetItemBarcodeEvent>(_getItemBarcode);
    on<AddToCartEvent>(_addProductToCart);
    //add(GetItemBarcodeEvent("", 1));
  }

  Future<FutureOr<void>> _getItemBarcode(
      GetItemBarcodeEvent event, Emitter<BarcodeState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));
    }

  FutureOr<void> _addProductToCart(
      AddToCartEvent event, Emitter<BarcodeState> emit) {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}

class BarcodeEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetItemBarcodeEvent extends BarcodeEvent {
  final String barcode;
  final QRViewController? qrViewController;

  GetItemBarcodeEvent(this.barcode, {this.qrViewController});

  @override
  List<Object?> get props => [barcode, qrViewController];
}

class AddToCartEvent extends BarcodeEvent {

  AddToCartEvent();
}

class BarcodeState extends BlocState {
  @override
  List<Object?> get props =>
      [formStatus, numberCart, qrViewController];

  final FormSubmissionStatus formStatus;
  final int numberCart;
  final QRViewController? qrViewController;

  BarcodeState(
      {this.formStatus = const InitialFormStatus(),
        this.numberCart = 0,
        this.qrViewController,});

  BarcodeState copyWith(
      {FormSubmissionStatus? formStatus,
        int? numberCart,
        QRViewController? qrViewCtrl}) {
    return BarcodeState(
        formStatus: formStatus ?? const InitialFormStatus(),
        numberCart: numberCart ?? this.numberCart,
        qrViewController: qrViewCtrl ?? qrViewController,);
  }
}
