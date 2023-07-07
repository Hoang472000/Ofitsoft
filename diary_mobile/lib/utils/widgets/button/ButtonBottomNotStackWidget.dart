/*
import 'package:diary_mobile/resource/color.dart';
import 'package:diary_mobile/resource/style.dart';
import 'package:flutter/material.dart';

import '../button_widget.dart';

// ignore: use_key_in_widget_constructors
class ButtonBottomNotStackWidget extends StatelessWidget {
  final String title;
  final Function onPressed;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final double? marginTop;

  const ButtonBottomNotStackWidget(
      {Key? key, required this.title, required this.onPressed, this.margin, this.width, this.height,this.marginTop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop??16),
      height: height??50,
      width: width??MediaQuery.of(context).size.width ,
      decoration: BoxDecoration(gradient: LinearGradient( begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[AppColor.main, AppColor.green99]),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: BkavButton(
        color: Colors.transparent,

        onPressed: onPressed,
        child: Text(title,
          style: StyleBkav.textStyleFW400(Colors.white, 18),
        ),
      ),
    );
  }
}
*/
