import 'package:flutter/material.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../utils.dart';
import '../../../view/diary/detail_diary/detail_diary_page.dart';

///item diary
class ItemDiary extends StatefulWidget {
  final Diary diary;
  final int amountSelected; // xac dinh xem item co dang duoc chon khong
  final bool isChoose; // xac dinh xem item co dang duoc chon khong
  final Function(bool, Diary) callbackChooseItem;

  const ItemDiary(
      {Key? key,
      required this.diary,
      required this.amountSelected,
      required this.isChoose,
      required this.callbackChooseItem})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemDiaryState();
}

class _ItemDiaryState extends State<ItemDiary> {
  bool isExpansion = false;
  bool isCheckBox = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        if (widget.amountSelected > 0) {
          widget.callbackChooseItem(widget.isChoose, widget.diary);
        } else {
          Navigator.push(context,
              DetailDiaryPage.route(widget.diary.id ?? -1, widget.diary));
        }
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
                      )),
                )),
            Container(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
              margin: widget.amountSelected > 0
                  ? const EdgeInsets.only(
                      left: 52, right: 16, top: 4, bottom: 4)
                  : const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
              /*            margin: const EdgeInsets.only(
                  left: 20, right: 16, top: 4, bottom: 4),*/
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  color: AppColor.gray57,
                  blurRadius: 1,
                  offset: Offset(0, 0),
                ),
              ], borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: Text(
                          Utils.formatTime(widget.diary.startDate ?? ""),
                          style:
                              StyleOfit.textStyleFW400(AppColor.black22, 14),
                        ),
                      ),
                      Text(widget.diary.name.toString(),
                          style: StyleOfit.textStyleFW500(AppColor.main, 16),
                          maxLines: 3,
                          overflow: TextOverflow.visible),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: RichText(
                          text: Utils.convertText(
                              "Cây trồng: ",
                              "${widget.diary.cropName}",
                              AppColor.blue15,
                              14),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: RichText(
                          text: Utils.convertText(
                              "Thực hiện: ",
                              "${widget.diary.farmerName}",
                              AppColor.blue15,
                              12),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
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
