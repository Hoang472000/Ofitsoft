import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../data/entity/image/image_entity.dart';
import '../../../resource/color.dart';


class ImagePlayerWidget extends StatefulWidget {
  final List<ImageEntity> listImage;
  final int index;

  ImagePlayerWidget(this.listImage, this.index);

  @override
  _ImagePlayerWidgetState createState() => _ImagePlayerWidgetState();
}

class _ImagePlayerWidgetState extends State<ImagePlayerWidget> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _pageController = PageController(initialPage: currentIndex);
/*    _pageController.addListener(() {
      setState(() {
        currentIndex = _pageController.page!.round();
      });
    });*/
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [

            PageView.builder(
              controller: _pageController,
                itemCount: widget.listImage.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      Center(
                        child: Image.memory(
                          base64Decode(widget.listImage[index].contentView ?? ""),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.4),
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black.withOpacity(0.4),
                              ],
                              stops: [0, 0.08, 0.92, 1],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.listImage.length,
                      (index) => Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndex == index
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 5,left: 5,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
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



