import 'dart:convert';

import 'package:diary_mobile/utils/constants/shared_preferences_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreDiary{
  static Future<List<bool>> getRole() async {
    List<bool> checkFarmer = [false, false, false, false, false];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? roleJson = sharedPreferences.getString(SharedPreferencesKey.role);
    if (roleJson != null) {
      Map<String, dynamic> roleMap = jsonDecode(roleJson);
      Map<String, List<bool>> role = {};
      roleMap.forEach((key, value) {
        role[key] = List<bool>.from(value);
      });
      // Bây giờ role chứa dữ liệu được lấy từ SharedPreferences

      // [true, true, true, true] : [đọc, thêm, sửa, xóa

      // "farmer": [ true, true, true, true ],
      // "monitor": [ true, true, true, true ],
      // "backup_dairy": [ true, true, true, true ],
      // "report": [ true, true, true, true ]]
      // "purchase_transaction": [ true, true, true, true ]]

      print('Role: $role : ${role['farmer']}');
      if(role['farmer']!.contains(true)){
        checkFarmer[0] = true;
      }
      if(role['monitor']!.contains(true)){
        checkFarmer[1] = true;
      }
      if(role['backup_dairy']!.contains(true)){
        checkFarmer[2] = true;
      }
      //đánh giá nội bộ có phải quản lý không
      if(role['report']!.contains(true)){
        checkFarmer[3] = true;
      }
      if(role['purchase_transaction']!.contains(true)){
        checkFarmer[4] = true;
      }
    } else {
      // Xử lý trường hợp không tìm thấy dữ liệu
      return checkFarmer;
    }
    return checkFarmer;
  }
}