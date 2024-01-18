import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/monitor/monitor_diary.dart';
import 'package:diary_mobile/utils/status/form_submission_status.dart';
import 'package:diary_mobile/utils/widgets/empty_widget.dart';
import 'package:diary_mobile/utils/widgets/view_page_widget.dart';
import 'package:diary_mobile/view/diary_activity/activity/detail_activity.dart';
import 'package:diary_mobile/view/diary_activity/monitor/add_monitor.dart';
import 'package:diary_mobile/view_model/diary_activity/activity/activity_bloc.dart';
import 'package:diary_mobile/view_model/diary_activity/activity/info_diary_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../data/repository.dart';
import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/ofit_app_bar.dart';
import '../../../utils/widgets/dashed_circle.dart';
import '../../../utils/widgets/dialog/dialog_manager.dart';
import '../../../utils/widgets/items/item_activity_avatar.dart';
import '../../filter/filter_page.dart';
import '../../report/add_report.dart';
import '../monitor/detail_monitor_page.dart';
import 'add_activity.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage(
      {super.key,
      required this.action,
      required this.seasonFarmId,
      required this.activityFarm,
      required this.diary,
      required this.listActivity,
      required this.onListActivityChanged
      });

  final String action;
  final ActivityFarm activityFarm;
  final int seasonFarmId;
  final Diary diary;
  final List<ActivityDiary> listActivity;
  final Function(List<ActivityDiary>) onListActivityChanged;

  @override
  _ActivityPageState createState() => _ActivityPageState();

  static Route route(String action, int seasonFarmId, Diary diary,
      ActivityFarm activityFarm, List<ActivityDiary> listActivity,
      Function(List<ActivityDiary>) onListActivityChanged) {
    return Utils.pageRouteBuilder(
        ActivityPage(
          activityFarm: activityFarm,
          action: action,
          seasonFarmId: seasonFarmId,
          diary: diary,
          listActivity: listActivity,
            onListActivityChanged: onListActivityChanged
        ),
        true);
  }
}

class _ActivityPageState extends State<ActivityPage> {
  bool visible = true;
  OverlayEntry? _overlayEntry;
  bool updateHarvesting = false;
  List<ActivityDiary> listCallback = const [];
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
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.action.compareTo('activity') == 0 || widget.action.compareTo('monitor') == 0 || widget.action.compareTo('harvesting') == 0 || widget.action.compareTo('report') == 0){
      setState(() {
        visible = true;
      });
    } else{
      setState(() {
        visible = false;
      });
    }
    //_initView();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivityBloc(context.read<Repository>())
        ..add(GetListActivityEvent(widget.seasonFarmId, widget.action, false, widget.listActivity, [], (_){}, first: true)),
      child: Stack(
        children: [
          Scaffold(
            appBar: OfitAppBar(context,
              centerTitle: true,
              hasBottom: true,
              showDefaultBackButton: true,
              callback: [updateHarvesting, listCallback],
              actions: [
                IconButton(
                  icon: SvgPicture.asset(IconAsset.icFilter),
                  onPressed: () {
                    openFilter();
                  },
                ),],
              title: Text(
                widget.activityFarm.nameActivity,
                style: StyleOfit.textStyleFW700(Colors.white, 20),
              )),
            //resizeToAvoidBottomInset: true,
            backgroundColor: AppColor.background,
            floatingActionButton: BlocBuilder<ActivityBloc, ActivityState>(
              builder: (contextBloc, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: visible,
                      child: floatingActionButton(
                          "", Icons.add,   (widget.diary.status??'').compareTo("done") == 0 ||
                          (widget.diary.status??'').compareTo("cancelled") == 0 ?
                          () {
                        print("HoangCV: bug:Asdas : ${widget.diary.status}");
                        if((widget.diary.status??'').compareTo("done") == 0 ) {
                          DiaLogManager.displayDialog(context,
                              "Nhật ký đã hoàn thành","Bạn không thể thêm mới hoạt động",
                                  (){Navigator.pop(context);}, () {
                                print("HoangCV: bug:Asdas");
                              },
                              "",S.of(context).close_dialog);
                        }
                        if((widget.diary.status??'').compareTo("cancelled") == 0 ) {
                          DiaLogManager.displayDialog(context,
                              "Nhật ký đã đóng","Bạn không thể thêm mới hoạt động",
                                  (){Navigator.pop(context);}, () {},
                              "",S.of(context).close_dialog);
                        }
                      }
                          : () async {
                          var result = widget.action.compareTo(
                              "activity") == 0 || widget.action.compareTo(
                              "harvesting") == 0
                              ? await Navigator.of(context)
                              .push(AddActivityPage.route(
                              widget.seasonFarmId, widget.diary, widget.action))
                              : await Navigator.of(context).push(
                              AddMonitorPage.route());
                          if (result != null && result[0]) {
                            if(result[1]){
                              setState(() {
                                updateHarvesting = result[1];
                              });
                            }
                            contextBloc.read<ActivityBloc>().add(
                                GetListActivityEvent(
                                    widget.seasonFarmId, widget.action,
                                    result[1], [], [], (listCallback){
                                      widget.onListActivityChanged(listCallback);}));
                          }
                        }),
                    ),
                  ],
                );
              },
            ),
            body: HomeBackGround(
              children: [
                BlocConsumer<ActivityBloc, ActivityState>(
                    listener: (blocContext, state) async {
                  final formStatus = state.formStatus;
                  if(!state.isShowProgress){
                    setState(() {
                      listCallback = state.listCallback;
                    });
                  }
                  if (formStatus is SubmissionFailed) {
                    DiaLogManager.displayDialog(context, "", formStatus.exception, () {
                      Get.back();
                    }, () {
                      Get.back();
                    }, '', S.of(context).close_dialog);
                  } else if (formStatus is SubmissionSuccess) {
                    DiaLogManager.displayDialog(context, "", formStatus.success ?? "",
                        () {
                      Get.back();
                    }, () {
                      Get.back();
                    }, '', S.of(context).close_dialog);
                  } else if (formStatus is FormSubmitting) {
                    //DiaLogManager.showDialogLoading(context);
                  }
                }, builder: (blocContext, state) {
                  return state.isShowProgress /*&& (state.listDiaryActivity.length == 0 || state.listDiaryMonitor.length == 0)*/
                      ? Padding(
                    padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height/3),
                          child:
                              DashedCircle(size: 39, stringIcon: IconAsset.icLoadOtp),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            blocContext.read<ActivityBloc>().add(GetListActivityEvent(
                                widget.seasonFarmId, widget.action, false, [], [], (_){}));
                          },
                          child: ((widget.action.compareTo('activity') == 0 || widget.action.compareTo('harvesting') == 0 || widget.action.compareTo('sell') == 0) && state.listDiaryActivity.isEmpty) ||
                              ((widget.action.compareTo('monitor') == 0  || widget.action.compareTo('report') == 0) && state.listDiaryMonitor.isEmpty)
                              ? const EmptyWidget()
                              : SingleChildScrollView(
                            //physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                ListView.builder(
                                  itemCount: widget.action.compareTo('activity') == 0 || widget.action.compareTo('harvesting') == 0 ||widget.action.compareTo('sell') == 0
                                      ? state.listDiaryActivity.length
                                      : state.listDiaryMonitor.length,
                                  itemBuilder: (BuildContext contextBloc, int index) {
                                    return ItemActivityAvatar(
                                        diary: widget.diary,
                                        activityDiary: widget.action.compareTo('activity') == 0 || widget.action.compareTo('harvesting') == 0 ||widget.action.compareTo('sell') == 0 ? state.listDiaryActivity[index] : ActivityDiary(),
                                        monitorDiary: widget.action.compareTo('monitor') == 0  || widget.action.compareTo('report') == 0 ? state.listDiaryMonitor[index] : MonitorDiary(),
                                        action: widget.action,
                                        callbackChooseItem: () async {
                                          //Truyen id de sang man ben goi api hoac DB
                                          print("HoangCV: state.listDiaryActivity[index]: ${state.listDiaryActivity[index].toJson()}");
                                          if (widget.action.compareTo('activity') == 0 || widget.action.compareTo('harvesting') == 0 ||widget.action.compareTo('sell') == 0) {
                                            var result = await Navigator.push(
                                                context,
                                                DetailActivityPage.route(
                                                    state.listDiaryActivity[index],
                                                    widget.diary));
                                            if (result != null && result[0]) {
                                              contextBloc.read<ActivityBloc>().add(
                                                  GetListActivityEvent(
                                                      widget.seasonFarmId,
                                                      widget.action,
                                                      result[1], [], [], (listCallback){
                                                    widget.onListActivityChanged(listCallback);}));
                                            }
                                          } else {
                                            var result = await Navigator.push(
                                                context,
                                                DetailMonitorPage.route(
                                                    state.listDiaryMonitor[index]));
                                            if (result != null && result[0]) {
                                              contextBloc.read<ActivityBloc>().add(
                                                  GetListActivityEvent(
                                                      widget.seasonFarmId,
                                                      widget.action,
                                                      false, [], [], (_){}));
                                            }
                                          }
                                        },
                                        callbackDelete: () {
                                          blocContext.read<ActivityBloc>().add(
                                              RemoveActivityEvent(
                                                  state.listDiaryActivity[index].id ?? -1,
                                                  widget.action, (listCallback){
                                                widget.onListActivityChanged(listCallback);}));
                                        });
                                  },
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                ),
                                SizedBox(
                                  height: 60,
                                )
                              ],
                            ),
                          ),
                        );
                }),
              ],
            ),
          ),
          if (isFilterOpen)
            AnimatedContainer(
              duration: const Duration(milliseconds: 700),
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
              child: BlocBuilder<ActivityBloc, ActivityState>(
                  builder: (contextBloc, state) {
                    return state.listDiaryActivityFilter.length > 0 ? FilterPage(
                      list: state.listDiaryActivityFilter,
                      type: widget.action,
                      onClose: closeFilter,
                      callBack: (dynamic){
                        contextBloc.read<ActivityBloc>().add(FilterEvent(dynamic, widget.action));
                      },
                      // Other parameters you might need to pass
                    ) : SizedBox();
                  }
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget floatingActionButton(String name, IconData icon, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          child: FloatingActionButton(
              //backgroundColor: Colors.transparent,
              onPressed: onTap,
              child: Icon(icon)
          ),
        ),
      ],
    );
}
}
