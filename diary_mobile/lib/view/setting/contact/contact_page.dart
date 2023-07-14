import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  static Route route() {
    return Utils.pageRouteBuilder(const ContactPage(), true);
  }

  @override
  State<StatefulWidget> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          backgroundColor: AppColor.background,
          appBar: BkavAppBar(
            context,
            showDefaultBackButton: true,
            centerTitle: true,
            title: Text(
              "Liên hệ",
              style: StyleBkav.textStyleFW700(AppColor.whiteF2, 20),
            ),
            //backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          extendBodyBehindAppBar: true,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageAsset.imageOfitsoftText),
                  fit: BoxFit.scaleDown
              ),
              color: AppColor.whiteF2,
              //color: AppColor.orangeF8,
            ),
            padding: const EdgeInsets.only(top: 64),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                  /*  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                          AssetImage(ImageAsset.imageContactBackgroundBottom),
                          fit: BoxFit.fill),
                    ),*/
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(top: 75),
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.only(left: 16, right: 18),
                      child: SingleChildScrollView(
                        physics:
                        const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(IconAsset.icContact),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              Utils.launchPhoneUrl("0989426911");
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Liên hệ kỹ thuật:",
                                                  style: StyleBkav.textStyleFW400(
                                                      AppColor.main, 15),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 5.0,
                                                      bottom: 10),
                                                  child: Text(
                                                    "0989426911",
                                                    style: StyleBkav
                                                        .textStyleFW400(
                                                        AppColor.black22,
                                                        15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              Utils.launchPhoneUrl(
                                                  "1900 54 54 14");
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  "Đăng ký dịch vụ:",
                                                  style: StyleBkav
                                                      .textStyleFW400(
                                                      AppColor.main,
                                                      15),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      top: 5.0,
                                                      bottom: 10),
                                                  child: Text(
                                                    "1900 54 54 14",
                                                    style: StyleBkav
                                                        .textStyleFW400(
                                                        AppColor
                                                            .black22,
                                                        15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {},
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisSize:
                                              MainAxisSize.max,
                                              children: [
                                                Text(
                                                  "Fax:",
                                                  style: StyleBkav
                                                      .textStyleFW400(
                                                      AppColor.main,
                                                      15),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      top: 5.0,
                                                      bottom: 18),
                                                  child: Text(
                                                      "+84 24 560 5552",
                                                      style: StyleBkav
                                                          .textStyleFW400(
                                                          AppColor
                                                              .black22,
                                                          15,
                                                          overflow:
                                                          TextOverflow
                                                              .visible)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // const Divider(color: AppColor.grayE8,thickness: 1,),
                            const Padding(
                              padding: EdgeInsets.only(right: 30),
                              child: DottedLine(dashColor:Color(0xFFE8E9EE),),
                            ),
                            const SizedBox(height: 8,),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Utils.launchMailUrl("ofitsoft@gmail.com");
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(IconAsset.icContact),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16),
                                          child: Text(
                                              "ofitsoft@gmail.com",
                                              style: StyleBkav.textStyleFW400(
                                                  AppColor.black22, 15, overflow: TextOverflow.visible)
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // const Divider(color: AppColor.grayE8,thickness: 1,),
                            const SizedBox(height: 8,),
                            const Padding(
                              padding: EdgeInsets.only(right: 30),
                              child: DottedLine(dashColor:Color(0xFFE8E9EE),),
                            ),
                            const SizedBox(height: 8,),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(IconAsset.icKho, color: AppColor.badgeBackground,),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 16),
                                        child: Text(
                                          "108A Lò Đúc, Đồng Xuân, Hai Bà Trưng, Hà Nội",
                                          style: const TextStyle(
                                              color: AppColor.black22,
                                              fontSize: 15,
                                              height: 1.2,
                                              overflow: TextOverflow.visible,
                                              fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

}
