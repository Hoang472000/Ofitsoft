import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../utils.dart';
import '../bkav_app_bar.dart';


class PDFScreen extends StatefulWidget {
  final String base64Data;
  PDFScreen({required this.base64Data});

  _PDFScreenState createState() => _PDFScreenState();

  static Route route(String base64Data) {
    return Utils.pageRouteBuilder(
        PDFScreen(
            base64Data: base64Data
        ),
        true);
  }
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
  Completer<PDFViewController>();
  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  String base64Data = '';

/*  Future<String> readPDF(String file, String fileName) async {
    if (fileName.contains('/')) {
      fileName = fileName.replaceAll("/", "");
    }
    String base64 = await rootBundle.loadString(file);
    return base64;
  }*/
  Future<String> loadBase64Data(String assetPath) async {
    String base64 = await rootBundle.loadString(assetPath);
    return base64;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    base64Data = await loadBase64Data(widget.base64Data);
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
     // backgroundColor: AppColor.background,
      appBar: OfitAppBar(
        context,
        centerTitle: true,
        showDefaultBackButton: true,
        title: Text(
          "Chi tiết",
          style: StyleOfit.textStyleFW700(Colors.white, 20),
        ),
        backgroundColor: AppColor.main,
        actions: [],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            // padding: EdgeInsets.all(16),
            child:  PDFView(
              // filePath: widget.path,
              pdfData: base64Decode(base64Data),
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: true,
              pageSnap: true,
              fitPolicy: FitPolicy.BOTH,
              fitEachPage: true,
              preventLinkNavigation:
              false, // if set to true the link is handled in flutter
              onRender: (pagess) {
                setState(() {
                  pages = pagess!;
                  isReady = true;
                });
              },
              onError: (error) {
                setState(() {
                  errorMessage = error.toString();
                });
                print(error.toString());
              },
              onPageError: (page, error) {
                setState(() {
                  errorMessage = '$page: ${error.toString()}';
                });
                print('$page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController pdfViewController) {
                _controller.complete(pdfViewController);
              },
              onLinkHandler: (uri) {
                print('goto uri: $uri');
              },
              onPageChanged: (page, total) {
                print('page change: $page/$total');
                setState(() {
                  currentPage = page!;
                });
              },
            ),
          ),
          errorMessage.isEmpty
              ? !isReady
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Container()
              : Center(
            child: Text(errorMessage),
          )
        ],
      ),
      // floatingActionButton: FutureBuilder<PDFViewController>(
      //   future: _controller.future,
      //   builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
      //     if (snapshot.hasData) {
      //       return FloatingActionButton.extended(
      //         label: Text("Trang ${pages ~/ 2}"),
      //         onPressed: () async {
      //           await snapshot.data.setPage(pages ~/ 2);
      //         },
      //       );
      //     }
      //
      //     return Container();
      //   },
      // ),
    );
  }
}