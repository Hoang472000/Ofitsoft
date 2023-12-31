import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../view/login/login_page.dart';
import '../../../view_model/navigation_service.dart';
import '../../logger.dart';
import '../../utils.dart';
import '../dashed_circle.dart';
///Class chứa các dialog dùng chung cho app
class DiaLogManager {
  static Future<void> displayDialog(
      BuildContext context,
      String title,
      String content,
      VoidCallback onTap,
      VoidCallback cancelCallback,
      String cancel,
      String access,
      {bool dialogComplete = false,
        bool isHaveIcon = false,
        bool? contentHtml,
        Widget? widgetContent, bool dismissible = true}) async {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    Get.dialog(barrierDismissible: dismissible,AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      contentPadding: const EdgeInsets.all(0),
      content: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
/*            isHaveIcon
                ? Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 24),
              child: dialogComplete
                  ? SvgPicture.asset(
                IconAsset.icLogoBkav,
                width: 48,
                height: 48,
              )
                  : SvgPicture.asset(
                IconAsset.icLogoBkav,
                width: 48,
                height: 48,
              ),
            )
                : Container(),*/
            title == ""
                ? const SizedBox(
              height: 16,
            )
                : Padding(
              padding: const EdgeInsets.only(
                  bottom: 2, right: 15, left: 15, top: 23),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: StyleOfit.textStyleBlack16NotOverflow(),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 16, right: 15, left: 15),
                child: contentHtml == true
                    ? widgetContent
                    : Text(
                  content,
                  textAlign: TextAlign.center,
                  style: StyleOfit.textStyleBlack14NotOverflow(),
                )),
            const Divider(
              color: AppColor.gray300,
              height: 1.0,
            ),
            InkWell(
              child: Row(
                children: [
                  cancel != ""
                      ? Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        cancelCallback();
                      },
                      child: SizedBox(
                          height: 52,
                          child: Center(
                              child: Text(cancel,
                                  textAlign: TextAlign.center,
                                  style: StyleOfit.textStyleFW700(
                                      AppColor.gray500, 15)))),
                    ),
                  )
                      : Container(),
                  access != ""
                      ? Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: onTap,
                      child: SizedBox(
                          height: 52,
                          child: Center(
                              child: Text(access,
                                  textAlign: TextAlign.center,
                                  style: StyleOfit.textStyleFW700(
                                      AppColor.main, 14,
                                      fontWeight: FontWeight.w600)))),
                    ),
                  )
                      : Container(),
                ],
              ),
            ),
          ],
        ),

      )
      ),
    );
  }

  //HoangCV: show dialog error khi cos loi http code
  static void showDialogHTTPError(
      {required int status,
        required int resultStatus,
        required String resultObject}) {
    // Logger.loggerDebug(" showDialogError "
    //     "1 - ${NavigationService.navigatorKey.currentContext}  - ok $status resultStatus $resultStatus resultObject $resultObject ");
    // Logger.loggerDebug(" status $status, object: $resultObject ");
    displayDialog(
        NavigationService.navigatorKey.currentContext!, "", resultObject, () {},
            () async {
          Get.back();
          if(status == 401 && resultStatus ==100){
            Navigator.of(NavigationService.navigatorKey.currentContext!).pushAndRemoveUntil<void>(
                await LoginPage.route(), (route) => false);
          }
        }, S.of(NavigationService.navigatorKey.currentContext!).close_dialog, "");
    return;
  }

  ///HoangCV: show dialog "tinh nang dang phat trien"
  static void showDialogDevelopingFeature() {
    // Logger.loggerDebug(" showDialogError "
    //     "1 - ${NavigationService.navigatorKey.currentContext}  - ok $status resultStatus $resultStatus resultObject $resultObject ");
    // Logger.loggerDebug("Loi khi thuc hien mang status $resultStatus, object: $resultObject ");
    displayDialog(
        NavigationService.navigatorKey.currentContext!,
        "",
        S.of(NavigationService.navigatorKey.currentContext!).feature_mess,
            () {}, () {
      Get.back();
    }, S.of(NavigationService.navigatorKey.currentContext!).close_dialog, "");
    return;
  }

  ///HoangCV: show dialog "Nhap thong tin thanh cong"
  static void showDialogSuccess(
      BuildContext context, String title, VoidCallback acceptCallback, {bool dismissible = true }) {
    Html html = Html(
      data: """<html>
<head>
<title>Fotmat_font</title>
</head>
<body>
<p><font color="black" size="10">Mã</font> <font color="#F15B25" size="10"> 12345678 </font> <font color="black" size="10"> đã được kích hoạt, bạn được thưởng </font> <font color="#F15B25" size="10">2</font><font color="black" size="10"> điểm</font></p>
</body>
</html>""",
      style: {
        'html': Style(textAlign: TextAlign.center),
      },
    );

    //HoangCV TODO:
    DiaLogManager.displayDialog(
      context,
      "",
      title,
      acceptCallback,
      () {},
      "",
      "OK", /*contentHtml: html*/
      dismissible: dismissible
    );
  }

  ///HoangCV: show dialog "Nhap thong tin thanh cong"
  static void showDialogSendInformationSuccess(BuildContext context,
      String title, String dataHtml, VoidCallback acceptCallback) {
    Logger.loggerDebug("HoangCV show dialog Datahtml: $dataHtml");
    Html html = createHtml(dataHtml, Colors.black);

    DiaLogManager.displayDialog(
        context, title, "", acceptCallback, () {}, "", "OK",
        widgetContent: html, contentHtml: true);
  }

  static void showDialogLoading(BuildContext context) {
    if (Get.isDialogOpen == true) {
      return;
    }
    Get.dialog(Container(
      color: Colors.transparent,
      alignment: Alignment.center,
      child: const SizedBox(
        height: 40,
        width: 40,
        child: DashedCircle(
            size: 39, stringIcon: IconAsset.icLoadOtp),
      ),
    ));
  }

  static void showDialogAddProductNew(BuildContext context,
      String title, String dataHtml, VoidCallback acceptCallback) {
    Html html = createHtml(dataHtml, Colors.black);

    DiaLogManager.displayDialog(
        context, title, "", acceptCallback, () {}, "", "OK",
        widgetContent: html, contentHtml: true);
  }

  static Html createHtml(String dataHtml, Color color){
    return Html(data: dataHtml, style: {
      "body": Style(
          textAlign: TextAlign.center,
/*          padding:  EdgeInsets.only(top: 14),*/
          fontSize: FontSize(16),
          color: color,
          fontWeight: FontWeight.w400)
    });
  }

  static TextSpan transformWord(String word, String refNo) {
    List<String> name = word.split(' ');
    List<TextSpan> listTextSpan = [];
    for (int i = 0; i < name.length; i++) {
      if (name[i]=="@p") {
        Logger.loggerDebug("transformWord: $refNo");
        listTextSpan.add(TextSpan(
            text: "$refNo ",
            style: StyleOfit.textStyleFW700(AppColor.blueE8, 14,
                overflow: TextOverflow.visible)));
      } else {
        listTextSpan.add(TextSpan(
            text: "${name[i]} ",
            style: StyleOfit.textStyleFW400(Colors.black, 14,
                overflow: TextOverflow.visible)));
      }
    }
    return TextSpan(children: listTextSpan);
  }
}
