import 'dart:ui';

import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/activity/activity_transaction.dart';
import 'package:diary_mobile/utils/status/form_submission_status.dart';
import 'package:diary_mobile/utils/widgets/items/item_transaction.dart';
import 'package:diary_mobile/view/diary_activity/activity_sell/activity_select_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../data/entity/activity/activity_purchase.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../data/repository.dart';
import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../../utils/widgets/dashed_circle.dart';
import '../../../utils/widgets/dialog/dialog_manager.dart';
import '../../../utils/widgets/empty_widget.dart';
import '../../../view_model/diary_activity/activity/activity_sell/activity_purchase_bloc.dart';
import '../activity_sell/add_activity_purchase.dart';
import '../activity_sell/detail_activity_transaction.dart';
import 'detail_activity_purchase.dart';

class ActivityPurchasePage extends StatefulWidget {
  const ActivityPurchasePage(
      {super.key,
        required this.action,
        required this.seasonFarmId,
        required this.listActivityTransaction,
        required this.listActivityDiary});

  final String action;
  final int seasonFarmId;
  final List<ActivityPurchase> listActivityTransaction;
  final List<ActivityDiary> listActivityDiary;

  @override
  _ActivityPurchasePageState createState() =>
      _ActivityPurchasePageState();

  static Route route(
      String action,
      {int? seasonFarmId,
        List<ActivityPurchase>? listActivityTransaction,
        List<ActivityDiary>? listActivityDiary}) {
    return Utils.pageRouteBuilder(
        ActivityPurchasePage(
          action: action,
          seasonFarmId: seasonFarmId ?? -1,
          listActivityTransaction: listActivityTransaction ?? [],
          listActivityDiary: listActivityDiary ?? [],
        ),
        true);
  }
}

class _ActivityPurchasePageState extends State<ActivityPurchasePage> {
  bool visible = true;
  bool updateHarvesting = false;
  List<ActivityPurchase> listCallback = const [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivityPurchaseBloc(context.read<Repository>())
        ..add(GetListActivityPurchaseEvent()),
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, -1);
          return false;
        },
        child: Scaffold(
          appBar: OfitAppBar(context,
              centerTitle: true,
              hasBottom: true,
              showDefaultBackButton: true,
              callback: [updateHarvesting, listCallback],
              title: Text(
                "Hoạt động mua hàng",
                style: StyleOfit.textStyleFW700(Colors.white, 20),
              ), actions: [
              BlocBuilder<ActivityPurchaseBloc, ActivityPurchaseState>(
                  builder: (contextBloc, state) {
                  return Visibility(
                    visible: state.amountSelected > 0,
                    child: IconButton(
                      padding: EdgeInsets.only(left: 4, right: 16),
                      icon: const Image(
                        image: AssetImage(ImageAsset.imageInfo),
                        color: Colors.white,
                        //width: 40,
                        fit: BoxFit.contain,
                      ),
                      onPressed: () {
                        List<int> resultList = state.listActivityTransaction
                            .asMap()
                            .entries
                            .where((entry) => entry.key < state.listSelected.length && state.listSelected[entry.key])
                            .map((entry) => entry.value.id)
                            .whereType<int>()
                            .toList();
                        print("HOangCV:resultList: ${resultList}");
                        contextBloc.read<ActivityPurchaseBloc>().add(
                            ExportPDFEvent(
                                resultList));
                      },
                    ),
                  );
                }
              )
            ],),
          //resizeToAvoidBottomInset: true,
          backgroundColor: AppColor.background,
          floatingActionButton: BlocBuilder<ActivityPurchaseBloc, ActivityPurchaseState>(
            builder: (contextBloc, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: visible,
                    child: floatingActionButton(
                        "",
                        Icons.add,
                            () async {
                            var result = await Navigator.of(context).push(AddActivityPurchasePage.route());
                            if (result != null && result[0]) {
                              setState(() {
                                updateHarvesting = result[0];
                              });
                              contextBloc.read<ActivityPurchaseBloc>().add(
                                  GetListActivityPurchaseEvent());
                            }

                        }),
                  ),
                ],
              );
            },
          ),
          body: BlocConsumer<ActivityPurchaseBloc, ActivityPurchaseState>(
              listener: (blocContext, state) async {
                final formStatus = state.formStatus;
                if (!state.isShowProgress) {
                  setState(() {
                    listCallback = state.listCallbackTransaction;
                  });
                  print(
                      "HoangCV: state.listCallbackTransaction : ${state.listCallbackTransaction.length} : ${listCallback.length}");
                }
                if (formStatus is SubmissionFailed) {
                  DiaLogManager.displayDialog(context, "", formStatus.exception, () {
                    Get.back();
                  }, () {
                    Get.back();
                  }, '', S.of(context).close_dialog);
                } else if (formStatus is SubmissionSuccess) {
                  DiaLogManager.displayDialog(context, "", formStatus.success ?? "",
                          () {
                        Get.back();
                      }, () {
                        Get.back();
                      }, '', S.of(context).close_dialog);
                } else if (formStatus is FormSubmitting) {
                  //DiaLogManager.showDialogLoading(context);
                }
              },
              builder: (blocContext, state) {
                return state
                    .isShowProgress /*&& (state.listDiaryActivity.length == 0 || state.listDiaryMonitor.length == 0)*/
                    ? const Center(
                  child:
                  DashedCircle(size: 39, stringIcon: IconAsset.icLoadOtp),
                )
                    : RefreshIndicator(
                  onRefresh: () async {
                    blocContext.read<ActivityPurchaseBloc>().add(GetListActivityPurchaseEvent());
                  },
                  child: state.listActivityTransaction.isEmpty ? const EmptyWidget()
                      : SingleChildScrollView(
                    //physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        ListView.builder(
                          itemCount: state.listActivityTransaction.length,
                          itemBuilder: (BuildContext contextBloc, int index) {
                            return ItemTransaction(
                                diary: Diary(),
                                activityDiary:
                                state.listActivityTransaction[index],
                                action: widget.action,
                                chooseItem: () async {
                                  //Truyen id de sang man ben goi api hoac DB
                                  //if (widget.action.compareTo('sell') == 0) {
                                  var result = await Navigator.push(
                                      context,
                                      DetailActivityPurchasePage.route(
                                          state
                                              .listActivityTransaction[index],
                                          widget.action));
                                  if (result != null && result[0]) {
                                    contextBloc.read<ActivityPurchaseBloc>().add(
                                        GetListActivityPurchaseEvent());
                                  }
                                  //}
                                },
                              callbackChooseItem: (isChoose){
                                blocContext.read<ActivityPurchaseBloc>().add(
                                    AddChoosePurchaseEvent(
                                        index, !isChoose));
                              },
                                callbackDelete: () {
                                  blocContext.read<ActivityPurchaseBloc>().add(
                                      RemoveActivityPurchaseEvent(
                                          state.listActivityTransaction[index].id ??
                                              -1,
                                          widget.action));
                                },
                            callbackExport: (){
                              blocContext.read<ActivityPurchaseBloc>().add(
                                  ExportPDFEvent(
                                      [state.listActivityTransaction[index].id ??
                                          -1]));
                            }, amountSelected: state.amountSelected,
                              isChoose: state.listSelected[index],
                            );
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
                );
              }),
        ),
      ),
    );
  }

  Widget floatingActionButton(String name, IconData icon, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColor.main, AppColor.green99],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
            borderRadius: BorderRadius.circular(
                36.0), // Adjust the border radius as needed
          ),
          child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: onTap,
              child: Icon(icon)),
        ),
      ],
    );
  }
}
