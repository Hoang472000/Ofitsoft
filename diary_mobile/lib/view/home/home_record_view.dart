import 'dart:async';

import 'package:diary_mobile/utils/constants/shared_preferences_key.dart';
import 'package:diary_mobile/view/access_origin/access_origin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resource/assets.dart';
import '../../resource/color.dart';
import '../../resource/style.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/ofit_app_bar.dart';
import '../../view_model/diary_activity/activity/info_diary_bloc.dart';
import '../../view_model/home_bloc.dart';
import '../diary_activity/activity_sell/activity_purchase_page.dart';
import '../diary_activity/record_diary/add_record_diary.dart';
import '../report/list_report_result_view.dart';
import '../setting/contact/contact_page.dart';
import '../setting/feedback/feedback_page.dart';
import '../setting/mananger/list_pdf_page.dart';

class HomeRecordView extends StatefulWidget {
  const HomeRecordView({super.key});

  @override
  State<HomeRecordView> createState() => _HomeRecordViewState();
}

class _HomeRecordViewState extends State<HomeRecordView> {
  final PageController _pageController = PageController(initialPage: 0,
    viewportFraction: 1,);
  int _currentPage = 0;
  final int _totalPages = 5;
  Timer? _timer;
  bool _showAppbar = true;
  bool isScrollingDown = false;
  double bottomBarHeight = 75;
  String userName = '';

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    myScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5 ), (timer) {
      if (_pageController.page! < (_totalPages) - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.jumpToPage(0);
      }
    });
  }

  void myScroll() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userName = sharedPreferences.getString(SharedPreferencesKey.fullName) ?? "";
    });
  }
  Widget build(BuildContext context) {
    //print("runqay Home record view");
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Scaffold(
        //backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: Utils.bkavCheckOrientation(
            context,
            Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        opacity: 1,
                        image: AssetImage(
                            ImageAsset.imageOfitSoftBackground),
                        fit: BoxFit.fill),
                  ),
                  child:  Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 13,
                          left: MediaQuery.of(context).size.width / 20 + MediaQuery.of(context).size.width / 4,
                          right: MediaQuery.of(context).size.width / 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    "Xin chào",
                                    style: StyleOfit.textStyleFW600(Colors.orange, 17),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    userName,
                                    style: StyleOfit.textStyleFW600(Colors.black, 20),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Chúc bạn một ngày làm việc hiệu quả",
                                    style: StyleOfit.textStyleFW400(Colors.black, 14, overflow: TextOverflow.visible),
                                    maxLines: 3,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),),
                Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 15, left: MediaQuery.of(context).size.width / 20),
                  child: Image(
                    image: AssetImage(
                        ImageAsset.imageOfitsoftText),
                    opacity: const AlwaysStoppedAnimation(.8),
                    height: MediaQuery.of(context).size.width / 4,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.5),
                  child: Container(
                    //height: MediaQuery.of(context).size.height / 9,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.white,Colors.white ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      shadows: [
                        BoxShadow(
                          color: AppColor.grayDC,
                          offset: const Offset(0, -2), // Dịch shadow lên trên (âm số)
                          blurRadius: 3, // Bán kính blur của shadow
                          spreadRadius: 0, // Khoảng lan rộng của shadow
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3.5,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 18, top: 18),
                                  child: Text(
                                    "Tính năng",
                                    style: StyleOfit.textStyleFW600(Colors.black, 18),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(MediaQuery.sizeOf(context).width/40),
                                  child: GridView.builder(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: MediaQuery.sizeOf(context).width/30,
                                      mainAxisSpacing: MediaQuery.sizeOf(context).width/30,
                                    ),
                                    itemCount: state.listActivityFarm.length,
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var activity = state.listActivityFarm[index];
                                      return GestureDetector(
                                        onTap: () {
                                          if (activity.id == 1) {
                                            Navigator.push(context, ActivityPurchasePage.route("purchase"));
                                          } else if (activity.id == 2) {
                                            Navigator.push(context, ListReportResultView.route());
                                          } else if (activity.id == 3) {
                                            Navigator.push(context, AccessOriginPage.route());
                                          } else if (activity.id == 4) {
                                            Navigator.push(context, FeedbackPage.route());
                                          } else if (activity.id == 5) {
                                            Navigator.push(context, ListPDFPage.route());
                                          } else if (activity.id == 6) {
                                            Navigator.push(context, ContactPage.route());
                                          } else if (activity.id == 7) {
                                            Navigator.push(context, AddRecordDiaryPage.route("record"));
                                          }
                                        },
                                        child: item(activity),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: MediaQuery.sizeOf(context).width/56,
                                    right: MediaQuery.sizeOf(context).width/56,
                                    top: MediaQuery.sizeOf(context).width/25,),
                                  width: double.infinity,
                                  height: MediaQuery.sizeOf(context).width/3,
                                  child: PageView.builder(
                                    controller: _pageController,
                                    //pageSnapping: false,
                                    key: const PageStorageKey('uniqueKey'),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _totalPages,
                                    // viewportFraction: 0.8,
                                    onPageChanged: (index) {
                                      setState(() {
                                        _currentPage = index;
                                      });
                                    },
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(left: MediaQuery.sizeOf(context).width/28,
                                            right: MediaQuery.sizeOf(context).width/28,), // Khoảng cách giữa các item
                                        child: Center(
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  'assets/images/image_$index.jpg',
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            )),
      );
    });
  }

  Widget item(ActivityFarm activity){
    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          colors: [AppColor.background,AppColor.whiteF2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        shadows: const [
          BoxShadow(
            color: AppColor.background,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Image(
                image: AssetImage(activity.iconActivity),
                //height: 20,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: RichText(
                    text: TextSpan(
                        text: activity.nameActivity,
                        style: StyleOfit.textStyleFW500(AppColor.black22, 16)),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  //textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
