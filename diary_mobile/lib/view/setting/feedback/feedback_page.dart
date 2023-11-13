import 'dart:ui';

import 'package:diary_mobile/data/entity/monitor/monitor_diary.dart';
import 'package:diary_mobile/utils/constants/name_icon.dart';
import 'package:diary_mobile/utils/status/form_submission_status.dart';
import 'package:diary_mobile/utils/widgets/empty_widget.dart';
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
import '../../../utils/widgets/items/item_feedback.dart';
import '../../../view_model/setting/feedback/feedback_bloc.dart';
import '../../report/add_report.dart';
import 'add_feedback.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage(
      {super.key});


  @override
  _FeedbackPageState createState() => _FeedbackPageState();

  static Route route() {
    return Utils.pageRouteBuilder(
        FeedbackPage(),
        true);
  }
}

class _FeedbackPageState extends State<FeedbackPage> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedbackBloc(context.read<Repository>())
        ..add(GetListFeedbackEvent()),
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
              title: Text(
                "Thông tin phản hồi",
                style: StyleOfit.textStyleFW700(Colors.white, 20),
              )),
          //resizeToAvoidBottomInset: true,
          backgroundColor: AppColor.background,
          floatingActionButton: BlocBuilder<FeedbackBloc, FeedbackState>(
            builder: (contextBloc, state) {
              return floatingActionButton(
                  "", Icons.add,
                   () async {
                    var result = await Navigator.of(context).push(
                        AddFeedbackPage.route());
                    if (result != null && result[0]) {
                      contextBloc.read<FeedbackBloc>().add(
                          GetListFeedbackEvent());
                    }
                  });
            },
          ),
          body: BlocConsumer<FeedbackBloc, FeedbackState>(
              listener: (blocContext, state) async {
                final formStatus = state.formStatus;
                if(!state.isShowProgress){
                  setState(() {
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
            return state.isShowProgress /*&& (state.listDiaryFeedback.length == 0 || state.listDiaryMonitor.length == 0)*/
                ? const Center(
              child:
              DashedCircle(size: 39, stringIcon: IconAsset.icLoadOtp),
            )
                : RefreshIndicator(
              onRefresh: () async {
                blocContext.read<FeedbackBloc>().add(GetListFeedbackEvent());
              },
              child: state.listFeedback.isEmpty
                  ? const EmptyWidget()
                  : SingleChildScrollView(
                //physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: state.listFeedback.length,
                      itemBuilder: (BuildContext contextBloc, int index) {
                        return ItemFeedback(
                            feedbackInfo: state.listFeedback[index],
                            callbackChooseItem: () async {
                             /* var result = await Navigator.push(
                                    context,
                                    DetailMonitorPage.route(
                                        state.listDiaryMonitor[index]));
                                if (result != null && result[0]) {
                                  contextBloc.read<FeedbackBloc>().add(
                                      GetListFeedbackEvent(
                                          widget.seasonFarmId,
                                          widget.action,
                                          false, [], []));
                                }*/
                            },
                            callbackDelete: () {
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
    return Container(
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
    );
  }
}
