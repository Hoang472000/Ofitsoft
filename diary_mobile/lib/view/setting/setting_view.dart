import 'dart:convert';

import 'package:diary_mobile/utils/constants/shared_preferences_key.dart';
import 'package:diary_mobile/utils/widgets/dialog_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';
import '../../resource/assets.dart';
import '../../resource/color.dart';
import '../../resource/style.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/bkav_app_bar.dart';
import '../../utils/widgets/button_widget.dart';
import '../home/home_page.dart';
import '../login/login_page.dart';
import 'account/account_information_page.dart';
import 'change_password/change_password_page.dart';
import 'contact/contact_page.dart';

///Bkav HoangCV: GD tai khoan
class SettingView extends StatefulWidget {
  const SettingView({
    Key? key,
  }) : super(key: key);

  static Route route(String userName, String phone) {
    return Utils.pageRouteBuilder(SettingView(), true);
  }

  @override
  State<StatefulWidget> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  String fullName= '';
  String group= '';
  String image= '';

  @override
  void initState() {
    // TODO: implement initState
    getUserInfo();
    super.initState();
  }

  Future<void> getUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      fullName = sharedPreferences.getString(SharedPreferencesKey.fullName)??'';
      group = sharedPreferences.getString(SharedPreferencesKey.group)??'';
      image = sharedPreferences.getString(SharedPreferencesKey.imageProfile)??'';
    });
  }
  @override
  Widget build(BuildContext context) {
    //precacheImage(AssetImage(ImageAsset.imageContactBackgroundBottom), context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          appBar: OfitAppBar(
            context,
            centerTitle: true,
            //backgroundColor: Colors.white,
            showDefaultBackButton: false,
            title: Text(
              S.of(context).setting,
              style: StyleOfit.textStyleFW700(Colors.white, 20),
            ),
           // hasBottom: true,
          ),
          backgroundColor: AppColor.background,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: CircleAvatar(
                        backgroundColor: AppColor.background,
                        radius: 40,
                        child:ClipOval(
                            child: image == '' ?
                            Image.asset(ImageAsset.imagePersonProfile, fit: BoxFit.fitHeight,) :
                            Image.memory(base64Decode(image),gaplessPlayback: true, fit: BoxFit.cover, width: 80, height: 80,
                              errorBuilder: (context, error, stackTrace) {
                                // Nếu có lỗi, hiển thị hình ảnh thay thế từ Image.asset
                                print("HoangCV: run way");
                                return Image.asset(
                                  ImageAsset.imagePersonProfile,
                                  fit: BoxFit.fitHeight,
                                  width: 80,
                                  height: 80,
                                );
                              },
                            )), //CircleAvatar
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Container(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: RichText(
                                    text: TextSpan(
                                        text: fullName,
                                        style: StyleOfit.textStyleFW700(
                                            Colors.black, 18,
                                            overflow: TextOverflow.visible)))),
                          ),
                          Flexible(
                              child: RichText(
                                  text: TextSpan(
                                      text: group,
                                      style: StyleOfit.textStyleFW400(
                                          Colors.black, 14,
                                          overflow: TextOverflow.visible)))),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 14),
                  child: itemAccount(context, text: "Thông tin tài khoản",
                      voidCallback: () async{
                        var result = await Navigator.push(context, AccountInformationPage.route());
                        print("result: $result");
                        if(result == null){
                          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          setState(() {
                            image = sharedPreferences.getString(SharedPreferencesKey.imageProfile)??'';
                          });
                        }
                  }, icon: IconAsset.icPersonSetting),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 0),
                  child: itemAccount(context, text: "Tra cứu mùa vụ",
                      voidCallback: () {
                        DiaLogManager.showDialogDevelopingFeature();
                        /*                Navigator.push(context, HistoryActivityPage.route());*/
                      }, icon: IconAsset.icCart),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 0),
                  child: itemAccount(context, text: "Lịch sử hoạt động",
                      voidCallback: () {
                        DiaLogManager.showDialogDevelopingFeature();
                    /*                Navigator.push(context, HistoryActivityPage.route());*/
                  }, icon: IconAsset.icHistoryActivity),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 0),
                  child: itemAccount(context,
                      text: S.of(context).change_password, voidCallback: () {
                           Navigator.push(context, ChangePassWordPage.route());
                  }, icon: IconAsset.icChangePassword),
                ),

                itemAccount(context, text: "Hướng dẫn sử dụng",
                    voidCallback: () {
                      DiaLogManager.showDialogDevelopingFeature();
                  /*          Navigator.push(context, UserManualPage.route());*/
                }, icon: IconAsset.icUserManual),
                itemAccount(context, text: "Liên hệ", voidCallback: () {
                            Navigator.push(context, ContactPage.route());
                }, icon: IconAsset.icContact),
                // SizedBox(height: 20,)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: OfitButton(
                    text: S.of(context).logout,
                    onPressed: () async {
                      DiaLogManager.displayDialog(context, "Đăng xuất", "Bạn có chắc chắn muốn đăng xuất?\nTất cả thông tin đăng nhập và dữ liệu đã lưu trữ sẽ bị xóa.\nBấm \'Đồng ý\' để đăng xuất.",
                              () async {
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        preferences.remove(SharedPreferencesKey.token);
                        preferences.remove(SharedPreferencesKey.userName);
                        Navigator.of(context).pushAndRemoveUntil(
                            await LoginPage.route(), (route) => false);
                      }, () {Get.back(); }, S.of(context).cancel, S.of(context).agree,);
                    },
                    color: AppColor.main,
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget itemAccount(BuildContext context,
      {required String icon,
      required String text,
      required VoidCallback voidCallback,
      String? iconRight}) {
    return InkWell(
      onTap: () {
        voidCallback();
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  SvgPicture.asset(icon),
                  Flexible(
                    child: SizedBox(
                      child: Container(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            text,
                            style:
                                StyleOfit.textStyleFW400(AppColor.black22, 16),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                voidCallback();
              },
              icon: SvgPicture.asset(iconRight ?? IconAsset.icArrowRight),
              padding:
                  const EdgeInsets.only(left: 8, right: 0, top: 12, bottom: 12),
              constraints: const BoxConstraints(),
            )
          ],
        ),
      ),
    );
  }
}
