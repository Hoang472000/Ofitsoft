import 'dart:convert';

import 'package:diary_mobile/view/diary_activity/activity/activity_page.dart';
import 'package:diary_mobile/view/diary_activity/infomation_diary/info_diary_page.dart';
import 'package:diary_mobile/view/diary_activity/infomation_diary/workflow_page.dart';
import 'package:diary_mobile/view/home/home_record_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/entity/activity/activity_diary.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../data/repository.dart';
import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/constants/shared_preferences.dart';
import '../../../utils/utils.dart';
import '../../../view_model/diary_activity/activity/info_diary_bloc.dart';
import '../activity/activity_harvesting_page.dart';

class InfoDiaryView extends StatefulWidget {
  const InfoDiaryView({
    Key? key,required this.id, required this.diary
  }) : super(key: key);
  
  final int id;
  final Diary diary;
  
  static Future<Route> route(int id, Diary diary) async {
    return Utils.pageRouteBuilder(InfoDiaryView(id: id,diary: diary,), false);
  }

  @override
  State<InfoDiaryView> createState() => _InfoDiaryViewState();
}

class _InfoDiaryViewState extends State<InfoDiaryView> with TickerProviderStateMixin {
  int currentTab = 0;
  late List<Widget> screens = [];
  final PageStorageBucket bucket = PageStorageBucket();
  bool checkMonitor = false;
  late Widget currentScreen;
  List<ActivityDiary> listActivity = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentScreen = ActivityPage(
        action: "activity",
        seasonFarmId: widget.id,
        activityFarm: ActivityFarm(
            id: 1,
            nameActivity: "Hoạt động canh tác",
            iconActivity: ImageAsset.imageActivityFarm),
        diary: widget.diary,
        listActivity: listActivity,
        onListActivityChanged: (_) {});
    checkUser(context);
  }

  void checkUser(BuildContext context) async {
    listActivity = await context.read<Repository>().getListActivityDiary(widget.id);
      screens = [
        ActivityPage(action: "activity", seasonFarmId: widget.id, activityFarm: ActivityFarm(
            id: 1,
            nameActivity: "Hoạt động canh tác",
            iconActivity: ImageAsset.imageActivityFarm), diary: widget.diary, listActivity: listActivity,
          onListActivityChanged: (updatedListActivity) {
            print("HoangC:V :111 listActivity : ${listActivity.length}");
            setState(() {
              listActivity = updatedListActivity;
              print("HoangC:V222 : listActivity : ${listActivity.length}");
            });
          },),
        ActivityHarvestingPage(action: "harvesting", seasonFarmId: widget.id, activityFarm: ActivityFarm(
            id: 2,
            nameActivity: "Hoạt động thu hoạch",
            iconActivity: ImageAsset.imageActivityFarm), diary: widget.diary, listActivity: listActivity,
          onListActivityChanged: (updatedListActivity) {
            setState(() {
              listActivity = updatedListActivity;
            });
          },),
        InfoDiaryPage(id: widget.id, diary: widget.diary), //const Page1(),
        WorkflowPage(id: widget.diary.productProcessId ?? -1), // page ban hang const Page2(),//const Page5(),
      ];
      currentScreen = screens[0];

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentScreen.toString() == "ActivityPage" || currentScreen.toString() == "ActivityPage") {
          Navigator.pop(context);
          return true;
        } else {
          setState(() {
            currentScreen = screens[0];
            currentTab = 0;
          });
          return false;
        }
      },
      child:
        Scaffold(
          body: PageStorage(
            bucket: bucket,
            child: currentScreen,
          ),
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
                          currentScreen = ActivityPage(action: "activity", seasonFarmId: widget.id, activityFarm: ActivityFarm(
                              id: 1,
                              nameActivity: "Hoạt động canh tác",
                              iconActivity: ImageAsset.imageActivityFarm), diary: widget.diary, listActivity: listActivity,
                            onListActivityChanged: (updatedListActivity) {
                              print("HoangC:V :111 listActivity : ${listActivity.length}");
                              setState(() {
                                listActivity = updatedListActivity;
                                print("HoangC:V222 : listActivity : ${listActivity.length}");
                              });
                            },);
                          currentTab = 0;
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
                            /*S.of(context).home_label*/"Canh tác",
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
                          currentScreen = ActivityHarvestingPage(action: "harvesting", seasonFarmId: widget.id, activityFarm: ActivityFarm(
                              id: 2,
                              nameActivity: "Hoạt động thu hoạch",
                              iconActivity: ImageAsset.imageActivityFarm), diary: widget.diary, listActivity: listActivity,
                            onListActivityChanged: (updatedListActivity) {
                              setState(() {
                                listActivity = updatedListActivity;
                              });
                            },);
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(IconAsset.icPurchase, color: AppColor.black22,),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            "Thu hoạch",
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
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentScreen = screens[2];
                            currentTab = 2;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(IconAsset.icMenu, color: AppColor.black22,),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              /*S.of(context).notify_label*/"Thông tin chi tiết",
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
                      )),
                  Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentScreen = screens[3];
                            currentTab = 3;
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
                              "Quy trình",
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
                      ))
                ],
              ),
            ),
          ),
        ),
    );
  }
}
