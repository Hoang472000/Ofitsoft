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
  final String title;
  PDFScreen({required this.base64Data, required this.title});

  _PDFScreenState createState() => _PDFScreenState();

  static Route route(String base64Data, String title) {
    return Utils.pageRouteBuilder(
        PDFScreen(
            base64Data: base64Data,
            title: title
        ),
        true);
  }
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller = Completer<PDFViewController>();
  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  String base64Data = '';

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    base64Data = await rootBundle.loadString(widget.base64Data);
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
      appBar: OfitAppBar(
        context,
        centerTitle: true,
        showDefaultBackButton: true,
        title: Text(
          widget.title,
          style: StyleOfit.textStyleFW700(Colors.white, 20),
        ),
        backgroundColor: AppColor.main,
        actions: [],
      ),
      body: Stack(
        children: <Widget>[
          FutureBuilder<String>(
            future: rootBundle.loadString(widget.base64Data),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Container(
                    child: PDFView(
                      pdfData: base64Decode(snapshot.data!),
                      enableSwipe: true,
                      swipeHorizontal: false,
                      autoSpacing: false,
                      pageFling: true,
                      pageSnap: true,
                      fitPolicy: FitPolicy.BOTH,
                      fitEachPage: true,
                      preventLinkNavigation: false,
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
                  );
                } else {
                  return Text("Không thể tải dữ liệu PDF");
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          errorMessage.isEmpty
              ? !isReady
              ? Center(child: CircularProgressIndicator())
              : Container()
              : Center(child: Text(errorMessage)),
        ],
      ),
    );
  }
}