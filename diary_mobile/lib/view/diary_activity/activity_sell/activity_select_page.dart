
import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../data/repository.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../../utils/widgets/dashed_circle.dart';
import '../../../view_model/diary_activity/activity/activity_sell/activity_select_bloc.dart';
import '../../../utils/widgets/items/item_activity_select.dart';

class ActivitySelectPage extends StatefulWidget {
  const ActivitySelectPage(
      {super.key,
        required this.diary, required this.activityDiary});

  final List<ActivityDiary> activityDiary;
  final Diary diary;

  @override
  _ActivitySelectPageState createState() => _ActivitySelectPageState();

  static Route route(Diary diary, List<ActivityDiary> activityDiary) {
    return Utils.pageRouteBuilder(
        ActivitySelectPage(
          diary: diary,
          activityDiary: activityDiary,
        ),
        true);
  }
}

class _ActivitySelectPageState extends State<ActivitySelectPage> {
  bool visible = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivitySelectBloc(context.read<Repository>())
        ..add(GetListActivitySelectEvent(widget.activityDiary, widget.diary)),
      child: GestureDetector(
        onTap: () {
          setState(() {
            visible = true;
          });
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColor.background,
          appBar: OfitAppBar(
            context,
            centerTitle: true,
            showDefaultBackButton: true,
            title: Text(
              "Chọn hoạt động",
              style: StyleOfit.textStyleFW700(Colors.white, 20),
            ),
            backgroundColor: AppColor.main,
            actions: [],
            /*leading: BlocBuilder<DetailActivityBloc, DetailActivityState>(
  builder: (blocContext, state) {
    return IconButton(
            onPressed: () {
              print("HoangCV: bugugugu");
              blocContext
                  .read<DetailActivityBloc>()
                  .add(BackEvent(copiesActivityDiary, listCopies2, listCopies));
              Navigator.pop(context);
            },
      icon: SvgPicture.asset(
          IconAsset.icArrowLeft,
          height: 20,
          color: AppColor.whiteF2
      ),
      color: Colors.white,
      padding: EdgeInsets.zero,
          );
  },
),*/
          ),
          body: BlocConsumer<ActivitySelectBloc, ActivitySelectState>(
              listener: (blocContext, state) async {
              }, builder: (blocContext, state) {
            return state.isShowProgress /*&& (state.listDiaryActivity.length == 0 || state.listDiaryMonitor.length == 0)*/
                ? const Center(
              child:
              DashedCircle(size: 39, stringIcon: IconAsset.icLoadOtp),
            )
                : RefreshIndicator(
              onRefresh: () async {
                blocContext.read<ActivitySelectBloc>().add(GetListActivitySelectEvent(widget.activityDiary,
                    widget.diary));
              },
              child: Stack(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: (){
                                blocContext.read<ActivitySelectBloc>().add(
                                    AddChooseAllDiary(state.amountSelected == state.listDiaryActivity.length));
                              },
                              child: Row(
                                children: [
                                  SizedBox(width: 5,),
                                  IconButton(
                                      onPressed: () {
                                        blocContext.read<ActivitySelectBloc>().add(
                                            AddChooseAllDiary(state.amountSelected == state.listDiaryActivity.length));
                                      },
                                      icon: state.amountSelected == state.listDiaryActivity.length
                                          ? const Icon(
                                        Icons.check_box_outlined,
                                        color: AppColor.main,
                                        size: 20,
                                      )
                                          : const Icon(
                                        Icons.check_box_outline_blank,
                                        color: AppColor.main,
                                        size: 20,
                                      ),
                                      padding: EdgeInsets.zero),
                                  Text(state.amountSelected == state.listDiaryActivity.length ? "Bỏ chọn tất cả" : "Chọn tất cả",
                                      style: StyleOfit.textStyleFW500(AppColor.gray57, 14)),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: (state.amountSelected > 0),
                              child: InkWell(
                                onTap: () async{
                                  blocContext.read<ActivitySelectBloc>().add(
                                      GetListDiarySelected(context));
                                },
                                child: Row(
                                  children: [
                                    Text("Bán sản phẩm", style: StyleOfit.textStyleFW500(AppColor.gray57, 14)),
                                    IconButton(
                                        onPressed: () {
                                          blocContext.read<ActivitySelectBloc>().add(
                                              GetListDiarySelected(context));
                                        },
                                        icon: const Icon(
                                          Icons.card_giftcard,
                                          color: AppColor.main,
                                          size: 30,
                                        ),
                                        padding: EdgeInsets.zero),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                          itemCount: state.listDiaryActivity.length,
                          itemBuilder: (BuildContext contextBloc, int index) {
                            return ItemActivitySelect(diary: state.listDiaryActivity[index],
                              amountSelected: state.amountSelected,
                              isChoose: state.listSelected[index],
                              callbackChooseItem: (isChoose, diary)  {
                                setState(() {
                                  //selectAll=false;
                                });
                                blocContext.read<ActivitySelectBloc>().add(
                                    AddChooseDiary(
                                        index, !isChoose, diary));
                              });
                          },
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                        SizedBox(
                          height: 60,
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: state.amountSelected > 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,

                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: AppColor.gray57,
                                blurRadius: 1,
                                offset: Offset(0, 0),
                              ),
                            ],      gradient:const LinearGradient(
                          colors: [AppColor.main, AppColor.green99],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white),
                        child: TextButton(
                          child: Text("Thu bán sản phẩm",
                            style: StyleOfit.textStyleFW500(AppColor.whiteF2, 16),),
                        onPressed: (){
                          blocContext.read<ActivitySelectBloc>().add(
                              GetListDiarySelected(context));
                        },),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
