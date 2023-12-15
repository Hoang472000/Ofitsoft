import 'dart:async';

import 'package:create_atom/create_atom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';
import '../../resource/assets.dart';
import '../../resource/color.dart';
import '../../resource/style.dart';
import '../../utils/constants/shared_preferences_key.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/bkav_app_bar.dart';
import '../../utils/widgets/dialog/dialog_manager.dart';
import '../../view_model/diary_activity/activity/info_diary_bloc.dart';
import '../../view_model/home_bloc.dart';
import '../access_origin/access_origin_page.dart';
import '../diary_activity/activity/activity_transaction_page.dart';
import '../diary_activity/activity_sell/activity_purchase_page.dart';
import '../diary_activity/record_diary/add_record_diary.dart';
import '../manager/manager_page.dart';
import '../report/add_report_view.dart';
import '../report/list_report_result_view.dart';
import '../setting/contact/contact_page.dart';
import '../setting/feedback/feedback_page.dart';
import '../setting/mananger/list_pdf_page.dart';
import 'dart:math' as math;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController(initialPage: 0,
    viewportFraction: 1,);
  int _currentPage = 0;
  final int _totalPages = 5;
  Timer? _timer;
  bool _showAppbar = true;
  final ScrollController _scrollBottomBarController = ScrollController();
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
    _scrollBottomBarController.removeListener(() {});
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
    _scrollBottomBarController.addListener(() {
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
        }
      }
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
        }
      }
    });
  }

  Widget build(BuildContext context) {
    //print("runqay Home record view");
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Scaffold(
        //backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        /*appBar: _showAppbar ? OfitAppBar(
          context,
          centerTitle: true,
          showDefaultBackButton: false,
          title: Text(
            "Trang chủ",
            style: StyleOfit.textStyleFW700(AppColor.main, 20),
          ),
          backgroundColor: Colors.transparent,
          flexibleSpace: SizedBox(),
          hasBottom: true,
          actions: [],
        )
            : PreferredSize(
          child: Container(),
          preferredSize: Size(0.0, 0.0),
        ),*/
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
                      //color: const Color(0xFFEFF2F5),
                      child: Row(
                        children: [
                          /*SizedBox(
                          width: MediaQuery.of(context).size.width / 20 + MediaQuery.of(context).size.width / 3.5,
                        ),*/
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
                                    style: StyleOfit.textStyleFW600(Colors.black, 16),
                                  ),
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    atomBackground(),
                                    Container(
                                      padding: EdgeInsets.all(MediaQuery.sizeOf(context).width/23),
                                      child: GridView.builder(
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: MediaQuery.sizeOf(context).width/23,
                                          mainAxisSpacing: MediaQuery.sizeOf(context).width/23,
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
                                    //atomBackground(),
                                  ],
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

  Widget atomBackground(){
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.sizeOf(context).width/2.5,
        height: MediaQuery.sizeOf(context).width/2.5,
        color: Colors.transparent,
        child: Atom(
          size: MediaQuery.sizeOf(context).width/2.5,
          nucleusRadiusFactor: 3.5,
          orbitsWidthFactor: 2.0,

          orbit1Angle: math.pi / 2,
          orbit2Angle: math.pi / 6,
          orbit3Angle: - math.pi / 6,

          orbitsColor: AppColor.green2.withOpacity(0.3),
          electronsColor: AppColor.main.withOpacity(0.3),
          nucleusColor: AppColor.green2.withOpacity(0.3),

          animDuration1: Duration(seconds: 3),
          animDuration2: Duration(seconds: 4),
          animDuration3: Duration(seconds: 6),
          centerWidget: Container(),
        ),
      ),
    );
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
        shadows: [
          BoxShadow(
            color: AppColor.background,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(activity.iconActivity),
              width: 40,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                activity.nameActivity,
                style: StyleOfit.textStyleFW500(
                  AppColor.main,
                  16,
                  overflow: TextOverflow.visible,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
