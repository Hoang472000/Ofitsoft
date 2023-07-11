import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/l10n.dart';
import '../../resource/assets.dart';
import '../../resource/color.dart';
import '../../resource/style.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/bkav_app_bar.dart';
import '../../utils/widgets/button_widget.dart';
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
  @override
  Widget build(BuildContext context) {
    //precacheImage(AssetImage(ImageAsset.imageContactBackgroundBottom), context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          appBar: BkavAppBar(
            context,
            centerTitle: true,
            //backgroundColor: Colors.white,
            showDefaultBackButton: false,
            title: Text(
              S.of(context).setting,
              style: StyleBkav.textStyleFW700(Colors.white, 20),
            ),
           // hasBottom: true,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0, right: 20),
                      child: SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.asset(
                            ImageAsset.imagePerson,
                            fit: BoxFit.fitHeight,
                          )),
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
                                        text: "Cao Văn Hoàng",
                                        style: StyleBkav.textStyleFW700(
                                            Colors.black, 18,
                                            overflow: TextOverflow.visible)))),
                          ),
                          Flexible(
                              child: RichText(
                                  text: TextSpan(
                                      text: "Hộ nông dân",
                                      style: StyleBkav.textStyleFW400(
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
                      voidCallback: () {
                        Navigator.push(context, AccountInformationPage.route());
                  }, icon: IconAsset.icPersonSetting),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 0),
                  child: itemAccount(context, text: "Lịch sử hoạt động",
                      voidCallback: () {
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
                  /*          Navigator.push(context, UserManualPage.route());*/
                }, icon: IconAsset.icUserManual),
                itemAccount(context, text: "Liên hệ", voidCallback: () {
                            Navigator.push(context, ContactPage.route());
                }, icon: IconAsset.icContact),
                // SizedBox(height: 20,)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: BkavButton(
                    text: S.of(context).logout,
                    onPressed: () async {},
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
                                StyleBkav.textStyleFW400(AppColor.black22, 16),
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
