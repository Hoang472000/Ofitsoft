
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';

import '../utils.dart';
import 'input_register_model.dart';

class ServiceInfoExtension {

  String type = "";
  // Hiển thị bottom để chọn lịch
  Future<int> selectDate(BuildContext context, InputRegisterModel modelInput, String type,
      Function(InputRegisterModel) onNotification) async{
    /// Đóng bàn phím nếu đang chọn
    FocusScope.of(context).requestFocus(FocusNode());
    final completer = Completer<int>();
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
        //modelInput.valueDefault = /*Utils.formatDateTimeToString(*/DateTime.parse(picker.adapter.text).isUtc;
        modelInput.error = null;
        //onNotification(modelInput);
        completer.complete(1);
      },
      onSelect: (picker, index, selecteds) {
        picker.updateColumn(1, true);
        //onNotification(modelInput);
      },
    ).showModal(context).whenComplete(() {
      if (!completer.isCompleted) {
        completer.complete(0); // Resolve the completer with 0 indicating no value is picked
      }
    });
    return completer.future;
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
        modelInput.valueDefault = Utils.formatDateTimeToString(DateTime.parse(picker.adapter.text));
        modelInput.error = null;
        onNotification();
      },
      onSelect: (picker, index, selecteds) {
        picker.updateColumn(1, true);
        //onNotification();
      },
    ).showModal(context);
  }

  // Hiển thị danh sách ngày
  Future<int> selectDay(BuildContext context, InputRegisterModel modelInput,
      Function(InputRegisterModel) onNotification) async{
    /// Đóng bàn phím nếu đang chọn
    FocusScope.of(context).requestFocus(FocusNode());
    final completer = Completer<int>();
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
        print("HoangCV: picker: ${result} : ${resultInt} : ${modelInput.listValue[resultInt]}");
        modelInput.positionSelected = resultInt;
        modelInput.valueDefault = null;
        modelInput.valueSelected = modelInput.listValue[resultInt];
        modelInput.error = null;
       // onNotification(modelInput);
        completer.complete(1);
      },
    ).showModal(context).whenComplete(() {
      if (!completer.isCompleted) {
        completer.complete(0); // Resolve the completer with 0 indicating no value is picked
      }
    });
    return completer.future;
  }

  Future<int> selectValue(InputRegisterModel inputRegisterModel, BuildContext context,
      Function(InputRegisterModel) onNotification) async{
    FocusScope.of(context).requestFocus(FocusNode());
    switch (inputRegisterModel.valueSelected.runtimeType) {
      case PickerItem:
        return await selectDay(context, inputRegisterModel, (modelInput) {
          onNotification(modelInput);
        });
        break;
      case DateTime:
        return await selectDate(context, inputRegisterModel, type, (modelInput) {
          onNotification(modelInput);
        });
        break;
      default:
        return await selectDate(context, inputRegisterModel, type, (modelInput) {
          onNotification(modelInput);
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

/*  void selectValueYD(InputRegisterModel inputRegisterModel, BuildContext context,
      Function onNotification) {
    FocusScope.of(context).requestFocus(FocusNode());
    print("=======${inputRegisterModel.valueSelected.runtimeType}");
    switch (inputRegisterModel.valueSelected.runtimeType) {
      case PickerItem:
        return selectDay(context, inputRegisterModel, (modelInput) {
          onNotification(modelInput);
        });
        break;
      case DateTime:
        return selectDate(context, inputRegisterModel, "kYM", (modelInput) {
          onNotification(modelInput);
        });
        break;
    }
  }*/
}

enum TypeInputEnum {
  dmucItem,
  name, //Họ tên
  sex, // Giới tính
  birthday, //Ngày sinh
  country, // Quốc tịch
  password, // Mật khẩu
  new_password, // Mật khẩu mới
  re_new_password, // Nhập lại mật khẩu mới
  text,
  date,
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
