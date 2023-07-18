import 'package:diary_mobile/resource/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../../../view_model/diary/list_diary_bloc.dart';

class InfomationActivityPage extends StatefulWidget {
  const InfomationActivityPage({super.key});

  @override
  _InfomationActivityPageState createState() => _InfomationActivityPageState();

  static Route route() {
    return Utils.pageRouteBuilder(InfomationActivityPage(), true);
  }
}

class _InfomationActivityPageState extends State<InfomationActivityPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => ListDiaryBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.background,
        body: BlocConsumer<ListDiaryBloc, ListDiaryState>(
            listener: (context, state) async {},
            builder: (blocContext, state) {
              return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CardTile(
                            label: "Tên nhật ký",
                            value: "Cây trồng",
                        image: ImageAsset.imageDiary),
                        CardTile(
                            label: "Địa chỉ",
                            value:
                                "số 108 Lò Đúc, Hai Bà Trưng, Hà Nội, Việt Nam,số 108 Lò Đúc, Hai Bà Trưng, Hà Nội, Việt Nam",
                            image: ImageAsset.imageDisaster),
                        CardTile(
                            label: "Loại vật nuôi/cây trồng",
                            value: "Quế tươi",
                            image: ImageAsset.imageTree),
                        CardTile(
                            label: "Diện tích",
                            value: "12.000",
                            image: ImageAsset.imageManagement),
                        CardTileDouble(
                            label1: "SL ban đầu",
                            value1: "10",
                            value2: "VNĐ",
                            image: ImageAsset.imageBudget),
                        CardTileDouble(
                            label1: "SL dự kiến",
                            value1: "15",
                            value2: "VNĐ",
                            image: ImageAsset.imageBudget),
                        CardTile(
                            label: "Sản lượng thu hoạch",
                            value: "12.000",
                            image: ImageAsset.imagePlantCrop),
                      ],
                    ),
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
      padding: EdgeInsets.only(top: 8, bottom: 8),
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
                  padding: EdgeInsets.all(4),
                  child: Text(
                    label,
                    style: StyleBkav.textStyleFW400(AppColor.black22, 16, overflow: TextOverflow.visible,),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(4),
                  /*padding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: AppColor.gray1.withOpacity(0.4),
                  ),*/
                  child: Text(
                    value,
                    style: StyleBkav.textStyleFW400(AppColor.black22, 16),
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
  Widget CardTileDouble(
      {required String label1,
        required String value1,
        required String value2,
        required String image,}) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8),
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
                  padding: EdgeInsets.all(4),
                  child: Text(
                    label1,
                    style: StyleBkav.textStyleFW400(AppColor.black22, 14),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(4),
         /*         padding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: AppColor.gray1.withOpacity(0.4),
                  ),*/
                  child: Text(
                    value1,
                    style: StyleBkav.textStyleFW400(AppColor.black22, 14),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      "ĐVT",
                      style: StyleBkav.textStyleFW400(AppColor.black22, 14),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(4),
           /*         padding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: AppColor.gray1.withOpacity(0.4),
                    ),*/
                    child: Text(
                      value2,
                      style: StyleBkav.textStyleFW400(AppColor.black22, 14),
                    ),
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
