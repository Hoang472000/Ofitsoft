import 'package:flutter/material.dart';

import '../../resource/color.dart';
import '../../resource/style.dart';

class BkavButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final Color? color;
  final bool? isEnterMore;

  const BkavButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.onLongPressed,
      this.color,
      this.isEnterMore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
            primary: isEnterMore != null ? Colors.white : color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
              side: isEnterMore != null
                  ? const BorderSide(color: AppColor.main)
                  : BorderSide.none),
        ).copyWith(
          elevation: MaterialStateProperty.resolveWith(
                (states) {
              return 0;
            },
          ),
        ),
        onPressed: onPressed,
        onLongPress: onLongPressed,
        child: Ink(
          decoration: BoxDecoration(
            gradient: isEnterMore != null
                ? null
                : const LinearGradient(
              colors: [AppColor.main, AppColor.green99],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: StyleBkav.textStyleFW700(isEnterMore != null ?  AppColor.main: null, 16),
            ),
          ),
        ),
      ),
    );
  }
}
