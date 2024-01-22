import 'package:diary_mobile/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/status/form_submission_status.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/ofit_app_bar.dart';
import '../../../utils/widgets/dashed_circle.dart';
import '../../../utils/widgets/dialog/dialog_manager.dart';
import '../../../utils/widgets/empty_widget.dart';
import '../../../utils/widgets/view_page_widget.dart';
import '../../../view_model/diary/diary_monitor_child_bloc.dart';
import '../../../utils/widgets/items/item_diary.dart';
import '../../filter/filter_page.dart';

class DiaryMonitorChild extends StatefulWidget {
  const DiaryMonitorChild({super.key/*, required this.diary, required this.action*/});
/*  final List<Diary> diary;
  final String action;*/

  static Route route(/*List<Diary> diary, String action*/) {
    return Utils.pageRouteBuilder(DiaryMonitorChild(/*diary: diary, action: action*/), true);
  }

  @override
  _DiaryMonitorChildState createState() => _DiaryMonitorChildState();
}

class _DiaryMonitorChildState extends State<DiaryMonitorChild> {
  String searchString = "";

  bool isFilterOpen = false;

  void openFilter() {
    setState(() {
      isFilterOpen = true;
    });
  }

  void closeFilter() {
    setState(() {
      isFilterOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      DiaryMonitorChildBloc(context.read<Repository>())..add(GetListDiaryEvent(/*widget.diary, widget.action, */first: true)),
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: OfitAppBar(context,
              centerTitle: true,
              showDefaultBackButton: false,
              title: Text(
                S.of(context).diary_support,
                style: StyleOfit.textStyleFW700(Colors.white, 20),
              ),
              actions: [
                IconButton(
                  icon: SvgPicture.asset(IconAsset.icFilter),
                  onPressed: () {
                    openFilter();
                  },
                ),
              ],
              hasBottom: true,
              bottom: null,
            ),
            backgroundColor: AppColor.background,
            body: HomeBackGround(
              children: [
                BlocConsumer<DiaryMonitorChildBloc, DiaryMonitorChildState>(
                    listener: (context, state) async {
                      final formStatus = state.formStatus;
                      if (formStatus is SubmissionFailed) {
                        DiaLogManager.displayDialog(context, "", formStatus.exception, () {
                          Get.back();
                        }, () {
                          Get.back();
                        }, '', S.of(context).close_dialog);
                      } else if (formStatus is SubmissionSuccess) {
                      } else if (formStatus is FormSubmitting) {
                        DiaLogManager.showDialogLoading(context);
                      }
                    },
                    builder: (blocContext, state) {
                      return state.isShowProgress
                          ? Padding(
                        padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height/3),
                        child: DashedCircle(size: 39, stringIcon: IconAsset.icLoadOtp),)
                          : SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              margin: const EdgeInsets.only(top: 8),
                              child: TextField(
                                onChanged: (value) {
                                  if ((value.length >= 2) || (value.length == 0)) {
                                    setState(() {
                                      searchString = value.toLowerCase();
                                    });
                                    blocContext.read<DiaryMonitorChildBloc>().add(
                                        SearchListDiaryEvent(value));
                                  }
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColor.whiteF2)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColor.whiteF2, width: 1.0),
                                  ),
                                  fillColor: AppColor.whiteF2,
                                  labelText: S.of(context).search,
                                  suffixIcon: Icon(Icons.search, color: AppColor.whiteF2,),

                                  labelStyle: StyleOfit.textStyleFW400(AppColor.whiteF2, 16),
                                  contentPadding: EdgeInsets.all(8),
                                ),
                              ),
                            ),
                            const Divider(
                              height: 10.0,
                            ),
                            Visibility(
                              visible: (state.amountSelected > 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      blocContext.read<DiaryMonitorChildBloc>().add(
                                          AddChooseAllDiary(state.amountSelected == state.lengthDiary));
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(width: 1,),
                                        IconButton(
                                            onPressed: () {
                                              blocContext.read<DiaryMonitorChildBloc>().add(
                                                  AddChooseAllDiary(state.amountSelected == state.lengthDiary));
                                            },
                                            icon: state.amountSelected == state.lengthDiary
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
                                        Text(state.amountSelected == state.lengthDiary ? "Bỏ chọn tất cả" : "Chọn tất cả",
                                            style: StyleOfit.textStyleFW500(AppColor.whiteF2, 14)),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async{
                                      blocContext.read<DiaryMonitorChildBloc>().add(
                                          GetListDiarySelected(context));
                                    },
                                    child: Row(
                                      children: [
                                        Text("Thêm nhiều", style: StyleOfit.textStyleFW500(AppColor.whiteF2, 14)),
                                        IconButton(
                                            onPressed: () {
                                              blocContext.read<DiaryMonitorChildBloc>().add(
                                                  GetListDiarySelected(context));
                                            },
                                            icon: const Icon(
                                              Icons.edit_note_outlined,
                                              color: AppColor.main,
                                              size: 30,
                                            ),
                                            padding: EdgeInsets.zero),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            state.listDate.isEmpty ? const EmptyWidget() : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.listDate.length,
                              itemBuilder: (context, indexParent) {
                                String monthAndYear = state.listDate[indexParent];
                                /*                    List<Diary> tasksForMonthAndYear =
                                getTasksForMonthAndYear(
                                    monthAndYear, state.listDiary);*/

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            monthAndYear,
                                            style: StyleOfit.textStyleFW500(
                                                AppColor.whiteF2, 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: state.listDiary[indexParent].length,
                                      itemBuilder: (context, index) {
                                        return ItemDiary(diary: state.listDiary[indexParent][index],
                                            amountSelected: state.amountSelected,
                                            isChoose: state.listSelected[indexParent][index],
                                            callbackChooseItem: (isChoose, diary)  {
                                          /*if(widget.action == "record"){*/
                                              blocContext.read<DiaryMonitorChildBloc>().add(
                                                  AddChooseDiary(
                                                      indexParent, index, !isChoose, diary));
                                              }
                                            //}
                                          );
                                      },
                                    ),
                                    /*Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 70, vertical: 4),
                                      child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        indent: 1,
                                        color: Colors.black26,
                                      ),
                                    )*/
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      )
                      /*: const EmptyWidget()*/;
                    }),
              ],
            ),
          ),

          if (isFilterOpen)
            AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              color: Colors.black.withOpacity(0.5),
              child: GestureDetector(
                onTap: () {
                  closeFilter();
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),

          // Sliding filter screen
          AnimatedPositioned(
            duration: const Duration(milliseconds: 700),
            left: isFilterOpen ? MediaQuery.of(context).size.width * 0.1 : MediaQuery.of(context).size.width,
            top: 0,
            bottom: 0,
            width: MediaQuery.of(context).size.width * 0.9,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: ModalRoute.of(context)!.animation!,
                curve: Curves.ease,
              )),
              child:  BlocBuilder<DiaryMonitorChildBloc, DiaryMonitorChildState>(
                builder: (contextBloc, state) {
                  return state.listDiaryFilter.length > 0 ?FilterPage(
                list: state.listDiaryFilter,
                type: "diary",
                onClose: closeFilter,
                callBack: (dynamic){
                  contextBloc.read<DiaryMonitorChildBloc>().add(FilterEvent(dynamic));
                },
                // Other parameters you might need to pass
              ): SizedBox();
  },
),
            ),
          ),
        ],
      ),
    );
  }
}

