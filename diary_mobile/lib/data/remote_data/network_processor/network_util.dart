/*
import 'dart:convert';

import '../object_model/object_command_data.dart';
import '../object_model/object_result.dart';

class NetworkUtils{
  static const String partnerGUID = "2dc95d1d-d1ea-42cb-9bc0-8943513009cf";
  static const String partnerToken =
      "ImbBXz79s+Ym5dPYD0HjC+mo8YUCdbYP+7CWG0zNOMI=:+APOtUGI/f2ISN1rgOvCJA==";

  */
/**
   * Url: Tham chiếu mục 1.2
      Action: POST
      Header: Content-Type: “application/json”
      Header:
      Method: POST
      Content-Type: “application/json”
      Body:
      {
      "PartnerGUID": "14d657f0-415c-426c-aaf1-ca6e3926cc8f",
      "EncryptedCommandData": "Object CommanđData được mã hoá và encode base 64 thành string"
      }

      PartnerGUID:
      Type: UUID
      Required: true
      GUID định danh riêng. Bkav cung cấp mỗi Partner một PartnerGUID riêng.

      EncryptedCommandData:
      Type: String
      Required: true
      Là object CommandData (json, xml) được convert sang string, sau đó Zip lại rồi mã hóa bằng PartnerToken

   *********************
      Cấu trúc API Response:
      {
      "d": "Chuỗi Result đã được nén, mã hoá và decode base 64",
      }

   *********************
      GUID và token con beta: GUID: 5d9f009e-6fa3-4770-bccc-1bab214c2744
      TOKEN: 0GtLANQWQ48xdnf+coGFeazeoFpo7fmzif79Siv9dcY=:8seRRdSTMslv1CnKBaurPg==
   *//*


  /// tao body
  static Map<String, dynamic> createBody(String partnerGuid,
      {required String token,
        required String oGuid,
*/
/*        required int cmdType,*//*

        required dynamic cmdObject}) {
    String encryptedData = encryptedCommandData(
        token: token, oGuid: oGuid, */
/*cmdType: cmdType,*//*
 cmdObject: cmdObject);
    // print("encryptedData $encryptedData  ok = ${utf8.decode(base64Decode(encryptedData))}");
    return {"PartnerGUID": partnerGuid, "EncryptedCommandData": encryptedData};
  }

  /// Ham dung xu ly du lieu va day len server voi dinh nghia api [cmdType] va data truyen vao [cmdObject]
  static String encryptedCommandData(
      {required String token,
        required String oGuid,
*/
/*        required int cmdType,*//*

        dynamic cmdObject}) {
    try {
      // Tao doi tuong commandData
      ObjectCommandData objectCommandData = ObjectCommandData(
          accessToken: token,
          //commandType: cmdType,
          orgGUID: oGuid,
          commandObject: cmdObject);
      // chuyen doi tuong commandData -> string json
      String jsonString = jsonEncode(objectCommandData.toJson());
      //encode base64
      List<int> bytes = utf8.encode(jsonString);
      return base64Encode(bytes);
    } catch (e) {
      return "Lỗi khi mã hoá dữ liệu :  ${e.toString()}";
    }
  }

  /// Ham gia ma du lieu tu server
  static ObjectResult decryptedResult(dynamic data) {
    // print(" data = $data");
    try {
      String result = data["d"];
      // Decode base 64 thu duoc mang byte
      return ObjectResult.fromJson(json.decode(utf8.decode(base64Decode(result))));
    } catch (e) {
      return ObjectResult(1, "Có lỗi xảy ra khi giải mã dữ liệu : ${e.toString()}", "", "", false, true);
    }
  }
}
*/
