import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/utils/status/form_submission_status.dart';
import 'package:diary_mobile/utils/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../../data/entity/report/report.dart';
import '../../data/entity/report/report_result_title.dart';
import '../../utils/widgets/items/item_report_result.dart';
import '../../view_model/diary_activity/activity/info_diary_bloc.dart';
import '../../view_model/report/list_report_result_bloc.dart';
import 'add_report.dart';
import 'detail_report.dart';
import 'edit_report.dart';
import 'list_report_select.dart';


class ListReportResultView extends StatefulWidget {
  const ListReportResultView(
      {super.key,});

  @override
  _ListReportResultViewState createState() => _ListReportResultViewState();

  static Route route() {
    return Utils.pageRouteBuilder(
        ListReportResultView(),
        true);
  }
}

class _ListReportResultViewState extends State<ListReportResultView> {
  bool visible = true;
  bool updateHarvesting = false;
  List<ReportResult> listCallback = const [];
  OverlayEntry? overlayEntry;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListReportResultBloc(context.read<Repository>())..
      add(GetListReportResultEvent()),
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, -1);
          return false;
        },
        child: Scaffold(
          appBar: OfitAppBar(context,
              centerTitle: true,
              hasBottom: true,
              showDefaultBackButton: true,
              callback: [updateHarvesting, listCallback],
              title: Text(
                "Đánh giá & Khảo sát",
                style: StyleOfit.textStyleFW700(Colors.white, 20),
              )),
          //resizeToAvoidBottomInset: true,
          backgroundColor: AppColor.background,
          floatingActionButton: BlocBuilder<ListReportResultBloc, ListReportResultState>(
            builder: (contextBloc, state) {
              return floatingActionButton(
                  "", Icons.add,
                      () async {
                    if(state.listReportSelect.length > 1) {
                      var result = await Navigator.of(context)
                          .push(ListReportSelect.route(state.listReportSelect));
                      if (result != null && result[0]) {
                        contextBloc.read<ListReportResultBloc>().add(
                            GetListReportResultEvent(
                                checkUpdate: true));
                      }
                    } else if (state.listReportSelect.isNotEmpty) {
                      var result = await Navigator.of(context)
                          .push(AddReportViewPage.route(
                          state.listReportSelect[0].id ?? -1));
                      if (result != null && result[0]) {
                        contextBloc.read<ListReportResultBloc>().add(
                            GetListReportResultEvent(
                                checkUpdate: true));
                      }
                    } else{

                    }
              });
            },
          ),
          body: BlocConsumer<ListReportResultBloc, ListReportResultState>(
              listener: (blocContext, state) async {
                final formStatus = state.formStatus;
                if(!state.isShowProgress){
                }
                if (formStatus is SubmissionFailed) {
                  DiaLogManager.displayDialog(context, "", formStatus.exception, () {
                    Get.back();
                  }, () {
                    Get.back();
                  }, '', S.of(context).close_dialog);
                } else if (formStatus is SubmissionSuccess) {
                  setState(() {
                    updateHarvesting = true;
                    listCallback = state.listReport;
                  });
                  if ((formStatus.success ?? "").isNotEmpty) {
                  DiaLogManager.displayDialog(context, "", formStatus.success ?? "",
                          () {
                        Get.back();
                      }, () {
                        Get.back();
                      }, '', S.of(context).close_dialog);
                  }
                } else if (formStatus is FormSubmitting) {
                }
              }, builder: (blocContext, state) {
            return state.isShowProgress
                ? const Center(
              child:
              DashedCircle(size: 39, stringIcon: IconAsset.icLoadOtp),
            )
                : RefreshIndicator(
              onRefresh: () async {
                blocContext.read<ListReportResultBloc>().add(
                    GetListReportResultEvent(checkUpdate: true));
              },
              child: SingleChildScrollView(
                //physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                blocContext
                                    .read<ListReportResultBloc>()
                                    .add(
                                      UpdateRadioButtonEvent(
                                          ReportEnum.report),
                                    );
                              },
                              child: Row(
                                children: [
                                  Radio<ReportEnum>(
                                    value: ReportEnum.report,
                                    groupValue: state.reportEnum,
                                    onChanged: (ReportEnum? value) {
                                      blocContext
                                          .read<ListReportResultBloc>()
                                          .add(
                                            UpdateRadioButtonEvent(
                                                value as ReportEnum),
                                          );
                                    },
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text(
                                          'Đánh giá nội bộ'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                blocContext
                                    .read<ListReportResultBloc>()
                                    .add(UpdateRadioButtonEvent(
                                        ReportEnum.survey));
                              },
                              child: Row(
                                children: [
                                  Radio<ReportEnum>(
                                    value: ReportEnum.survey,
                                    groupValue: state.reportEnum,
                                    onChanged: (ReportEnum? value) {
                                      blocContext
                                          .read<ListReportResultBloc>()
                                          .add(UpdateRadioButtonEvent(
                                              value as ReportEnum));
                                    },
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text(
                                          'Khảo sát ban đầu'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                          ),
                    (state.listReport.isEmpty)
                        ? const EmptyWidget()
                        : Flexible(
                      child: ListView.builder(
                        itemCount: state.listReport.length,
                        itemBuilder: (BuildContext contextBloc, int index) {
                          return ItemReportResult(
                              reportResult: state.listReport[index],
                              callbackChooseItem: () {
                                Navigator.of(context)
                                    .push(DetailReportViewPage.route(state.listReport[index].id??-1));
                              },
                              callbackDelete: () {
                                  contextBloc.read<ListReportResultBloc>().add(
                                      DeleteReportResultEvent(state.listReport[index].id??-1));
                              },
                            callbackEdit: () async {
                            var result = await Navigator.of(context)
                                .push(EditReportViewPage.route(state.listReport[index].id??-1));
                            if (result != null && result[0]) {
                              contextBloc.read<ListReportResultBloc>().add(
                                  GetListReportResultEvent(checkUpdate: true));
                            }
                          }, overlayEntry: overlayEntry,);
                        },
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
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
