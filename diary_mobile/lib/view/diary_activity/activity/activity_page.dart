import 'dart:ui';

import 'package:diary_mobile/utils/form_submission_status.dart';
import 'package:diary_mobile/view/diary_activity/activity/detail_activity.dart';
import 'package:diary_mobile/view/diary_activity/activity_sell/activity_select_page.dart';
import 'package:diary_mobile/view/diary_activity/monitor/add_monitor.dart';
import 'package:diary_mobile/view_model/diary_activity/activity/activity_bloc.dart';
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
import '../../../utils/widgets/dashed_circle.dart';
import '../../../utils/widgets/dialog_manager.dart';
import '../activity_sell/add_activity_sell.dart';
import '../monitor/detail_monitor_page.dart';
import 'add_activity.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage(
      {super.key,
      required this.action,
      required this.seasonFarmId,
      required this.diary});

  final String action;
  final int seasonFarmId;
  final Diary diary;

  @override
  _ActivityPageState createState() => _ActivityPageState();

  static Route route(String action, int seasonFarmId, Diary diary) {
    return Utils.pageRouteBuilder(
        ActivityPage(
          action: action,
          seasonFarmId: seasonFarmId,
          diary: diary,
        ),
        true);
  }
}

class _ActivityPageState extends State<ActivityPage> {
  bool visible = true;
  OverlayEntry? _overlayEntry;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_initView();
  }
  void _showOverlay(BuildContext contextBloc, ActivityState state) {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  _overlayEntry?.remove();
                  _overlayEntry = null;
                  setState(() {
                    visible = true;
                  });
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Visibility(
                        visible: !visible,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
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
                                        text: "Ghi thu bán",
                                        style: StyleOfit.textStyleFW500(AppColor.whiteF2, 14),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "", // Chữ bị gạch chân sẽ được thay bằng chuỗi rỗng
                                          ),
                                        ],
                                      ),
                                    )
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
                                      child: Icon(Icons.monetization_on),
                                      onPressed: (widget.diary.status??'').compareTo("done") == 0 ||
                                          (widget.diary.status??'').compareTo("cancelled") == 0 ?
                                          () {
                                        if((widget.diary.status??'').compareTo("done") == 0 ) {
                                          _overlayEntry?.remove();
                                          _overlayEntry = null;
                                          DiaLogManager.displayDialog(context,
                                              "Nhật ký đã hoàn thành","Bạn không thể thêm mới hoạt động",
                                                  (){Navigator.pop(context);}, () {},
                                              "",S.of(context).close_dialog);
                                        }
                                        if((widget.diary.status??'').compareTo("cancelled") == 0 ) {
                                          _overlayEntry?.remove();
                                          _overlayEntry = null;
                                          DiaLogManager.displayDialog(context,
                                              "Nhật ký đã đóng","Bạn không thể thêm mới hoạt động",
                                                  (){Navigator.pop(context);}, () {},
                                              "",S.of(context).close_dialog);
                                        }
                                      }
                                          : () async {
                                        _overlayEntry?.remove();
                                        _overlayEntry = null;
                                        var result = widget.action.compareTo("activity") == 0
                                            ? await Navigator.of(context)
                                            .push(ActivitySelectPage.route(widget.diary, state.listDiaryActivity))
                                            : await Navigator.of(context).push(AddMonitorPage.route());
                                        setState(() {
                                          visible = true;
                                        });
                                        if (result != null && result[0]) {
                                          contextBloc.read<ActivityBloc>().add(
                                              GetListActivityEvent(widget.seasonFarmId, widget.action, result[1]));
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
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
                                        text: "Ghi nhật ký",
                                        style: StyleOfit.textStyleFW500(AppColor.whiteF2, 14),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "", // Chữ bị gạch chân sẽ được thay bằng chuỗi rỗng
                                          ),
                                        ],
                                      ),
                                    )
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
                                      child: Icon(Icons.note_add),
                                      onPressed: (widget.diary.status??'').compareTo("done") == 0 ||
                                          (widget.diary.status??'').compareTo("cancelled") == 0 ?
                                          () {
                                        if((widget.diary.status??'').compareTo("done") == 0 ) {
                                          DiaLogManager.displayDialog(context,
                                              "Nhật ký đã hoàn thành","Bạn không thể thêm mới hoạt động",
                                                  (){Navigator.pop(context);}, () {},
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
                                        _overlayEntry?.remove();
                                        _overlayEntry = null;
                                        var result = widget.action.compareTo("activity") == 0
                                            ? await Navigator.of(context)
                                            .push(AddActivityPage.route(widget.seasonFarmId, widget.diary))
                                            : await Navigator.of(context).push(AddMonitorPage.route());
                                        setState(() {
                                          visible = true;
                                        });
                                        if (result != null && result[0]) {
                                          contextBloc.read<ActivityBloc>().add(
                                              GetListActivityEvent(widget.seasonFarmId, widget.action, result[1]));
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context)?.insert(_overlayEntry!);
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivityBloc(context.read<Repository>())
        ..add(GetListActivityEvent(widget.seasonFarmId, widget.action, false)),
      child: GestureDetector(
        onTap: () {
          setState(() {
            visible = true;
          });
          _overlayEntry?.remove();
          _overlayEntry = null;
        },
        child: Scaffold(
          //resizeToAvoidBottomInset: true,
          backgroundColor: AppColor.background,
          //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: BlocBuilder<ActivityBloc, ActivityState>(
            builder: (contextBloc, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [     Visibility(
                  visible: visible,
                  child: Container(
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
                      child: Icon(Icons.add),
                      onPressed: (){
                        _showOverlay(contextBloc, state);
                        setState(() {
                          visible = false;
                        });
                      }
                    ),
                  ),
                ),
                ],
              );
            },
          ),
          body: BlocConsumer<ActivityBloc, ActivityState>(
              listener: (blocContext, state) async {
            final formStatus = state.formStatus;
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
                          widget.seasonFarmId, widget.action, false));
                    },
                    child: SingleChildScrollView(
                      //physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.builder(
                            itemCount: widget.action.compareTo('activity') == 0
                                ? state.listDiaryActivity.length
                                : state.listDiaryMonitor.length,
                            itemBuilder: (BuildContext contextBloc, int index) {
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () async {
                                  //Truyen id de sang man ben goi api hoac DB
                                  if (widget.action.compareTo('activity') == 0) {
                                    var result = await Navigator.push(
                                        context,
                                        DetailActivityPage.route(
                                            state.listDiaryActivity[index], widget.diary));
                                    if (result != null && result[0]) {
                                      contextBloc.read<ActivityBloc>().add(
                                          GetListActivityEvent(
                                              widget.seasonFarmId,
                                              widget.action, result[1]));
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
                                              widget.action, false));
                                    }
                                  }
                                },
                                onLongPress: () {},
                                child: Container(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 12, bottom: 12, left: 24, right: 16),
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 16, top: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: AppColor.green53,
                                            blurRadius: 0,
                                            offset: Offset(-5.0, 0),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                        color: /*widget.isChoose ? Colors.red[100] :*/
                                            Colors.white),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        widget.action.compareTo('activity') == 0
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.only(
                                                        bottom: 5),
                                                    child: Text(
                                                      state
                                                              .listDiaryActivity[
                                                                  index]
                                                              .activityName ??
                                                          "",
                                                      style: StyleOfit
                                                          .textStyleFW700(
                                                              AppColor.gray500,
                                                              16),
                                                    ),
                                                  ),
                                                  Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 5, top: 5),
                                                      child:
                                                          RichText(
                                                        text: Utils.convertText(
                                                            "Thời gian thực hiện: ",
                                                            "${state.listDiaryActivity[index].actionTime}",
                                                            AppColor.blue15,
                                                            14),
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      )),
                                                  SizedBox(
                                                    child: Container(
                                                        alignment:
                                                            Alignment.centerLeft,
                                                        margin:
                                                            const EdgeInsets.only(
                                                                top: 5),
                                                        child: RichText(
                                                          text: Utils.convertText(
                                                              "Diện tích: ",
                                                              "${state.listDiaryActivity[index].actionArea ?? ''} ${state.listDiaryActivity[index].actionAreaUnitName}",
                                                              AppColor.blue15,
                                                              14),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )),
                                                  )
                                                ],
                                              )
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.only(
                                                        bottom: 5),
                                                    child: Text(
                                                      state
                                                              .listDiaryMonitor[
                                                                  index]
                                                              .activityIds[0]
                                                              .activity ??
                                                          "",
                                                      style: StyleOfit
                                                          .textStyleFW700(
                                                              AppColor.gray500,
                                                              16),
                                                    ),
                                                  ),
                                                  Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 5, top: 5),
                                                      child: RichText(
                                                        text: Utils.convertText(
                                                            "Thời gian thực hiện: ",
                                                            "${state.listDiaryMonitor[index].actionTime}",
                                                            AppColor.blue15,
                                                            14),
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      )),
                                                  SizedBox(
                                                    child: Container(
                                                        alignment:
                                                            Alignment.centerLeft,
                                                        margin:
                                                            const EdgeInsets.only(
                                                                top: 5),
                                                        child: RichText(
                                                          text: Utils.convertText(
                                                              "Trạng thái: ",
                                                              state
                                                                          .listDiaryMonitor[
                                                                              index]
                                                                          .activityIds[
                                                                              0]
                                                                          .checkYes ??
                                                                      false
                                                                  ? "Đã thực hiện"
                                                                  : "Chưa thực hiện",
                                                              AppColor.blue15,
                                                              14),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )),
                                                  )
                                                ],
                                              ),
                                        SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: /*(state.listDiaryActivity[index].harvesting ?? false) || */(widget.diary.status??'').compareTo("done") == 0 ||
                                              (widget.diary.status??'').compareTo("cancelled") == 0 ?
                                          Container(): IconButton(
                                            padding: EdgeInsets.only(
                                                left: 16, right: 4),
                                            icon: const Image(
                                              image:
                                                  AssetImage(ImageAsset.imageBin),
                                              //width: 40,
                                              fit: BoxFit.contain,
                                            ),
                                            onPressed: () {
                                              DiaLogManager.displayDialog(
                                                  context,
                                                  "",
                                                  "Bạn có muốn xóa hoạt động này không.",
                                                  () {
                                                Get.back();
                                                if (widget.action
                                                        .compareTo('activity') ==
                                                    0) {
                                                  blocContext
                                                      .read<ActivityBloc>()
                                                      .add(RemoveActivityEvent(
                                                          state
                                                                  .listDiaryActivity[
                                                                      index]
                                                                  .id ??
                                                              -1,
                                                          widget.action));
                                                } else {
                                                  DiaLogManager.showDialogSuccess(
                                                      context,
                                                      "Chức năng này đang phát triển. Vui lòng thử lại sau",
                                                      () {
                                                    Get.back();
                                                  });
                                                }
                                              }, () {
                                                Get.back();
                                              }, S.of(context).no,
                                                  S.of(context).yes);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
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
}
