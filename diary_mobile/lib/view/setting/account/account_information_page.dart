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
import '../../../utils/extenstion/extenstions.dart';
import '../../../utils/extenstion/input_register_model.dart';
import '../../../utils/extenstion/service_info_extension.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
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
            appBar: BkavAppBar(
              context,
              showDefaultBackButton: true,
              centerTitle: true,
              title: Text(
                "Thông tin tài khoản",
                style: StyleBkav.textStyleFW700(AppColor.whiteF2, 20),
              ),
              //backgroundColor: Colors.transparent,
              elevation: 0.0,
              hasBottom: true,
            ),
            //extendBodyBehindAppBar: true,

            body: Container(
              color: AppColor.whiteF5,
              padding: const EdgeInsets.only(top: 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          //margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.only(
                              top: 0, left: 10, right: 10),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF34B956), AppColor.green99],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(32),
                                bottomRight: Radius.circular(32)),
                          ),
                          height: 200,
                        ),
                        BlocBuilder<AccountInformationBloc,
                            AccountInformationState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                            Center(
                              child: CircleAvatar(
                                  backgroundColor: const Color(0xFF319A4B),
                                  radius: 70,
                                  child:ClipOval(
                              child: state.userInfo != null ? (state.userInfo!.mediaContent != '' ?
                                  Image.asset(ImageAsset.imagePersonProfile, fit: BoxFit.fitHeight,) :
                                  Image.memory(base64Decode(state.userInfo!.mediaContent ?? ""),gaplessPlayback: true, fit: BoxFit.cover, width: 140, height: 140,
                                    errorBuilder: (context, error, stackTrace) {
                                    // Nếu có lỗi, hiển thị hình ảnh thay thế từ Image.asset
                                  return Image.asset(
                                      ImageAsset.imagePersonProfile,
                                      fit: BoxFit.fitHeight,
                                      width: 140,
                                      height: 140,
                                    );
                                  },
                                 )):
                                  Image.asset(ImageAsset.imagePersonProfile, fit: BoxFit.cover, width: 140, height: 140, )), //CircleAvatar
                            )),
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
                                          /*const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          S
                                              .of(context)
                                              .from_camera,
                                          style: StyleBkav
                                              .textStyleFW500(
                                              AppColor
                                                  .black22,
                                              14),
                                        )*/
                                        ],
                                      ),
                                      onTap: () async {
                                        List<ImageEntity> list =
                                            await Utils.getImagePicker(
                                                ImageSource.camera,
                                                multiSelect: false);
                                          if (list.length > 0) {
                                            context.read<AccountInformationBloc>().add(AddOrDeleteImageEvent(list, context));
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
                                          /*  const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          S
                                              .of(context)
                                              .from_library,
                                          style: StyleBkav
                                              .textStyleFW500(
                                              AppColor
                                                  .black22,
                                              14),
                                        )*/
                                        ],
                                      ),
                                      onTap: () async {
                                        List<ImageEntity> list =
                                            await Utils.getImagePicker(
                                                ImageSource.gallery,
                                                multiSelect: false);
                                          if (list.isNotEmpty) {
                                            context.read<AccountInformationBloc>().add(AddOrDeleteImageEvent(list, context));
                                          }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
  },
),
                      ],
                    ),
                    BlocBuilder<AccountInformationBloc,
                        AccountInformationState>(
                      builder: (context, state) {
                        return Flexible(
                          child: Container(
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
                                    context.read<AccountInformationBloc>().add(
                                        OnSelectValueEvent(
                                            state.listWidget, index, context));
                                  }),
                            ),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<AccountInformationBloc,
                        AccountInformationState>(
                      builder: (context, state) {
                        return Container(
                          margin: const EdgeInsets.only(
                              top: 16, left: 16, right: 16),
                          child: Row(
                            children: [
                              Visibility(
                                visible: !edit,
                                child: Expanded(
                                  child: BkavButton(
                                      text: "Thay đổi thông tin",
                                      onPressed: () {
                                        setState(() {
                                          edit = !edit;
                                        });
                                        if (edit) {
                                          context.read<AccountInformationBloc>().add(ChangeEditInfoEvent());
                                        } else {
                                          context.read<AccountInformationBloc>().add(ChangeDetailInfoEvent());
                                        }
                                      }),
                                ),
                              ),
                              Visibility(
                                visible: edit,
                                child: Expanded(
                                  child:
                                      BkavButton(text: "Hủy", onPressed: () {
                                        setState(() {
                                          edit = !edit;
                                        });
                                        context.read<AccountInformationBloc>().add(ChangeDetailInfoEvent());
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
                                      BkavButton(text: "Lưu", onPressed: () {
                                        setState(() {
                                          edit = !edit;
                                        });
                                        context.read<AccountInformationBloc>().add(ChangeDetailInfoEvent());
                                      }),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
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
