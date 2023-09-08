import 'dart:convert';

import 'package:diary_mobile/utils/constants/shared_preferences_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreDiary{
  static Future<bool> getRole() async {
    bool checkFarmer = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? roleJson = sharedPreferences.getString(SharedPreferencesKey.role);
    if (roleJson != null) {
      Map<String, dynamic> roleMap = jsonDecode(roleJson);
      Map<String, List<bool>> role = {};
      roleMap.forEach((key, value) {
        role[key] = List<bool>.from(value);
      });
      // Bây giờ role chứa dữ liệu được lấy từ SharedPreferences
      print('Role: $role : ${role['farmer']}');
      if(role['farmer']![0]){
        checkFarmer = true;
      }
      if(role['monitor']![0]){
        return false;
      }
      if(role['backup_dairy']![0]){
        return false;
      }
      //đánh giá nội bộ có phải quản lý không
      /*if(role['report']![0]){
        return false;
      }*/
    } else {
      // Xử lý trường hợp không tìm thấy dữ liệu
      return true;
    }
    return true;
  }
}