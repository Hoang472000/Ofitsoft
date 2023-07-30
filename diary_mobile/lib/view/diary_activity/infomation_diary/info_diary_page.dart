import 'package:diary_mobile/resource/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../data/repository.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../../../view_model/diary/list_diary_bloc.dart';
import '../../../view_model/diary_activity/activity/info_diary_bloc.dart';

class InfoDiaryPage extends StatefulWidget {
  const InfoDiaryPage({super.key, required this.id});
  final int id;

  @override
  _InfoDiaryPageState createState() => _InfoDiaryPageState();

  static Route route(int id) {
    return Utils.pageRouteBuilder(InfoDiaryPage(id: id,), true);
  }
}

class _InfoDiaryPageState extends State<InfoDiaryPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => DetailDiaryBloc(context.read<Repository>())..add(GetDetailDiaryEvent(widget.id)),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.background,
        body: BlocBuilder<DetailDiaryBloc, DetailDiaryState>(
            builder: (blocContext, state) {
              return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: state.detailDiary !=null ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CardTile(
                            label: "Tên nhật ký",
                            value: "${state.detailDiary!.name}",
                        image: ImageAsset.imageDiary),
       /*                 CardTile(
                            label: "Địa chỉ",
                            value:
                                "số 108 Lò Đúc, Hai Bà Trưng, Hà Nội, Việt Nam,số 108 Lò Đúc, Hai Bà Trưng, Hà Nội, Việt Nam",
                            image: ImageAsset.imageDisaster),*/
                        CardTile(
                            label: "Loại vật nuôi/cây trồng",
                            value: "${state.detailDiary!.cropName}",
                            image: ImageAsset.imageTree),
                        CardTile(
                            label: "Diện tích",
                            value: "${state.detailDiary!.area} ${state.detailDiary!.areaUnit}",
                            image: ImageAsset.imageManagement),
                        CardTileDouble(
                            label1: "Số lượng ban đầu",
                            value1:  "${state.detailDiary!.amount== -1 ? '' : (state.detailDiary!.amount??0).toInt()}",
                            value2: "${state.detailDiary!.amountUnit}",
                            image: ImageAsset.imageBudget),
                        CardTileDouble(
                            label1: "Sản lượng ước tính",
                            value1: "${state.detailDiary!.yieldEstimate== -1 ? '' : (state.detailDiary!.yieldEstimate??0).toInt()}",
                            value2: "${state.detailDiary!.yieldEstimateUnit}",
                            image: ImageAsset.imageBudget),
                        CardTile(
                            label: "Ngày bắt đầu",
                            value: "${state.detailDiary!.startDate}",
                            image: ImageAsset.imageCalendarBegin),
                        ((state.detailDiary!.status??'').compareTo("done") == 0)?CardTile(
                            label: "Ngày kết thúc",
                            value: "${state.detailDiary!.startDate}",
                            image: ImageAsset.imageCalendarEnd): Container(),
                        CardTile(
                            label: "Trạng thái",
                            value: "${state.detailDiary!.status}",
                            image: ImageAsset.imageStatus),
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
                    style: StyleBkav.textStyleFW400(AppColor.black22, 16, overflow: TextOverflow.visible,),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(4),
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
                    style: StyleBkav.textStyleFW400(AppColor.black22, 14),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(4),
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
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      "ĐVT",
                      style: StyleBkav.textStyleFW400(AppColor.black22, 14),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(4),
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
