import 'package:diary_mobile/data/entity/activity/season_farm.dart';
import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/item_default.dart';
import 'package:diary_mobile/data/entity/item_default/material_entity.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:diary_mobile/data/entity/report/report.dart';
import 'package:diary_mobile/utils/widgets/bottom_sheet/bottom_sheet_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';

import '../../view_model/setting/account/account_information_bloc.dart';
import 'input_register_model.dart';
import 'service_info_extension.dart';


class Extension {
  /// Nếu giá trị trả về là -1 thì người dùng không click vào item
  /// Nếu giá trị khác -1 thì trả về vị trí item người dùng click
  Future<int> showBottomSheetSelection(
      BuildContext context, List list, int posSelected, String title,
      {bool hasSearch = false}) async {
    /// Đóng bàn phím nếu đang chọn
    FocusScope.of(context).requestFocus(FocusNode());
    var result = await showModalBottomSheet<dynamic>(
      backgroundColor: Colors.white.withOpacity(0),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (BuildContext _context) => BottomSheetCustomWidget(
        title: title,
        list: list,
        haveSearch: hasSearch,
        posSelected: posSelected,
      ),
    );
    return (result == null || result == -1) ? -1 : result;
  }

  String getValueDisplay(
    dynamic model,
  ) {
/*    print("HoangCV: model: ${model.runtimeType} : ${model.name}");*/
    switch (model.runtimeType) {
      case SexEnum:
        {
          switch (model as SexEnum) {
            case SexEnum.M:
              return "Nam";
              break;
            case SexEnum.F:
              return "Nữ";
              break;
          }
          break;
        }
      case PickerItem:
        return model.value;
        break;
      case MaterialEntity:
      case Tool:
      case Activity:
      case Unit:
      case Item:
      case Gender:
      case People:
      case SeasonFarm:
        return model.name;
/*
      case People:
        return "${model.id} - "+ model.name;
*/

      case DateTime:
        return DateFormat('dd/MM/yyyy HH:mm:ss').format(model);
      case String:
        return model;
        break;
    /*  case CountryModel:
        return model.countryName;
        break;
      case ProvinceModel:
        return model.regionName;
        break;

      case AccountAll:
        return model.acctNo;
        break;
      case CurrencyModel:
        return model.currucyCode;
        break;*/


      /// 3/3/2021 Lỗi k tồn tại class
      // case SourceAccount:
      //   return model.acctNo;
      //   break;


      case MoneyTypeEnum:
        return model.toString().split('.').last;
        break;
/*      case RegisterServiceEnum:
        {
          switch (model as RegisterServiceEnum) {
            case RegisterServiceEnum.IB:
              return Public().languageCustom(
                "payAccount.ib",
              );
              break;
            case RegisterServiceEnum.SMS:
              return Public().languageCustom(
                "payAccount.sms",
              );
              break;
            case RegisterServiceEnum.MB:
              return Public().languageCustom(
                "payAccount.mb",
              );
              break;
          }
          break;
        }*/

      // ! start danh loc
      //* thêm số tài khoản chuyển và tiền tệ
    /*  case AccountAll:
        return '${model.acctNo} ${model.currencyCode}';
        break;*/
      // * xem ai là người chuyển phí
     /* case FeeTypeEnum:
        switch (model as FeeTypeEnum) {
          case FeeTypeEnum.FEE_TYPE_0:
            return Public().languageCustom(
              "internal-transfer.transfer_pay",
            );
            break;
          case FeeTypeEnum.FEE_TYPE_1:
            return Public().languageCustom(
              "internal-transfer.recipients_pay",
            );
            break;
        }
        break;*/
      // * show ngân hàng chọn ra ngân hàng 247
     /* case BankNapasResponceModel:
        return model.shortName;
        break;*/
      // danh muc NH
/*
      case DmucNganHang:
        return model.maNganHang + " - " + model.tenNganHang;

      case TkNganHangModel:
        return model.soTaiKhoanThe;

      case TenPhieuXuatModel:
        return model.tenPhieuXuat;

      case DanhMucTBaoModel:
        return model.tenTBao;
        break;
      // ! end danh loc

    //danh sach tờ khai
      case ListDmToKhaiModel:
        return model.tenTKhai;
        break;
    //danh sach tờ khai
      case DMucTKhaiModel:
        return model.maTKhai + "-" + model.tenTKhai;
        break;
    //danh sách cục thuế
      case CucThueModel:
        return model.tenCqThue;
     //danh sach tinh
      case DanhMucTinhModel:
        return model.tenTinh;
     // danh sach NH unt
      case DanhMucNganHangUntModel:
        return model.fullName;
    //danh sách chi cục thuế
      case ChiCucThueModel:
        return model.tenCqThue;
      case ChiCucThueModel:
        return model.tenCqThue;
      case TthaiBtruModel:
        return model.tenTthai;
    //danh sach loai phuong tien
      case LoaiPhuongTienModel:
        String taiSan = "${model.tenTaiSan}";
        return taiSan;
    //danh sach nhan hieu
      case NhanHieuModel:
        String nhanhieu = "${model.tenNhanHieu}";
        return nhanhieu;
      case ItemDMuc:
        String dmuc ;
        if(model.tenTinh != null){
          dmuc = "${model.tenTinh}";
        }else if(model.tenHuyen != null){
          dmuc = "${model.tenHuyen}";
        }else if(model.tenXa != null){
          dmuc = "${model.tenXa}";
        }else if(model.tenMuc != null){
          dmuc = "${model.tenMuc}";
        }else if(model.tenNganh != null){
          dmuc = "${model.maNganh} - ${model.tenNganh}";
        } else if(model.ten != null){
          dmuc = "${model.ten}";
        }
        return dmuc;
      case KhoBacModel:
        return model.tenKBac;
      case DMucChon:
        return model.name;
      case ThongTinMST:
        String ttmst ;
        if(model.ten != null){
          ttmst = "${model.ten}";
        }
        return ttmst;



    //danh sach ten thuong mai
      case TenThuongMaiModel:
        return model.tenThuongMai;
      case NuocSanXuatModel:
        return model.tenQuocGia;
      case SecurityDeviceEnum:
        {
          switch (model as SecurityDeviceEnum) {
            case SecurityDeviceEnum.SMS:
              return Public().languageCustom(
                "internet_banking.sms",
              );
              break;
            case SecurityDeviceEnum.Token:
              return Public().languageCustom(
                "internet_banking.token",
              );
              break;
          }
          break;
        }
*/

        // mauld end
    }
    return "";
  }

  /// isSubmit= true sẽ check lỗi khi dữ liệu trống và ngược lại
  void validateInput(InputRegisterModel inputModel, {bool isSubmit = false}) {
    if (inputModel.isCompulsory) {
      switch (inputModel.type) {
        case TypeInputRegister.TextField:
          if (inputModel.controller!.text.isEmpty && isSubmit) {
            inputModel.error = "Vui lòng nhập ${inputModel.title.toLowerCase()}";
            return;
          } else {
            inputModel.error = null;
          }
          if (inputModel.isEmail && isSubmit) {
            bool emailValid = RegExp(
                    r'(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))')
                .hasMatch(inputModel.controller!.text);
            if (!emailValid) {
              inputModel.error = "Email sai định dạng";
              return;
            }
          } else {
            inputModel.error = null;
          }
         /* if (inputModel.typeInputEnum == TypeInputEnum.deposits) {
            if (double.parse(inputModel.controller!.text.replaceAll(',', '')) <
                50000) {
              inputModel.error = "Số tiền giao dịch phải lớn hơn 50.000";
            } else {
              inputModel.error = null;
            }
          }*/
          break;
        case TypeInputRegister.Select:
          if (inputModel.valueDefault != null ||
              (/*inputModel.typeInputEnum == TypeInputEnum.determinative &&*/
                  inputModel.valueSelected.value == '')) {
            inputModel.error = "Vui lòng nhập ${inputModel.title.toLowerCase()}";
            return;
          } else {
            inputModel.error = null;
          }
          break;
        case TypeInputRegister.MultiSelection:
          int amountSelected = 0;
          inputModel.listMutiChoice!.forEach((card) {
            if (card.isSelected) {
              amountSelected++;
            }
          });
          if (amountSelected == 0) {
            inputModel.error = "Vui lòng chọn ${inputModel.title.toLowerCase()}";
          } else {
            inputModel.error = null;
          }
          break;
        case TypeInputRegister.Non:
          if (inputModel.controller!.text.isEmpty && isSubmit) {
            inputModel.error = "Vui lòng nhập ${inputModel.title.toLowerCase()}";
            return;
          } else {
            inputModel.error = null;
          }
          // TODO: Handle this case.
          break;
        case TypeInputRegister.Balance:
          if (int.parse(inputModel.valueDefault!
                      .split('/')[0]
                      .replaceAll(',', "")) <
                  50000 &&
              isSubmit) {
            inputModel.error = "Số dư không khả dụng";
            return;
          } else {
            inputModel.error = null;
          }
          // TODO: Handle this case.
          break;
        case TypeInputRegister.TextFieldIcon:
          alertEmtype(inputModel, isSubmit);

          break;
        case TypeInputRegister.TextFieldMoney:
          alertEmtype(inputModel, isSubmit);
          break;
        case TypeInputRegister.TextFieldRemark:
          alertEmtype(inputModel, isSubmit);

          break;
        case TypeInputRegister.Tolge:
          // TODO: Handle this case.
          break;
        case TypeInputRegister.TextFieldDate:
          break;
      }
    }else{
      if (inputModel.typeInputEnum == TypeInputEnum.birthday/*||
          inputModel.typeInputEnum == TypeInputEnum.passportDate*/
      ) {
        DateTime dt= inputModel.valueSelected as DateTime;
        if(dt.isBefore(DateTime.now())){
          inputModel.error = null;
        }else{
          inputModel.error = "Vui lòng không chọn ngày tương lai";
        }
      }
    }
  }

  alertEmtype(InputRegisterModel inputModel, bool isSubmit) {
    if (inputModel.controller!.text.isEmpty && isSubmit) {
      inputModel.error = "Vui lòng nhập ${inputModel.title.toLowerCase()}";
      return;
    } else {
      inputModel.error = null;
    }
  }
}
