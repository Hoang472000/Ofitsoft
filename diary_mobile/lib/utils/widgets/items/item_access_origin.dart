import 'package:diary_mobile/data/entity/access/product_batch.dart';
import 'package:flutter/material.dart';
import '../../../resource/color.dart';
import '../../../utils/utils.dart';

class ItemAccessOrigin extends StatefulWidget {
  final ProductBatch productBatch;
  final VoidCallback callbackChooseItem;

  ItemAccessOrigin({
    Key? key,
    required this.productBatch,
    required this.callbackChooseItem,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemAccessOriginState();
}

class _ItemAccessOriginState extends State<ItemAccessOrigin> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        widget.callbackChooseItem();
      },
      onLongPress: () {
      },
      child: Container(
        padding: const EdgeInsets.only(top: 8),
        child: Container(
          padding:
          const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
          margin: const EdgeInsets.only(left: 20, right: 16, top: 4, bottom: 4),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColor.green53,
                  blurRadius: 0,
                  offset: Offset(-5.0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
              color: /*widget.isChoose ? Colors.red[100] :*/
              Colors.white),
          child: Container(
            padding:
            const EdgeInsets.only(top: 5, bottom: 12, left: 16, right: 0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(bottom: 0, top: 10),
                          child: RichText(
                            text: Utils.convertText(
                                "Tên lô sản phẩm: ",
                                "${widget.productBatch.name}",
                                AppColor.blue15,
                                15),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textScaleFactor: MediaQuery.of(context).textScaleFactor,
                          )),
                      SizedBox(
                        child: Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(top: 5),
                            child: RichText(
                              text: Utils.convertText(
                                  "Mã lô sản phẩm: ",
                                  "${widget.productBatch.batchCode}",
                                  AppColor.blue15,
                                  14),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textScaleFactor: MediaQuery.of(context).textScaleFactor,
                            )),
                      ),
                      SizedBox(
                        child: Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(top: 5),
                            child: RichText(
                              text: Utils.convertText(
                                  "Sản phẩm: ",
                                  "${widget.productBatch.productName}",
                                  AppColor.blue15,
                                  14),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textScaleFactor: MediaQuery.of(context).textScaleFactor,
                            )),
                      ),
                      SizedBox(
                        child: Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(top: 5),
                            child: RichText(
                              text: Utils.convertText(
                                  "Trọng lượng: ",
                                  "${widget.productBatch.weightTree}",
                                  AppColor.blue15,
                                  14),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textScaleFactor: MediaQuery.of(context).textScaleFactor,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
