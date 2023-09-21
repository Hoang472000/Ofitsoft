import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/monitor/monitor_diary.dart';
import 'package:diary_mobile/data/entity/report/report_result_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../dialog/dialog_manager.dart';

class ItemReportResult extends StatefulWidget {
  final ReportResult reportResult;
  final VoidCallback callbackChooseItem;
  final VoidCallback callbackDelete;

  const ItemReportResult({
    Key? key,
    required this.reportResult,
    required this.callbackChooseItem,
    required this.callbackDelete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemReportResultState();
}

class _ItemReportResultState extends State<ItemReportResult> {
  bool isExpansion = false;
  bool isCheckBox = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        widget.callbackChooseItem();
      },
      onLongPress: () {},
      child: Container(
        padding: const EdgeInsets.only(top: 8),
        child: Container(
          padding:
          const EdgeInsets.only(top: 12, bottom: 12, left: 24, right: 16),
          margin: const EdgeInsets.only(left: 20, right: 16, top: 4, bottom: 4),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text(
                  "Khảo sát: ${widget.reportResult.id}",
                  style:
                  StyleOfit.textStyleFW500(AppColor.gray57, 16),
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(bottom: 0, top: 0),
                  child: RichText(
                    text: Utils.convertText(
                        "",
                        "${widget.reportResult.surveyId}",
                        AppColor.blue15,
                        14),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )),
              SizedBox(
                child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 5),
                    child: RichText(
                      text: Utils.convertText(
                          "Thanh tra viên: ",
                          "${widget.reportResult.internalInspector}",
                          AppColor.blue15,
                          14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
              ),
              SizedBox(
                child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 5),
                    child: RichText(
                      text: Utils.convertText(
                          "Ngày thực hiện: ",
                          "${widget.reportResult.createDate}",
                          AppColor.blue15,
                          14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
