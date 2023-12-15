import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resource/assets.dart';
import '../../resource/color.dart';
import '../../resource/style.dart';
import '../../utils/constants/shared_preferences.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/bkav_app_bar.dart';
import '../../utils/widgets/dialog/dialog_manager.dart';
import '../../view_model/home_bloc.dart';
import '../diary_activity/activity_sell/activity_purchase_page.dart';
import '../report/list_report_result_view.dart';
import '../setting/contact/contact_page.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  State<ManagerPage> createState() => _ManagerPageState();

  static Route route() {
    return Utils.pageRouteBuilder(
        const ManagerPage(),
        true);
  }
}

class _ManagerPageState extends State<ManagerPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser(context);
  }

  void checkUser(BuildContext context) async {
    bool checkReport = false;
    bool checkPurchase = false;
    List<bool> check = await SharedPreDiary.getRole();
    checkReport = check[3];
    checkPurchase = check[4];
    if (checkReport && checkPurchase) {
    }
    else if (checkReport) {
      var result = await Navigator.push(context,
          ListReportResultView.route());
      if(result != null){
        print("HoangCV: result: $result");
        Navigator.of(context).pop();
      }
    }
    else if(checkPurchase){
      var result = await  Navigator.push(context,
          ActivityPurchasePage.route("purchase"));
      if(result != null){
        print("HoangCV: result: $result");
        Navigator.of(context).pop();
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    //print("runqay ");
      return Scaffold(
        backgroundColor: AppColor.background,
        appBar: OfitAppBar(
          context,
          centerTitle: true,
          showDefaultBackButton: true,
          title: Text(
            "Tổng quan quản lý",
            style: StyleOfit.textStyleFW700(Colors.white, 20),
          ),
          backgroundColor: AppColor.main,
          actions: [
          ],
        ),
        body: Utils.bkavCheckOrientation(
            context,
            SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              var result = await Navigator.push(context,
                                  ActivityPurchasePage.route("purchase"));
                            },
                            child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                height: 250,
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: AssetImage(ImageAsset.imagePurchase2),
                                      fit: BoxFit.fill ,
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.2),
                                          BlendMode.darken
                                      ),)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    //Image(image: AssetImage(ImageAsset.imageSelling), opacity: const AlwaysStoppedAnimation(.8),height: 50,),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Mua hàng",
                                        style: StyleOfit.textStyleFW600(
                                            Colors.white, 22),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context,ListReportResultView.route());
                            },
                            child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 15),
                                padding: const EdgeInsets.all(10),
                                height: 250,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image:
                                    AssetImage(ImageAsset.imageManagerSmart2),
                                    fit: BoxFit.fill,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.2),
                                        BlendMode.darken
                                    ),),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    //Image(image: AssetImage(ImageAsset.imageDisaster), opacity: const AlwaysStoppedAnimation(.8), height: 50,),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Báo cáo đánh giá",
                                        style:
                                        StyleOfit.textStyleFW600(Colors.white, 22),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ))),
      );

  }
}
