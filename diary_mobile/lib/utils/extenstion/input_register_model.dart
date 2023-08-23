import 'package:diary_mobile/utils/extenstion/service_info_extension.dart';
import 'package:flutter/material.dart';


enum TypeInputRegister {
  TextField,
  Select,
  MultiSelection,
  Non,
  Balance,
  TextFieldIcon,
  TextFieldMoney,
  TextFieldRemark,
  Tolge,
  TextFieldDate,
}

class InputRegisterModel<T,S> extends ChangeNotifier {
  String title;
  bool isCompulsory;
  TextEditingController? controller;
  S? valueSelected;
  S? valueDefault;
  List<T> listValue = [];
  TypeInputRegister type;
  int positionSelected;
  IconData? icon;
  String image;
  TextInputType typeInput;
  TextCapitalization? textCapitalization;
  bool isEmail;
  String? error;
  List<CardType>? listMutiChoice=[];
  TypeInputEnum? typeInputEnum;
  String? confirmTitle;
  bool? hasSearch;
  String? unit;
  int? maxLengthTextInput;
  bool isFormatText;
  var focusNode = FocusNode();
  bool isDecimalCurrency; // cho phép nhập số tiền thập phân
  bool isOnlyInputNumber;
  bool isPassword;
  bool rotateIcon; // cho phép quay icon 180°
  bool isUpCaseTextAndRemoveSign; // Viết hoa và bỏ dấu tiếng việt khi nhập xong
  String hintText; // hintText cho textfield nhiều dòng
  bool isOnlySelectDay;// Chỉ lựa chọn ngày cho thanh toán hoá đơn
  bool isRemoveSign; // chỉ cho phép nhận số và chữ. bỏ kí tự đặc biệt
  bool isAlwaysCap;
  bool noBorder;
  bool noUnder;
//<editor-fold desc="Data Methods" defaultstate="collapsed">

  InputRegisterModel({
    required this.title,
    required this.isCompulsory,
    this.controller,
    this.valueSelected,
    this.isUpCaseTextAndRemoveSign=false,
    this.listValue = const [],
    this.isRemoveSign=false,
    this.confirmTitle,
    this.isOnlySelectDay=false,
    this.typeInput=TextInputType.text,
    this.isEmail=false,
    this.isPassword=false,
    this.valueDefault,
    this.isFormatText=false,
    this.error,
    this.isOnlyInputNumber=false,
    this.maxLengthTextInput,
    this.unit,
    this.typeInputEnum ,
    this.listMutiChoice,
    this.hasSearch,
    required this.type,
    this.positionSelected = -1,
    this.icon,
    this.isDecimalCurrency = false,
    this.rotateIcon = false,
    this.hintText = '',
    this.textCapitalization,
    this.isAlwaysCap=false,
    this.image='',
    this.noBorder = false,
    this.noUnder = false,
  });

  InputRegisterModel copyWith({
    String? title,
    bool? isCompulsory,
    TextEditingController? controller,
    S? valueSelected,
    String? valueDefault,
    List<T>? listValue,
    TypeInputRegister? type,
    int? positionSelected,
    IconData? icon,
    TextInputType? typeInput,
    bool? isEmail,
    String? error,
    List<CardType>? listTypeCard,
    TypeInputEnum? typeInputEnum,
    String? confirmTitle,
    bool? isDecimalCurrency, // cho phép nhập số tiền thập phân
    bool? rotateIcon,
    String? hintText,
    TextCapitalization? textCapitalization,
    bool? isAlwaysCap,
    String? image
  }) {
    return InputRegisterModel(
      title: title ?? this.title,
      isCompulsory: isCompulsory ?? this.isCompulsory,
      controller: controller ?? this.controller,
      valueSelected: valueSelected ?? this.valueSelected,
      valueDefault: valueDefault ?? this.valueDefault,
      listValue: listValue ?? this.listValue,
      type: type ?? this.type,
      positionSelected: positionSelected ?? this.positionSelected,
      icon: icon ?? this.icon,
      typeInput: typeInput ?? this.typeInput,
      isEmail: isEmail ?? this.isEmail,
      error: error ?? this.error,
      listMutiChoice: listTypeCard ?? this.listMutiChoice,
      typeInputEnum: typeInputEnum ?? this.typeInputEnum,
      confirmTitle: confirmTitle ?? this.confirmTitle,
      isDecimalCurrency: isDecimalCurrency ?? this.isDecimalCurrency,
      rotateIcon: rotateIcon ?? this.rotateIcon,
      hintText: hintText ?? this.hintText,
      textCapitalization: textCapitalization ?? this.textCapitalization,
      isAlwaysCap: isAlwaysCap ?? this.isAlwaysCap,
      image: image ?? this.image,
    );
  }

  @override
  String toString() {
    return 'InputRegisterModel{title: $title, isCompulsory: $isCompulsory, controller: $controller, valueSelected: $valueSelected, valueDefault: $valueDefault, listValue: $listValue, type: $type, positionSelected: $positionSelected, icon: $icon, typeInput: $typeInput, isEmail: $isEmail, error: $error, listTypeCard: $listMutiChoice, typeInputEnum: $typeInputEnum, confirmTitle: $confirmTitle, isDecimalCurrency: $isDecimalCurrency, rotateIcon: $rotateIcon, hintText: $hintText, textCapitalization: $textCapitalization, isAlwaysCap: $isAlwaysCap}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InputRegisterModel &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          isCompulsory == other.isCompulsory &&
          controller == other.controller &&
          valueSelected == other.valueSelected &&
          valueDefault == other.valueDefault &&
          listValue == other.listValue &&
          type == other.type &&
          positionSelected == other.positionSelected &&
          icon == other.icon &&
          typeInput == other.typeInput &&
          isEmail == other.isEmail &&
          error == other.error &&
          listMutiChoice == other.listMutiChoice &&
          typeInputEnum == other.typeInputEnum &&
          confirmTitle == other.confirmTitle &&
          rotateIcon == other.rotateIcon &&
          hintText == other.hintText &&
          textCapitalization == other.textCapitalization &&
          isDecimalCurrency == other.isDecimalCurrency&&
          isAlwaysCap == other.isAlwaysCap&&
          image == other.image);

  @override
  int get hashCode =>
      title.hashCode ^
      isCompulsory.hashCode ^
      controller.hashCode ^
      valueSelected.hashCode ^
      valueDefault.hashCode ^
      listValue.hashCode ^
      type.hashCode ^
      positionSelected.hashCode ^
      icon.hashCode ^
      typeInput.hashCode ^
      isEmail.hashCode ^
      error.hashCode ^
      listMutiChoice.hashCode ^
      typeInputEnum.hashCode ^
      confirmTitle.hashCode ^
      rotateIcon.hashCode ^
      hintText.hashCode ^
      textCapitalization.hashCode ^
      isAlwaysCap.hashCode ^
      isDecimalCurrency.hashCode ^
      image.hashCode;

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'title': this.title,
      'isCompulsory': this.isCompulsory,
      'controller': this.controller,
      'valueSelected': this.valueSelected,
      'valueDefault': this.valueDefault,
      'listValue': this.listValue,
      'type': this.type,
      'positionSelected': this.positionSelected,
      'icon': this.icon,
      'typeInput': this.typeInput,
      'isEmail': this.isEmail,
      'error': this.error,
      'listTypeCard': this.listMutiChoice,
      'typeInputEnum': this.typeInputEnum,
      'confirmTitle': this.confirmTitle,
      'isDecimalCurrency': this.isDecimalCurrency,
      'hintText': this.hintText,
      'textCapitalization': this.textCapitalization,
      'isAlwaysCap': this.isAlwaysCap,
      'rotateIcon': this.rotateIcon,
      'image': this.image
    } as Map<String, dynamic>;
  }

//</editor-fold>

}

class CardType{
  String? cardName;
  String? description;
  bool isSelected;
  String? cardCode;
  String? status;

  CardType({
     this.cardName,
     this.description,
     this.isSelected=false,
     this.cardCode,
     this.status,
  });

  CardType copyWith({
    String? cardName,
    String? description,
    bool? isSelected,
    String? cardCode,
    String? status,
  }) {
    return new CardType(
      cardName: cardName ?? this.cardName,
      description: description ?? this.description,
      isSelected: isSelected ?? this.isSelected,
      cardCode: cardCode ?? this.cardCode,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'CardType{cardName: $cardName, description: $description, isSelected: $isSelected, cardCode: $cardCode, status: $status}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardType &&
          runtimeType == other.runtimeType &&
          cardName == other.cardName &&
          description == other.description &&
          isSelected == other.isSelected &&
          cardCode == other.cardCode &&
          status == other.status);

  @override
  int get hashCode =>
      cardName.hashCode ^
      description.hashCode ^
      isSelected.hashCode ^
      cardCode.hashCode ^
      status.hashCode;

  factory CardType.fromMap(Map<String, dynamic> map) {
    return new CardType(
      cardName: map['cardName'].toString(),
      description: map['description'].toString(),
      cardCode: map['cardCode'].toString(),
      status: map['status'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'cardName': this.cardName,
      'description': this.description,
      'isSelected': this.isSelected,
      'cardCode': this.cardCode,
      'status': this.status,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}