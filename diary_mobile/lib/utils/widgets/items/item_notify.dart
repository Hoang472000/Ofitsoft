
import 'package:diary_mobile/data/entity/notify/notify_entity.dart';
import 'package:flutter/material.dart';
import '../../../data/entity/setting/feedback_info.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';

///Bkav HoangCV: item feedback
class ItemNotify extends StatefulWidget {
  final NotifyEntity notifyEntity;
  final VoidCallback callbackChooseItem;
  final VoidCallback callbackDelete;

  const ItemNotify({
    Key? key,
    required this.notifyEntity,
    required this.callbackChooseItem,
    required this.callbackDelete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemNotifyState();
}

class _ItemNotifyState extends State<ItemNotify> {
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
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: AppColor.green53,
                  blurRadius: 0,
                  offset: Offset(-5.0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
              color: (widget.notifyEntity.isRead == false) ? AppColor.whiteE8 :
              Colors.white),
          child: Stack(
            children: [
              (widget.notifyEntity.isRead == false) ?
              Positioned(
                right: 8,
                  top: 8,
                  child: Icon(Icons.circle, color: AppColor.red11, size: 10,)) :
              SizedBox(),
              Container(
                padding:
                const EdgeInsets.only(top: 12, bottom: 12, left: 24, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(bottom: 5, top: 5),
                        child: RichText(
                          text: Utils.convertTextFeedback(
                              "Tiêu đề: ",
                              "${widget.notifyEntity.title}",
                              AppColor.black22,
                              16),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )),
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(bottom: 5, top: 5),
                        child: RichText(
                          text: Utils.convertTextFeedback(
                              "Nội dung: ",
                              "${widget.notifyEntity.message}",
                              AppColor.black22,
                              16),
                          maxLines: 5,
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
