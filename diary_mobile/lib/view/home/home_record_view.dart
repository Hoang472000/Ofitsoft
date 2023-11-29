import 'dart:async';

import 'package:diary_mobile/view/access_origin/access_origin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resource/assets.dart';
import '../../resource/color.dart';
import '../../resource/style.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/bkav_app_bar.dart';
import '../../utils/widgets/dialog/dialog_manager.dart';
import '../../view_model/home_bloc.dart';
import '../diary_activity/activity_sell/activity_purchase_page.dart';
import '../manager/manager_page.dart';
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
  final ScrollController _scrollBottomBarController = ScrollController();
  bool isScrollingDown = false;
  double bottomBarHeight = 75;

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
  @override
  Widget build(BuildContext context) {
    //print("runqay Home record view");
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Scaffold(
        //backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: _showAppbar ? OfitAppBar(
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
        ),
        body: Utils.bkavCheckOrientation(
            context,
            FractionallySizedBox(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          opacity: 1,
                          image: AssetImage(
                              ImageAsset.imageOfitSoftBackground),
                          fit: BoxFit.fill),
                    ), ),
                     SingleChildScrollView(
                         controller: _scrollBottomBarController,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          //height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              SizedBox(height: 80,),
                              Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 14),
                                  //color: const Color(0xFFEFF2F5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 12.0),
                                        child: Text(
                                          "OFITSOFT xin chào",
                                          style: StyleOfit.textStyleFW600(Colors.orange, 16),
                                        ),
                                      ),
                                      Text(
                                        "Chúc bạn một ngày làm việc hiệu quả",
                                        style: StyleOfit.textStyleFW400(Colors.black, 14),
                                      ),
                                    ],
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                margin: const EdgeInsets.only(left: 24.0, right: 24),
                                //height: 80,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: state.listActivityFarm.map((activity) {
                                    return GestureDetector(
                                      onTap: () {
                                        if(activity.id == 1){
                                          Navigator.push(context, ManagerPage.route());
                                        } else if(activity.id == 2){
                                          Navigator.push(context, AccessOriginPage.route());
                                        } else if(activity.id == 3){
                                          Navigator.push(context, FeedbackPage.route());
                                        } else if(activity.id == 4){
                                          Navigator.push(context, ListPDFPage.route());
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image(
                                              image: AssetImage(activity.iconActivity),
                                              width: 34,
                                              fit: BoxFit.contain,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                activity.nameActivity,
                                                style: StyleOfit.textStyleFW500(
                                                  AppColor.main,
                                                  12,
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
                                  }).toList(),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 8, right: 8, top: 16,),
                                width: double.infinity,
                                height: 130,
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
                                      padding: const EdgeInsets.only(left: 16, right: 16.0), // Khoảng cách giữa các item
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
                              Center(
                                child: Container(
                                  //height: double.infinity,
                                  //color: AppColor.background,
                                  margin: EdgeInsets.only(top: 16),
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
                                                    StyleOfit.textStyleFW600(Colors.white, 22),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                        )),

                ],
              ),
            )),
      );
    });
  }
}
