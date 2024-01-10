import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../generated/l10n.dart';
import '../../resource/color.dart';
import '../../resource/style.dart';
import '../../utils/status/form_submission_status.dart';
import '../../utils/logger.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/ofit_app_bar.dart';
import '../../utils/widgets/button_widget.dart';
import '../../utils/widgets/dialog/dialog_manager.dart';
import '../../view_model/quetma/quet_qr_bloc.dart';
enum ScanType { barcode, qrcode }
class QRCodeView extends StatefulWidget {
  const QRCodeView({Key? key}) : super(key: key);

  static Route route() {
    return Utils.pageRouteBuilder(
        QRCodeView(), true);
  }

  @override
  State<StatefulWidget> createState() => _QRCodeViewState();
}

class _QRCodeViewState extends State<QRCodeView>{
  final TextEditingController _inputBarCodeController = TextEditingController();
  double cutOutBottomOffsetQr = 100;
  final FocusNode _focusBarCode = FocusNode();
  int numberProduct = 1;
  late BuildContext contextState;
  late BarcodeState barcodeState;
  bool addOrRemoveFromCart = false;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  String textError = "";
  String barCodeError = "";

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

/*  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('state = $state');
    switch (state) {
      case AppLifecycleState.resumed:
        controller!.resumeCamera();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      //case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        controller!.resumeCamera();
        break;
    }
  }*/

  @override
  initState() {
    //WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    //WidgetsBinding.instance.removeObserver(this);
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BarcodeBloc>(
        create: (context) =>
            BarcodeBloc(context),
        child: Scaffold(
                appBar: OfitAppBar(
                  context,
                  centerTitle: true,
                  showDefaultBackButton: true,
                  backgroundColor: AppColor.main,
                  title: Text(
                    S.of(context).code_scan,
                    style: StyleOfit.textStyleFW700(Colors.white, 20),
                  ),
                ),
                body: BlocConsumer<BarcodeBloc, BarcodeState>(
                    listener: (context, state) async {
                      final formStatus = state.formStatus;
                      if (formStatus is SubmissionFailed) {
                        DiaLogManager.displayDialog(context,
                            "${S.of(context).code} $barCodeError ${S.of(context).code_not_exist}", "", () {
                              Get.back();
                              if (state.qrViewController != null) {
                                state.qrViewController!.resumeCamera();
                              }
                            }, () {
                              Get.back();
                              if (state.qrViewController != null) {
                                state.qrViewController!.resumeCamera();
                              }
                            }, "", S.of(context).agree);
                      } else if (formStatus is SubmissionSuccess) {

                      } else if (formStatus is FormSubmitting) {
                        DiaLogManager.showDialogLoading(context);
                      }
                    }, builder: (context, state) {
                  contextState = context;
                  barcodeState = state;
                  return Stack(
                    children: <Widget>[
                      _buildQrView(context),
                      Positioned.fill(
                        top: 5,
                        child: Container(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                icon: const Icon(Icons.flash_on_sharp),
                                color: AppColor.main,
                                onPressed: () async {
                                  await controller!.toggleFlash();
                                })),
                      ),
                      Positioned.fill(
                        top: 48,
                        child: Container(
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Text(
                              S.of(context).bar_mess,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      Positioned.fill(
                        // top: 300,
                          child: Container(
                              alignment: Alignment.bottomCenter,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 100),
                              width: 50,
                              height: 48,
                              child: OfitButton(
                                color: AppColor.main,
                                text: S.of(context).code_scan,
                                onPressed: () {
                                  controller!.resumeCamera();
                                  if (state.qrViewController != null) {
                                    state.qrViewController!.pauseCamera();
                                  }
                                },
                              ))),
                      /*Positioned.fill(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 40),
                          width: 50,
                          height: 48,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: AppColor.main,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                    side:
                                    const BorderSide(color: AppColor.main)),
                              ).copyWith(
                                elevation: MaterialStateProperty.resolveWith(
                                      (states) {
                                    return 0;
                                  },
                                ),
                              ),
                              onPressed: () async {
                              },
                              child: buildMyNavBar(context)),
                        ),
                      ),*/
                    ],
                  );
                })));
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 600 ||
        MediaQuery.of(context).size.height < 600)
        ? 250.0
        : 580.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: AppColor.main,
          borderRadius: 0,
          borderLength: 20,
          borderWidth: 4,
          cutOutSize: scanArea,
          cutOutBottomOffset: cutOutBottomOffsetQr),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      print("HoangCV: scanData.format: ${scanData.format} : ${scanData.format != BarcodeFormat.qrcode}");
      if ( scanData.format != BarcodeFormat.qrcode){
        if (scanData.format == BarcodeFormat.qrcode) {
          DiaLogManager.displayDialog(
              context, "",scanData.format == BarcodeFormat.qrcode? S.of(context).qrcode:S.of(context).barcode_error, () {},
                  () async {
                controller.resumeCamera();
                Get.back();
              }, S.of(context).close_dialog, "");
        }
        else{
          setState(() {
            barCodeError= scanData.code.toString();
          });
          Logger.loggerDebug(
              "HoangCV: scanData=============: ${scanData.code.toString()} ");
          /*"HH-0000000029"*/
          controller.pauseCamera();
          DiaLogManager.displayDialog(
              context, "",scanData.format == BarcodeFormat.qrcode? S.of(context).qrcode_error:S.of(context).barcode_error, () {},
                  () async {
                controller.resumeCamera();
                Get.back();
              }, S.of(context).close_dialog, "");
         /* contextState.read<BarcodeBloc>().add(GetItemBarcodeEvent(
              scanData.code.toString(),
              qrViewController: controller));*/
        }

      }else{
        print("Hoangcv: qrcode: ${scanData.code} : ${scanData.rawBytes}");
        Utils.launchInBrowser(scanData.code??"");
        controller.resumeCamera();
/*        DiaLogManager.displayDialog(
            context, "",scanData.format == BarcodeFormat.qrcode? S.of(context).qrcode:S.of(context).qrcode_error, () {},
                () async {
              controller.resumeCamera();
              Get.back();
            }, S.of(context).close_dialog, "");*/
        // setState(() {
        //   textError =
        //   "${S.of(context).you_scanning}${scanData.format == BarcodeFormat.qrcode ? S.of(context).qrcode
        //       : S.of(context).barcode}${S.of(context).not}${widget.scanType.name}${S.of(context).please_re}";
        // });
        return;
      }
    });
    controller.resumeCamera();
  }

  Widget addOrRemoveCart(BuildContext context, String content, Color color,
      VoidCallback callback, Color background) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: callback,
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColor.main, width: 1)),
          child: Center(
              child: Text(
                content,
                style: StyleOfit.textStyleFW500(color, 16),
              )),
        ));
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    Logger.loggerDebug(
        '${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).no_permission)),
      );
    }
  }
}
