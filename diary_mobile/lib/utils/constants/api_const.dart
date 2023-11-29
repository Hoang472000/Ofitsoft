class ApiConst {

  static const String domainApi = "http://qlvsx.ofitsoft.com:8069";//"http://10.0.20.249:8069";//http://diary.visimex.com:8069/
  //
  //static const String domainApi = "http://10.0.20.249:8069";
  static const String get_diaries_farmer = "/get/diaries/farmer/";// /get/diaries/farmer/<int:id>

  //api login
  static const String login = "/api/login";

  static const String qrCode = "http://qlvsx.ofitsoft.com:8069/traceability/";

  //api lay danh muc dung chung
  static const String getListTools = "/get/tools_farmer/";
  static const String getListMaterials = "/get/materials_farmer/";
  static const String getListActivities = "/get/activites_farmer/";
  static const String getListUnits = "/get/units_farmer/";
  static const String getListWorkflow = "/get/product_process";//
  //api danh sach diary
  static const String getListDiary = "/get/diaries/farmer/";//
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
  static const String getListActivityTransaction = "/get/sale_transaction/";
  static const String addActivityTransaction = "/add/diary_transaction/";
  static const String removeActivityTransaction = "/delete/diary_transaction/";
  static const String updateActivityTransaction = "/edit/diary_transaction/";
  static const String getSeasonFarm = "/get/season_farm";
  static const String getListActivityPurchase = "/get/purchase_transaction";

  //api get, add 1 activity REPORT, remove, edit
  static const String getListReport = "/get/assessment/";
  static const String uploadQuestion = "/add/user_input_line/"; // support add/edit/update
  static const String getListReportResult = "/get/list_result_assessment/";
  static const String getDetailReport = "/get/result_assessment/";
  static const String editFarmerInspector = "/edit/result_assessment/";
  static const String getListReportSelect = "/get/list_assessment/";
  static const String deleteReport = "/delete/item/result_assessment/";
  //offline
  static const String editFarmerInspectorOffline = "/edit/result_assessment_offline/";
  static const String uploadQuestionOffline = "/add/user_input_line_offline/";
  //feedback
  static const String getListFarmerFeedback = "/get/list_farmer_feedback/";///get/list_farmer_feedback/<int:id>
  static const String getFarmerFeedback = "/get/farmer_feedback/";///get/farmer_feedback/<int:id>
  static const String addFarmerFeedback = "/add/farmer_feedback";
  static const String addReplyFeedback = "/add/reply_feedback";
  //loc mua vu lo trong
  static const String getListAreaEntity = "/get/area";//

  //danh sach thong bao
  static const String getListNotify = "/get/notification";
  static const String editNotification = "/edit/notification/";

  //truy xuat nguon goc
  static const String getListProductBatch = "/get/list_product_batch";
  static const String getDetailProductBatch = "/get/product_batch/"; // id

  static const String exportPdf = "/export/xlsx_invoice/";

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
