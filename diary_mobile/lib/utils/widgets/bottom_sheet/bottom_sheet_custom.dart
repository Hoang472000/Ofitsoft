import 'dart:convert';

import 'package:diary_mobile/resource/style.dart';
import 'package:flutter/material.dart';

import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../extenstion/extenstions.dart';
import '../../utils.dart';
import '../checkbox/checkbox_custom_widget.dart';


class BottomSheetCustomWidget extends StatefulWidget {
  final List list;
  final int posSelected;
  final String title;
  final bool haveSearch;

  const BottomSheetCustomWidget(
      {required this.list,
        required this.posSelected,
        required this.title,Key? key,this.haveSearch = false})
      : super(key: key);

  @override
  _BottomSheetCustomWidgetState createState() =>
      _BottomSheetCustomWidgetState();
}

class _BottomSheetCustomWidgetState extends State<BottomSheetCustomWidget> {
  int result = -1;
  double appBarHeight = 44;
  double itemHeight = 50;
  double searchWidgetHeight = 55;
  List _list = [];
  int posSelected = -1;
  String title = "";
  TextEditingController controller = TextEditingController();
  late ScrollController scrollController;
  GlobalKey stickyKey = GlobalKey();
  double heightWidget = 0;
  var focusNode = FocusNode();
  bool hasSearch = false;

  @override
  void initState() {
    _list = widget.list;
    posSelected = widget.posSelected;
    title = widget.title;
    scrollController = _list!= [] ? ScrollController(
        initialScrollOffset: (itemHeight * posSelected).toDouble()) : ScrollController();
    if (widget.haveSearch == null) {
      hasSearch = false;
    } else {
      hasSearch = widget.haveSearch;
    }
    controller.addListener(() {
      setState(() {
        listDataSearch(controller.text);
      });
    });
    super.initState();
  }

  List listDataSearch(String textChanged) {
    if (textChanged.isEmpty) {
      return _list;
    } else {
      List listFilter = _list.where((item) {
        return Utils.formatText(Extension().getValueDisplay(item).toLowerCase())
            .contains(Utils.formatText(textChanged.toLowerCase()));
      }).toList();
      return listFilter;
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Tính toán chiều cao của bottom sheet
    double maxItemDisplay = (MediaQuery.of(context).size.height -
        (AppBar().preferredSize.height + 40) -
        (appBarHeight + searchWidgetHeight + 8 * 2)) /
        itemHeight;
    print("HoangCV: maxItemDisplay: ${maxItemDisplay} : ${_list.length}");
    if (_list.length > maxItemDisplay) {
      int maxItemDisplayInt = maxItemDisplay.toInt();
      heightWidget = (maxItemDisplayInt * 60 + appBarHeight);
    } else {
      if (hasSearch) {
        if (_list.length == 0) {
          heightWidget = appBarHeight + 60;
        } else {
          heightWidget = (_list.length * 60 + appBarHeight + 60); // thêm appBarHeight và height_150 khi danh sách chỉ có 1 phần tử
        }
      } else {
        if (_list.length == 0) {
          heightWidget = appBarHeight;
        } else {
          heightWidget = (_list.length * 74 + appBarHeight - 16);
        }
      }
    }

    return Padding(
      key: stickyKey,
      padding: EdgeInsets.only(top: AppBar().preferredSize.height + 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          color: Colors.white,
        ),
        height: heightWidget,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: hasSearch
                      ? appBarHeight + searchWidgetHeight
                      : appBarHeight),
              child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  controller: scrollController,
                  itemCount: listDataSearch(controller.text).length,
                  itemBuilder: (context, index) {
                    bool isItemSelected = index == posSelected;
                    return GestureDetector(
                      onTap: () {
                        result = _list.indexWhere((element) =>
                        element == listDataSearch(controller.text)[index]);
                        Navigator.pop(context, result);
                      },
                      child: Stack(
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 12),
                              alignment: Alignment.centerLeft,
                              width: double.infinity,
                              color: Colors.white,
                              //height: itemHeight,
                              height: Extension()
                                          .getValueDisplay(listDataSearch(
                                              controller.text)[index])
                                          .toString()
                                          .length <
                                      50
                                  ? !(listDataSearch(controller.text)[index] is String) && listDataSearch(controller.text)[index]?.image!='' ? 70 : itemHeight
                                  : Extension()
                                              .getValueDisplay(listDataSearch(
                                                  controller.text)[index])
                                              .toString()
                                              .length <
                                          100
                                      ? 58
                                      : 80,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [(!(listDataSearch(controller.text)[index] is String) && listDataSearch(controller.text)[index].image!=null && listDataSearch(controller.text)[index].image !='') ?
                                        Flexible(
                                            flex: 1,child: Image.memory(gaplessPlayback: true,
                                          base64Decode(listDataSearch(controller.text)[index]?.image ?? ""),
                                          height: 65, fit: BoxFit.fitWidth,
                                        ),) : const SizedBox(),
                                        Flexible(
                                          flex: 3,
                                          child: Text(
                                            "${Extension().getValueDisplay(
                                              listDataSearch(controller.text)[index],
                                            )}",
                                            style: TextStyle(
                                                color: !isItemSelected
                                                    ? Colors.black
                                                    : Theme.of(context)
                                                        .primaryColorDark,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: CheckboxCustomWidget(
                                      isChecked: isItemSelected,
                                      colorBorder: Colors.white,
                                    ),
                                  )
                                ],
                              )),
                          Divider(
                            height: 1,
                            thickness: 1,
                            indent: 10,
                            color: Colors.black12,
                          )
                          // Divider(),
                        ],
                      ),
                    );
                  }),
            ),

            ///App bar
            Container(
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        "${title}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Theme(
                        data: ThemeData(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context, -1);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: appBarHeight / 4),
                            child: Text(
                              "Đóng",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                height: appBarHeight,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12)),
                    color: Theme.of(context).primaryColor)),

            /// Search
            hasSearch
                ? Container(
              margin: EdgeInsets.only(top: appBarHeight),
              height: searchWidgetHeight,
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                  horizontal: 16, vertical: 8),
              child: TextField(
                enabled: _list.length != 0,
                focusNode: focusNode,
                controller: controller,
                style: StyleOfit.textStyleFW400(AppColor.black22, 18),
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFB2B8BB),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFB2B8BB),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  suffixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  hintText: "Tìm kiếm",
                  contentPadding: EdgeInsets.only(
                    left: 16,
                    right: 20,
                    top: 8,
                    bottom: 8,
                  ),
                ),
              ),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
