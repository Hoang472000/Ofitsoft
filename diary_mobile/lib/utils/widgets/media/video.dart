import 'dart:io';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../../resource/color.dart';


class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;

  VideoPlayerWidget(this.videoPath);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.file(File(widget.videoPath));
    _chewieController = ChewieController(
        //aspectRatio: 16 / 9,
      videoPlayerController: _videoController,
      autoPlay: true,
      looping: true,
        zoomAndPan: true,
        routePageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondAnimation, provider) {
          return AnimatedBuilder(
            animation: animation,
            builder: (context, widget) {
              return VideoScaffold(
                child: Scaffold(
                  //resizeToAvoidBottomPadding: false,
                  resizeToAvoidBottomInset: false,
                  body: Container(
                    alignment: Alignment.center,
                    color: AppColor.background,
                    child: provider,
                  ),
                ),
              );
            },
          );
        }
      // Cấu hình thêm tùy chỉnh khác tại đây
    );
  }
  @override
  Widget build(BuildContext context) {
  /*  ScreenUtil.init(
      context,
      designSize: Size(360, 640), // Kích thước thiết kế ban đầu của bạn
    );*/
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Chewie(
          controller: _chewieController,
    ),
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
    _chewieController.dispose();
  }
}

class VideoScaffold extends StatefulWidget {
  const VideoScaffold({super.key, required this.child});

  final Widget child;

  @override
  State<StatefulWidget> createState() => _VideoScaffoldState();
}

class _VideoScaffoldState extends State<VideoScaffold> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    AutoOrientation.landscapeAutoMode(forceSensor: true);
    super.initState();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    AutoOrientation.portraitAutoMode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
