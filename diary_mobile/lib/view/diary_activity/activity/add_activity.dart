import 'dart:convert';
import 'dart:io';

import 'package:diary_mobile/data/entity/image/image_entity.dart';
import 'package:diary_mobile/data/repository.dart';
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
import '../../../utils/status/form_submission_status.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../../utils/widgets/button_widget.dart';
import '../../../utils/widgets/dialog/dialog_manager.dart';
import '../../../utils/widgets/input/container_input_widget.dart';
import '../../../utils/widgets/media/image_widget.dart';
import '../../../utils/widgets/media/video_widget.dart';
import '../../../view_model/diary_activity/activity/add_actitivy_bloc.dart';
import 'add_activity_sub/add_activity_sub.dart';

class AddActivityPage extends StatefulWidget {
  const AddActivityPage({super.key, required this.seasonFarmId, required this.diary, required this.action});

  final int seasonFarmId;
  final Diary diary;
  final String action;

  @override
  _AddActivityPageState createState() => _AddActivityPageState();

  static Route route(int seasonFarmId, Diary diary, String action) {
    return Utils.pageRouteBuilder(
        AddActivityPage(
          seasonFarmId: seasonFarmId,
            diary: diary,
            action: action,
        ),
        true);
  }
}

class _AddActivityPageState extends State<AddActivityPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddActivityBloc(context.read<Repository>())
        ..add(InitAddActivityEvent(widget.seasonFarmId, widget.diary, widget.action)),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.background,
        appBar: OfitAppBar(
          context,
          centerTitle: true,
          showDefaultBackButton: true,
          callback: const [false],
          title: Text(
            "Thêm hoạt động",
            style: StyleOfit.textStyleFW700(Colors.white, 20),
          ),
          backgroundColor: AppColor.main,
          actions: [],
        ),
        body: BlocConsumer<AddActivityBloc, AddActivityState>(
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
              Navigator.pop(context, [true, state.listActivity[state.indexActivity].harvesting]);
            }, () {
/*              Get.back();
              Navigator.pop(context, [true]);*/
            }, '', S.of(context).close_dialog, dismissible: false);
          } else if (formStatus is FormSubmitting) {
            DiaLogManager.showDialogLoading(context);
          }
        }, builder: (blocContext, state) {
          return Container(
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
                          blocContext.read<AddActivityBloc>().add(
                              OnSelectValueEvent(
                                  state.listWidget, index, context));
                        },
                        onMutiChoice: (id) {},
                        onChangeText: (text) {
                          blocContext.read<AddActivityBloc>().add(
                              SaveValueTextFieldEvent(
                                  text, state.listWidget[index], index));
                        },
                        onEditingComplete: (text) {
                          blocContext.read<AddActivityBloc>().add(
                              SaveValueTextFieldEvent(
                                  text, state.listWidget[index], index));
                        },
                      ),
                    ),
                    state.listWidgetArea.isNotEmpty
                        ? Row(
                            children: [
                              Expanded(
                                  flex: 7,
                                  child: ContainerInputWidget(
                                    contextParent: context,
                                    inputRegisterModel: state.listWidgetArea[0],
                                    onClick: () {
                                      setState(() {});
                                      blocContext.read<AddActivityBloc>().add(
                                          OnSelectValueEvent(
                                              state.listWidgetArea,
                                              0,
                                              context));
                                    },
                                    onChangeText: (text) {
                                      blocContext.read<AddActivityBloc>().add(
                                          SaveValueTextFieldEvent(text,
                                              state.listWidgetArea[0], 0));
                                    },
                                    onSubmittedText: (text) {
                                    },
                                    onEditingComplete: (text) {
                                      blocContext.read<AddActivityBloc>().add(
                                          SaveValueTextFieldEvent(text,
                                              state.listWidgetArea[0], 0));
                                    },
                                  )),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                  flex: 6,
                                  child: ContainerInputWidget(
                                    contextParent: context,
                                    inputRegisterModel: state.listWidgetArea[1],
                                    onClick: () {
                                      setState(() {});
                                      blocContext.read<AddActivityBloc>().add(
                                          OnSelectValueEvent(
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
                            flex: 7,
                            child: ContainerInputWidget(
                              contextParent: context,
                              inputRegisterModel: state.listWidgetYield[0],
                              onClick: () {
                                setState(() {});
                                blocContext.read<AddActivityBloc>().add(
                                    OnSelectValueEvent(
                                        state.listWidgetYield,
                                        0,
                                        context));
                              },
                              onChangeText: (text) {
                                blocContext.read<AddActivityBloc>().add(
                                    SaveValueTextFieldEvent(text,
                                        state.listWidgetYield[0], 0));
                              },
                              onSubmittedText: (text) {
                              },
                              onEditingComplete: (text) {
                                blocContext.read<AddActivityBloc>().add(
                                    SaveValueTextFieldEvent(text,
                                        state.listWidgetYield[0], 0));
                              },
                            )),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            flex: 6,
                            child: ContainerInputWidget(
                              contextParent: context,
                              inputRegisterModel: state.listWidgetYield[1],
                              onClick: () {
                                setState(() {});
                                blocContext.read<AddActivityBloc>().add(
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
                      var result = await Navigator.of(context).push(
                          AddActivitySubPage.route(
                              state.listVatTuAdd,
                              state.listCongCuAdd,
                              state.listWidgetVT,
                              state.listWidgetCC,
                              true));
                    }),
                    SizedBox(
                      height:
                          state.listImage.isNotEmpty ? state.imageHeight + 50 : 0,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: state.listImage.length,
                          itemBuilder: (context, index) {
                            print("HoangCV: type: ${state.listImage[index].type}");
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        child: GestureDetector(
                                          onTap: () {
                                            state.listImage[index].type != "2" ?
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ImagePlayerWidget(state.listImage[index]
                                                    .contentView ?? ''),
                                              ),
                                            ) : null;
                                          },
                                          child: Image.memory(
                                                  gaplessPlayback: true,
                                                  base64Decode(state.listImage[index]
                                                          .contentView ??
                                                      ""),
                                                  height: state.imageHeight,
                                                  width: state.imageWidth,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: state.listImage[index].type == "2",
                                        child: Positioned(
                                          child: IconButton(
                                              onPressed: () {
                                                print("HoangCV: state.listImage[index].filePath: ${state.listImage[index].filePath}");
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => VideoPlayerWidget(state.listImage[index].filePath??''),
                                                  ),
                                                );
                                              },
                                              icon: Transform.scale(
                                                scale: (state.imageWidth/4)/30,
                                                child: Image(
                                                  image:
                                                  AssetImage(ImageAsset.imageYoutube),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
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
                                                    .read<AddActivityBloc>()
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
                                          image:
                                          AssetImage(ImageAsset.imageBin),
                                          //width: 40,
                                          fit: BoxFit.contain,
                                        ),
                                      ))
                                ],
                              ),
                            );
                          }),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.bottomSheet(
                          SizedBox(
                              height: 140,
                              //padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Container(
                                decoration: const BoxDecoration(
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
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(12),
                                                    topLeft:
                                                        Radius.circular(12)),
                                            color:
                                                Theme.of(context).primaryColor),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.only(
                                                  left: 10, top: 8, bottom: 8),
                                              child: Text(
                                                  S.of(context).pick_a_photo,
                                                  style:
                                                      StyleOfit.textStyleFW700(
                                                          Colors.white, 18)),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.close,
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
                                        padding: const EdgeInsets.only(top: 18),
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
                                                        ImageAsset.imageCamera),
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
                                                    await Utils.getImagePicker(
                                                        ImageSource.camera);
                                                setState(() {
                                                  if (list.length > 0) {
                                                    blocContext
                                                        .read<AddActivityBloc>()
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
                                                    image: AssetImage(ImageAsset
                                                        .imageGallery),
                                                    width: 40,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    S.of(context).from_library,
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
                                                    await Utils.getImagePicker(
                                                        ImageSource.gallery);
                                                setState(() {
                                                  if (list.length > 0) {
                                                    blocContext
                                                        .read<AddActivityBloc>()
                                                        .add(
                                                            AddOrDeleteImageEvent(
                                                                list,
                                                                -1,
                                                                context));
                                                  }
                                                });
                                              },
                                            ),
                                  /*          GestureDetector(
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
                                                await Utils.getImagePicker(
                                                    ImageSource.camera, type: "video");
                                                setState(() {
                                                  if (list.length > 0) {
                                                    blocContext
                                                        .read<AddActivityBloc>()
                                                        .add(
                                                        AddOrDeleteImageEvent(
                                                            list,
                                                            -1,
                                                            context));
                                                  }
                                                });
                                                //HoangCV pick camera
                                              },
                                            ),*/
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
                              style:
                                  StyleOfit.textStyleFW500(AppColor.gray57, 16),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: OfitButton(
                          text: "Hoàn Thành",
                          onPressed: () {
                            blocContext
                                .read<AddActivityBloc>()
                                .add(AddActivityDiaryEvent());
                          }),
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
