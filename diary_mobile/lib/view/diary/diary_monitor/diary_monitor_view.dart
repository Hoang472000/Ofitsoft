import 'package:diary_mobile/resource/assets.dart';
import 'package:diary_mobile/view/diary/diary_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/repository.dart';
import '../../../../resource/color.dart';
import '../../../../resource/style.dart';
import '../../../../utils/utils.dart';
import '../../../../utils/widgets/dashed_circle.dart';
import '../../../utils/constants/shared_preferences.dart';
import '../../../utils/constants/shared_preferences_key.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../../view_model/diary/diary_monitor_bloc.dart';
import '../../filter/filter_page.dart';
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

  //late TabController _tabController;
  bool _tabControllerInitialized = false;

  bool isFilterOpen = false;

  void openFilter() {
    setState(() {
      isFilterOpen = true;
    });
  }

  void closeFilter() {
    setState(() {
      isFilterOpen = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //_tabController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_initializeTabController();
  }

  Future<void> _initializeTabController() async {
    int tabLength = await calculateLength();
    print("HoangCV: tabLength : ${tabLength}");
  /*  _tabController = TabController(vsync: this, length: tabLength);
    setState(() {
      _tabControllerInitialized = true;
    });*/
    // Không cần return ở đây.
  }

  Future<int> calculateLength() async {
    List<bool> check = await SharedPreDiary.getRole();
    int count = 0;
    //for(int i = 0 ; i < 3; i++){
      if(check[0]){
        count++;
      }
      if(check[2]){
        count++;
      }
    //}
    print("HoangCV: count: ${count}");
    // Trường hợp mặc định, bạn có thể trả về một giá trị khác nếu cần.
    return count;
  }

  void _handleTabIndex() {
/*    if (_tabController.index != 1) {
      enableAdd = false;
    } else {
      if (isOpening) enableAdd = true;
    }*/
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      DiaryMonitorBloc(context.read<Repository>())
        ..add(GetDiaryMonitorEvent()),
      child: BlocBuilder<DiaryMonitorBloc, DiaryMonitorState>(
        builder: (context, state) {
          return state.isShowProgress /*|| !_tabControllerInitialized*/
              ? const Center(
            child: DashedCircle(
                size: 39, stringIcon: IconAsset.icLoadOtp),
          ) : Stack(
            children: [
              Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: AppColor.background,
                  appBar: OfitAppBar(context,
                      centerTitle: true,
                      showDefaultBackButton: false,
                      title: Text(
                        "Nhật ký ghi hộ",
                        style: StyleOfit.textStyleFW700(Colors.white, 20),
                      ),
                      //backgroundColor: AppColor.background,
                      actions: [
                        IconButton(
                          //padding: EdgeInsets.only(left: 4, right: 16),
                          icon: SvgPicture.asset(IconAsset.icFilter/*, color: Colors.white,*/),
                          onPressed: () {
                            openFilter();
                          },
                        ),
                      ],
                      hasBottom: true,
                    bottom: /*_tabControllerInitialized
                        ? TabBar(
                      controller: _tabController ?? TabController(length: 0, vsync: this),
                      indicatorWeight: 4,
                      indicatorColor: AppColor.yellowFE,
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor: Colors.white,
                      labelColor: AppColor.yellowFE,
                      tabs: (state.listActivityFarm ?? []).map((element) {
                        return Tab(text: element.nameActivity);
                      }).toList(),
                    )
                        : */null, // Set to null when _tabController is not initialized.

                  ),
                  body: BlocBuilder<DiaryMonitorBloc, DiaryMonitorState>(
                    builder: (context, state) {
                      return state.isShowProgress /*|| !_tabControllerInitialized*/
                          ? const Center(
                        child: DashedCircle(
                            size: 39, stringIcon: IconAsset.icLoadOtp),
                      )
                          : /*_tabControllerInitialized ? TabBarView(
                        controller: _tabController ?? TabController(vsync: this, length: 0),
                        children: state.listActivityFarm.map((element) {
                          return */DiaryMonitorChild(
                           // diary: /*element.action == 'farmer' ? state.listFarmerDiary :
                           // element.action == 'record' ? */state.listBackupDiary /*: state.listMonitorDiary*/,
                            //action: /*element.action*/"record",
                          );
                        /*}).toList(),*//*<Widget>[
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
                        ],*/
                     // ): SizedBox();
                    },
                  )),
              if (isFilterOpen)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color: Colors.black.withOpacity(0.5),
                  child: GestureDetector(
                    onTap: () {
                      closeFilter();
                    },
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),

              // Sliding filter screen
              AnimatedPositioned(
                duration: const Duration(milliseconds: 700),
                left: isFilterOpen ? MediaQuery.of(context).size.width * 0.1 : MediaQuery.of(context).size.width,
                top: 0,
                bottom: 0,
                width: MediaQuery.of(context).size.width * 0.9,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1.0, 0.0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: ModalRoute.of(context)!.animation!,
                    curve: Curves.ease,
                  )),
                  child: FilterPage(
                    list: state.listBackupDiary,
                    type: "diary",
                    onClose: closeFilter,
                    callBack: (dynamic){

                    },
                    // Other parameters you might need to pass
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
