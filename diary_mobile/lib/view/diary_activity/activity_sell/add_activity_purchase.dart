import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/status/form_submission_status.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../../utils/widgets/button_widget.dart';
import '../../../utils/widgets/dashed_circle.dart';
import '../../../utils/widgets/dialog/dialog_manager.dart';
import '../../../utils/widgets/input/container_input_widget.dart';
import '../../../utils/widgets/input/text_form_input.dart';
import '../../../view_model/diary_activity/activity/activity_sell/add_activity_purchase_bloc.dart';

class AddActivityPurchasePage extends StatefulWidget {
  const AddActivityPurchasePage(
      {super.key});

  @override
  _AddActivityPurchasePageState createState() => _AddActivityPurchasePageState();

  static Route route() {
    return Utils.pageRouteBuilder(
        AddActivityPurchasePage(),
        true);
  }
}

class _AddActivityPurchasePageState extends State<AddActivityPurchasePage> {
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddActivityPurchaseBloc(context.read<Repository>())
        ..add(InitAddActivityPurchaseEvent()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.background,
        appBar: OfitAppBar(
          context,
          centerTitle: true,
          showDefaultBackButton: true,
          callback: [false, false],
          title: Text(
            "Thu mua sản phẩm",
            style: StyleOfit.textStyleFW700(Colors.white, 20),
          ),
          backgroundColor: AppColor.main,
          actions: [],
        ),
        body: BlocConsumer<AddActivityPurchaseBloc, AddActivityPurchaseState>(
            listener: (context, state) async {
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
                      Navigator.pop(context,
                          [true]);
                    }, () {
                    }, '', S.of(context).close_dialog, dismissible: false);
              } else if (formStatus is FormSubmitting) {
                DiaLogManager.showDialogLoading(context);
              }
            }, builder: (blocContext, state) {
          return state.isShowProgress ?
          const Center(
            child: DashedCircle(size: 39, stringIcon: IconAsset.icLoadOtp),)
              : Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: SingleChildScrollView(
                //physics: NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.listWidget.length,
                      itemBuilder: (_, index) => ContainerInputWidget(
                        contextParent: context,
                        inputRegisterModel: state.listWidget[index],
                        onClick: () {
                          setState(() {});
                          blocContext.read<AddActivityPurchaseBloc>().add(
                              OnSelectValueEvent(
                                  state.listWidget, index, context));
                        },
                        onMutiChoice: (id) {},
                        onChangeText: (text) {
                          blocContext.read<AddActivityPurchaseBloc>().add(
                              SaveValueTextFieldEvent(
                                  text, state.listWidget[index], index));
                        },
                        onEditingComplete: (text) {
                          blocContext.read<AddActivityPurchaseBloc>().add(
                              SaveValueTextFieldEvent(
                                  text, state.listWidget[index], index));
                        },
                      ),
                    ),
                    state.listWidgetArea.isNotEmpty
                        ? Row(
                      children: [
                        Expanded(
                            flex: 10,
                            child: ContainerInputWidget(
                              contextParent: context,
                              inputRegisterModel: state.listWidgetArea[0],
                              onClick: () {
                                setState(() {});
                                blocContext
                                    .read<AddActivityPurchaseBloc>()
                                    .add(OnSelectValueEvent(
                                    state.listWidgetArea,
                                    0,
                                    context));
                              },
                              onChangeText: (text) {
                                blocContext
                                    .read<AddActivityPurchaseBloc>()
                                    .add(SaveValueTextFieldEvent(text,
                                    state.listWidgetArea[0], 0));
                              },
                              onSubmittedText: (text) {},
                              onEditingComplete: (text) {
                                blocContext
                                    .read<AddActivityPurchaseBloc>()
                                    .add(SaveValueTextFieldEvent(text,
                                    state.listWidgetArea[0], 0));
                              },
                            )),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                            flex: 9,
                            child: ContainerInputWidget(
                              contextParent: context,
                              inputRegisterModel: state.listWidgetArea[1],
                              onClick: () {
                                setState(() {});
                                blocContext
                                    .read<AddActivityPurchaseBloc>()
                                    .add(OnSelectValueEvent(
                                    state.listWidgetArea,
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
                                            "Chi tiết đơn mua",
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
                                                    blocContext.read<AddActivityPurchaseBloc>().add(
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
                      child: OfitButton(
                          text: "Hoàn Thành",
                          onPressed: () {
                            blocContext
                                .read<AddActivityPurchaseBloc>()
                                .add(AddActivityPurchaseDiaryEvent());
                          }),
                    )
                  ],
                ),
              ));
        }),
      ),
    );
  }
}
