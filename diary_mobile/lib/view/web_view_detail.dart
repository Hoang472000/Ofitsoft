/*
import 'dart:io';
import 'package:ai_book/resource/color.dart';
import 'package:ai_book/resource/style.dart';
import 'package:ai_book/utils/logger.dart';
import 'package:ai_book/utils/utils.dart';
import 'package:ai_book/utils/widgets/bkav_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewDetail extends StatefulWidget {
  const WebViewDetail({Key? key, required this.title, required this.urlWeb})
      : super(key: key);

  final String title;
  final String urlWeb;

  static Route route(String title, String url) {
    return Utils.pageRouteBuilder(
        WebViewDetail(
          title: title,
          urlWeb: url,
        ),
        true);
  }

  @override
  WebViewDetailState createState() => WebViewDetailState();
}

class WebViewDetailState extends State<WebViewDetail> {

  int loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) {
      // WebView.platform = AndroidWebView();
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BkavAppBar(
        context,
        showDefaultBackButton: true,
        backgroundColor: AppColor.main,
        title: Text(
          widget.title,
          style: StyleBkav.textStyleFW700(Colors.white, 18),
        ),
      ),
      body: Stack(
        children: [
          // WebView(
          //   initialUrl: widget.urlWeb,
          //   javascriptMode: JavascriptMode.unrestricted,
          //
          //   onPageStarted: (url) {
          //     Logger.loggerDebug("Bkav DucLQ startLoad");
          //     setState(() {
          //       loadingPercentage = 0;
          //     });
          //   },
          //   onProgress: (progress) {
          //     Logger.loggerDebug("Bkav DucLQ loading  $progress");
          //     setState(() {
          //       loadingPercentage = progress;
          //     });
          //   },
          //   onPageFinished: (url) {
          //     setState(() {
          //       loadingPercentage = 100;
          //     });
          //   },
          // ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
        ],
      )
    );
  }

}
*/
