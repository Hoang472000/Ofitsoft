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
  final VoidCallback callbackChooseItem;
  final VoidCallback callbackDelete;
  final VoidCallback callbackExport;

  const ItemTransaction({
    Key? key,
    required this.diary,
    required this.activityDiary,
    required this.action,
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
        //Truyen id de sang man ben goi api hoac DB
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      (widget.activityDiary.isPurchase ?? false)
                          ? "Hoạt động mua "
                          : "Hoạt động bán",
                      style: StyleOfit.textStyleFW700(AppColor.gray500, 16),
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(bottom: 5, top: 5),
                      child: RichText(
                        text: Utils.convertText(
                            "Thời gian giao dịch: ",
                            "${widget.activityDiary.transactionDate}",
                            AppColor.blue15,
                            14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                  SizedBox(
                    child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(bottom: 5, top: 5),
                        child: RichText(
                          text: Utils.convertText(
                              "Sản lượng: ",
                              "${Utils.convertNumber(widget.activityDiary.quantity ?? 0)} ${widget.activityDiary.quantityUnitName}",
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
                              "Tổng tiền: ",
                              "${Utils.convertNumber((widget.activityDiary.unitPrice ?? 0) * (widget.activityDiary.quantity ?? 0))}",
                              AppColor.blue15,
                              14, isMoney: true, buildContext: context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
                width: 50,
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
          IconButton(
                padding: EdgeInsets.only(left: 16, right: 4),
                icon: const Image(
                  image: AssetImage(ImageAsset.imageInfo),
                  //width: 40,
                  fit: BoxFit.contain,
                ),
                onPressed: () {
         widget.callbackExport();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
