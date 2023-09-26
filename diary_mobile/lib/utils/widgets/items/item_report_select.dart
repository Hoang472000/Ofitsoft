import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/monitor/monitor_diary.dart';
import 'package:diary_mobile/data/entity/report/report_result_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../data/entity/report/report.dart';
import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../dialog/dialog_manager.dart';

class ItemReportSelect extends StatefulWidget {
  final Report report;
  final VoidCallback callbackChooseItem;

  const ItemReportSelect({
    Key? key,
    required this.report,
    required this.callbackChooseItem,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemReportSelectState();
}

class _ItemReportSelectState extends State<ItemReportSelect> {

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
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Mẫu khảo sát ${widget.report.id}",
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
                              "${widget.report.title}",
                              AppColor.blue15,
                              14),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
