import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/monitor/monitor_diary.dart';
import 'package:diary_mobile/data/entity/report/report_result_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  final VoidCallback callbackEdit;
  OverlayEntry? overlayEntry;

  ItemReportResult({
    Key? key,
    required this.reportResult,
    required this.callbackChooseItem,
    required this.callbackDelete,
    required this.callbackEdit,
    required this.overlayEntry,
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
        if (widget.overlayEntry?.mounted == true) {
          widget.overlayEntry?.remove();
        }
        widget.callbackChooseItem();
      },
      child: Container(
        padding: const EdgeInsets.only(top: 8),
        child: Container(
          padding:
          const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
          margin: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: widget.reportResult.state == 'done'
                      ? AppColor.green53
                      : widget.reportResult.state == 'storage' ?
                      AppColor.gray12 : AppColor.yellow07,
                  blurRadius: 0,
                  offset: Offset(-5.0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
              color: AppColor.whiteF2),
          child: Stack(
            children: [
              Container(
                padding:
                const EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(bottom: 0, top: 16),
                              child: Text(
                                "${widget.reportResult.surveyId}",
                                style: StyleOfit.textStyleFW400(AppColor.blue15,
                                    15),
                                overflow: TextOverflow.visible,
                              )),
                          Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(top: 5),
                              child: Utils.convertTextWidget(
                                    "Thanh tra: ",
                                    "${widget.reportResult.internalInspector}",
                                    AppColor.blue15,
                                    14),
                                ),
                          Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(top: 5),
                              child: Utils.convertTextWidget(
                                    "Nông hộ: ",
                                    "${widget.reportResult.farmerName}",
                                    AppColor.blue15,
                                    14),
                                ),
                          Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(top: 5, bottom: 0),
                              child: Utils.convertTextWidget(
                                    "Ngày thực hiện: ",
                                    Utils.formatTime(widget.reportResult.createDate?? ""),
                                    AppColor.black22,
                                    14)),
                          Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(top: 5, bottom: 16),
                              child: Utils.convertTextWidget(
                                  "Trạng thái: ",
                                  widget.reportResult.state == 'done'
                                      ? "Hoàn thành"
                                      : widget.reportResult.state == 'storage' ?
                                      "Lưu trữ": "Chưa hoàn thành",
                                  widget.reportResult.state == 'done'
                                      ? AppColor.green53
                                      : widget.reportResult.state == 'storage' ?
                                      AppColor.gray57 :AppColor.orange,
                                  14))
                        ],
                      ),
                    ),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.zero,
                          child: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              widget.callbackEdit();
                            },
                            constraints: BoxConstraints(),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            DiaLogManager.displayDialog(context, "",
                                "Bạn có muốn xóa hoạt động này không.", () {
                                  Get.back();
                                  widget.callbackDelete();
                                }, () {
                                  Get.back();
                                }, S.of(context).no, S.of(context).yes);
                          },
                          icon: const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Image(
                              image: AssetImage(ImageAsset.imageBin),
                              //width: 40,
                              fit: BoxFit.contain,
                            ),
                          ),
                          //padding: EdgeInsets.all(9),
                          constraints: BoxConstraints(),
                        )
                      ],
                    ),
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
