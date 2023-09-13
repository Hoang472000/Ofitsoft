class ApiConst {

  static const String domainApi = "http://qlvsx.ofitsoft.com:8069";//"http://10.0.20.249:8069";//http://diary.visimex.com:8069/
  //
  //static const String domainApi = "http://10.0.20.249:8069";
  static const String get_diaries_farmer = "/get/diaries/farmer/";// /get/diaries/farmer/<int:id>

  //api login
  static const String login = "/api/login";

  //api lay danh muc dung chung
  static const String getListTools = "/get/tools_farmer/";
  static const String getListMaterials = "/get/materials_farmer/";
  static const String getListActivities = "/get/activites_farmer/";
  static const String getListUnits = "/get/units_farmer/";
  //api danh sach diary
  static const String getListDiary = "/get/diaries/farmer/";
  //api danh sach backup diary
  static const String getListBackupDiary = "/get/backup_dairies/";
  //api get, update user info
  static const String getUserInfo = "/get/user/";
  static const String editUserInfo = "/edit/user/";
  //api get, add 1 activity diary, remove, edit
  static const String getListActivity = "/get/diary_farmer/";
  static const String addActivityDiary = "/add/item/diary_farmer";
  static const String removeActivityDiary = "/delete/item/diary_farmer/";
  static const String updateActivityDiary = "/edit/diary_farmer/";
  //api add hang loat activity_diary
  static const String addManyActivityDiary = "/add/many_items/diary_farmer";
  //api get information 1 diary
  static const String getInfoDiary = "/get/season_diary/";
  //api get, add 1 monitor diary, remove, edit
  static const String getListMonitor = "/get/diary_monitor/";
  //api change password truyền vào id của nông hộ
  static const String changePassword = "/edit/password/";

  //api get, add 1 activity diary SELL, PURCHASE, remove, edit
  static const String getListActivityTransaction = "/get/diary_transaction/";
  static const String addActivityTransaction = "/add/diary_transaction/";
  //static const String removeActivityDiary = "/delete/item/diary_farmer/";
  static const String updateActivityTransaction = "/edit/diary_transaction/";

  //api get, add 1 activity REPORT, remove, edit
  static const String getListReport = "/get/assessment/";
  static const String uploadQuestion = "/add/user_input_line/";
  //static const String removeActivityDiary = "/delete/item/diary_farmer/";
  //static const String updateActivityTransaction = "/edit/diary_transaction/";

  //update
  static const packageIdIOS = "com.bkav.aibooks";
  static const packageIdANDROID = "com.bkav.aibooks";

  static const bool isRememberDefault = true; // gia tri mac dinh nho mat khau
  /// command data type const, chi tiet xem : https://docs.google.com/document/d/1gWTu8AJHOQel5a13lkp51cdm658tE2R9/edit#heading=h.50ej0584cnw
  static const int loginType = 100; //dang nhap bang tai khoan mat khau
  static const int loginWithGG$FBType = 101; //dang nhap bang google
  static const int loginWithBioType = 102;
  static const int passwordRetrieval = 110; // lay lai mat khau
  static const int confirmNewPassword = 100; // xac nhan mat khau moi
  static const int provideAccessToken = 111; // xin cap phat access token
  static const int changePassWord = 122; //thay doi mat khau
  static const int refreshAccessToken = 120; //cap phat lai access token


}
