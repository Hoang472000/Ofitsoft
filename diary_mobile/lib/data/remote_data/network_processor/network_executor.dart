import 'dart:convert';
import 'dart:io';

import 'package:diary_mobile/data/entity/activity/activity_diary_no_network.dart';
import 'package:diary_mobile/data/entity/activity/no_network/activity_purchase_no_network.dart';
import 'package:diary_mobile/data/entity/activity/no_network/activity_transaction_no_network.dart';
import 'package:diary_mobile/data/entity/report/question_upload.dart';
import 'package:diary_mobile/utils/constants/status_const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants/api_parameter_const.dart';
import '../../../utils/constants/shared_preferences_key.dart';
import '../../../utils/logger.dart';
import '../../local_data/diary_db.dart';
import '../api_model/api_base_generator.dart';
import '../object_model/object_command_data.dart';
import '../object_model/object_result.dart';
import 'network_check_connect.dart';
import 'network_util.dart';

///create request api
class NetworkExecutor{
  BuildContext context;
  NetworkExecutor({required this.context});
  static const String partnerGUID = "2dc95d1d-d1ea-42cb-9bc0-8943513009cf";
  static const String partnerToken =
      "ImbBXz79s+Ym5dPYD0HjC+mo8YUCdbYP+7CWG0zNOMI=:+APOtUGI/f2ISN1rgOvCJA==";
  static const String tokenExpires="AIB12001";

  ///neu la login thi isLogin= true
  ///nguoc lai mac dinh la false
  Future<ObjectResult> request({required ApiBaseGenerator route,
    bool? tokenRefreshing= false, bool isHandlerError= true, bool isLogin= false, bool loop = false}) async {
    ObjectResult? objectResult;
    try {
      if (await NetworkCheckConnect.status) {
        if(!loop) {
          print("HoangCV: loop loop ");
          List<ActDiaryNoNetwork> list = await DiaryDB.instance
              .getListActDiaryNoNetWork();
          for (var element in list) {
            ObjectResult objectResult = await request(
                loop: true,
                route: ApiBaseGenerator(
                    path: element.api ?? '',
                    body: ObjectData(
                        token: route.body.token, params: element.toJson())));
              await DiaryDB.instance.removeActDiaryNoNetWork(element.id ?? -1);
          }
          List<QuestionUpload> listQsUl = await DiaryDB.instance
              .getListQuestionUploadNoNetWork();
          await DiaryDB.instance.removeQuestionUploadNoNetWork();
          for (var element in listQsUl) {
            ObjectResult objectResult = await request(
                loop: true,
                route: ApiBaseGenerator(
                    path: element.api ?? '',
                    body: ObjectData(
                        token: route.body.token, params: element.toJson())));
            //if (objectResult.responseCode == StatusConst.code00 && objectResult.responseCode == StatusConst.code01) {
            //  print("HoangCV: loop remove QuestionUpload: $objectResult ");
            //}
          }
          List<FarmerInspectorUpload> listFaIn = await DiaryDB.instance
              .getListFarmerInspectorUploadNoNetWork();
          for (var element in listFaIn) {
            ObjectResult objectResult = await request(
                loop: true,
                route: ApiBaseGenerator(
                    path: element.api ?? '',
                    body: ObjectData(
                        token: route.body.token, params: element.toJson())));
            //if (objectResult.responseCode == StatusConst.code00 && objectResult.responseCode == StatusConst.code01) {
              print("HoangCV: loop remove FarmerInspectorUpload: $objectResult ");
              await DiaryDB.instance.removeFarmerInspectorUploadNoNetWork(element.idOffline ?? "");
            //}
          }

          List<ActivityPurchaseNoNetWork> listPurchase = await DiaryDB.instance
              .getListActivityPurchaseNoNetwork();
          for (var element in listPurchase) {
            ObjectResult objectResult = await request(
                loop: true,
                route: ApiBaseGenerator(
                    path: element.api ?? '',
                    body: ObjectData(
                        token: route.body.token, params: element.toJson())));
            print("HoangCV: loop remove ActivityPurchaseNoNetWork: $objectResult ");
            await DiaryDB.instance.removeActivityPurchaseNoNetWork(element.id ?? -1);
          }

          List<ActivityTransactionNoNetwork> listTransaction = await DiaryDB.instance
              .getListActivityTransactionNoNetwork();
          for (var element in listTransaction) {
            ObjectResult objectResult = await request(
                loop: true,
                route: ApiBaseGenerator(
                    path: element.api ?? '',
                    body: ObjectData(
                        token: route.body.token, params: element.toJson())));
            print("HoangCV: loop remove ActivityTransactionNoNetwork: $objectResult ");
            await DiaryDB.instance.removeActivityTransactionNoNetWork(element.id ?? -1);
          }
        }
        var client = Dio();
        client.interceptors.add(InterceptorsWrapper(
            onError: (error, handler) async {
              final prefspre = await SharedPreferences.getInstance();
/*              Logger.loggerDebug(
                  "call api ${route.body.commandType} error ${error.response
                      ?.statusCode} isRemember ${prefspre
                      .getBool(SharedPreferencesKey.isRemember)}");*/
              bool isRemember =
                  prefspre.getBool(SharedPreferencesKey.isRemember) ?? false;
              String refreshToken =
                  prefspre.getString(SharedPreferencesKey.refreshToken) ?? "";
/*              Logger.loggerDebug(
                  "call api ${route.body.commandType} error ${error.response?.statusCode} isRemember $isRemember");*/
          // duy tri dang nhap, khong hoat dong do server dang tra ve status code = 200 khi token het han
              print("HoangCV: ${route.path} bug: ${error.toString()} : ${error.message}  : ${error.response} ");
          if (error.response != null) {
            if (/*NetworkUtils.decryptedResult(*/error.response!.data ==
                StatusConst.code03) {
              var options = error.response!.requestOptions;
              ObjectResult response = await request(
                  route: ApiBaseGenerator(
                      body: ObjectData(params: {
                ApiParameterConst.refreshToken: refreshToken
              }/*, commandType: ApiConst.refreshAccessToken*/)));

              prefspre.setString(SharedPreferencesKey.accessToken,
                  response.response['AccessToken']);
              prefspre.setString(SharedPreferencesKey.refreshToken,
                  response.response['RefreshToken']);
              client.fetch(options).then(
                (r) => handler.resolve(r),
                onError: (e) {
                  handler.reject(e);
                },
              );
              return;
            }
          }

          return handler.next(error);
        }));

        bool reFetchApi = false; // xac dinh xem co phai refresh api neu token het han k
        // do ben sever dang tra ve 200 neu apihet
        do{
          reFetchApi = false;
          String token= "";
          String orgGuid= "";
          //print("HoangCV123: ${route.path} bug: ${route.body.token} ");
          // if(!isLogin){
          //   SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
          //   token= sharedPreferences.getString(SharedPreferencesKey.accessToken)?? "";
          //   orgGuid= sharedPreferences.getString(SharedPreferencesKey.orgGuid)?? "";
          //   //route.body.token = token;
          //   print("HoangCV123: ${token} bug: ${route.body} bug: ${token}");
          //   if(token.isEmpty || route.body.token.isEmpty){
          //     //route.body.token = token;
          //     print("HoangCV123111: ${    route.body.token} bug: ${route.body} bug: ${token}");
          //     return ObjectResult(1, "Lần đầu đăng nhập", "", "",false , true);
          //   }
          // }
          print("HoangCV1234: ${route.path} bug:/* ${route.body.toJson()}*/ bug: ${route.header}");
          print("HoangCV1235: ${route.baseUrl} bug: ${route.method} bug: ${route.queryParameters}");
          Response response = await client.fetch(RequestOptions(
              headers: route.header,
              baseUrl: route.baseUrl,
              method: route.method,
              path: route.path,
              queryParameters: route.queryParameters,
              data: route.body.toJson(),
              sendTimeout: const Duration(seconds: 180),
              receiveTimeout: const Duration(seconds: 180),
              validateStatus: (statusCode) =>
              (statusCode! >= HttpStatus.ok &&
                  statusCode <= HttpStatus.multipleChoices)));
          print("HoangCV: result: ${response.data}");
         // print("HoangCV: result: ${response.data['result']}");
       /*   Map<String, dynamic> jsonMap = json.decode(response.data);
          Map<String, dynamic> result = jsonMap['result'];*/
          try {
            objectResult = ObjectResult.fromJson(response.data['result']);
            if(objectResult.responseCode == StatusConst.code03){
              objectResult =  ObjectResult(1, "Error System" , "Quá hạn đăng nhập!\nVui lòng đăng nhập lại.", "03",false , true);
            }
          } catch(_){
            objectResult= ObjectResult(1, "Error System" , "Lỗi hệ thống!\n Vui lòng thử lại sau.", "01",false , true);
          }
          // Đoạn này là đoạn refresh token nếu token hết hạn
          /*if (objectResult.responseCode == StatusConst.code03) {
            reFetchApi = true; // neu token het han thi re fetch lai api
            final pref = await SharedPreferences.getInstance();
            String refreshToken =
                pref.getString(SharedPreferencesKey.refreshToken) ?? "";

            ObjectResult response = await request(
                route: ApiBaseGenerator(
                    body: ObjectData(params: {
                      ApiParameterConst.refreshToken: refreshToken
                    }, *//*commandType: ApiConst.refreshAccessToken*//*)));
            // debugPrint(
            //     "HoangCV:-- is ok--------------------- ${response.toString()} , == $refreshToken");

            if (response.response['AccessToken'] != null) {
              pref.setString(SharedPreferencesKey.accessToken,
                  response.response['AccessToken']);
            }
            if (response.response['RefreshToken'] != null) {
              pref.setString(SharedPreferencesKey.refreshToken,
                  response.response['RefreshToken']);
            }
          }*/
        } while(reFetchApi);

        // debugPrint("HoangCV: isOK = =================== ${objectResult.toString()}");
        return objectResult;
      } else {
        ///khong co mang
        objectResult= ObjectResult(1, "Lost Internet connection" , "Không có kết nối mạng!\n Vui lòng kiểm tra lại kết nối mạng.", "06",false , true);
      }
    }on DioException catch(dioError){
        /// loi timeout
      print("HoangCV: bug dioError.type: ${dioError.type} : message: ${dioError.message} : dioError: ${dioError}");
        if(dioError.type== DioExceptionType.connectionTimeout||
        dioError.type== DioExceptionType.sendTimeout||
        dioError.type== DioExceptionType.receiveTimeout){
          objectResult= ObjectResult(1, "Connection timed out", "Kết nối bị gián đoạn! \n Vui lòng thử lại sau.", "07",false, true);
        }else {
          if (dioError.type == DioExceptionType.badResponse) {
            ///may chu phan hoi nhung co trang thai khong chinh xac (404,503...)
/*            Logger.loggerDebug(
                "call api ${route.body.commandType} request DioError response: ${dioError.response}");*/
          } else if (dioError.type == DioExceptionType.cancel) {
/*            Logger.loggerDebug("call api ${route.body.commandType} request DioError cancel");*/
          } else {
/*            Logger.loggerDebug("call api ${route.body.commandType} request DioError other: ${dioError.error?? ""}");*/
          }
          objectResult= ObjectResult(1, "Unknown error", "Hệ thống đang bảo trì!\nVui lòng thử lại sau.", "08", false, true);
        }
    }
    handlerError(objectResult, isHandlerError);
    return objectResult;
  }

  static void handlerError(ObjectResult? objectResult, bool? isHandlererror){
    if(objectResult!= null && objectResult.status==1){
      if(objectResult.responseCode== tokenExpires){
        ///logout

      }else if(isHandlererror== true){
        ///show dialog error
        String error= objectResult.response;

      }
    }
  }
}