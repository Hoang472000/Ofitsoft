import 'package:diary_mobile/resource/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resource/assets.dart';
import '../utils/utils.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoadingPage());
  }

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Theme(data: ThemeData(), child: Scaffold(
      backgroundColor: AppColor.background,
      body: Utils.bkavCheckOrientation(
        context, SizedBox(
        width: double.infinity,
        height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              flex: 7,
              child: Container(
                alignment: Alignment.center,
                child: Image(image: AssetImage(ImageAsset.imageOfitsoftText), height: 200,),
              ),
            ),
        /*    Expanded(
              flex: 5,
              child: SvgPicture.asset(
                  IconAsset.icBackgroundAIBook,fit: BoxFit.cover,
              width: double.infinity),
            )*/

          ],
      ),
        ),
      ),
    )) ;
  }
}