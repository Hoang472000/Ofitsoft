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


  OverlayEntry createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: position.dy,
          left: position.dx,
          width: renderBox.size.width,
          height: renderBox.size.height,
          child: GestureDetector(
            onTap: () {
              if (widget.overlayEntry?.mounted == true) {
                widget.overlayEntry?.remove();
              }
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 16, top: 12, bottom: 4),
              color: Colors.black12.withOpacity(0.3),
              child: Material( // Wrap IconButton with Material widget
                color: Colors.transparent, // Make Material widget transparent
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white),
                  onPressed: () {
                    DiaLogManager.displayDialog(context, "",
                        "Bạn có muốn xóa báo cáo này không.", () {
                          Get.back();
                          widget.callbackDelete();
                          if (widget.overlayEntry?.mounted == true) {
                            widget.overlayEntry?.remove();
                          }
                        }, () {
                          Get.back();
                        }, S.of(context).no, S.of(context).yes);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

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
      onLongPress: () {
        widget.overlayEntry = createOverlayEntry();
        Overlay.of(context).insert(widget.overlayEntry!);
        Future.delayed(const Duration(seconds: 2), () {
          if (widget.overlayEntry?.mounted == true) {
            widget.overlayEntry?.remove();
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.only(top: 8),
        child: Container(
          padding:
          const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
          margin: const EdgeInsets.only(left: 20, right: 16, top: 4, bottom: 4),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: widget.reportResult.state == 'done'
                      ? AppColor.green53
                      : AppColor.yellow07,
                  blurRadius: 0,
                  offset: Offset(-5.0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
              color: /*widget.isChoose ? Colors.red[100] :*/
              Colors.white),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: SvgPicture.asset(
                  widget.reportResult.state == 'done' ? IconAsset.icSuccess : IconAsset.icLoading,
                  width: 25,
                  height: 25,
                  color: widget.reportResult.state == 'done'
                      ? AppColor.green53
                      : AppColor.yellowFF,
                ),
              ),
              Container(
                padding:
                const EdgeInsets.only(top: 5, bottom: 12, left: 24, right: 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(bottom: 0, top: 20),
                              child: RichText(
                                text: Utils.convertText(
                                    "",
                                    "${widget.reportResult.surveyId}",
                                    AppColor.blue15,
                                    15),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              )),
                          SizedBox(
                            child: Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(top: 5),
                                child: RichText(
                                  text: Utils.convertText(
                                      "Thanh tra: ",
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
                                      "Vùng trồng: ",
                                      "${widget.reportResult.farmName}",
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
                                      Utils.formatTime(widget.reportResult.createDate?? ""),
                                      AppColor.black22,
                                      12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          )
                        ],
                      ),
                    ),
                   Container(
                     padding:
                     const EdgeInsets.only(top: 10, bottom: 0, left: 0, right: 0),
                     child: /*checkDelete ? IconButton(icon: Icon(Icons.delete),
                       onPressed: (){
                         widget.callbackDelete();
                       },) : */IconButton(icon: Icon(Icons.edit),
                       onPressed: (){
                         widget.callbackEdit();
                       },),
                   )
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
