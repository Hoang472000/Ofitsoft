import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/monitor/monitor_diary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../dialog/dialog_manager.dart';

///HoangCV: item diary
class ItemActivity extends StatefulWidget {
  final ActivityDiary activityDiary;
  final MonitorDiary monitorDiary;
  final Diary diary;
  final String action;
  final VoidCallback callbackChooseItem;
  final VoidCallback callbackDelete;

  const ItemActivity({
    Key? key,
    required this.diary,
    required this.activityDiary,
    required this.monitorDiary,
    required this.action,
    required this.callbackChooseItem,
    required this.callbackDelete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemActivityState();
}

class _ItemActivityState extends State<ItemActivity> {
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
              widget.action.compareTo('activity') == 0 || widget.action.compareTo('harvesting') == 0 || widget.action.compareTo('sell') == 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            widget.activityDiary.activityName ?? "",
                            style:
                                StyleOfit.textStyleFW700(AppColor.gray500, 16),
                          ),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(bottom: 5, top: 5),
                            child: RichText(
                              text: Utils.convertText(
                                  "Thời gian thực hiện: ",
                                  "${widget.activityDiary.actionTime}",
                                  AppColor.blue15,
                                  14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                        SizedBox(
                          child: Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(top: 5),
                              child: RichText(
                                text: Utils.convertText(
                                    "Diện tích: ",
                                    "${widget.activityDiary.actionArea ?? ''} ${widget.activityDiary.actionAreaUnitName}",
                                    AppColor.blue15,
                                    14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                        ),
                        (widget.activityDiary.harvesting ?? false)
                            ? SizedBox(
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.only(top: 10),
                                    child: RichText(
                                      text: Utils.convertText(
                                          "Sản lượng thu hoạch: ",
                                          "${widget.activityDiary.amount ?? ''} ${widget.activityDiary.amountUnitName}",
                                          AppColor.blue15,
                                          14),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                              )
                            : const SizedBox()
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            widget.monitorDiary.activityIds[0].activity ?? "",
                            style:
                                StyleOfit.textStyleFW700(AppColor.gray500, 16),
                          ),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(bottom: 5, top: 5),
                            child: RichText(
                              text: Utils.convertText(
                                  "Thời gian thực hiện: ",
                                  "${widget.monitorDiary.actionTime}",
                                  AppColor.blue15,
                                  14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                        SizedBox(
                          child: Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(top: 5),
                              child: RichText(
                                text: Utils.convertText(
                                    "Trạng thái: ",
                                    widget.monitorDiary.activityIds[0]
                                                .checkYes ??
                                            false
                                        ? "Đã thực hiện"
                                        : "Chưa thực hiện",
                                    AppColor.blue15,
                                    14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                        )
                      ],
                    ),
              SizedBox(
                height: 50,
                width: 50,
                child: /*(state.listDiaryActivity[index].harvesting ?? false) || */
                    (widget.diary.status ?? '').compareTo("done") == 0 ||
                            (widget.diary.status ?? '')
                                    .compareTo("cancelled") ==
                                0
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
                                if (widget.action.compareTo('activity') == 0) {
                                  widget.callbackDelete();
                                } else {
                                  DiaLogManager.showDialogSuccess(context,
                                      "Chức năng này đang phát triển. Vui lòng thử lại sau",
                                      () {
                                    Get.back();
                                  });
                                }
                              }, () {
                                Get.back();
                              }, S.of(context).no, S.of(context).yes);
                            },
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
