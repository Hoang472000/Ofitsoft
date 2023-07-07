import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/l10n.dart';
import '../../resource/assets.dart';
import '../../resource/color.dart';
import '../../resource/style.dart';
import '../../utils/utils.dart';
import '../../view_model/home_bloc.dart';
import '../diary/diary_view.dart';
import '../notify/notify_view.dart';
import '../quetma/quet_qr_view.dart';
import '../setting/setting_view.dart';
import 'home_view.dart';


class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  static Future<Route> route() async {
    return Utils.pageRouteBuilder(const HomePage(), false);
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int currentTab = 0;
  final List<Widget> screens = [
    const HomeView(), //const Page1(),
    const DiaryView(), // page ban hang const Page2(),
    const QRCodeView(), // page mua hang Page3(),
    const NotifyView(), //const Page4(),
    const SettingView(), //const Page5(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeView();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentScreen.toString() == "HomeView") {
          SystemNavigator.pop();
          return true;
        } else {
          setState(() {
            currentScreen = const HomeView();
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
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColor.green99,
            child: SvgPicture.asset(IconAsset.icBarCode,height: 30,width: 30,),
            onPressed: () {
              setState(() {
                Navigator.of(context).push(QRCodeView.route());
              });
            },
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
                          currentScreen = const HomeView();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(IconAsset.icHome),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            S.of(context).home_label,
                            style: StyleBkav.textStyleFW500(Colors.grey, 10,
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
                          currentScreen = const DiaryView();
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(IconAsset.icSelll),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            "Nhật ký",
                            style: StyleBkav.textStyleFW500(Colors.grey, 10,
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
                          "Quét mã",
                          style: StyleBkav.textStyleFW500(Colors.grey, 10,
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
                            SvgPicture.asset(IconAsset.icNotifi),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              S.of(context).notify_label,
                              style: StyleBkav.textStyleFW500(Colors.grey, 10,
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
                            SvgPicture.asset(IconAsset.icSetTing, color: Colors.grey,),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              S.of(context).setting,
                              style: StyleBkav.textStyleFW500(Colors.grey, 10,
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
