import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/monitor/monitor_diary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/entity/activity/activity_transaction.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../dialog/dialog_manager.dart';

class ItemTransaction extends StatefulWidget {
  final dynamic activityDiary;
  final Diary diary;
  final String action;
  final int amountSelected; // xac dinh xem item co dang duoc chon khong
  final bool isChoose; // xac dinh xem item co dang duoc chon khong
  final Function(bool) callbackChooseItem;
  final VoidCallback chooseItem;
  final VoidCallback callbackDelete;
  final VoidCallback callbackExport;

  const ItemTransaction({
    Key? key,
    required this.diary,
    required this.activityDiary,
    required this.action,
    required this.amountSelected,
    required this.isChoose,
    required this.chooseItem,
    required this.callbackChooseItem,
    required this.callbackDelete,
    required this.callbackExport,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemTransactionState();
}

class _ItemTransactionState extends State<ItemTransaction> {
  bool isExpansion = false;
  bool isCheckBox = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        if (widget.amountSelected > 0) {
          widget.callbackChooseItem(widget.isChoose);
        } else {
          widget.chooseItem();
        }
      },
      onLongPress: () {
        setState(() {
          widget.callbackChooseItem(widget.isChoose);
        });
      },
      child: Container(
        padding: const EdgeInsets.only(top: 8),
        child: Stack(
          children: [
            Positioned.fill(
                left: 16,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Visibility(
                      visible: (widget.amountSelected > 0),
                      child: SizedBox(
                        height: 30,
                        width: 10,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                widget.callbackChooseItem(
                                    widget.isChoose);
                              });
                            },
                            icon: widget.isChoose
                                ? const Icon(
                              Icons.check_box_outlined,
                              color: AppColor.main,
                              size: 20,
                            )
                                : const Icon(
                              Icons.check_box_outline_blank,
                              color: AppColor.main,
                              size: 20,
                            ),
                            padding: EdgeInsets.zero),
                      )),
                )),
            Container(
/*              padding:
                  const EdgeInsets.only(top: 12, bottom: 12, left: 24, right: 16),
              margin: const EdgeInsets.only(left: 20, right: 16, top: 4, bottom: 4),*/
              padding:
              const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
              margin: widget.amountSelected > 0
                  ? const EdgeInsets.only(
                  left: 52, right: 16, top: 4, bottom: 4)
                  : const EdgeInsets.only(
                  left: 16, right: 16, top: 4, bottom: 4),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: AppColor.main,
                      blurRadius: 0,
                      offset: Offset(-5.0, 0),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                  color: /*widget.isChoose ? Colors.red[100] :*/
                      Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "${widget.activityDiary.seasonFarmName}",
                            style: StyleOfit.textStyleFW500(AppColor.black22, 15,
                            overflow: TextOverflow.visible),
                          ),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(bottom: 5, top: 5),
                            child: Utils.convertTextWidget(
                                  "Ngày giao dịch: ",
                                  Utils.formatTime("${widget.activityDiary.transactionDate}"),
                                  AppColor.blue15,
                                  14),
                            ),
                        SizedBox(
                          child: Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(bottom: 5, top: 5),
                              child: Utils.convertTextWidget(
                                    "Sản lượng: ",
                                    "${Utils.convertNumber(widget.activityDiary.quantity ?? 0)} ${widget.activityDiary.quantityUnitName}",
                                    AppColor.blue15,
                                    14),
                                ),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(top: 5),
                            child: Utils.convertTextWidget(
                                  "Tổng tiền: ",
                                  "${Utils.convertNumber((widget.activityDiary.unitPrice ?? 0) * (widget.activityDiary.quantity ?? 0))}",
                                  AppColor.blue15,
                                  14),
                              ),
                      ],
                    ),
                  ),
                  IconButton(
                    //padding: EdgeInsets.only(left: 16, right: 4),
                    icon: const Icon(Icons.file_download_outlined, color: AppColor.back09,size: 30,)/*Image(
                      image: AssetImage(ImageAsset.imageInfo),
                      //width: 40,
                      fit: BoxFit.contain,
                    )*/,
                    onPressed: () {
                      widget.callbackExport();
                    },
                  ),
                  SizedBox(
                    height: 44,
                    width: 44,
                    child: widget.action == "sell" &&
                        ((widget.diary.status ?? '').compareTo("done") == 0 ||
                                (widget.diary.status ?? '')
                                        .compareTo("cancelled") ==
                                    0)
                            ? Container()
                            : IconButton(
                                padding: EdgeInsets.only(left: 16, right: 4),
                                icon: const Image(
                                  image: AssetImage(ImageAsset.imageBin),
                                  //width: 40,
                                  fit: BoxFit.contain,
                                ),
                                onPressed: () {
                                  DiaLogManager.displayDialog(context, "",
                                      "Bạn có muốn xóa hoạt động này không.", () {
                                    Get.back();
                                    widget.callbackDelete();
                                  }, () {
                                    Get.back();
                                  }, S.of(context).no, S.of(context).yes);
                                },
                              ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
