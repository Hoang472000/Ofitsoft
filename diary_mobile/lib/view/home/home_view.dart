import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/l10n.dart';
import '../../resource/assets.dart';
import '../../resource/color.dart';
import '../../resource/style.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/bkav_app_bar.dart';
import '../../utils/widgets/dialog/dialog_manager.dart';
import '../../view_model/home_bloc.dart';
import '../diary_activity/activity/activity_transaction_page.dart';
import '../diary_activity/activity_sell/activity_purchase_page.dart';
import '../report/add_report_view.dart';
import '../setting/contact/contact_page.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColor.background,
        appBar: OfitAppBar(
          context,
          centerTitle: true,
          showDefaultBackButton: false,
          title: Text(
            "Trang chủ",
            style: StyleOfit.textStyleFW700(Colors.white, 20),
          ),
          backgroundColor: AppColor.main,
          actions: [
            TextButton(
                onPressed: () {},
                child: SvgPicture.asset(
                  IconAsset.icPaste,
                  color: Colors.white,
                ))
          ],
        ),
        body: Utils.bkavCheckOrientation(
            context,
            SingleChildScrollView(
                child: Column(
              children: [
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 32, horizontal: 24),
                    //color: const Color(0xFFEFF2F5),
                    child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "OFITSOFT xin chào",
                              style: StyleOfit.textStyleFW600(Colors.orange, 16),
                            ),
                          ),
                          Text(
                            "Chúc bạn một ngày làm việc vui vẻ",
                            style: StyleOfit.textStyleFW400(Colors.black, 14),
                          ),
                        ],
                      );
                    })),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, ContactPage.route());
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
                                        AssetImage(ImageAsset.imageTeamSupport),
                                    fit: BoxFit.fill,
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.2),
                                      BlendMode.darken
                                  ),),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image(image: AssetImage(ImageAsset.imageOfitsoftText), opacity: const AlwaysStoppedAnimation(.8), height: 70,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Hỗ trợ hỏi đáp",
                                    style:
                                        StyleOfit.textStyleFW600(Colors.white, 18),
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
    });
  }
}
