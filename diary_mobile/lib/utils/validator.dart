

import 'logger.dart';

class Validator {
  static const String _emailRule =
      r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";
  static const String _passwordRule =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?~]).{9,}$';
  static const String _rejectRule =
      r"^!@#$%&*()_+-={}[]/|\:;”,“<>";


  static String? emailValidator(String email) {
    if (email == "") {
      return "Email is Empty";
    }
    var isValid = RegExp(_emailRule).hasMatch(email);
    if (!isValid) {
      return "Email invalid";
    }
    return null;
  }

  static String passwordValidator(String pass) {
    if (pass == "") {
      return "Password is Empty";
    }
    if (pass.length < 8) {
      return "Password require minimum 8 characters";
    }
    var isValid = RegExp(_passwordRule).hasMatch(pass);
    if (!isValid) {
      return "Password invalid";
    }
    return "";
  }

  //
  static String errorValidate(String content){
    if(content == ""){
      return "Lý do từ chối không được để trống";
    }
    if(content.length < 5){
      return "Số ký tự nhập tối thiểu là 5";
    }
    if(content.length > 500){
      return "Số ký tự nhập tối đa là 500";
    }

    //validate toàn bộ là 1 ký tu
    int count = 0;
    for (var x in content.runes) {
      for (var y in content.runes) {
        if(x==y){
          count++;
        }
      }
      if(count == content.runes.length){
        return "Lý do từ chối không hợp lệ";
      }
      count = 0;
    }

    //validate toàn bộ là ký tự đăc biet
    int countRule = 0;
    for (var x in content.runes) {
      for (var y in _rejectRule.runes) {
        if(x==y){
          countRule++;
        }
      }
    }
    if(countRule == content.runes.length){
      return "Lý do từ chối không hợp lệ";
    }
    return "";
  }

  ///HoangCV: validate mat khau
  /// Mat khau co do dai toi thieu la 8
  /// Chứa 3 trong 4 kiểu ký tự (a – z, A – Z, 0 – 9, !@#$%^&*)
  ///  Khong chua khoang trang
  static bool validateFormatPass(String pass){
    RegExp regExp1= RegExp(r"^(?=(.*[0-9]))(?=.*[\!@#$%^&*])(?=.*[a-z])(?=(.*[A-Z]))(?=(.*)).{8,}");
    RegExp regExp2=RegExp(r"^(?=(.*[0-9]))(?=.*[\!@#$%^&*])(?=.*[a-z])(?=(.*)).{8,}");
    RegExp regExp3=RegExp(r"^(?=(.*[0-9]))(?=.*[\!@#$%^&*])(?=.*[A-Z])(?=(.*)).{8,}");
    RegExp regExp4= RegExp(r"^(?=(.*[0-9]))(?=.*[a-z])(?=(.*[A-Z]))(?=(.*)).{8,}");
    RegExp regExp5= RegExp(r"^(?=.*[\!@#$%^&*])(?=.*[a-z])(?=(.*[A-Z]))(?=(.*)).{8,}");
    return (regExp1.hasMatch(pass)|| regExp2.hasMatch(pass)|| regExp3.hasMatch(pass)|| regExp4.hasMatch(pass)|| regExp5.hasMatch(pass)) &&
        !pass.contains(" ");
  }

  static bool validateFormatPassWord(String pass){
    RegExp regExp= RegExp(r"^(?=(.*[0-9]))(?=.*[a-z])(?=(.*[A-Z]))(?=(.*[\!@#$%^&*])).{8,}");
    return regExp.hasMatch(pass) && !pass.contains(" ");
  }

  static bool validatePhone(String? phone) {
    return validateMobileNumber(phone) || validateLandlineNumber(phone);
  }

  //tách thành 2 luật riêng cho số di động và cố định
  static bool validateMobileNumber(String? mobile) {
    RegExp regExp = RegExp(r'(?:[0]+([35789]))+([0-9]{8}$)');
    return regExp.hasMatch(mobile!) && !mobile.contains(" ");
  }

  static bool validateLandlineNumber(String? landline) {
    RegExp regExp1 = RegExp(r'^(?:[(][+][0-9]{1,3}[)])?[0-9]{8,10}$');
    RegExp regExp2 = RegExp(r'^(?:[(][0-9]{1,3}[)])?[0-9]{9,11}$');
    return (regExp1.hasMatch(landline!)||regExp2.hasMatch(landline)) && !landline.contains(" ");
  }

  static bool validateFormatPhone(String? phone) {
    RegExp regExp = RegExp(r'^(?:[+0][1-9])?[0-9]{10}$');
    Logger.loggerDebug("HoangCV: validateFormatPhone: ${regExp.hasMatch(phone!)}");
    return (regExp.hasMatch(phone) && !phone.contains(" "));
  }
  static bool isEmail(String? em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em!);
  }

  static bool validatorTaxCode(String? taxCode) {

    String p = r'^(?:[[0-9]{10}[-])?[0-9]{3}$';
    String q = r'^(?:[[0-9]{10})$';
    RegExp regExp1 = new RegExp(p);
    RegExp regExp2 = new RegExp(q);
    return regExp1.hasMatch(taxCode!)||regExp2.hasMatch(taxCode);
  }
  static bool validatorOtp(String? taxCode) {
    String q = r'^(?:[[0-9]{6})$';
    RegExp regExp = new RegExp(q);
    return regExp.hasMatch(taxCode!);
  }
  static bool validatePassLength(String pass){
    if(pass.length<8) {
      return false;
    }
    return true;
  }
  static bool validateWarehouseLength(String pass){
    if(pass.length<3) {
      return false;
    }
    return true;
  }

  /// Cấu trúc MST:
  /// Trường hợp 10 ký tự: 10 ký tự số
  /// Trường hợp 14 ký tự : (10 ký tự số)(dấu '-')(3 ký tự số)
  static const _taxCodeRule = r'^(\d{10})(-\d{3}){0,1}$';
  static bool validateTaxCode(String taxCode) {
    return RegExp(_taxCodeRule).hasMatch(taxCode);
  }
}
