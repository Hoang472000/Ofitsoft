
import 'package:flutter/material.dart';
import '../../../data/entity/setting/feedback_info.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';

///HoangCV: item feedback
class ItemFeedback extends StatefulWidget {
  final FeedbackInfo feedbackInfo;
  final VoidCallback callbackChooseItem;
  final VoidCallback callbackDelete;

  const ItemFeedback({
    Key? key,
    required this.feedbackInfo,
    required this.callbackChooseItem,
    required this.callbackDelete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemFeedbackState();
}

class _ItemFeedbackState extends State<ItemFeedback> {
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
          padding:
          const EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
          margin: const EdgeInsets.only(left: 20, right: 16, top: 4, bottom: 4),
          decoration: BoxDecoration(
              /*boxShadow: const [
                BoxShadow(
                  color: AppColor.main,
                  blurRadius: 0,
                  offset: Offset(-5.0, 0),
                ),
              ],*/
              borderRadius: BorderRadius.circular(8),
              color: /*widget.isChoose ? Colors.red[100] :*/
              Colors.white.withOpacity(0.9)),
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Container(
                   alignment: Alignment.centerLeft,
                   margin: const EdgeInsets.only(bottom: 5, top: 5),
                   child: RichText(
                     text: Utils.convertTextFeedback(
                         "Tiêu đề: ",
                         "${widget.feedbackInfo.title}",
                         AppColor.black22,
                         16),
                        maxLines: 3,
                     overflow: TextOverflow.ellipsis,
                     textScaleFactor: MediaQuery.of(context).textScaleFactor,
                   )),
               Container(
                   alignment: Alignment.centerLeft,
                   margin: const EdgeInsets.only(bottom: 5, top: 5),
                   child: RichText(
                     text: Utils.convertTextFeedback(
                         "Nội dung: ",
                         "${widget.feedbackInfo.description}",
                         AppColor.black22,
                         16),
                     maxLines: 3,
                     overflow: TextOverflow.ellipsis,
                     textScaleFactor: MediaQuery.of(context).textScaleFactor,
                   )),
             ],
           ),
        ),
      ),
    );
  }
}
