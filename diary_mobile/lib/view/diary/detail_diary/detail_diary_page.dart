import 'package:diary_mobile/resource/assets.dart';
import 'package:diary_mobile/view/diary/diary_view.dart';
import 'package:flutter/material.dart';

import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../diary_activity/activity/activity_page.dart';
import '../../diary_activity/infomation_activity/infomation_activity_page.dart';

class DetailDiaryPage extends StatefulWidget {
  @override
  _DetailDiaryPageState createState() => _DetailDiaryPageState();

  static Route route() {
    return Utils.pageRouteBuilder(DetailDiaryPage(), true);
  }
}

class _DetailDiaryPageState extends State<DetailDiaryPage>
    with SingleTickerProviderStateMixin {
  int diaryId = 0;
  bool isOpening = true;
  bool enableAdd = true;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    _tabController.animateTo(0);
    //_tabController.addListener(_handleTabIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

/*  void _handleTabIndex() {
    if (_tabController.index != 1){
      enableAdd = false;
    }
    else{
      if (isOpening) enableAdd = true;
    }
    setState(() {});
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BkavAppBar(context,
          centerTitle: true,
          hasBottom: true,
          showDefaultBackButton: true,
          title: Text(
            "Thông tin nhật ký",
            style: StyleBkav.textStyleFW700(Colors.white, 20),
          ),
          backgroundColor: AppColor.background,
          bottom: TabBar(
              /*     indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // Creates border
                  color: Colors.white),
              labelColor: AppColor.main,*/
              controller: _tabController,
              tabs: const <Tab>[
                Tab(
                    icon: Image(
                      image: AssetImage(ImageAsset.imageActivityFarm),
                      width: 40,
                      fit: BoxFit.contain,
                    ),
                    text: "Hoạt động", height: 80,),
                Tab(
                    icon: Image(
                      image: AssetImage(ImageAsset.imageSpyware),
                      width: 40,
                      fit: BoxFit.contain,
                    ),
                    text: "Giám sát"),
                Tab(
                    icon: Image(
                      image: AssetImage(ImageAsset.imageFile),
                      width: 40,
                      fit: BoxFit.contain,
                    ),
                    text: "Thông tin chung")
              ])),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          ActivityPage(
            action: "activity",
          ),
          ActivityPage(
            action: "monitor",
          ),
          InfomationActivityPage()
        ],
      ),
    );
  }
}
