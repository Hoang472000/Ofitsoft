import 'dart:convert';
import 'dart:io';

import 'package:diary_mobile/data/entity/image/image_entity.dart';
import 'package:diary_mobile/data/repository.dart';
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
import '../../../utils/widgets/input/text_form_input.dart';
import '../../../utils/widgets/input/text_form_input_text.dart';
import '../../../utils/widgets/media/image_widget.dart';
import '../../../utils/widgets/media/video_widget.dart';
import '../../../view_model/setting/feedback/add_feedback_bloc.dart';

class AddFeedbackPage extends StatefulWidget {
  const AddFeedbackPage({super.key,});

  @override
  _AddFeedbackPageState createState() => _AddFeedbackPageState();

  static Route route() {
    return Utils.pageRouteBuilder(
        AddFeedbackPage(
        ),
        true);
  }
}

class _AddFeedbackPageState extends State<AddFeedbackPage> {
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFeedbackBloc(context.read<Repository>())
        ..add(InitAddFeedbackEvent()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.background,
        appBar: OfitAppBar(
          context,
          centerTitle: true,
          showDefaultBackButton: true,
          callback: const [false],
          title: Text(
            "Tạo ý kiến phản hồi",
            style: StyleOfit.textStyleFW700(Colors.white, 20),
          ),
          backgroundColor: AppColor.main,
          actions: [],
        ),
        body: BlocConsumer<AddFeedbackBloc, AddFeedbackState>(
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
                      Navigator.pop(context, [true]);
                    }, () {
                    }, '', S.of(context).close_dialog, dismissible: false);
              } else if (formStatus is FormSubmitting) {
                DiaLogManager.showDialogLoading(context);
              }
            }, builder: (blocContext, state) {
          return Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: SingleChildScrollView(
                child: state.listWidget.length >0 ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ContainerInputWidget(
                        contextParent: context,
                        inputRegisterModel: state.listWidget[0],
                        onClick: () {
                          setState(() {});
                          blocContext.read<AddFeedbackBloc>().add(
                              OnSelectValueEvent(
                                  state.listWidget, 0, context));
                        },
                        onMutiChoice: (id) {},
                        onChangeText: (text) {
                          blocContext.read<AddFeedbackBloc>().add(
                              SaveValueTextFieldEvent(
                                  text, state.listWidget[0], 0));
                        },
                        onEditingComplete: (text) {
                          blocContext.read<AddFeedbackBloc>().add(
                              SaveValueTextFieldEvent(
                                  text, state.listWidget[0], 0));
                        },
                      ),
                    //Text("Nhập nội dung ý kiến phản hồi"),
                    Container(
                        //margin: const EdgeInsets.only(top: 25),
                        child: TextFormFieldInputText(
                          noBorder: false,
                          underLine: false,
                          "Ý kiến phản hồi:",
                          state.moTaController ?? TextEditingController(),
                          false,
                          false,
                          focusNode,
                          (state.formStatus is ValidatePassFail) ? "ý kiến phản hồi không được để trống" : "",
                              (lostFocus) {
                            /*blocContext.read<AddFeedbackBloc>().add(
                                SaveValueTextFieldEvent(
                                    state.titleController!.text, state.listWidget[1], 1));
                            if (!lostFocus) {
                              //_focusNodePassNew.requestFocus();

                            }*/
                          },
                          true,
                          //icons: '',
                          onChangeCallBack: (text) {
                            print("text: onchangeCallback: $text");
                              //onchangePassOld = text;
                              blocContext.read<AddFeedbackBloc>().add(
                                  SaveValueTextFieldEvent(
                                      text, state.listWidget[1], 1));
                          },// textCapitalization: false,
                          // false
                        )),
                    ContainerInputWidget(
                        contextParent: context,
                        inputRegisterModel: state.listWidget[2],
                        onClick: () {
                          setState(() {});
                          blocContext.read<AddFeedbackBloc>().add(
                              OnSelectValueEvent(
                                  state.listWidget, 2, context));
                        },
                        onMutiChoice: (id) {},
                        onChangeText: (text) {
                          blocContext.read<AddFeedbackBloc>().add(
                              SaveValueTextFieldEvent(
                                  text, state.listWidget[2], 2));
                        },
                        onEditingComplete: (text) {
                          blocContext.read<AddFeedbackBloc>().add(
                              SaveValueTextFieldEvent(
                                  text, state.listWidget[2], 2));
                        },
                      ),

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
                                                    .read<AddFeedbackBloc>()
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
                                                        .read<AddFeedbackBloc>()
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
                                                        .read<AddFeedbackBloc>()
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
                                                        .read<AddFeedbackBloc>()
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
                          text: "Gửi phản hồi",
                          onPressed: () {
                            blocContext
                                .read<AddFeedbackBloc>()
                                .add(AddFeedbackDiaryEvent());
                          }),
                    )
                  ],
                ) :
                SizedBox(),
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
