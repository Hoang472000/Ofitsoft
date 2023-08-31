import 'package:diary_mobile/resource/assets.dart';
import 'package:diary_mobile/resource/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resource/color.dart';

class ItemCardActivity extends StatelessWidget {
  const ItemCardActivity({
    super.key,
    required this.name,
    required this.icon,
    required this.onTap,
  });

  final String name;
  final String icon;
  final VoidCallback onTap;

  Color get backgroundColor {
    return Colors.white;
  }

  Color get borderColor {
    return AppColor.green53;
  }

  Color get shadowColor {
    return AppColor.green53;
  }

  Color get textColor {
    return const Color(0xFF4B4B4B);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: LayoutBuilder(
        builder: (context, constraints) {
          final ratio = constraints.maxWidth / 162.0;

          return Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColor.yellow00,AppColor.yellow01,AppColor.green2,AppColor.green01,AppColor.green1, AppColor.green53],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    shape: RoundedRectangleBorder(
                      /*side: BorderSide(
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: borderColor,
                      ),*/
                      borderRadius: BorderRadius.circular(24),
                    ),
                    shadows: [
                      BoxShadow(
                        color: shadowColor,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image(
                          image: AssetImage(icon),
                          width: 64,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          name,
                          style: StyleOfit.textStyleFW500(AppColor.whiteF2, 13, overflow: TextOverflow.visible, height: 1.2),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )),
            ],
          );
        },
      ),
    );
  }
}
