import 'dart:ui';

import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/activity/activity_transaction.dart';
import 'package:diary_mobile/utils/status/form_submission_status.dart';
import 'package:diary_mobile/utils/widgets/items/item_transaction.dart';
import 'package:diary_mobile/view/diary_activity/activity_sell/activity_select_page.dart';
import 'package:diary_mobile/view_model/diary_activity/activity/activity_bloc.dart';
import 'package:diary_mobile/view_model/diary_activity/activity/info_diary_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
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
import '../activity_sell/add_activity_purchase.dart';
import '../activity_sell/detail_activity_transaction.dart';

class ActivityTransactionPage extends StatefulWidget {
  const ActivityTransactionPage(
      {super.key,
      required this.action,
      required this.seasonFarmId,
      required this.diary,
      required this.listActivityTransaction,
      required this.listActivityDiary});

  final String action;
  final int seasonFarmId;
  final Diary diary;
  final List<ActivityTransaction> listActivityTransaction;
  final List<ActivityDiary> listActivityDiary;

  @override
  _ActivityTransactionPageState createState() =>
      _ActivityTransactionPageState();

  static Route route(
      String action,
  {int? seasonFarmId,
    Diary? diary,
      List<ActivityTransaction>? listActivityTransaction,
      List<ActivityDiary>? listActivityDiary}) {
    return Utils.pageRouteBuilder(
        ActivityTransactionPage(
          action: action,
          seasonFarmId: seasonFarmId ?? -1,
          diary: diary ?? Diary(),
          listActivityTransaction: listActivityTransaction ?? [],
          listActivityDiary: listActivityDiary ?? [],
        ),
        true);
  }
}

class _ActivityTransactionPageState extends State<ActivityTransactionPage> {
  bool visible = true;
  bool updateHarvesting = false;
  List<ActivityTransaction> listCallback = const [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivityBloc(context.read<Repository>())
        ..add(GetListActivityEvent(widget.seasonFarmId, widget.action, false,
            widget.listActivityDiary, widget.listActivityTransaction, (_){})),
      child: Scaffold(
        appBar: OfitAppBar(context,
            centerTitle: true,
            hasBottom: true,
            showDefaultBackButton: true,
            callback: [updateHarvesting, listCallback],
            title: Text(
              widget.action == "sell" ? "HOẠT ĐỘNG BÁN HÀNG" : "HOẠT ĐỘNG MUA HÀNG",
              style: StyleOfit.textStyleFW700(Colors.white, 20),
            )),
        //resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.background,
        floatingActionButton: BlocBuilder<ActivityBloc, ActivityState>(
          builder: (contextBloc, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: visible,
                  child: floatingActionButton(
                      widget.action.compareTo("sell") == 0
                          ? "Ghi bán hàng"
                          : "Ghi thu mua",
                      Icons.add,
                      () async {
                              if (widget.action.compareTo("sell") == 0) {
                                var result = await Navigator.of(context).push(
                                    ActivitySelectPage.route(
                                        widget.diary, state.listDiaryActivity));
                                if (result != null && result[0]) {
                                  setState(() {
                                    updateHarvesting = result[0];
                                  });
                                  contextBloc.read<ActivityBloc>().add(
                                      GetListActivityEvent(
                                          widget.seasonFarmId,
                                          widget.action,
                                          result[0],
                                          widget.listActivityDiary, [], (_){}));
                                }
                              }
                            }),
                ),
              ],
            );
          },
        ),
        body: BlocConsumer<ActivityBloc, ActivityState>(
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
                    blocContext.read<ActivityBloc>().add(GetListActivityEvent(
                        widget.seasonFarmId, widget.action, false, [], [], (_){}));
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
                                diary: widget.diary,
                                activityDiary:
                                    state.listActivityTransaction[index],
                                action: widget.action,
                                chooseItem: () async {
                                  //Truyen id de sang man ben goi api hoac DB
                                  //if (widget.action.compareTo('sell') == 0) {
                                    var result = await Navigator.push(
                                        context,
                                        DetailActivityTransactionPage.route(
                                            state
                                                .listActivityTransaction[index],
                                            diary: widget.diary, widget.action));
                                    if (result != null && result[0]) {
                                      contextBloc.read<ActivityBloc>().add(
                                          GetListActivityEvent(
                                              widget.seasonFarmId,
                                              widget.action,
                                              result[1], widget.listActivityDiary, [], (_){}));
                                    }
                                  //}
                                },
                                callbackDelete: () {
                                  blocContext.read<ActivityBloc>().add(
                                      RemoveActivityEvent(
                                          state.listActivityTransaction[index].id ??
                                              -1,
                                          widget.action, (_){}));
                                }, callbackExport: (){},
                            callbackChooseItem: (isChoose){

                            },isChoose: false,
                                amountSelected: 0,);
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
    );
  }

  Widget floatingActionButton(String name, IconData icon, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          child: FloatingActionButton(
              //backgroundColor: Colors.transparent,
              onPressed: onTap,
              child: Icon(icon)),
        ),
      ],
    );
  }
}
