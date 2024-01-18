import 'package:diary_mobile/resource/assets.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../resource/color.dart';

class HomeBackGround extends StatelessWidget {
  final List<Widget> children;

  HomeBackGround({required this.children});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Image.asset(ImageAsset.imageOfitSoftBG).image,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(AppColor.colorBG, BlendMode.multiply),//0xFF37474F
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: children,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
