import 'package:diary_mobile/resource/color.dart';
import 'package:diary_mobile/resource/style.dart';
import 'package:flutter/material.dart';

import '../../../data/entity/item_default/item_expansion.dart';
import '../../utils.dart';

class ExpansionTileCustom extends StatefulWidget {
  ExpansionTileCustom({super.key, required this.list});
  List<ItemExpansion> list;

  @override
  State<ExpansionTileCustom> createState() => _ExpansionTileCustomState();
}

class _ExpansionTileCustomState extends State<ExpansionTileCustom> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0.0) ,
      primary: true,
      shrinkWrap: true,
      children: <Widget>[ ListTileTheme(
        contentPadding: EdgeInsets.only(left: 12, right: 12, bottom: -4, top: -4),
        dense: true,
        horizontalTitleGap: -8.0,
        minLeadingWidth: 0,
    minVerticalPadding: 0,
        child: ExpansionTile(
          title: widget.list.isNotEmpty ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${widget.list[0].name}", style: StyleOfit.textStyleFW500(AppColor.whiteF2, 15)),
              Text("${widget.list[0].amount}", style: StyleOfit.textStyleFW500(AppColor.main, 15),),
            ],
          ) : Text('No Items'),
          //tilePadding: const EdgeInsets.symmetric(vertical: 0),
          //subtitle: Text('Trailing expansion arrow icon'),
          children: _buildItemTiles(),
        ),
      ),]
    );
  }

  List<Widget> _buildItemTiles() {
    List<Widget> tiles = [];

    for (int i = 1; i < widget.list.length; i++) {
      tiles.add(
        Padding(
          padding: const EdgeInsets.only(right: 35.0),
          child: ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${widget.list[i].name}", style: StyleOfit.textStyleFW500(AppColor.whiteF2, 15)),
                Text("${widget.list[i].amount}", style: StyleOfit.textStyleFW500(AppColor.main, 15),),
              ],
            ),
            minLeadingWidth: 0,
            minVerticalPadding: 0,
            dense: true,
            //contentPadding: EdgeInsets.zero,
          ),
        ),
      );
    }

    return tiles;
  }
}
