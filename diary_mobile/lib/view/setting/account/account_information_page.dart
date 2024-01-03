import 'dart:convert';

import 'package:diary_mobile/data/repository.dart';
import 'package:diary_mobile/utils/widgets/button_widget.dart';
import 'package:diary_mobile/view_model/setting/account/account_information_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/entity/image/image_entity.dart';
import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/status/form_submission_status.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../../utils/widgets/dialog/dialog_manager.dart';
import '../../../utils/widgets/input/container_input_widget.dart';

class AccountInformationPage extends StatefulWidget {
  const AccountInformationPage({Key? key}) : super(key: key);

  static Route route() {
    return Utils.pageRouteBuilder(const AccountInformationPage(), true);
  }

  @override
  State<StatefulWidget> createState() => _AccountInformationPageState();
}

class _AccountInformationPageState extends State<AccountInformationPage> {

  bool edit = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: BlocProvider(
        create: (context) => AccountInformationBloc(context.read<Repository>()),
        child: Scaffold(
            //backgroundColor: AppColor.background,
            appBar: OfitAppBar(
              context,
              showDefaultBackButton: true,
              centerTitle: true,
              title: Text(
                "Thông tin tài khoản",
                style: StyleOfit.textStyleFW700(AppColor.whiteF2, 20),
              ),
              elevation: 0.0,
              //hasBottom: true,
              //backgroundColor: Colors.transparent,
            ),
            //extendBodyBehindAppBar: true,
            body: BlocConsumer<AccountInformationBloc, AccountInformationState>(
              listener: (context, state)async {
                final formStatus = state.formStatus;
                if (formStatus is SubmissionFailed) {
                } else if (formStatus is SubmissionSuccess) {
                  DiaLogManager.displayDialog(context, "", formStatus.success ?? "",
                          () {
                        Get.back();
                         setState(() {
                    edit = !edit;
                  });
                      }, () {
                        Get.back();
                        Navigator.pop(context, [true]);

                      }, '', S.of(context).close_dialog, dismissible: false);
                } else if (formStatus is FormSubmitting) {
                  DiaLogManager.showDialogLoading(context);
                }
              },
              builder: (contextBloc, state) {
                return SafeArea(
                child: Container(
                  //color: AppColor.whiteF5,
                  padding: const EdgeInsets.only(top: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          children: [
                            Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(left: 16, right: 16),
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                height: MediaQuery.sizeOf(context).height / 4,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        ImageAsset.imageBackgroundDigital),
                                    colorFilter: ColorFilter.mode(
                                        AppColor.main.withOpacity(0.1),
                                        BlendMode.darken
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.all(
                                       Radius.circular(32)),
                                )),
                           Column(
                             mainAxisSize: MainAxisSize.min,
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                              CircleAvatar(
                                  backgroundColor: const Color(0xFF319A4B),
                                  radius: 70,
                                  child:ClipOval(
                              child: state.userInfo != null ? (state.userInfo!.mediaContent == '' || state.userInfo!.mediaContent == null ?
                                  Image.asset(ImageAsset.imagePersonProfile, fit: BoxFit.fitHeight,) :
                                  Image.memory(base64Decode(state.userInfo!.mediaContent ?? ""),gaplessPlayback: true, fit: BoxFit.cover, width: 140, height: 140,
                                    errorBuilder: (context, error, stackTrace) {
                                    // Nếu có lỗi, hiển thị hình ảnh thay thế từ Image.asset
                                      print("HoangCV: run way");
                                  return Image.asset(
                                      ImageAsset.imagePersonProfile,
                                      fit: BoxFit.fitHeight,
                                      width: 140,
                                      height: 140,
                                    );
                                  },
                                 )):
                                  Image.asset(ImageAsset.imagePersonProfile, fit: BoxFit.cover, width: 140, height: 140, )), //CircleAvatar
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Visibility(
                                      visible: edit,
                                      child: GestureDetector(
                                        child: const Column(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  ImageAsset.imageCamera),
                                              width: 40,
                                              fit: BoxFit.contain,
                                            ),
                                          ],
                                        ),
                                        onTap: () async {
                                          List<ImageEntity> list =
                                              await Utils.getImagePicker(
                                                  ImageSource.camera,
                                                  multiSelect: false);
                                            if (list.length > 0) {
                                              contextBloc.read<AccountInformationBloc>().add(AddOrDeleteImageEvent(list, context));
                                            }
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Visibility(
                                      visible: edit,
                                      child: GestureDetector(
                                        child: const Column(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  ImageAsset.imageGallery),
                                              width: 40,
                                              fit: BoxFit.contain,
                                            ),
                                          ],
                                        ),
                                        onTap: () async {
                                          List<ImageEntity> list =
                                              await Utils.getImagePicker(
                                                  ImageSource.gallery,
                                                  multiSelect: false);
                                            if (list.isNotEmpty) {
                                              contextBloc.read<AccountInformationBloc>().add(AddOrDeleteImageEvent(list, context));
                                            }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),

                          ],
                        ),
                        Flexible(
                              child: BlocConsumer<AccountInformationBloc,
                                  AccountInformationState>(
                            listener: (context, state) async {
                              final formStatus = state.formStatus;
                              if (formStatus is SubmissionFailed) {
/*                              DiaLogManager.displayDialog(
                                    context, "", formStatus.exception, () {
                                  Get.back();
                                }, () {
                                  Get.back();
                                }, '', S.of(context).close_dialog);*/
                              } else if (formStatus is SubmissionSuccess) {
  /*                            DiaLogManager.displayDialog(
                                    context, "", formStatus.success ?? "", () {
                                  Get.back();
                                }, () {
                                  Get.back();
                                }, '', S.of(context).close_dialog);*/
                              } else if (formStatus is FormSubmitting) {
                                DiaLogManager.showDialogLoading(context);
                              } else if(formStatus is InitialFormStatus){
                                if(Get.isDialogOpen== true){
                                  Get.back();
                                }
                              }
                            },
                            builder: (contextBloc, state) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    top: 16, left: 16, right: 16),
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.listWidget.length,
                                  itemBuilder: (_, index) => ContainerInputWidget(
                                      contextParent: context,
                                      inputRegisterModel: state.listWidget[index],
                                      onClick: () {
                                        setState(() {});
                                        contextBloc.read<AccountInformationBloc>().add(
                                            OnSelectValueEvent(
                                                state.listWidget, index, context));
                                      }),
                                ),
                              );
                            },
                          ),
                        ),

                        Container(
                              margin: const EdgeInsets.only(
                                  top: 16, left: 16, right: 16),
                              child: Row(
                                children: [
                                  Visibility(
                                    visible: !edit,
                                    child: Expanded(
                                      child: OfitButton(
                                          text: "Thay đổi thông tin",
                                          onPressed: () {
                                            setState(() {
                                              edit = !edit;
                                            });
                                            if (edit) {
                                              contextBloc.read<AccountInformationBloc>().add(ChangeEditInfoEvent());
                                            } else {
                                              contextBloc.read<AccountInformationBloc>().add(ChangeDetailInfoEvent(false));
                                            }
                                          }),
                                    ),
                                  ),
                                  Visibility(
                                    visible: edit,
                                    child: Expanded(
                                      child:
                                          OfitButton(text: "Hủy", onPressed: () {
                                            setState(() {
                                              edit = !edit;
                                            });
                                            contextBloc.read<AccountInformationBloc>().add(InitInfoEvent(true));
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
                                      child:
                                          OfitButton(text: "Lưu", onPressed: () {
                                            /*setState(() {
                                              edit = !edit;
                                            });*/
                                            contextBloc.read<AccountInformationBloc>().add(UpdateInfoEvent());
                                          }),
                                    ),
                                  )
                                ],
                              ),
                            )

                      ],
                    ),
                  ),
                ),
    );}
            )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //_initView();
  }
}
