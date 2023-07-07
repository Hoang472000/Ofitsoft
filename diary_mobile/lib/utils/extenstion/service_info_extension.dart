
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'input_register_model.dart';

class ServiceInfoExtension {

  String type = "";
  // Hiển thị bottom để chọn lịch
  void selectDate(BuildContext context, InputRegisterModel modelInput, String type,
      Function onNotification) {
    /// Đóng bàn phím nếu đang chọn
    FocusScope.of(context).requestFocus(FocusNode());
    Picker(
      //looping: true,
      //changeToFirst: true,
      adapter: DateTimePickerAdapter(
        type: type == "" ? PickerDateTimeType.kDMY : PickerDateTimeType.kYM,
        value: modelInput.valueSelected,
        isNumberMonth: true,
        minValue: DateTime(1900),
        maxValue: DateTime.now(),
      ),
      textAlign: TextAlign.center,
      confirmText: "Đồng ý",
      cancelText: "Hủy",
      height: MediaQuery.of(context).size.height / 3,
      itemExtent: 50.0,
      diameterRatio: 1.5,
      confirmTextStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold),
      cancelTextStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold),
      onConfirm: (Picker picker, List value) {
        modelInput.valueSelected = DateTime.parse(picker.adapter.text);
        modelInput.error = null;
        onNotification();
      },
      onSelect: (picker, index, selecteds) {
        picker.updateColumn(1, true);
        onNotification();
      },
    ).showModal(context);
  }

  void selectDateToDay(BuildContext context, InputRegisterModel modelInput, String type,
      Function onNotification) {
    /// Đóng bàn phím nếu đang chọn
    FocusScope.of(context).requestFocus(FocusNode());
    Picker(
      //looping: true,
      //changeToFirst: true,
      adapter: DateTimePickerAdapter(
        type: type == "" ? PickerDateTimeType.kDMY : PickerDateTimeType.kYM,
        value: modelInput.valueSelected,
        isNumberMonth: true,
        minValue: DateTime(1990),
        maxValue: DateTime(3000),
      ),
      textAlign: TextAlign.center,
      confirmText: "Đồng ý",
      cancelText: "Hủy",
      height: MediaQuery.of(context).size.height / 3,
      itemExtent: 50.0,
      diameterRatio: 1.5,
      confirmTextStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 30,
          fontWeight: FontWeight.bold),
      cancelTextStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 30,
          fontWeight: FontWeight.bold),
      onConfirm: (Picker picker, List value) {
        modelInput.valueSelected = DateTime.parse(picker.adapter.text);
        modelInput.error = null;
        onNotification();
      },
      onSelect: (picker, index, selecteds) {
        picker.updateColumn(1, true);
        onNotification();
      },
    ).showModal(context);
  }

  // Hiển thị danh sách ngày
  void selectDay(BuildContext context, InputRegisterModel modelInput,
      Function onNotification) {
    /// Đóng bàn phím nếu đang chọn
    FocusScope.of(context).requestFocus(FocusNode());
    Picker(
      adapter: PickerDataAdapter<dynamic>(
        data: modelInput.listValue as List<PickerItem<dynamic>>,
      ),
      textAlign: TextAlign.center,
      confirmText: "Đồng ý",
      cancelText: "Hủy",
      height: context.size!.height / 3,
      itemExtent: 50,
      // columnPadding: EdgeInsets.symmetric(horizontal: 50),
      diameterRatio: 1.5,
      confirmTextStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold),
      cancelTextStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold),
      selecteds: [modelInput.positionSelected ?? 0],
      onConfirm: (Picker picker, List value) {
        // String result = picker.adapter.text;
        String result = picker.adapter.text;
        int resultInt = int.parse(result.substring(1, result.length - 1));
        modelInput.positionSelected = resultInt;
        modelInput.valueDefault = null;
        modelInput.valueSelected = modelInput.listValue![resultInt];
        modelInput.error = null;
        onNotification();
      },
    ).showModal(context);
  }

  void selectValue(InputRegisterModel inputRegisterModel, BuildContext context,
      Function onNotification) {
    FocusScope.of(context).requestFocus(FocusNode());
    switch (inputRegisterModel.valueSelected.runtimeType) {
      case PickerItem:
        return selectDay(context, inputRegisterModel, () {
          onNotification();
        });
        break;
      case DateTime:
        return selectDate(context, inputRegisterModel, type, () {
          onNotification();
        });
        break;
      default:
        return selectDate(context, inputRegisterModel, type, () {
          onNotification();
        });
        break;

    }
  }

  void selectToday(InputRegisterModel inputRegisterModel, BuildContext context,
      Function onNotification){
    FocusScope.of(context).requestFocus(FocusNode());
    print("=======${inputRegisterModel.valueSelected.runtimeType}");
    switch (inputRegisterModel.valueSelected.runtimeType) {
      case DateTime:
        return selectDateToDay(context, inputRegisterModel, type, () {
          onNotification();
        });
        break;
      default:
        return selectDateToDay(context, inputRegisterModel, type, () {
          onNotification();
        });
        break;

    }
  }

  void selectValueYD(InputRegisterModel inputRegisterModel, BuildContext context,
      Function onNotification) {
    FocusScope.of(context).requestFocus(FocusNode());
    print("=======${inputRegisterModel.valueSelected.runtimeType}");
    switch (inputRegisterModel.valueSelected.runtimeType) {
      case PickerItem:
        return selectDay(context, inputRegisterModel, () {
          onNotification();
        });
        break;
      case DateTime:
        return selectDate(context, inputRegisterModel, "kYM", () {
          onNotification();
        });
        break;
    }
  }
}

enum TypeInputEnum {
  name, //Họ tên
  sex, // Giới tính
  birthday, //Ngày sinh
  country, // Quốc tịch
  identification, //Giấy tờ tùy thân
  passportNumber, //Số CMND/Passport
  passportDate, // Ngày cấp
  passportPlace, // Nơi cấp
  residentStatus, // Tình trạng cư trú
  residentAddressText, //Địa chỉ thường trú nhập tay
  residentContact, // Địa chỉ liên hệ nhập tay
  phoneNumber, // SỐ điện thoại
  email, //Email
  accountNumber, // Số tài khoản
  accountName, // Tên tài khoản
  typeCards, // Loại thẻ phát hành, đăng kí dịch vụ
  issuedPlace, // Chi nhánh liên hệ
  currentProvinceAddress, //Địa chỉ thường trú / Tỉnh/TP(Nơi ở hiện tại)
  residentProvinceAddress, // Tỉnh/TP địa chỉ thường trú
  residentCountry, // Quốc gia thường trú
  loanAmount, // Số tiền vay
  loanType, // Loại tiền vay
  loanDate, // Thời gian vay
  loanPurpose, // Mục đích vay
  totalIncome, // Tổng thu nhập tháng
  incomeSource, // Nguồn thu nhập chính
  guaranteedAsset, // Tài sản đảm bảo
  residentContactSelect, // Địa chỉ liên hệ lựa chọn
  contactInformation, // Thông tin liên hệ
  contactAddressProvince, // Chọn tỉnh địa chỉ liên hệ
  contactAddressCountry, // Chọn quốc gia địa chỉ liên hệ
  marriage, // Hôn nhân
  education, // Học vấn
  job, // Nghề nghiệp
  openAccount, // Tài khoản mở
  moneyType, // Loại tiền
  securityDevice, // Thiết bị bảo mật
  paymentAccount, // Tài khoản thanh toán
  living, // Đang sống tại
  balance,
  benificalAccount, // tài khoản thụ hưởng
  feeype, //  ai chuyển phí giao dịch
  remark, // nội dung của mỗi giao dịch
  sourceAccount, // tài khoản nguồn,
  typeDeterminative, // loại kì hạn
  determinative, //kì hạn
  depositProducts, // sản phẩm
  interest_rate, // lãi suất
  deposits, // số tiền gửi
  isRolloutRate, // hình thức trả lãi
  interest_account, // tài khoản nhận tiền
  isRolloutInterest, // hình thức đáo hạn
  togle, // có lưu hay không togle chuyển đ
  date_open, // ngày mở
  date_close, // ngày đáo hạn
  date_make, // ngày tất toán
  beneficiary_account, // tài khoản nhận tiền
  service, // Dịch vụ
  provide_house, // Nhà cung cấp
  id_customer, // Mã khách hàng
  otp, // nhập mã otp
  date_pay, // Ngày thanh toán
  fee_type, // Loại phí
  password, // Mật khẩu
  new_password, // Mật khẩu mới
  re_new_password, // Nhập lại mật khẩu mới
  beneficiary_bank, // ngân hàng thụ hưởng
  beneficiary_branch, // chi nhánh nhận
  benificalCombobox, //tài khoản nhận dạng combobox
  cmt, // chứng minh thư
  benificalInput, //tài khoản nhận dạng inupt
  text,
  date,
  dmuctbao,
  dmuctkhai,
  dmucCqt,
  dmucChiCucCqt,
  money,
  dmucLoaiPT,
  dmucNhanHieu,
  dmucTTMai,
  dmucQuocGia,
  congcutinhthue,
  dmucTinh,
  dmucHuyen,
  dmucXa,
  dmucNganHang,
  dmucHoSo,
  dmucMaMuc,
  dmucTieuMuc,
  dmucLoaiTien,
  thongTinMST,
  kyThue,
  dmucChon,
}

enum SexEnum {
  M, // Nam
  F, // Nữ

}

// enum DatetimeMY {
//   kMY, // Nam
// }


enum IdentificationEnum {
  cardId, // CMND
  passport, // Hộ chiếu
}

enum SecurityDeviceEnum { SMS, Token }

enum MoneyTypeEnum {
  VND, // VND
}

enum EducationEnum {
  after_university, // Sau đại học
  university, // Đại học
  poly, // Cao đẳng
  high_school, // THPT, Trung cấp
  below_high_school // Dưới THPT
}

enum JobEnum {
  learning, // Đang đi học
  no_work, // Không đi làm
  working, // Đang đi làm
  self_employed, // Tự kinh doanh
  retirement // Nghỉ hưu
}

enum ContactAddressEnum {
  vn, // GIống địa chỉ thường trú
  other, // Khác
}
enum MarriageEnum {
  single, // Độc thân
  married, // Đã kết hôn
  other // Khác
}

enum ResidentEnum {
  resident, // Cư trú
  nonResident, // Không cư trú
}

enum TypeCardEnum {
  DC, // Thẻ ghi nợ cuẩn
  CO, // Thẻ tín dụng
  TM, // Thẻ TH truemart
  OC, // Thẻ khác
}
enum RegisterServiceEnum {
  IB, // Internet banking
  SMS, // SMS
  MB, // Mobile banking
}
enum TypeRegisterScreen {
  card, // Đăng ký dịch vụ thẻ
  loan, // Đăng ký vay vốn
  open_account, // Đăng ký mở tài khoản thanh toán
  ib, //Đăng ký dịch vụ Internet Banking
  mPos, // Đăng ký mPos
}

const IDENTIFICATION_ENUM = <IdentificationEnum, String>{
  IdentificationEnum.cardId: "1",
  IdentificationEnum.passport: "2",
};

const RESIDENT_ENUM = <ResidentEnum, String>{
  ResidentEnum.resident: "1", // Cư trú
  ResidentEnum.nonResident: "0", // Không cứ trú
};

const TYPE_CARD_ENUM = <TypeCardEnum, String>{
  TypeCardEnum.CO: "CO",
  TypeCardEnum.DC: "DC",
  TypeCardEnum.OC: "OC",
  TypeCardEnum.TM: "TM",
};

const SECURITYDEVICEENUM = <SecurityDeviceEnum, String>{
  SecurityDeviceEnum.SMS: "1",
  SecurityDeviceEnum.Token: "2",
};

// mauld start
const INSURANCE_UNIT_ENUM = <SecurityDeviceEnum, String>{
  SecurityDeviceEnum.SMS: "1",
  SecurityDeviceEnum.Token: "2",
};
// mauld end
