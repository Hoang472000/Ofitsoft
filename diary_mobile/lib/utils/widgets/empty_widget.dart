import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../generated/l10n.dart';
import '../../resource/assets.dart';
import '../../resource/color.dart';
import '../../resource/style.dart';

class EmptyWidget extends StatefulWidget {
  const EmptyWidget({super.key});

  @override
  State<EmptyWidget> createState() => _EmptyWidgetState();
}

class _EmptyWidgetState extends State<EmptyWidget> with TickerProviderStateMixin {
  bool isVisible = true;
  bool checkFuture = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    _animationController.repeat(); // Để làm cho animation lặp lại liên tục
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: 0.9,
                    child: Image(
                      image: AssetImage(ImageAsset.imageEmpty),
                      width: MediaQuery.of(context).size.width / 1.5,
                    ),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width / 2.5, // Điều chỉnh vị trí ban đầu của icon
                  top: MediaQuery.of(context).size.height / 8, // Điều chỉnh vị trí ban đầu của icon
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      double angle = _animation.value * 2 * 3.14;
                      double x = (MediaQuery.of(context).size.width / 5) * cos(angle * 1);
                      double y = (MediaQuery.of(context).size.height / 8) * sin(angle * 1);

                      return Transform.translate(
                        offset: Offset(x, y),
                        child: Container(
                          margin: EdgeInsets.all(8),
                          width: 50,
                          height: 50,
                          child: Center(
                            child: Icon(Icons.search, color: AppColor.main, size: 40,),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
           /* SizedBox(
              height: MediaQuery.of(context).size.height / 44,
            ),*/
            Text(
              S.of(context).empty,
              style: StyleOfit.textStyleFW400(
                AppColor.whiteF2,
                18,
              ),
            )
          ],
        ),
      ),
    );
  }
}