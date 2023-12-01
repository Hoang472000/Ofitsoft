import 'dart:ui';

import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/monitor/monitor_diary.dart';
import 'package:diary_mobile/utils/constants/name_icon.dart';
import 'package:diary_mobile/utils/status/form_submission_status.dart';
import 'package:diary_mobile/utils/widgets/empty_widget.dart';
import 'package:diary_mobile/view/diary_activity/activity/detail_activity.dart';
import 'package:diary_mobile/view/diary_activity/activity_sell/activity_select_page.dart';
import 'package:diary_mobile/view/diary_activity/monitor/add_monitor.dart';
import 'package:diary_mobile/view_model/diary_activity/activity/activity_bloc.dart';
import 'package:diary_mobile/view_model/diary_activity/activity/info_diary_bloc.dart';
import 'package:flutter/cupertino.dart';
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
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../../utils/widgets/dashed_circle.dart';
import '../../../utils/widgets/dialog/dialog_manager.dart';
import '../../../utils/widgets/items/item_activity.dart';
import '../../../utils/widgets/items/item_activity_avatar.dart';
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
      required this.listActivity});

  final String action;
  final ActivityFarm activityFarm;
  final int seasonFarmId;
  final Diary diary;
  final List<ActivityDiary> listActivity;

  @override
  _ActivityPageState createState() => _ActivityPageState();

  static Route route(String action, int seasonFarmId, Diary diary,
      ActivityFarm activityFarm, List<ActivityDiary> listActivity) {
    return Utils.pageRouteBuilder(
        ActivityPage(
          activityFarm: activityFarm,
          action: action,
          seasonFarmId: seasonFarmId,
          diary: diary,
          listActivity: listActivity,
        ),
        true);
  }
}

class _ActivityPageState extends State<ActivityPage> {
  bool visible = true;
  OverlayEntry? _overlayEntry;
  bool updateHarvesting = false;
  List<ActivityDiary> listCallback = const [];
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
        ..add(GetListActivityEvent(widget.seasonFarmId, widget.action, false, widget.listActivity, [])),
      child: GestureDetector(
        onTap: () {
/*          setState(() {
            visible = true;
          });
          _overlayEntry?.remove();
          _overlayEntry = null;*/
        },
        child: Scaffold(
          appBar: OfitAppBar(context,
            centerTitle: true,
            hasBottom: true,
            showDefaultBackButton: true,
            callback: [updateHarvesting, listCallback],
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
                        "Ghi nhật ký", Icons.note_add,   (widget.diary.status??'').compareTo("done") == 0 ||
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
                            : widget.action.compareTo(
                            "report") == 0 ? await Navigator.of(context)
                            .push(AddReportViewPage.route(-1)): await Navigator.of(context).push(
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
                                  result[1], [], []));
                        }
                      }),
                  ),
                ],
              );
            },
          ),
          body: BlocConsumer<ActivityBloc, ActivityState>(
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
                ? const Center(
                    child:
                        DashedCircle(size: 39, stringIcon: IconAsset.icLoadOtp),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      blocContext.read<ActivityBloc>().add(GetListActivityEvent(
                          widget.seasonFarmId, widget.action, false, [], []));
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
                                                result[1], [], []));
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
                                                false, [], []));
                                      }
                                    }
                                  },
                                  callbackDelete: () {
                                    blocContext.read<ActivityBloc>().add(
                                        RemoveActivityEvent(
                                            state.listDiaryActivity[index].id ?? -1,
                                            widget.action));
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
        ),
      ),
    );
  }

  Widget floatingActionButton(String name, IconData icon, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: AppColor.gray57,
                      blurRadius: 1,
                      offset: Offset(0, 0),
                    ),
                  ],      gradient:const LinearGradient(
                colors: [AppColor.main, AppColor.green99],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white),
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  text: name,
                  style: StyleOfit.textStyleFW500(AppColor.whiteF2, 14),
                  children: <TextSpan>[
                    TextSpan(
                      text: "", // Chữ bị gạch chân sẽ được thay bằng chuỗi rỗng
                    ),
                  ],
                ),
              )
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColor.main, AppColor.green99],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
            borderRadius: BorderRadius.circular(36.0), // Adjust the border radius as needed
          ),
          child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: onTap,
              child: Icon(icon)
          ),
        ),
      ],
    );
}
}
