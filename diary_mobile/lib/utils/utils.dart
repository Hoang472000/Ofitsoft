import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/entity/image/image_entity.dart';
import '../generated/l10n.dart';
import '../resource/color.dart';
import '../resource/style.dart';
import '../view_model/navigation_service.dart';
import 'constants/shared_preferences_key.dart';
import 'logger.dart';

class Utils {

  ///Bkav TungDV check check man hinh ngang doc de fix loi tai tho tren ios
  static Widget bkavCheckOrientation(BuildContext context, Widget child) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? Container(child: child)
        : SafeArea(
            top: false,
            child: child,
          );
  }

  ///Bkav HoangLD : hiệu ứng chuyển giữa các page khác nhau
  static Route pageRouteBuilder(Widget widget, bool transitions) {
    if (transitions) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1, 0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    } else {
      return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => widget);
    }
  }
  static Future<String> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId =
        sharedPreferences.getString(SharedPreferencesKey.userId) ?? "";
    return userId;
  }
  static Future<void> onImageSave(String url) async {
    if(url.isEmpty){
      return;
    }
    bool checkInternet = await checkInternetConnection();
    if(!checkInternet)
    {
      return;
    }
    var response = await http.get(Uri.parse(parseImageUrl(url)));
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = "${documentDirectory.path}/images";
    var filePathAndName = '${documentDirectory.path}/images/cacheImage.jpg';
    await Directory(firstPath).create(recursive: true);
    File file2 = File(filePathAndName);
    file2.writeAsBytesSync(response.bodyBytes);
    Logger.loggerDebug("Bkav HoangCV:onImageSave: $filePathAndName ");
    SharedPreferences sharePreferences= await SharedPreferences.getInstance();
    sharePreferences.setString(SharedPreferencesKey.imageSelected, filePathAndName);
  }
  static bool checkPathImageLocal(String path) {
    return path.contains("/Avartar/cacheImage.png");
  }
  static Future<bool> statusFaceID({String? key}) async {
    final prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString(SharedPreferencesKey.userName) ?? "-1";
    String faceIDSettingSharePref =
        prefs.getString((key ?? userName).toLowerCase()) ??
            jsonEncode(SettingSharePref.toJson(false, false));
    return SettingSharePref.fromJson(jsonDecode(faceIDSettingSharePref))
        .isFaceId;
  }
  static Future<bool> statusFingerprint({String? key}) async {
    final prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString(SharedPreferencesKey.userName) ?? "-1";
    String fingerprintSettingSharePref =
        prefs.getString((key ?? userName).toLowerCase()) ??
            jsonEncode(SettingSharePref.toJson(false, false));
    // debugPrint("statusFingerprint  $userName -- $fingerprintSettingSharePref");
    return SettingSharePref.fromJson(jsonDecode(fingerprintSettingSharePref))
        .isFingerPrint;
  }

  //HoangLD tạo 1 channel để call native ios
  static const channelBkav = MethodChannel('com.bkav.aibook/bkav_channel');
  static Future<bool> checkBiometricsFaceIdIos() async{
    bool faceId = false;
    if (Platform.isIOS) {
      String checkIos = await channelBkav.invokeMethod('getBiometricType');
      if(checkIos == "faceID"){
        faceId = true;
      }else{
        faceId = false;
      }
    }
    return faceId;
  }
  static String convertTime(String time) {
    final timeTemp = time.split('T');
    return timeTemp[0].split('-').reversed.join('-');
  }

  static String convertTimeDay(String time) {
    final timeTemp = time.split('T');
    final timeTemp2 = timeTemp[1].split('.');
    return timeTemp2[0] + " | " + timeTemp[0].split('-').reversed.join('-');
  }

  //Bkav Nhungltk: check dieu kien mang
  static Future<bool> checkInternetConnection() async {
    return await FlutterNetworkConnectivity().isInternetConnectionAvailable();
  }

  static void dismissDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
//CachedNetworkImage(imageUrl: urlImage)
  static String parseImageUrl(String urlImage) {

    return Uri.parse("https://wsdemo.aibooks.vn//Avartar/14562ae1-c998-4166-ae62-21081105cdf0.png").toString();
  }

  static String formatTime(String time) {
    if (time.isNotEmpty) {
      final dateTime = DateTime.parse(time);
      return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    } else {
      return "";
    }
  }

  static String formatDate(String time) {
    if (time.isNotEmpty) {
      DateTime dateTime = DateTime.parse(time.replaceFirst(' ', 'T'));
      final f = DateFormat('dd/MM/yyyy');
      return f.format(dateTime);
    } else {
      return "";
    }
  }

  static String formatDateToString(DateTime time) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
      return formatter.format(time);
  }

  static String formatDateToStringYMD(DateTime time) {
    DateFormat formatter = DateFormat.yMd('dd/MM/yyyy');
    return formatter.format(time);
  }

  static DateTime formatStringToDate(String time) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    DateTime dateTime = DateTime.parse(time.replaceFirst(' ', 'T'));
/*    DateTime dateTime = formatter.parse(time);
    DateTime dateTime1 = DateTime.parse(dateTime.toString());*/
    return dateTime.toUtc();
  }

  static Future<void> launchInBrowser(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
  //DatNVh open GoogleMap
  static Future<void> launchMapUrl(String address) async {
    String encodedAddress = Uri.encodeComponent(address);
    String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$encodedAddress";
    String appleMapUrl = "http://maps.apple.com/?q=$encodedAddress";
    if (Platform.isAndroid) {
      try {
        if (await canLaunch(googleMapUrl)) {
          await launch(googleMapUrl);
        }
      } catch (error) {
        throw("Cannot launch Google map");
      }
    }
    if (Platform.isIOS) {
      try {
        if (await canLaunch(appleMapUrl)) {
          await launch(appleMapUrl);
        }
      } catch (error) {
        throw("Cannot launch Apple map");
      }
    }
  }

  //DatNVh open phoneCall
  static Future<void> launchPhoneUrl(String phone) async {
    final Uri launchUri=Uri(
        scheme: 'tel',
        path: phone
    );
    if(await canLaunch(launchUri.toString())){
      await launch(launchUri.toString());
    }else{
      throw("the action is not supported.");
    }
  }

  //DatNVh open email
  static Future<void> launchMailUrl(String email) async {
    String? encodeQueryParameters(Map<String,String> params){
      return params.entries
          .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }
    final Uri emailUrl=Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String,String>{
        'subject':"Content",
        'body':"Content"
      }),
    );
    if(await canLaunch(emailUrl.toString())){
      launch(emailUrl.toString());
    }else{
      throw("the action is not supported.");
    }
  }

  //DatNVh open browser
  static Future<void> launchBrowserUrl(String url) async {
    if(Platform.isAndroid){
      if(await canLaunch(url)){
        await launch(url,forceWebView: false);
      }
      else{
        throw("the action is not supported.");
      }
    }
    if(Platform.isIOS){
      if(await canLaunch(url)){
        await launch(url,forceSafariVC: false);
      }
      else{
        throw("the action is not supported.");
      }
    }
  }
  ///Bkav Nhungltk: cap nhat avatar
  static formatText(data) {
    var str = data;
    str = str.replaceAll(RegExp(r"(\à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)"), 'a');
    str = str.replaceAll(RegExp(r"(\À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ)"), 'A');
    str = str.replaceAll(RegExp(r"(\è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ)"), 'e');
    str = str.replaceAll(RegExp(r"(\ì|í|ị|ỉ|ĩ)"), 'i');
    str = str.replaceAll(RegExp(r"(\ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)"), 'o');
    str = str.replaceAll(RegExp(r"(\ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)"), 'u');
    str = str.replaceAll(RegExp(r"(\ỳ|ý|ỵ|ỷ|ỹ)"), 'y');
    str = str.replaceAll(RegExp(r"(\đ)"), 'd');
    str = str.replaceAll(RegExp(r"(\È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ)"), 'E');
    str = str.replaceAll(RegExp(r"(\Ì|Í|Ị|Ỉ|Ĩ)"), 'I');
    str = str.replaceAll(RegExp(r"(\Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ)"), 'O');
    str = str.replaceAll(RegExp(r"(\Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ)"), 'U');
    str = str.replaceAll(RegExp(r"(\Ỳ|Ý|Ỵ|Ỷ|Ỹ)"), 'Y');
    str = str.replaceAll(RegExp(r"(\Đ)"), 'D');
    return str;
  }

  static String formatCurrencyTonNumberString(String text) {
    return text.replaceAll(RegExp(r'\D'), '');
  }

  static formatDecimalCurrency(String valueStr, bool isAllowZero) {
    String val = valueStr;
    String firstVal;
    String secordVal;
    if (val.toString().indexOf('.') > 0) {
      firstVal =
          valueStr.substring(0, val.indexOf('.')).replaceAll('/\D/g', '');
      print(val.indexOf('.'));
      secordVal =
          val.substring(val.indexOf('.'), val.length).replaceAll('/\D/g', '');
      if (secordVal.length > 2) {
        secordVal = secordVal.substring(0, 4);
      }
      if (isAllowZero && secordVal.length == 2 && secordVal.contains('0')) {
        secordVal = '';
      }
      val = formatCurrency(firstVal) + secordVal;
    } else {
      val = formatCurrency(valueStr.toString().replaceAll('/\D/g', ''));
    }
    return val;
  }
  static String formatDateTextField(String text) {
    var value = text.replaceAll('/', ''); // Xóa các ký tự không phải số
    if (value.length == 0) return ''; // Nếu chuỗi rỗng thì trả về ''

    if (value.length <= 2) {
      // Định dạng ngày
      return value;
    } else if (value.length <= 4) {
      // Định dạng ngày/tháng
      var day = value.substring(0, 2);
      var month = value.substring(2);
      return '$day/$month';
    } else {
      // Định dạng ngày/tháng/năm
      var day = value.substring(0, 2);
      var month = value.substring(2, 4);
      var year = value.substring(4);
      return '$day/$month/$year';
    }
  }

  static Icon iconCustom({
    IconData? icon,
    context,
    Color? color,
    double? size,
  }) {
    return Icon(icon!, /*fontFamily: fontIconApp*/
        size: size ?? 16, color: color ?? Theme.of(context).primaryColor);
  }

  static String formatCurrency(String text) {
    if (text.length > 2) {
      var value = text;
      value = value.replaceAll(RegExp(r'\D'), '');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
      return value;
    }
    return text.replaceAll(
        RegExp(r'\D'), ''); // nhập không phải là số thì xóa hết
  }

  static String convertNumber(double number){
    var formatter = NumberFormat('#,###,###');
    var result = formatter.format(number);
    return result.replaceAll(",", ".");
  }

  static double convertStringToDouble(String number){
    if(number.isEmpty){
      return double.parse("0");
    }else {
      return double.parse(number.replaceAll(",", ""));
    }
  }
  static  List<String> listCompany = ["",'Công ty', 'Hộ gia đình/Cá nhân'];
  static List<String> itemFinancialYear = ["",'Từ 01/01 đến 31/12', 'Từ 01/04 đến 31/03 năm sau','Từ 01/10 đến 30/09 năm sau','Từ 01/07 đến 30/6 năm sau'];
  static List<String> itemDateFormat = ["",'dd/mm/yyyy', 'mm/dd/yyyy','dd-mm-yyyy','mm-dd-yyyy','yyyy-mm-dd'];
  static List<String> itemNumberFormatType=["",'Kiểu 1 (1.000.000,00)','Kiểu 2 (1.000,000.00)'];
  static List<String> itemDiscountRate = ["","Thuế suất Tổng", "Thuế suất chi tiết"];
  static List<String> itemDiscountType = ["","Chiết khấu Tổng", "Chiết khấu chi tiết"];
  static List<String> itemIsDiscountBeforeTax = ["","Chiết khấu trước thuế", "Chiết khấu sau thuế"];
  static List<String> itemIsSingleWarehouseManage = ["","Quản lý 1 Kho", "Quản lý nhiều Kho"];
  static List<String> itemTaxCircularsCompany = ["","133/2016/TT-BTC", "200/2014/TT-BTC"];
  static List<String> itemTaxCirculars = ["","88/2021/TT-BTC"];
  static List<String> itemCostMethodID = ["","Phương pháp bình quân gia quyền","Phương pháp nhập trước – xuất trước","Phương pháp đích danh"];
  static List<String> itemTaxDecMethod=["",'Gián tiếp','Trực tiếp'];
  static List<String> itemTaxPeriod=["",'Tháng','Quý','Năm'];
  static List<String> itemCurrency = ["",'VND', 'USD','EUR'];
 static List<String> listDay = <String>[
    'Hôm nay',
    'Từ hôm qua',
    '3 ngày trước',
    '1 tuần trước',
    '1 tháng trước',
    'Khoảng thời gian',
  ];
  static List<String> listPayrolls = <String>[
    'Tất cả',
    '1 tháng trước',
    '1 quý trước',
    '1 năm trước',
    'Khoảng thời gian',
  ];
  static List<String> listPaymentDay = <String>[
    'Hôm nay',
    'Từ hôm qua',
    '3 ngày trước',
    '1 tuần trước',
    '1 tháng trước',
    'Khoảng thời gian',
  ];
  static List<String> listCustomer = <String>[
    'Tất cả',
    'Danh sách khách hàng',
  ];
  static List<String> listWarehouse = <String>[
    'Tất cả',
    'Danh sách kho',
  ];
  static List<String> listSupplier = <String>[
    'Tất cả',
    'Danh sách nhà cung cấp',
  ];
  static List<String> listStaff = <String>[
    'Tất cả',
    'Danh sách nhân viên',
  ];

 static Map<String, bool> listPaymentStatus = {
    'Chưa thanh toán': false,
    'Thanh toán 1 phần': false,
     'Đã thanh toán': false,
  };

  static Map<String, bool> listBillStatus = {
    'Đang sử dụng': false,
    'Không sử dụng': false,
  };

  ///Bkav Nhungltk: so luong item
  static String sumAmountSlip(int amountSunSlip, String item) {
    String sumAmuntSlip = item;
    List<String> list = sumAmuntSlip.split(" ");
    String s = "";
    for (String word in list) {
      if (word == "@") {
        word = "$amountSunSlip";
        s += "$word ";
      } else {
        s += "$word ";
      }
    }
    return s;
  }

 static TextSpan transformWord(String word, String textContain) {
   List<String> name = word.split(' ');
   List<TextSpan> listTextSpan = [];
   for (int i = 0; i < name.length; i++) {
     if (textContain.toLowerCase().contains(name[i].toLowerCase())) {
       listTextSpan.add(TextSpan(
           text: "${name[i]} ",
           style: StyleBkav.textStyleFW700(AppColor.main, 14,
               overflow: TextOverflow.visible)));
     } else {
       listTextSpan.add(TextSpan(
           text: "${name[i]} ",
           style: StyleBkav.textStyleFW400(Colors.black, 14,
               overflow: TextOverflow.visible)));
     }
   }
   return TextSpan(children: listTextSpan);
 }
  //Bkav ToanTDd
  static Color colorFromHex(String code) {
    var str = code.substring(1, 7);
    var bigint = int.parse(str, radix: 16);
    final r = (bigint >> 16) & 255;
    final g = (bigint >> 8) & 255;
    final b = bigint & 255;
    const a = 255;
    return Color.fromARGB(a, r, g, b);
  }
  static String getCurrentTime() {
    DateTime time = DateTime.now();
    final f = DateFormat('dd/MM/yyyy');
    return f.format(time).toString();
  }

  static DateTime formatMillisecondsToDateTime(int time) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    String date = formatter.format(dateTime);
    return DateFormat('dd/MM/yyyy').parse(date);
  }

  static DateTime formatStringToDateTime(String time) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    DateTime dateTime = formatter.parse(time);
    DateTime dateTime1 = DateTime.parse(dateTime.toString());
    return dateTime1;
  }
  static String formatDateTimeToString(DateTime dateTime) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    String formattedString = formatter.format(dateTime);
    return formattedString;
  }


  static String timeToText(DateTime dateTime) {
    String date = dateTime.day.toString().padLeft(2, '0');
    String month = dateTime.month.toString().padLeft(2, '0');
    String year = dateTime.year.toString();
    return '$date/$month/$year';
  }

  static TextSpan convertText(String title, String value, Color color,
      {bool isMoney = false, BuildContext? buildContext}) {
    return TextSpan(children: [
      TextSpan(
          text: title, style: StyleBkav.textStyleFW400(AppColor.gray57, 12)),
      TextSpan(text: value, style: StyleBkav.textStyleFW400(color, 12)),
      if (isMoney = true && buildContext != null)
        TextSpan(
            text: " ${S.of(buildContext!).vnd}",
            style: StyleBkav.textStyleFW400(AppColor.gray57, 12))
    ]);
  }

  // vung hien thi trang thai
  static Widget descriptionPaymentStatusWidget(int amount,int select,  BuildContext context,VoidCallback ontap,VoidCallback ontapAll,bool selectAll,
      {bool isShowAll = true}) {
    return Container(
      padding: const EdgeInsets.only(top: 26, bottom: 0),
      color: Colors.white,
      child: Container(
          margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: Column(
            children: [
              Visibility(
                visible: select<=0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Utils.sumAmountSlip(amount, S.of(context).sum_amount_slip)
                          .toUpperCase(),
                      style: StyleBkav.textStyleFW600(
                        AppColor.gray57,
                        14,
                      ),
                    ),
                    /*   Text(
                                                  "${state.listSalesSlip.totalIntoMoney ?? 0} ${S.of(context).vnd}",
                                                  style: const TextStyle(
                                                      color: AppColor.blueE8,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 14),
                                                )*/
                  ],
                ),
              ),
            ///DatNVh bo chon tat ca
            /*  Visibility(
                visible: select > 0 && !selectAll,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: ontapAll,
                          child: !selectAll? Icon(Icons.check_box_outline_blank,color: AppColor.main,size: 20):Icon(Icons.check_box_outlined,color: AppColor.main,size: 20)),
                      SizedBox(width: 10,),
                      Text(
                      "Chon tat ca phieu ".toUpperCase(),
                        style: StyleBkav.textStyleFW600(
                          AppColor.gray57,
                          14,
                        ),
                      ),
                      /*   Text(
                                                    "${state.listSalesSlip.totalIntoMoney ?? 0} ${S.of(context).vnd}",
                                                    style: const TextStyle(
                                                        color: AppColor.blueE8,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14),
                                                  )*/
                    ],
                  ),
                ),
              ),*/
              Visibility(
                visible: select > 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: ontap,
                        child: const Icon(Icons.check_box_outlined,color: AppColor.main,size: 20)),
                    const SizedBox(width: 10,),
                    Text(
                      Utils.sumAmountSlip(select, S.of(context).select_amount_slip)
                          .toUpperCase(),
                      style: StyleBkav.textStyleFW600(
                        AppColor.gray57,
                        14,
                      ),
                    ),
                    /*   Text(
                                                  "${state.listSalesSlip.totalIntoMoney ?? 0} ${S.of(context).vnd}",
                                                  style: const TextStyle(
                                                      color: AppColor.blueE8,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 14),
                                                )*/
                  ],
                ),
              ),
              Padding(
                padding:const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isShowAll
                        ? Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: AppColor.green00,
                                  radius: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    S.of(context).paid,
                                    style: StyleBkav.textStyleFW600(
                                      AppColor.gray57,
                                      14,
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CircleAvatar(
                            backgroundColor: AppColor.orangeF4,
                            radius: 10,
                          ),
                          Expanded(
                            child: Text(
                              S.of(context).unpaid,
                              style: StyleBkav.textStyleFW600(
                                AppColor.gray57,
                                14,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CircleAvatar(
                            backgroundColor: AppColor.yellowFF,
                            radius: 10,
                          ),
                          Expanded(
                            child: Text(
                              S.of(context).partial_payment,
                              style: StyleBkav.textStyleFW600(
                                AppColor.gray57,
                                14,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  static Future<String> getImage(
      BuildContext context, ImageSource imageSource) async {
    //Bkav HoangLD ImagePicker() ham nay phai chay tren may thuc ios moi lay duoc anh con hien tai tren may ao ios 14+ thi khong dung duoc
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    String pathImageSelect = "";
    if (pickedFile != null) {
      if (imageSource == ImageSource.gallery) {
        pathImageSelect = await cropImage(pickedFile.path);
      } else {
        Directory directory = await getApplicationDocumentsDirectory();
        final String path = directory.path;
        // Bkav HanhNTHe: Lưu ảnh vào rồi mới cắt
        final File newImage =
        await File(pickedFile.path).copy('$path/temp_avatar.png');
        pathImageSelect = await cropImage(newImage.path);
      }
    } else {
      const snackBar = SnackBar(
        content: Text("Error: No image Selected"),
        duration: Duration(milliseconds: 2000),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      /*  Get.snackbar("Error", "No image Selected",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);*/
    }
    return pathImageSelect;
  }

  static Future<List<ImageEntity>> getImagePicker(ImageSource imageSource, {bool multiSelect = true}) async {
    List<XFile> selectedImages = [];
    List<ImageEntity> listItemImage = [];
    final ImagePicker imagePicker = ImagePicker();
    if (imageSource == ImageSource.gallery && multiSelect) {
      selectedImages =
      await imagePicker.pickMultiImage(maxWidth: 512, maxHeight: 512);
    } else {
      XFile? xFile = await imagePicker.pickImage(
        source: imageSource,
        maxWidth: 512,
        maxHeight: 512,
      );
      if (xFile != null) {
        selectedImages.add(xFile);
      }
    }
    if (selectedImages.isNotEmpty) {
      for (var imageFile in selectedImages) {
        File image = File(imageFile.path);
        ImageEntity imageEntity = ImageEntity(
            fileImage: image,
            fileName: image.path.split('/').last.split('.').first,
            fileContent: base64Encode(image.readAsBytesSync().toList()),
            fileExtension: image.path.split('/').last.split('.').last);
        listItemImage.add(imageEntity);
      }
    }
    return listItemImage;
  }

  static Future<String> cropImage(String imagePath) async {
    String path = "";
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      cropStyle: CropStyle.rectangle,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
      ],
    );
    if (croppedFile != null) {
      path = croppedFile.path;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(SharedPreferencesKey.imageSelected, croppedFile.path);
      // compressFile(croppedFile.path);
      //update();
    }
    return path;
  }
}

/// Bkav HanhNTHe: remove scroll glow
class BkavBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
class SettingSharePref {
  bool isFingerPrint;
  bool isFaceId;

  SettingSharePref({required this.isFingerPrint, required this.isFaceId});

  factory SettingSharePref.fromJson(Map<String, dynamic> json) {
    return SettingSharePref(
        isFingerPrint: json[SharedPreferencesKey.statusFingerprint],
        isFaceId: json[SharedPreferencesKey.statusFaceID]);
  }

  static Map<String, dynamic> toJson(bool isFingerPrint, bool isFaceId) {
    return {
      SharedPreferencesKey.statusFingerprint: isFingerPrint,
      SharedPreferencesKey.statusFaceID: isFaceId
    };
  }
}
