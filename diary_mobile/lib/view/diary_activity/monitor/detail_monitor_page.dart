import 'dart:convert';
import 'package:diary_mobile/data/entity/image/image_entity.dart';
import 'package:diary_mobile/data/entity/monitor/monitor_diary.dart';
import 'package:diary_mobile/data/repository.dart';
import 'package:diary_mobile/view/diary_activity/monitor/add_monitor_sub/add_monitor_sub.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
import '../../../view_model/diary_activity/monitor/detail_monitor_bloc.dart';

class DetailMonitorPage extends StatefulWidget {
  DetailMonitorPage({super.key, required this.monitorDiary});

  MonitorDiary monitorDiary;

  @override
  _DetailMonitorPageState createState() => _DetailMonitorPageState();

  static Route route(MonitorDiary monitorDiary) {
    return Utils.pageRouteBuilder(
        DetailMonitorPage(
          monitorDiary: monitorDiary,
        ),
        true);
  }
}

class _DetailMonitorPageState extends State<DetailMonitorPage> {
  bool edit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_initViewDetail();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailMonitorBloc(context.read<Repository>())
        ..add(GetDetailMonitorEvent(widget.monitorDiary)),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.background,
        appBar: OfitAppBar(
          context,
          centerTitle: true,
          showDefaultBackButton: true,
          title: Text(
            "Chi tiết giám sát",
            style: StyleOfit.textStyleFW700(Colors.white, 20),
          ),
          backgroundColor: AppColor.main,
          actions: [],
        ),
        body: BlocConsumer<DetailMonitorBloc, DetailMonitorState>(
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
                      /* setState(() {
                    edit = !edit;
                  });*/
                      Navigator.pop(context, [true]);
                    }, () {
                      Get.back();
                      /*setState(() {
                    edit = !edit;
                  });*/
                      Navigator.pop(context, [true]);
                    }, '', S.of(context).close_dialog);
              } else if (formStatus is FormSubmitting) {
                DiaLogManager.showDialogLoading(context);
              }
            },
            builder: (blocContext, state) {
          return Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                          blocContext.read<DetailMonitorBloc>().add(
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
                    itemAccount(context,
                        text: "Biện pháp khắc phục",
                        image: ImageAsset.imageTherapy,
                        voidCallback: () async {
                /*          print(
                              "HoangCV: state.listWidgetVT: ${state.listVatTuAdd.length} : ${state.listCongCuAdd.length}");*/
                          var result = await Navigator.of(context).push(
                              AddMonitorSubPage.route(
                                  state.listWidgetBP,));

                        }),
                    SizedBox(
                      height:
                      state.listImage.isNotEmpty ? state.imageHeight : 0,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: state.listImage.length,
                          itemBuilder: (context, index) {
                            /*      double imageWidth =
                                    130; // Kích thước mặc định nếu có >= 3 ảnh
                                double imageHeight =
                                100;*/
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  state.listImage[index].fileImage != null
                                      ? Image.file(
                                    state.listImage[index].fileImage!,
                                    height: state.imageHeight,
                                    //width: 100,
                                    width: state.imageWidth,
                                    fit: BoxFit.cover,
                                  )
                                      : Image.memory(
                                    gaplessPlayback: true,
                                    base64Decode(state.listImage[index]
                                        .fileContent ??
                                        ""),
                                    height: state.imageHeight,
                                    width: state.imageWidth,
                                    fit: BoxFit.cover,
                                  ),
                                  Visibility(
                                    visible: edit,
                                    child: Positioned(
                                      top: -5,
                                      right: -10,
                                      child: IconButton(
                                          onPressed: () async {
                                            DiaLogManager.displayDialog(
                                                context,
                                                "",
                                                S
                                                    .of(context)
                                                    .you_sure_want_delete_image,
                                                    () async {
                                                  Get.back();
                                                  setState(() {
                                                    blocContext
                                                        .read<DetailMonitorBloc>()
                                                        .add(AddOrDeleteImageEvent(
                                                        state.listImage,
                                                        index,
                                                        context));
                                                  });
                                                }, () {
                                              Get.back();
                                            }, S.of(context).cancel,
                                                S.of(context).agree);
                                          },
                                          icon: const SizedBox(
                                            height: 25,
                                            child: Image(
                                              image: AssetImage(
                                                  ImageAsset.imageBin),
                                              //width: 40,
                                              fit: BoxFit.contain,
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    Visibility(
                      visible: edit,
                      child: TextButton(
                        onPressed: () {
                          Get.bottomSheet(
                            SizedBox(
                                //height: 140,
                                //padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        topLeft: Radius.circular(12)),
                                    color: Colors.white,
                                  ),
                                  constraints: BoxConstraints(
                                    maxHeight: MediaQuery.of(context).size.height * 0.2, // Hoặc giá trị phù hợp với nhu cầu của bạn
                                  ),
                                  child: Center(
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 44,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(12),
                                                  topLeft: Radius.circular(12)),
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    top: 8,
                                                    bottom: 8),
                                                child: Text(
                                                    S.of(context).pick_a_photo,
                                                    style: StyleOfit
                                                        .textStyleFW700(
                                                        Colors.white, 18)),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.clear,
                                                  color: Colors.white,
                                                  size: 20.0,
                                                ),
                                                onPressed: () {
                                                  Get.back();
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding:
                                          const EdgeInsets.only(top: 18),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                child: Column(
                                                  children: [
                                                    const Image(
                                                      image: AssetImage(
                                                          ImageAsset
                                                              .imageCamera),
                                                      width: 40,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      S.of(context).from_camera,
                                                      style: StyleOfit
                                                          .textStyleFW500(
                                                          AppColor.black22,
                                                          14),
                                                    )
                                                  ],
                                                ),
                                                onTap: () async {
                                                  Get.back();
                                                  List<ImageEntity> list =
                                                  await Utils
                                                      .getImagePicker(
                                                      ImageSource
                                                          .camera);
                                                  setState(() {
                                                    if (list.length > 0) {
                                                      blocContext
                                                          .read<
                                                          DetailMonitorBloc>()
                                                          .add(
                                                          AddOrDeleteImageEvent(
                                                              list,
                                                              -1,
                                                              context));
                                                    }
                                                  });
                                                  //HoangCV pick camera
                                                },
                                              ),
                                              GestureDetector(
                                                child: Column(
                                                  children: [
                                                    const Image(
                                                      image: AssetImage(
                                                          ImageAsset
                                                              .imageGallery),
                                                      width: 40,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      S
                                                          .of(context)
                                                          .from_library,
                                                      style: StyleOfit
                                                          .textStyleFW500(
                                                          AppColor.black22,
                                                          14),
                                                    )
                                                  ],
                                                ),
                                                onTap: () async {
                                                  ///HoangCV TODO: Tam tat tinh nang nay
                                                  Get.back();

                                                  //HoangCV: chup anh
                                                  List<ImageEntity> list =
                                                  await Utils
                                                      .getImagePicker(
                                                      ImageSource
                                                          .gallery);
                                                  setState(() {
                                                    if (list.length > 0) {
                                                      blocContext
                                                          .read<
                                                          DetailMonitorBloc>()
                                                          .add(
                                                          AddOrDeleteImageEvent(
                                                              list,
                                                              -1,
                                                              context));
                                                    }
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                            // barrierColor: Colors.transparent,
                            isDismissible: true,
                            enableDrag: true,
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                            //color: AppColor.gray1.withOpacity(0.9),
                            gradient: const LinearGradient(
                              colors: [AppColor.grayC7, AppColor.gray9B],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 5),
                                child: Image(
                                  image: AssetImage(ImageAsset.imageCamera),
                                  width: 40,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Text(
                                "Chụp ảnh",
                                style: StyleOfit.textStyleFW500(
                                    AppColor.gray57, 16),
                              )
                            ],
                          ),
                        ),
                      ),
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
                                  onPressed: () {
                                    setState(() {
                                      edit = !edit;
                                      //state.listWidget.clear();
                                      if (edit) {
                                        blocContext
                                            .read<DetailMonitorBloc>()
                                            .add(ChangeEditMonitorEvent());
                                      } else {
                                        blocContext
                                            .read<DetailMonitorBloc>()
                                            .add(ChangeDetailMonitorEvent());
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
                                    //not ok
                                    blocContext
                                        .read<DetailMonitorBloc>()
                                        .add(ChangeDetailMonitorEvent());
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
                                    /*      setState(() {
                                      edit = !edit;
                                    });*/
                                    blocContext
                                        .read<DetailMonitorBloc>()
                                        .add(UpdateMonitorEvent());
                                  }),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
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
