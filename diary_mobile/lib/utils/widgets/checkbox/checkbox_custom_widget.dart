
import 'package:flutter/material.dart';

class CheckboxCustomWidget extends StatelessWidget {
  final isChecked;
  final colorBorder;

  const CheckboxCustomWidget({Key? key, this.isChecked, this.colorBorder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
        width: 30,
        height: 30,
        decoration:  BoxDecoration(
          border: Border.all(width: 3,color:colorBorder ?? Color(0xFFB2B8BB)),
          color: isChecked?Theme.of(context).primaryColor:Colors.white,
          shape: BoxShape.circle,
        ),
        child:  Icon(
          Icons.check,
          size: 20,
          color: Colors.white,
        ));
  }
}
