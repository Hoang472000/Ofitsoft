import 'package:diary_mobile/data/entity/notify/notify_entity.dart';
import 'package:flutter/material.dart';
import '../../../data/entity/setting/feedback_info.dart';
import '../../../data/entity/task /task_entity.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';

///HoangCV: item feedback
class ItemTask extends StatefulWidget {
  final TaskEntity taskEntity;
  final VoidCallback callbackChooseItem;
  final VoidCallback callbackDelete;

  const ItemTask({
    Key? key,
    required this.taskEntity,
    required this.callbackChooseItem,
    required this.callbackDelete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemTaskState();
}

class _ItemTaskState extends State<ItemTask> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        //Truyen id de sang man ben goi api hoac DB
        widget.callbackChooseItem();
        setState(() {
          visible = !visible;
        });
      },
      onLongPress: () {},
      child: Container(
        padding: const EdgeInsets.only(top: 8),
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 16, top: 4, bottom: 4),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: (widget.taskEntity!.status ?? '' ).compareTo("done")==0 ?
              AppColor.green1 :
              (widget.taskEntity!.status ?? '' ).compareTo("cancelled")==0 ?
              AppColor.red11 : AppColor.yellow07,
              //AppColor.main,
              blurRadius: 0,
              offset: Offset(-5.0, 0),
            ),
          ], borderRadius: BorderRadius.circular(8), color: Colors.white),
          child: Container(
            padding:
                const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(bottom: 5, top: 5),
                  child: Utils.convertTextWidget("Nhiệm vụ:",
                      "${widget.taskEntity.name}", AppColor.black22, 16),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 5, top: 5),
                    child: Utils.convertTextWidget(
                        "Công việc cần làm:",
                        "${widget.taskEntity.activityName}",
                        AppColor.black22,
                        16)),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 5, top: 5),
                    child: Utils.convertTextWidget(
                        "Trạng thái:",
                        (widget.taskEntity!.status ?? '' ).compareTo("draft")==0?"Lên kế hoạch":
                        (widget.taskEntity!.status ?? '' ).compareTo("pending")==0?"Chờ xử lý":
                        (widget.taskEntity!.status ?? '' ).compareTo("processing")==0?"Đang diễn ra":
                        (widget.taskEntity!.status ?? '' ).compareTo("done")==0?"Hoàn thành":
                        (widget.taskEntity!.status ?? '' ).compareTo("cancelled")==0?"Đã hủy": "",
                        (widget.taskEntity!.status ?? '' ).compareTo("done")==0 ?
                        AppColor.green1 :
                        (widget.taskEntity!.status ?? '' ).compareTo("cancelled")==0 ?
                        AppColor.red11 : AppColor.yellow07,
                        16)),
              (widget.taskEntity!.status ?? '' ).compareTo("done")==0 ?
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 5, top: 5),
                    child: Utils.convertTextWidget(
                        "Ngày hoàn thành:",
                        Utils.formatTime("${widget.taskEntity.completeDate}"),
                        AppColor.black22,
                        16)) : SizedBox(),
                ((widget.taskEntity!.status ?? '' ).compareTo("draft")==0 ||
                (widget.taskEntity!.status ?? '' ).compareTo("processing")==0 ||
                (widget.taskEntity!.status ?? '' ).compareTo("pending")==0) ?
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 5, top: 5),
                    child: Text(
                        Utils.getRemainingTimeMessage(
                            "${widget.taskEntity.endDate}"),
                        style: StyleOfit.textStyleFW500(
                            Utils.checkDateTimeNow(
                                "${widget.taskEntity.endDate}")
                                ? AppColor.red11
                                : AppColor.yellow07, 16))) : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
