import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({Key? key}) : super(key: key);

  static Route route() {
    return Utils.pageRouteBuilder(AboutMePage(), true);
  }

  @override
  State<StatefulWidget> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  String version = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPackageInfo();
  }
  Future<void> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          backgroundColor: AppColor.background,
          appBar: OfitAppBar(
            context,
            showDefaultBackButton: true,
            centerTitle: true,
            title: Text(
              "Thông tin ứng dụng",
              style: StyleOfit.textStyleFW700(AppColor.whiteF2, 20),
            ),
            //backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          //extendBodyBehindAppBar: true,
          body: Container(
            margin: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    height: MediaQuery.sizeOf(context).height/4,
                    width: MediaQuery.of(context).size.width/1,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      image: DecorationImage(
                        image:
                        AssetImage(ImageAsset.imageBackgroundDigital),
                        fit: BoxFit.fill,
                       ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "CT CỔ PHẦN PHẦN MỀM NÔNG NGHIỆP TỐI ƯU",
                                style:
                                StyleOfit.textStyleFW400(AppColor.main, 8),
                                //textAlign: TextAlign.center,
                              ),
                            ),
                            Image(image: AssetImage(ImageAsset.imageOfitsoftText), height: 100,),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Thông tin ứng dụng",
                            style:
                            StyleOfit.textStyleFW500(AppColor.main, 18, height: 1),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            "OfitOne",
                            style:
                            StyleOfit.textStyleFW500(AppColor.main, 18, height: 1),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      physics:
                      const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Divider(color: AppColor.grayE8,thickness: 1,),
                          const Padding(
                            padding: EdgeInsets.only(right: 0),
                            child: DottedLine(dashColor: AppColor.gray9B,),
                          ),
                          const SizedBox(height: 8,),
                          Container(
                            padding: const EdgeInsets.only(top: 4, bottom: 4, left: 5, right: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                      "Tên nhà phát triển",
                                      style: StyleOfit.textStyleFW400(
                                          AppColor.gray1, 15, overflow: TextOverflow.visible)
                                  ),
                                ),
                                Text(
                                    "OPTIMIZED FARMING IT SOFTWARE JOINT STOCK COMPANY",
                                    style: StyleOfit.textStyleFW400(
                                        AppColor.black22, 15, overflow: TextOverflow.visible),
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 0),
                            child: Divider(color: AppColor.gray9B,),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 4, bottom: 4, left: 5, right: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                      "Hạng mục",
                                      style: StyleOfit.textStyleFW400(
                                          AppColor.gray1, 15, overflow: TextOverflow.visible)
                                  ),
                                ),
                                Text(
                                  "Nông nghiệp",
                                  style: StyleOfit.textStyleFW400(
                                      AppColor.black22, 15, overflow: TextOverflow.visible),
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 0),
                            child: Divider(color: AppColor.gray9B,),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 4, bottom: 4, left: 5, right: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                      "Cập nhật",
                                      style: StyleOfit.textStyleFW400(
                                          AppColor.gray1, 15, overflow: TextOverflow.visible)
                                  ),
                                ),
                                Text(
                                  "20/12/2023",
                                  style: StyleOfit.textStyleFW400(
                                      AppColor.black22, 15, overflow: TextOverflow.visible),
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 0),
                            child: Divider(color: AppColor.gray9B,),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 4, bottom: 4, left: 5, right: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                      "Phiên bản",
                                      style: StyleOfit.textStyleFW400(
                                          AppColor.gray1, 15, overflow: TextOverflow.visible)
                                  ),
                                ),
                                Text(
                                  version,
                                  style: StyleOfit.textStyleFW400(
                                      AppColor.black22, 15, overflow: TextOverflow.visible),
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 0),
                            child: Divider(color: AppColor.gray9B,),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 4, bottom: 4, left: 5, right: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                      "Dung lượng",
                                      style: StyleOfit.textStyleFW400(
                                          AppColor.gray1, 15, overflow: TextOverflow.visible)
                                  ),
                                ),
                                Text(
                                  "88MB",
                                  style: StyleOfit.textStyleFW400(
                                      AppColor.black22, 15, overflow: TextOverflow.visible),
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),const Padding(
                            padding: EdgeInsets.only(right: 0),
                            child: Divider(color: AppColor.gray9B,),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 4, bottom: 4, left: 5, right: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                      "Ngôn ngữ",
                                      style: StyleOfit.textStyleFW400(
                                          AppColor.gray1, 15, overflow: TextOverflow.visible)
                                  ),
                                ),
                                Text(
                                  "Tiếng việt",
                                  style: StyleOfit.textStyleFW400(
                                      AppColor.black22, 15, overflow: TextOverflow.visible),
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                          // const Divider(color: AppColor.grayE8,thickness: 1,),
                        ],
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
