import 'package:diary_mobile/resource/assets.dart';
import 'package:diary_mobile/view/diary/diary_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/repository.dart';
import '../../../../resource/color.dart';
import '../../../../resource/style.dart';
import '../../../../utils/utils.dart';
import '../../../../utils/widgets/dashed_circle.dart';
import '../../../utils/constants/shared_preferences_key.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../../view_model/diary/diary_monitor_bloc.dart';
import 'diary_monitor_child_page.dart';

class DiaryMonitorView extends StatefulWidget {
  const DiaryMonitorView({super.key});

  @override
  _DiaryMonitorViewState createState() => _DiaryMonitorViewState();

  static Route route() {
    return Utils.pageRouteBuilder(const DiaryMonitorView(), true);
  }
}

class _DiaryMonitorViewState extends State<DiaryMonitorView>
    with SingleTickerProviderStateMixin {
  int diaryId = 0;
  bool isOpening = true;
  bool enableAdd = true;

  late TabController _tabController;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    //_tabController.animateTo(0);
    //_tabController.addListener(_handleTabIndex);
    //checkUser(context);
    //Navigator.push(context, DiaryView.route());
  }

  void _handleTabIndex() {
    if (_tabController.index != 1) {
      enableAdd = false;
    } else {
      if (isOpening) enableAdd = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiaryMonitorBloc(context.read<Repository>())
        ..add(GetDiaryMonitorEvent()),
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColor.background,
          appBar: OfitAppBar(context,
              centerTitle: true,
              showDefaultBackButton: false,
              title: Text(
                "Danh sách nhật ký",
                style: StyleOfit.textStyleFW700(Colors.white, 20),
              ),
              //backgroundColor: AppColor.background,
              actions: [],
              hasBottom: true,
              bottom: TabBar(
                  controller: _tabController,
                  indicatorWeight: 4,
                  indicatorColor: AppColor.yellowFE,
                  indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelColor: Colors.white,
                  labelColor: AppColor.yellowFE,
                  tabs: const <Tab>[
                    Tab(text: "Nông hộ"),
                    Tab(text: "Ghi hộ"),
                    Tab(text: "Giám sát")
                  ])),
          body: BlocBuilder<DiaryMonitorBloc, DiaryMonitorState>(
            builder: (context, state) {
              return state.isShowProgress
                  ? const Center(
                      child: DashedCircle(
                          size: 39, stringIcon: IconAsset.icLoadOtp),
                    )
                  : TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        DiaryMonitorChild(
                          diary: state.listFarmerDiary,
                          action: "farmer",
                        ),
                        DiaryMonitorChild(
                          diary: state.listBackupDiary,
                          action: "record",
                        ),
                        DiaryMonitorChild(
                          diary: state.listMonitorDiary,
                          action: "monitor",
                        ),
                      ],
                    );
            },
          )),
    );
  }
}
