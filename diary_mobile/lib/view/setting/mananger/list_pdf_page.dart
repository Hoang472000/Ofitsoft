import 'package:diary_mobile/utils/constants/shared_preferences_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/ofit_app_bar.dart';
import '../../../utils/widgets/pdf/pdf_viewer.dart';

///HoangCV: GD PDF
class ListPDFPage extends StatefulWidget {
  const ListPDFPage({
    Key? key,
  }) : super(key: key);

  static Route route() {
    return Utils.pageRouteBuilder(ListPDFPage(), true);
  }

  @override
  State<StatefulWidget> createState() => _ListPDFPageState();
}

class _ListPDFPageState extends State<ListPDFPage> {
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
            showDefaultBackButton: true,
            title: Text(
              S.of(context).user_manual,
              style: StyleOfit.textStyleFW700(Colors.white, 20),
            ),
            // hasBottom: true,
          ),
          backgroundColor: AppColor.background,
          body: SingleChildScrollView(
            child: Column(
              children: [
                itemAccount(context, text: "Hướng dẫn sử dụng chung",
                    voidCallback: () {
                      Navigator.push(context, PDFScreen.route("assets/pdf/HDSDAppQLVT", "Hướng dẫn sử dụng chung"));
                    }),
                itemAccount(context, text: "Hoạt động Canh tác/Thu hoạch",
                    voidCallback: () {
                      Navigator.push(context, PDFScreen.route("assets/pdf/HDCanhTac", "Hoạt động Canh tác/Thu hoạch"));
                    }),
                itemAccount(context, text: "Hoạt động Mua bán",
                    voidCallback: () {
                      Navigator.push(context, PDFScreen.route("assets/pdf/HDMuaBan", "Hoạt động Mua bán"));
                    }),
                itemAccount(context, text: "Báo cáo đánh giá thực địa",
                    voidCallback: () {
                      Navigator.push(context, PDFScreen.route("assets/pdf/BCDanhGiaThucDia", "Báo cáo đánh giá thực địa"));
                    }),
                // SizedBox(height: 20,)
              ],
            ),
          )),
    );
  }


  Widget itemAccount(BuildContext context,
      {required String text,
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
