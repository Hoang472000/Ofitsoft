import 'package:flutter/material.dart';

import '../../resource/color.dart';
import '../../resource/style.dart';

class ItemMoreView extends StatefulWidget {
   ItemMoreView({Key? key,required this.text}) : super(key: key);
 String text;

  @override
  State<ItemMoreView> createState() => _ItemMoreViewState();
}

class _ItemMoreViewState extends State<ItemMoreView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Text(widget.text,
              style: StyleBkav.textStyleFW500(AppColor.black22, 16),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.start),
        )));
  }
}
