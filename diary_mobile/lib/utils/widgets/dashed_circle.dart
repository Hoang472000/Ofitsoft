import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//progress bar timer count down
class CircularBorder extends StatelessWidget {
  final double size;
  final double width;
  final Widget icon;
  final String stringIcon;

  const CircularBorder({required this.size ,this.width =4.0, required this.icon, required this.stringIcon}): super();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: SvgPicture.asset(stringIcon),
    );
  }
}
class DashedCircle extends StatefulWidget {
  final double size;
  final String stringIcon;

  const DashedCircle ({Key? key,  required this.size,required this.stringIcon }) : super(key: key);


  @override
  DashedBorderState createState() => DashedBorderState();
}
class DashedBorderState extends State<DashedCircle> with TickerProviderStateMixin<DashedCircle> {

  late final AnimationController _controller =
  AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat();
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: child,
        );
      },
      child: CircularBorder(icon: Container(),size: widget.size,stringIcon: widget.stringIcon),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}