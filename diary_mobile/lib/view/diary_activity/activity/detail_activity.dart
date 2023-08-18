import 'dart:convert';
import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/image/image_entity.dart';
import 'package:diary_mobile/data/repository.dart';
import 'package:diary_mobile/view_model/diary_activity/activity/detail_activity_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/form_submission_status.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../../utils/widgets/button_widget.dart';
import '../../../utils/widgets/dialog_manager.dart';
import '../../../utils/widgets/input/container_input_widget.dart';
import 'add_activity_sub/add_activity_sub.dart';

class DetailActivityPage extends StatefulWidget {
  DetailActivityPage({super.key, required this.activityDiary, required this.diary});

  final ActivityDiary activityDiary;
  final Diary diary;

  @override
  _DetailActivityPageState createState() => _DetailActivityPageState();

  static Route route(ActivityDiary activityDiary, Diary diary) {
    return Utils.pageRouteBuilder(
        DetailActivityPage(
          activityDiary: activityDiary,
            diary: diary
        ),
        true);
  }
}

class _DetailActivityPageState extends State<DetailActivityPage> {
  bool edit = false;
/*  late final ActivityDiary copiesActivityDiary;
  late final List<MaterialEntity> listCopies;
  late final List<Tool> listCopies2;*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
/*    copiesActivityDiary=ActivityDiary.copy(widget.activityDiary);
    listCopies = <MaterialEntity>[];
    listCopies.addAll(widget.activityDiary.material.map((material) => MaterialEntity.copy(material)));
    listCopies2 = <Tool>[];
    listCopies2.addAll(widget.activityDiary.tool.map((tool) => Tool.copy(tool)));*/
    //_initViewDetail();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailActivityBloc(context.read<Repository>())
        ..add(GetDetailActivityEvent(widget.activityDiary, widget.diary)),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.background,
        appBar: BkavAppBar(
          context,
          centerTitle: true,
          showDefaultBackButton: true,
          title: Text(
            "Chi tiết hoạt động",
            style: StyleBkav.textStyleFW700(Colors.white, 20),
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
        body: BlocConsumer<DetailActivityBloc, DetailActivityState>(
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
      /*        Get.back();
              Navigator.pop(context, [true]);*/
            }, '', S.of(context).close_dialog, dismissible: false);
          } else if (formStatus is FormSubmitting) {
            DiaLogManager.showDialogLoading(context);
          }
        }, builder: (blocContext, state) {
          return WillPopScope(
            onWillPop: () async{
   /*           blocContext
                  .read<DetailActivityBloc>()
                  .add(BackEvent(copiesActivityDiary, listCopies2, listCopies));*/
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
                            blocContext.read<DetailActivityBloc>().add(
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
                      state.listWidgetArea.isNotEmpty
                          ? Row(
                              children: [
                                Expanded(
                                    //flex: 8,
                                    child: ContainerInputWidget(
                                      contextParent: context,
                                      inputRegisterModel: state.listWidgetArea[0],
                                      onClick: () {
                                        setState(() {});
                                        blocContext
                                            .read<DetailActivityBloc>()
                                            .add(OnSelectValueEvent(
                                                state.listWidgetArea,
                                                0,
                                                context));
                                      },
                                      onChangeText: (text) {
                                        blocContext
                                            .read<DetailActivityBloc>()
                                            .add(SaveValueTextFieldEvent(text,
                                                state.listWidgetArea[0], 0));
                                      },
                                      onSubmittedText: (text) {
                                      },
                                      onEditingComplete: (text) {
                                         blocContext
                                            .read<DetailActivityBloc>()
                                            .add(SaveValueTextFieldEvent(text,
                                                state.listWidgetArea[0], 0));
                                      },
                                    )),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                    //flex: 5,
                                    child: ContainerInputWidget(
                                      contextParent: context,
                                      inputRegisterModel: state.listWidgetArea[1],
                                      onClick: () {
                                        setState(() {});
                                        blocContext
                                            .read<DetailActivityBloc>()
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
                                  blocContext.read<DetailActivityBloc>().add(
                                      OnSelectValueEvent(
                                          state.listWidgetYield,
                                          0,
                                          context));
                                },
                                onChangeText: (text) {
                                  blocContext.read<DetailActivityBloc>().add(
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
                                  blocContext.read<DetailActivityBloc>().add(
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
                                  blocContext.read<DetailActivityBloc>().add(
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
                      itemAccount(context,
                          text: "Danh sách vật tư, công cụ",
                          image: ImageAsset.imageGardening,
                          voidCallback: () async {
                        print(
                            "HoangCV: state.listWidgetVT: ${state.listVatTuAdd.length} : ${state.listCongCuAdd.length}");
                        var result = await Navigator.of(context).push(
                            AddActivitySubPage.route(
                                state.listVatTuAdd,
                                state.listCongCuAdd,
                                state.listWidgetVT,
                                state.listWidgetCC,
                                edit));

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
                                    Image.memory(
                                      gaplessPlayback: true,
                                      base64Decode(state.listImage[index]
                                          .contentView ??
                                          ""),
                                      height: state.imageHeight,
                                      width: state.imageWidth,
                                      fit: BoxFit.cover,
                                    ),
                                    Visibility(
                                      visible: state.listImage[index].type == "video",
                                      child: Positioned.fill(
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: SizedBox(
                                              height: state.imageWidth/4,
                                              child: Image(
                                                image:
                                                AssetImage(ImageAsset.imageYoutube),
                                              ),
                                            )),
                                      ),
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
                                                      .read<DetailActivityBloc>()
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
                                  height: 140,
                                  //padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(12),
                                          topLeft: Radius.circular(12)),
                                      color: Colors.white,
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
                                                      style: StyleBkav
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
                                                        style: StyleBkav
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
                                                                DetailActivityBloc>()
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
                                                        style: StyleBkav
                                                            .textStyleFW500(
                                                                AppColor.black22,
                                                                14),
                                                      )
                                                    ],
                                                  ),
                                                  onTap: () async {
                                                    //Bkav DucLQ TODO: Tam tat tinh nang nay
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
                                                                DetailActivityBloc>()
                                                            .add(
                                                                AddOrDeleteImageEvent(
                                                                    list,
                                                                    -1,
                                                                    context));
                                                      }
                                                    });
                                                  },
                                                ),
                                                GestureDetector(
                                                  child: Column(
                                                    children: [
                                                      const Image(
                                                        image: AssetImage(
                                                            ImageAsset.imageYoutube),
                                                        width: 40,
                                                        fit: BoxFit.contain,
                                                      ),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      Text(
                                                        "Quay video",
                                                        style: StyleBkav
                                                            .textStyleFW500(
                                                            AppColor.black22,
                                                            14),
                                                      )
                                                    ],
                                                  ),
                                                  onTap: () async {
                                                    Get.back();
                                                    List<ImageEntity> list =
                                                    await Utils.getImagePicker(
                                                        ImageSource.camera, type: "video");
                                                    setState(() {
                                                      if (list.length > 0) {
                                                        blocContext
                                                            .read<DetailActivityBloc>()
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
                                  style: StyleBkav.textStyleFW500(
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
                                child: BkavButton(
                                    text: "Sửa hoạt động",
                                    onPressed: ((widget.diary.status??'').compareTo("done") == 0 ||
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
                                              .read<DetailActivityBloc>()
                                              .add(ChangeEditActivityEvent());
                                        } else {
                           /*               blocContext
                                              .read<DetailActivityBloc>()
                                              .add(ChangeDetailActivityEvent());*/
                                        }
                                      });
                                    }),
                              ),
                            ),
                            Visibility(
                              visible: edit,
                              child: Expanded(
                                child: BkavButton(
                                    text: "Hủy",
                                    onPressed: () {
                                      setState(() {
                                        edit = !edit;
                                      });
                                      blocContext
                                          .read<DetailActivityBloc>()
                                          .add(GetDetailActivityEvent(widget.activityDiary, widget.diary, resetView: true));
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
                                child: BkavButton(
                                    text: "Lưu",
                                    onPressed: () {
                                      /// luu goi api
                                      blocContext
                                          .read<DetailActivityBloc>()
                                          .add(UpdateActivityEvent());
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
                        style: StyleBkav.textStyleFW400(AppColor.black22, 16),
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
