import 'dart:ffi';

import 'package:diary_mobile/resource/assets.dart';
import 'package:diary_mobile/utils/widgets/items/item_card_activity.dart';
import 'package:diary_mobile/view/diary_activity/infomation_diary/workflow_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../data/repository.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../../utils/widgets/dashed_circle.dart';
import '../../../view_model/diary_activity/activity/info_diary_bloc.dart';
import '../../home/home_page.dart';
import '../../report/list_report_result_view.dart';
import '../activity/activity_page.dart';
import '../activity/activity_transaction_page.dart';

class InfoDiaryPage extends StatefulWidget {
  const InfoDiaryPage({super.key, required this.id, required this.diary});
  final int id;
  final Diary diary;

  @override
  _InfoDiaryPageState createState() => _InfoDiaryPageState();

  static Route route(int id, Diary diary) {
    return Utils.pageRouteBuilder(InfoDiaryPage(id: id,diary: diary,), true);
  }
}

class _InfoDiaryPageState extends State<InfoDiaryPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => DetailDiaryBloc(context.read<Repository>())..add(GetDetailDiaryEvent(widget.id)),
      child: Scaffold(
        appBar: OfitAppBar(context,
            centerTitle: true,
            hasBottom: true,
            showDefaultBackButton: false,
            title: Text(
              "Thông tin chi tiết",
              style: StyleOfit.textStyleFW700(Colors.white, 20),
            ),
            leading: IconButton(
              icon: const Icon(Icons.home_outlined),
              onPressed: () async {
                Navigator.of(context).pushAndRemoveUntil(
                    await HomePage.route(), (route) => false);
              },
              color: Colors.white,
              //padding: EdgeInsets.zero,
            )),
        //resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.background,
        resizeToAvoidBottomInset: true,
        body: BlocBuilder<DetailDiaryBloc, DetailDiaryState>(
            builder: (blocContext, state) {
              return state.isShowProgress ?
              const Center(
                  child: DashedCircle(size: 39, stringIcon: IconAsset.icLoadOtp),)
              : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 20),
                  child: SingleChildScrollView(
                    //physics: const NeverScrollableScrollPhysics(),
                    child: state.detailDiary !=null ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /*Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 12.0,
                              ),
                                itemCount: state.listActivityFarm.length,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ItemCardActivity(
                                      name: state
                                          .listActivityFarm[index].nameActivity,
                                      icon: state
                                          .listActivityFarm[index].iconActivity,
                                      onTap: () async{
                                        if(state.listActivityFarm[index].id == 1){
                                          var result = await Navigator.push(context,
                                              ActivityPage.route("activity",
                                                 widget.id, widget.diary,state
                                                    .listActivityFarm[index], state.listActivityDiary));
                                          if(result != null && result[1].isNotEmpty){
                                            print("HoangCV: call back : ");
                                            blocContext.read<DetailDiaryBloc>().add(GetDetailDiaryEvent(widget.id, updateHarvesting : result[0], list: result[1]));
                                          }
                                        } else if(state.listActivityFarm[index].id == 2){
                                          var result = await Navigator.push(context,
                                              ActivityPage.route("harvesting",
                                                widget.id, widget.diary,state
                                                    .listActivityFarm[index], state.listActivityDiary));
                                          if(result != null && result[0]){
                                            blocContext.read<DetailDiaryBloc>().add(GetDetailDiaryEvent(widget.id, updateHarvesting : result[0], list: result[1]));
                                          }
                                        } else if(state.listActivityFarm[index].id == 3){
                                          var result = await Navigator.of(context).push(
                                              WorkflowPage.route(
                                                  state.detailDiary!.productProcessId ??
                                                      -1));
                                          *//*var result = await Navigator.push(context,
                                              ActivityTransactionPage.route("sell",
                                                seasonFarmId: widget.id,
                                                  diary: widget.diary,
                                                  listActivityTransaction: state.listActivityTransaction,
                                                  listActivityDiary: state.listActivityDiary));
                                          if(result != null && result[0]){
                                            blocContext.read<DetailDiaryBloc>().add(GetDetailDiaryEvent(widget.id, updateHarvesting : result[0], listTransaction: result[1]));
                                          }*//*
                                        }
                                      });
                                }),
                        ),*/
                          CardTile(
                            label: "Tên nhật ký",
                            value: "${state.detailDiary!.name}",
                        image: ImageAsset.imageDiary),
                        CardTile(
                            label: "Tên nông hộ",
                            value: "${state.detailDiary!.farmerName}",
                            image: ImageAsset.imageFarmerProfile),
                        CardTile(
                            label: "Tên vùng trồng",
                            value: "${state.detailDiary!.areaName} ${state.detailDiary!.areaCode}",
                            image: ImageAsset.imageManagement),
                        CardTile(
                            label: "Tên lô trồng",
                            value: "${state.detailDiary!.farmName} ${state.detailDiary!.farmCode}",
                            image: ImageAsset.imageManagement),
                        if((state.detailDiary!.googleMap??"").isNotEmpty)
                        cardUrl(
                            label: "Địa chỉ",
                            value: "${state.detailDiary!.googleMap}",
                            image: ImageAsset.imageLocation),
       /*                 CardTile(
                            label: "Địa chỉ",
                            value:
                                "số 108 Lò Đúc, Hai Bà Trưng, Hà Nội, Việt Nam,số 108 Lò Đúc, Hai Bà Trưng, Hà Nội, Việt Nam",
                            image: ImageAsset.imageDisaster),*/
       /*                 (state.detailDiary!.productProcessName ?? "").isNotEmpty ?
                          itemAccount(context,
                              image: ImageAsset.imageDiary,
                              text: "${state.detailDiary!.productProcessName}",
                              voidCallback: () async {
                                var result = await Navigator.of(context).push(
                                    WorkflowPage.route(
                                        state.detailDiary!.productProcessId ??
                                            -1));
                              }) : SizedBox(),*/
                        CardTile(
                            label: "Loại vật nuôi/cây trồng",
                            value: "${state.detailDiary!.cropName}",
                            image: ImageAsset.imageTree),
                        CardTile(
                            label: "Diện tích",
                            value: "${state.detailDiary!.area} ${state.detailDiary!.areaUnitName}",
                            image: ImageAsset.imageManagement),
                        state.detailDiary!.amount == -1 ?
                        Container() :
                        CardTileDouble(
                            label1: "Số lượng ban đầu",
                            value1:  "${state.detailDiary!.amount == -1 ? '' : state.detailDiary!.amount??0}",
                            value2: "${state.detailDiary!.amountUnitName}",
                            image: ImageAsset.imageBudget),
                        state.detailDiary!.yieldReal == -1 ?
                        Container() :
                        CardTileDouble(
                            label1: "Sản lượng thu hoạch",
                            value1:  "${state.detailDiary!.yieldReal == -1 ? '' : state.detailDiary!.yieldReal??0}",
                            value2: "${state.detailDiary!.yieldRealUnitName}",
                            image: ImageAsset.imageBudget),
                        state.detailDiary!.yieldEstimate == -1 ?
                        Container() :
                        CardTileDouble(
                            label1: "Sản lượng ước tính",
                            value1: "${state.detailDiary!.yieldEstimate == -1 ? '' : state.detailDiary!.yieldEstimate??0}",
                            value2: "${state.detailDiary!.yieldEstimateUnitName}",
                            image: ImageAsset.imageBudget),
                        CardTile(
                            label: "Ngày bắt đầu",
                            value: "${state.detailDiary!.startDate}",
                            image: ImageAsset.imageCalendarBegin),
                        ((state.detailDiary!.status??'').compareTo("done") == 0)?CardTile(
                            label: "Ngày kết thúc",
                            value: "${state.detailDiary!.endDate}",
                            image: ImageAsset.imageCalendarEnd): Container(),
                        //draft//processing//done//cancelled//
                        CardTile(
                            label: "Trạng thái",
                            value: (state.detailDiary!.status ?? '' ).compareTo("draft")==0?"Lên kế hoạch":
                            (state.detailDiary!.status ?? '' ).compareTo("processing")==0?"Đang diễn ra":
                            (state.detailDiary!.status ?? '' ).compareTo("done")==0?"Hoàn thành":
                            (state.detailDiary!.status ?? '' ).compareTo("cancelled")==0?"Đã hủy": "",
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
