class ApiConst {

  static const String domainApi = "http://localhost:8069";//"http://10.0.2.2:8069";//http://diary.visimex.com:8069/

  static const String get_diaries_farmer = "/get/diaries/farmer/";// /get/diaries/farmer/<int:id>
  //Bkav ToanTDd add
  static const String domain = "wsdemo.aibooks.vn";

  //Bkav ToanTDd end
  //static const String domainApi = "https://wsdemo.aibooks.vn/WSPublicAIBooks.asmx/ExecuteCommand";

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
