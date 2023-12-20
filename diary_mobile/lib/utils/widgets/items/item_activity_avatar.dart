import 'dart:convert';

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

/// item diary Avatar 
class ItemActivityAvatar extends StatefulWidget {
  final ActivityDiary activityDiary;
  final MonitorDiary monitorDiary;
  final Diary diary;
  final String action;
  final VoidCallback callbackChooseItem;
  final VoidCallback callbackDelete;

  const ItemActivityAvatar({
    Key? key,
    required this.diary,
    required this.activityDiary,
    required this.monitorDiary,
    required this.action,
    required this.callbackChooseItem,
    required this.callbackDelete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemActivityAvatarState();
}

class _ItemActivityAvatarState extends State<ItemActivityAvatar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.callbackChooseItem();
      },
      onLongPress: () {},
      child: Stack(
        children: [
          Positioned.fill(
              child: Stack(
                children: [
                  const Positioned.fill(
                      left: 8,
                      // padding: EdgeInsets.only(left: 15),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: VerticalDivider(
                            thickness: 2,
                            color: AppColor.green2,
                          ))),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: Icon(Icons.circle, color: AppColor.green53, size: 12,),
                    ),
                  )
                ],
              )),
          Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(
                      top: 15, bottom: 5, left: 32, right: 15),
                  child: Text(
                    Utils.formatDateForDiaryActivity("${widget.activityDiary.actionTime}"),
                    style: StyleOfit.textStyleFW500(
                      AppColor.black22,
                      14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
              Container(
                margin:
                const EdgeInsets.only(top: 5, bottom: 5, left: 32, right: 15),
                decoration: BoxDecoration(
                    color: AppColor.blue15,
                    borderRadius: BorderRadius.circular(10)),
                child: _item(context),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _item(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 16, top: 5, bottom: 5),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(blurRadius: 5, spreadRadius: 3, color: AppColor.grayEC),
          ],
          borderRadius: BorderRadius.circular(10),
          color: /*widget.isChoose ? Colors.red[100] :*/ Colors.white),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 0, top: 0, bottom: 5),
        child: Row(
         // mainAxisAlignment: MainAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child:  Image.memory(
                gaplessPlayback: true,
                base64Decode(widget.activityDiary
                    .media.length > 0 ? widget.activityDiary
                    .media.first.contentView ??
                    "" : ""),
                height: 70,
                width: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error,
                    stackTrace) {
                  return Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color:  AppColor.grayC7),
                    child: Center(
                      child: Text(
                        (widget.activityDiary.activityName ?? "").substring(0,1),
                        style:
                        StyleOfit.textStyleFW700(AppColor.green53, 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.action.compareTo('activity') == 0 || widget.action.compareTo('harvesting') == 0 || widget.action.compareTo('sell') == 0
                          ? Flexible(
                            child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                widget.activityDiary.activityName ?? "",
                                style:
                                StyleOfit.textStyleFW700(AppColor.gray500, 16,
                                overflow: TextOverflow.visible),
                              ),
                            ),
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
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                  )),
                            ),
                            (widget.activityDiary.harvesting ?? false)
                                ? SizedBox(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(top: 10),
                                  child: RichText(
                                    text: Utils.convertText(
                                        "Sản lượng: ",
                                        "${widget.activityDiary.amount ?? ''} ${widget.activityDiary.amountUnitName}",
                                        AppColor.blue15,
                                        14),
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                  )),
                            )
                                : SizedBox(),
                          if (!(widget.activityDiary.harvesting ?? false))
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Text(
                                widget.activityDiary.description ?? "",
                                style: StyleOfit.textStyleFW400(AppColor.gray500, 14),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                        ],
                      ),
                          )
                          : Flexible(
                            child: Column(
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
                          ),
                      /*widget.action.compareTo('harvesting') == 0 ? Container(): */SizedBox(
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
                                  if (widget.action.compareTo('activity') == 0 ||
                                      widget.action.compareTo('harvesting') == 0) {
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
