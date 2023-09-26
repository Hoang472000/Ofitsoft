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
import '../../utils/widgets/items/item_report_select.dart';
import '../../view_model/diary_activity/activity/info_diary_bloc.dart';
import '../../view_model/report/list_report_result_bloc.dart';
import 'add_report.dart';
import 'detail_report.dart';
import 'edit_report.dart';


class ListReportSelect extends StatefulWidget {
  const ListReportSelect(
      {super.key,
        required this.listReport});

  final List<Report> listReport;

  @override
  _ListReportSelectState createState() => _ListReportSelectState();

  static Route route(List<Report> listReport) {
    return Utils.pageRouteBuilder(
        ListReportSelect(
          listReport: listReport
        ),
        true);
  }
}

class _ListReportSelectState extends State<ListReportSelect> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OfitAppBar(context,
          centerTitle: true,
          hasBottom: true,
          showDefaultBackButton: true,
          callback: [],
          title: Text(
            "Chọn mẫu báo cáo đánh giá",
            style: StyleOfit.textStyleFW700(Colors.white, 20),
          )),
      //resizeToAvoidBottomInset: true,
      backgroundColor: AppColor.background,
      body:
        (widget.listReport.isEmpty)
                ? const EmptyWidget()
                : SingleChildScrollView(
              //physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: widget.listReport.length,
                    itemBuilder: (BuildContext contextBloc, int index) {
                      return ItemReportSelect(
                        report: widget.listReport[index],
                        callbackChooseItem: () async {
                          var result = await Navigator.of(context)
                              .push(AddReportViewPage.route(widget.listReport[index].id ?? -1));
                          if (result != null && result[0]) {
                            Navigator.of(context).pop(result);
                          }
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
            )
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
