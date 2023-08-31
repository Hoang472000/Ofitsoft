import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:flutter/material.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../utils.dart';
import '../../../view/diary/detail_diary/detail_diary_page.dart';

///Bkav Nhungltk: item diary
class ItemActivitySelect extends StatefulWidget {
  final ActivityDiary diary;
  final int amountSelected; // xac dinh xem item co dang duoc chon khong
  final bool isChoose; // xac dinh xem item co dang duoc chon khong
  final Function(bool, ActivityDiary) callbackChooseItem;

  const ItemActivitySelect(
      {Key? key,
      required this.diary,
      required this.amountSelected,
      required this.isChoose,
      required this.callbackChooseItem})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemActivitySelectState();
}

class _ItemActivitySelectState extends State<ItemActivitySelect> {
  bool isExpansion = false;
  bool isCheckBox = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
/*        if (widget.amountSelected > 0) {*/
        widget.callbackChooseItem(widget.isChoose, widget.diary);
        /*       } else {
          Navigator.push(context,
              DetailDiaryPage.route(widget.diary.id ?? -1, widget.diary));
        }*/
      },
      onLongPress: () {
        setState(() {
          widget.callbackChooseItem(widget.isChoose, widget.diary);
        });
      },
      child: Container(
        padding: const EdgeInsets.only(top: 0),
        child: Stack(
          children: [
            Positioned.fill(
                left: 14,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 30,
                    width: 10,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            widget.callbackChooseItem(
                                widget.isChoose, widget.diary);
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
                  ),
                )),
            Container(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 20, right: 16),
                margin: /*widget.amountSelected > 0 ? */
                const EdgeInsets.only(
                        left: 50, right: 16, top: 4, bottom: 4),
                   /* : const EdgeInsets.only(
                        left: 20, right: 16, top: 4, bottom: 4),*/
                /*            margin: const EdgeInsets.only(
                  left: 20, right: 16, top: 4, bottom: 4),*/
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
                        widget.diary.activityName ?? "",
                        style: StyleOfit.textStyleFW700(AppColor.gray500, 16),
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(bottom: 5, top: 5),
                        child: RichText(
                          text: Utils.convertText(
                              "Thời gian thu hoạch: ",
                              "${widget.diary.actionTime}",
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
                                "${widget.diary.actionArea ?? ''} ${widget.diary.actionAreaUnitName}",
                                AppColor.blue15,
                                14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ),
                    SizedBox(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(top: 10),
                          child: RichText(
                            text: Utils.convertText(
                                "Sản lượng thu hoạch: ",
                                "${widget.diary.amount ?? ''} ${widget.diary.amountUnitName}",
                                AppColor.blue15,
                                14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                    )
                  ],
                )),
            /*   Positioned(
              right: 12,
              // padding: EdgeInsets.only(bottom: 10),
              // margin: EdgeInsets.only(right: 17, top: 0, bottom: 10),
              child: _widgetViewEditAndCancel(context, widget.callbackEdit),
            )*/
          ],
        ),
      ),
    );
  }
}
