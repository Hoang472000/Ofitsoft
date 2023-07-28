import 'package:diary_mobile/resource/assets.dart';
import 'package:diary_mobile/view/diary/diary_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/entity/diary/diary.dart';
import '../../../data/repository.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../../view_model/diary_activity/activity/activity_bloc.dart';
import '../../../view_model/diary_activity/activity/info_diary_bloc.dart';
import '../../diary_activity/activity/activity_page.dart';
import '../../diary_activity/infomation_diary/info_diary_page.dart';

class DetailDiaryPage extends StatefulWidget {
  const DetailDiaryPage({super.key, required this.seasonFarmId});
  final int seasonFarmId;

  @override
  _DetailDiaryPageState createState() => _DetailDiaryPageState();

  static Route route(int seasonFarmId) {
    return Utils.pageRouteBuilder(DetailDiaryPage(seasonFarmId: seasonFarmId,), true);
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
        children: <Widget>[
          ActivityPage(
            action: "activity", seasonFarmId: widget.seasonFarmId,
          ),
          ActivityPage(
            action: "monitor", seasonFarmId: widget.seasonFarmId,
          ),
          InfoDiaryPage(id: widget.seasonFarmId,)
        ],
      ),
    );
  }
}
