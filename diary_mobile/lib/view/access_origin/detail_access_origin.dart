import 'dart:convert';
import 'dart:ffi';

import 'package:diary_mobile/resource/assets.dart';
import 'package:diary_mobile/utils/constants/api_const.dart';
import 'package:diary_mobile/utils/widgets/items/item_card_activity.dart';
import 'package:diary_mobile/view/diary_activity/infomation_diary/workflow_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../data/repository.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/dashed_circle.dart';
import '../../utils/widgets/bkav_app_bar.dart';
import '../../view_model/access_origin/detail_access_origin_bloc.dart';

class DetailAccessOrigin extends StatefulWidget {
  const DetailAccessOrigin({super.key, required this.id});
  final int id;

  @override
  _DetailAccessOriginState createState() => _DetailAccessOriginState();

  static Route route(int id) {
    return Utils.pageRouteBuilder(DetailAccessOrigin(id: id), true);
  }
}

class _DetailAccessOriginState extends State<DetailAccessOrigin> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => DetailAccessOriginBloc(context.read<Repository>())..add(GetDetailAccessOriginEvent(widget.id)),
      child: Scaffold(
        appBar: OfitAppBar(context,
          centerTitle: true,
          hasBottom: true,
          showDefaultBackButton: true,
          title: Text(
            "Thông tin lô sản phẩm",
            style: StyleOfit.textStyleFW700(Colors.white, 20),
          ),
          backgroundColor: AppColor.background,
        ),
        body: BlocBuilder<DetailAccessOriginBloc, DetailAccessOriginState>(
            builder: (blocContext, state) {
              return state.isShowProgress ?
              const Center(
                child: DashedCircle(size: 39, stringIcon: IconAsset.icLoadOtp),)
                  : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 40),
                  child: SingleChildScrollView(
                    //physics: const NeverScrollableScrollPhysics(),
                    child: state.detailAccessOrigin !=null ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        QrImageView(
                          data: '${ApiConst.qrCode}${state.detailAccessOrigin!.guid}',
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            CardTile(
                                label: "Tên lô sản phẩm",
                                value: "${state.detailAccessOrigin!.name} - ${state.detailAccessOrigin!.batchCode}",
                                image: ImageAsset.imageDiary),
                            CardTile(
                                label: "Tên công ty",
                                value: "${state.detailAccessOrigin!.companyName}",
                                image: ImageAsset.imageCompany),
                            CardTile(
                                label: "Tên sản phẩm",
                                value: "${state.detailAccessOrigin!.productName}",
                                image: ImageAsset.imageTree),
                            CardTile(
                                label: "Trọng lượng",
                                value: "${state.detailAccessOrigin!.weightTree}",
                                image: ImageAsset.imageFarmerProfile),
                            CardTile(
                                label: "Số lượng",
                                value: "${state.detailAccessOrigin!.quantity} ${state.detailAccessOrigin!.quantityUnitId}",
                                image: ImageAsset.imageBudget),
                            CardTile(
                                label: "Ngày sản xuất",
                                value: "${state.detailAccessOrigin!.manufactureDate}",
                                image: ImageAsset.imageCalendarBegin),
                            CardTile(
                                label: "Ngày hết hạn",
                                value: "${state.detailAccessOrigin!.expireDate}",
                                image: ImageAsset.imageCalendarEnd),
                            (state.detailAccessOrigin!.image ?? "").isNotEmpty ?
                            Container(
                              padding: const EdgeInsets.only(top: 8, bottom: 0, left: 4),
                              child: Text("Hình ảnh liên quan", style:
                              StyleOfit.textStyleFW400(AppColor.black22, 16, overflow: TextOverflow.visible,),),
                            ) : const SizedBox(),
                            Container(
                              padding: const EdgeInsets.all(24),
                              child: Center(
                                child: Image.memory(
                                  gaplessPlayback: true,
                                  base64Decode(state.detailAccessOrigin!.image ??
                                      ""),
                                  //height: MediaQuery.of(context).size.height/2,
                                  //width: MediaQuery.of(context).size.width/1.5,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error,
                                      stackTrace) {
                                    return Container(
                                      /*height: MediaQuery.of(context).size.width/2,
                                      width: MediaQuery.of(context).size.width/2,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color:  AppColor.grayC7),
                                      child: Center(
                                        child: Text(
                                          (state.detailAccessOrigin!.productName ?? "")*//*.substring(0,1)*//*,
                                          style:
                                          StyleOfit.textStyleFW700(AppColor.green53, 16),
                                        ),
                                      ),*/
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ) : Container(),
                  ));
            }),
      ),
    );
  }

  Widget CardTile(
      {required String image,
        required String label,
        required String value}) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4,right: 8.0),
            child: Image(
              image: AssetImage(image),
              width: 40,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    label,
                    style: StyleOfit.textStyleFW400(AppColor.black22, 16, overflow: TextOverflow.visible,),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    value,
                    style: StyleOfit.textStyleFW400(AppColor.black22, 16),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardUrl(
      {required String image,
        required String label,
        required String value}) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4,right: 8.0),
            child: Image(
              image: AssetImage(image),
              width: 40,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    label,
                    style: StyleOfit.textStyleFW400(AppColor.black22, 16, overflow: TextOverflow.visible,),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(4),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft),
                  child: Text(
                      value,
                      style: StyleOfit.textStyleFW400(AppColor.black22, 16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  onPressed: () {
                    Utils.launchBrowserUrl(value);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget CardTileDouble(
      {required String label1,
        required String value1,
        required String value2,
        required String image,}) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4,right: 8.0),
            child: Image(
              image: AssetImage(image),
              width: 40,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    label1,
                    style: StyleOfit.textStyleFW400(AppColor.black22, 16),
                  ),
                ),
                RichText(
                    overflow: TextOverflow.clip,
                    text: TextSpan(
                      text: "$value1 ",
                      style: StyleOfit.textStyleFW400(AppColor.black22, 16),
                      children:  <TextSpan>[
                        TextSpan(
                          text: value2,
                          style: StyleOfit.textStyleFW400(AppColor.black22, 16),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemAccount(BuildContext context,
      {required String image,
        required String text,
        required VoidCallback voidCallback,
        String? iconRight}) {
    return InkWell(
      onTap: () {
        voidCallback();
      },
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 4),
            child: Image(
              image: AssetImage(image),
              width: 40,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              padding: const EdgeInsets.only(left: 6, right: 6),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFB2B8BB),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        text,
                        style: StyleOfit.textStyleFW400(AppColor.black22, 16),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      voidCallback();
                    },
                    icon: SvgPicture.asset(
                      iconRight ?? IconAsset.icArrowRight,
                      color: AppColor.main,
                    ),
                    padding: const EdgeInsets.only(
                        left: 8, right: 0, top: 10, bottom: 10),
                    constraints: const BoxConstraints(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
