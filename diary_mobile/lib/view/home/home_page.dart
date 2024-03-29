import 'dart:convert';

import 'package:diary_mobile/view/home/home_record_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';
import '../../resource/assets.dart';
import '../../resource/color.dart';
import '../../resource/style.dart';
import '../../utils/constants/shared_preferences.dart';
import '../../utils/constants/shared_preferences_key.dart';
import '../../utils/utils.dart';
import '../../view_model/home_bloc.dart';
import '../diary/diary_monitor/diary_monitor_child_page.dart';
import '../diary/diary_monitor/diary_monitor_view.dart';
import '../diary/diary_view.dart';
import '../notify/notify_view.dart';
import '../quetma/quet_qr_view.dart';
import '../setting/setting_view.dart';
import 'home_view.dart';


class HomePage extends StatefulWidget {
  HomePage({
    Key? key, this.crScreen = 0
  }) : super(key: key);

  int crScreen = 0;
  static Future<Route> route({int crScreen = 0}) async {
    return Utils.pageRouteBuilder(HomePage(crScreen: crScreen), false);
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int currentTab = 0;
  late List<Widget> screens = [];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeView();
  bool checkMonitor = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser(context);
    print("HoangCV: ${currentScreen} : ${screens} : ${widget.crScreen}");
  }

  void checkUser(BuildContext context) async {
    bool checkFarmer = true;
    bool checkReport = false;
    bool checkPurchase = false;
    List<bool> check = await SharedPreDiary.getRole();
    checkReport = check[3];
    checkPurchase = check[4];
    bool isAllTrueExceptFirst = check[0] == true &&
        check.skip(1).every((element) => element == false);
    bool isAllFalse = check.every((element) => element == false);
    bool is3False = check[0] || check[1] || check[2];
    if (isAllTrueExceptFirst) {
      checkFarmer = true;
    }
    if (!isAllTrueExceptFirst) {
      checkFarmer = false;
      setState(() {
        checkMonitor = true;
      });
    }
    if(isAllFalse){
      checkFarmer = true;
      setState(() {
        checkMonitor = false;
      });
    }
    if(!is3False){
      //checkFarmer = true;
      setState(() {
        checkMonitor = false;
      });
    }

    print("HoangC: check: $check : ${isAllTrueExceptFirst} : ${isAllFalse} : ${checkReport} : ${checkFarmer}");
    if (checkFarmer) {
      screens = [
        const HomeView(), //const Page1(),
        const DiaryView(), // page ban hang const Page2(),
        const QRCodeView(), // page mua hang Page3(),
        const NotifyView(), //const Page4(),
        const SettingView(), //const Page5(),
      ];
    } else if(checkPurchase || checkReport){
      if(!is3False) {
        print("HoangCV: aor ma 1111");
        screens = [
          const HomeRecordView(), //const Page1(),
          const DiaryView(), // page ban hang const Page2(),
          const QRCodeView(), // page mua hang Page3(),
          const NotifyView(), //const Page4(),
          const SettingView(), //const Page5(),
        ];
      } else{
        print("HoangCV: aor ma");
        screens = [
          const HomeRecordView(), //const Page1(),
          const DiaryMonitorChild(), // page ban hang const Page2(),
          const QRCodeView(), // page mua hang Page3(),
          const NotifyView(), //const Page4(),
          const SettingView(), //const Page5(),
        ];
      }
    } else {
      print("HoangCV: aor ma 1111 121312");
      screens = [
        const HomeView(), //const Page1(),
        const DiaryMonitorChild(), // page ban hang const Page2(),
        const QRCodeView(), // page mua hang Page3(),
        const NotifyView(), //const Page4(),
        const SettingView(), //const Page5(),
      ];
    }
    setState(() {
      currentScreen = screens[widget.crScreen];
      currentTab = widget.crScreen;
    });
    print("HoangCV112123: ${currentScreen} : ${screens} : ${widget.crScreen}");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentScreen.toString() == "HomeView" || currentScreen.toString() == "HomeRecordView") {
          SystemNavigator.pop();
          return true;
        } else {
          setState(() {
            currentScreen = screens[0];
            currentTab = 0;
          });
          return false;
        }
      },
      child: BlocProvider(
        create: (context) =>
            HomeBloc(context),
        child: Scaffold(
          body: PageStorage(
            bucket: bucket,
            child: currentScreen,
          ),
          floatingActionButton: Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
            child: FloatingActionButton(

              //backgroundColor: AppColor.green99,
              elevation: 0,
              child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColor.main, AppColor.green99], // Đặt 2 màu ở đây
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: SizedBox(
                        height: 30,width: 30,
                        child: SvgPicture.asset(IconAsset.icBarCode, fit: BoxFit.contain,)),
                  )),
              onPressed: () {
                setState(() {
                  Navigator.of(context).push(QRCodeView.route());
                });
              },
            ),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 3,
            child: SizedBox(
              // decoration: const BoxDecoration(
              //   color: Colors.white,
              //   image: DecorationImage(
              //       image: AssetImage(ImageAsset.navigationBar), fit: BoxFit.cover),
              // ),
              height: 62,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          currentScreen = screens[0];
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(IconAsset.icHome2, color: AppColor.black22,),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            S.of(context).home_label,
                            style: StyleOfit.textStyleFW500(AppColor.black22, 12,
                                overflow: TextOverflow.ellipsis),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            height: 3,
                            width: 50,
                            color: currentTab == 0 ? AppColor.main : null,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {

                        setState(() {
                          currentScreen =  checkMonitor ? const DiaryMonitorChild() : const DiaryView();
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(IconAsset.icNotebook, color: AppColor.black22,),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            S.of(context).diary,
                            style: StyleOfit.textStyleFW500(AppColor.black22, 12,
                                overflow: TextOverflow.ellipsis),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            height: 3,
                            width: 50,
                            color: currentTab == 1 ? AppColor.main : null,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 27,
                        ),
                        Text(
                          "",
                          style: StyleOfit.textStyleFW500(AppColor.black22, 12,
                              overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          height: 3,
                          width: 50,
                          color: currentTab == 2 ? AppColor.main : null,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentScreen = const NotifyView();
                            currentTab = 3;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(IconAsset.icBell, color: AppColor.black22,),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              S.of(context).notify_label,
                              style: StyleOfit.textStyleFW500(AppColor.black22, 12,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Container(
                              height: 3,
                              width: 50,
                              color: currentTab == 3 ? AppColor.main : null,
                            )
                          ],
                        ),
                      )),
                  Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentScreen = const SettingView();
                            currentTab = 4;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(IconAsset.icSetTing, color: AppColor.black22,),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              S.of(context).setting,
                              style: StyleOfit.textStyleFW500(AppColor.black22, 12,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Container(
                              height: 3,
                              width: 50,
                              color: currentTab == 4 ? AppColor.main : null,
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
