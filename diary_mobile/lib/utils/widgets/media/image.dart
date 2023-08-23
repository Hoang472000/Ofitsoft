import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../resource/color.dart';


class ImagePlayerWidget extends StatefulWidget {
  final String base64Image;

  ImagePlayerWidget(this.base64Image);

  @override
  _ImagePlayerWidgetState createState() => _ImagePlayerWidgetState();
}

class _ImagePlayerWidgetState extends State<ImagePlayerWidget> {


  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.background,
        body: SafeArea(
          child: Center(
            child: Image.memory(
              gaplessPlayback: true,
              base64Decode(widget.base64Image),
/*          height: state.imageHeight,
              width: state.imageWidth,*/
              fit: BoxFit.cover,
            ),
          ),
        ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}



