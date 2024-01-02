import 'package:diary_mobile/data/entity/activity/activity_transaction.dart';
import 'package:diary_mobile/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/entity/activity/activity_purchase.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/status/form_submission_status.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../../utils/widgets/button_widget.dart';
import '../../../utils/widgets/dialog/dialog_manager.dart';
import '../../../utils/widgets/input/container_input_widget.dart';
import '../../../view_model/diary_activity/activity/activity_sell/detail_activity_purchase_bloc.dart';

class DetailActivityPurchasePage extends StatefulWidget {
  DetailActivityPurchasePage({super.key, required this.activityDiary, required this.diary, required this.action});

  final ActivityPurchase activityDiary;
  final Diary diary;
  final String action;

  @override
  _DetailActivityPurchasePageState createState() => _DetailActivityPurchasePageState();

  static Route route(ActivityPurchase activityDiary, String action, {Diary? diary,}) {
    return Utils.pageRouteBuilder(
        DetailActivityPurchasePage(
            activityDiary: activityDiary,
            diary: diary ?? Diary(),
            action: action
        ),
        true);
  }
}

class _DetailActivityPurchasePageState extends State<DetailActivityPurchasePage> {
  bool edit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailActivityPurchaseBloc(context.read<Repository>())
        ..add(GetDetailActivityPurchaseEvent(widget.activityDiary, widget.diary)),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.background,
        appBar: OfitAppBar(
          context,
          centerTitle: true,
          showDefaultBackButton: true,
          callback: [false],
          title: Text(
            "Chi tiết mua hàng",
            style: StyleOfit.textStyleFW700(Colors.white, 20),
          ),
          backgroundColor: AppColor.main,
          actions: [],
        ),
        body: BlocConsumer<DetailActivityPurchaseBloc, DetailActivityPurchaseState>(
            listener: (blocContext, state) async {
              final formStatus = state.formStatus;
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
                      Navigator.pop(context, [true, state.listActivity[state.indexActivity].harvesting]);
                    }, () {
                    }, '', S.of(context).close_dialog, dismissible: false);
              } else if (formStatus is FormSubmitting) {
                DiaLogManager.showDialogLoading(context);
              }
            }, builder: (blocContext, state) {
          return WillPopScope(
            onWillPop: () async{
              Navigator.pop(context);
              return false;
            },
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: SingleChildScrollView(
                  //physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.listWidget.length,
                        itemBuilder: (_, index) => ContainerInputWidget(
                          contextParent: context,
                          inputRegisterModel: state.listWidget[index],
                          onClick: () {
                            setState(() {});
                            blocContext.read<DetailActivityPurchaseBloc>().add(
                                OnSelectValueEvent(
                                    state.listWidget, index, context));
                            //onSelectValue(state.listWidget[index], context);
                          },
                          onMutiChoice: (id) {
                            setState(() {
                              state.listWidget[index].listMutiChoice![id]
                                  .isSelected =
                              !state.listWidget[index].listMutiChoice![id]
                                  .isSelected;
                            });
                          },
                          onChangeText: (text) {},
                        ),
                      ),
                      state.listWidgetYield.isNotEmpty
                          ? Row(
                        children: [
                          Expanded(
                            //flex: 8,
                              child: ContainerInputWidget(
                                contextParent: context,
                                inputRegisterModel: state.listWidgetYield[0],
                                onClick: () {
                                  setState(() {});
                                  blocContext.read<DetailActivityPurchaseBloc>().add(
                                      OnSelectValueEvent(
                                          state.listWidgetYield,
                                          0,
                                          context));
                                },
                                onChangeText: (text) {
                                  blocContext.read<DetailActivityPurchaseBloc>().add(
                                      SaveValueTextFieldEvent(text,
                                          state.listWidgetYield[0], 0));
                                },
                                onSubmittedText: (text) {
                                  print(
                                      "HoangCV: onSubmittedText: ${text}");
                                },
                                onEditingComplete: (text) {
                                  print(
                                      "HoangCV: onEditingComplete: ${text} : ${state.listWidgetYield[0].controller}");
                                  blocContext.read<DetailActivityPurchaseBloc>().add(
                                      SaveValueTextFieldEvent(text,
                                          state.listWidgetYield[0], 0));
                                },
                              )),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            //flex: 5,
                              child: ContainerInputWidget(
                                contextParent: context,
                                inputRegisterModel: state.listWidgetYield[1],
                                onClick: () {
                                  setState(() {});
                                  blocContext.read<DetailActivityPurchaseBloc>().add(
                                      OnSelectValueEvent(
                                          state.listWidgetYield,
                                          1,
                                          context));
                                },
                                onChangeText: (text) {},
                                onEditingComplete: (text) {},
                              )),
                        ],
                      )
                          : const SizedBox(),

                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              // <= No more error here :)
                              color: Colors.white,
                            ),
                            alignment: Alignment.bottomCenter,
                            margin: const EdgeInsets.only(top: 10, bottom: 20),
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 10),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Icon(Icons.newspaper, color: AppColor.main, size: 30,),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              widget.action.compareTo("sell") == 0 ? "Chi tiết đơn bán" :"Chi tiết đơn mua",
                                              style: StyleOfit.textStyleFW500(
                                                  AppColor.gray57, 18),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: state.inputDonGia.length,
                                                  itemBuilder: (_, index) => ContainerInputWidget(
                                                    titleStyle: StyleOfit.textStyleFW500(AppColor.black22, 16),
                                                    contextParent: context,
                                                    inputRegisterModel: state.inputDonGia[index],
                                                    onClick: () {},
                                                    onMutiChoice: (id) {},
                                                    onChangeText: (text) {
                                                      blocContext.read<DetailActivityPurchaseBloc>().add(
                                                          SaveValueTextFieldEvent(
                                                              text, state.inputDonGia[index], index));
                                                    },
                                                    onEditingComplete: (text) {
                                                      /*    blocContext.read<AddActivityPurchaseBloc>().add(
                                                        SaveValueTextFieldEvent(
                                                            text, state.inputDonGia[index], index));*/
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                " VND/${state.donViController?.text}",
                                                style: StyleOfit.textStyleFW500(
                                                    AppColor.gray57, 16),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const Divider(),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    /*         blocContext.read<CreateBillBloc>().add(ShowHideSummaryEvent());*/
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 5, top: 5),
                                      child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                S.of(context).into_money,
                                                style: StyleOfit.textStyleFW500(
                                                    AppColor.main, 16),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  Utils.convertNumber(state.total),
                                                  style: StyleOfit.textStyleFW500(
                                                      AppColor.main, 16),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  " VND",
                                                  style: StyleOfit.textStyleFW500(
                                                      AppColor.gray57, 16),
                                                )
                                              ],
                                            )
                                          ])),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Visibility(
                              visible: !edit,
                              child: Expanded(
                                child: OfitButton(
                                    text: "Sửa hoạt động",
                                    onPressed: widget.action == "sell" && (
                                        (widget.diary.status??'').compareTo("done") == 0 ||
                                            (widget.diary.status??'').compareTo("cancelled") == 0)?
                                        () {
                                      if((widget.diary.status??'').compareTo("done") == 0 ) {
                                        DiaLogManager.displayDialog(context,
                                            "Nhật ký đã hoàn thành","Bạn không thể sửa hoạt động",
                                                (){Navigator.pop(context);}, () {},
                                            "",S.of(context).close_dialog);
                                      }
                                      if((widget.diary.status??'').compareTo("done") == 0 ) {
                                        DiaLogManager.displayDialog(context,
                                            "Nhật ký đã đóng","Bạn không thể sửa hoạt động",
                                                (){Navigator.pop(context);}, () {},
                                            "",S.of(context).close_dialog);
                                      }
                                    }
                                        :() {
                                      setState(() {
                                        edit = !edit;
                                        //state.listWidget.clear();
                                        if (edit) {
                                          blocContext
                                              .read<DetailActivityPurchaseBloc>()
                                              .add(ChangeEditActivityPurchaseEvent());
                                        } else {
                                        }
                                      });
                                    }),
                              ),
                            ),
                            Visibility(
                              visible: edit,
                              child: Expanded(
                                child: OfitButton(
                                    text: "Hủy",
                                    onPressed: () {
                                      setState(() {
                                        edit = !edit;
                                      });
                                      blocContext
                                          .read<DetailActivityPurchaseBloc>()
                                          .add(GetDetailActivityPurchaseEvent(widget.activityDiary, widget.diary, resetView: true));
                                    }),
                              ),
                            ),
                            Visibility(
                                visible: edit,
                                child: SizedBox(
                                  width: 16,
                                )),
                            Visibility(
                              visible: edit,
                              child: Expanded(
                                child: OfitButton(
                                    text: "Lưu",
                                    onPressed: () {
                                      /// luu goi api
                                      blocContext
                                          .read<DetailActivityPurchaseBloc>()
                                          .add(UpdateActivityPurchaseEvent());
                                    }),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          );
        }),
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
