import 'package:diary_mobile/utils/widgets/button_widget.dart';
import 'package:flutter/material.dart';
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
  List<InputRegisterModel> _listWidget = [];

  List<String> listSex = [
    "Nam",
    "Nữ"
  ];
  TextEditingController nameController = TextEditingController(text: "Cao Văn Hoàng");
  TextEditingController sexController = TextEditingController(text: "Nam");
  TextEditingController addressController = TextEditingController(text: "421 hoàng quốc việt, hà nội, 421 hoàng quốc việt, cầu giấy, hà nội");
  TextEditingController statusController = TextEditingController(text: "Đang hoạt động");
  TextEditingController mainController = TextEditingController(text: "Nông hộ");
  TextEditingController dateController = TextEditingController(text: "04/07/2000");

  bool edit = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
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
                        padding:
                            const EdgeInsets.only(top: 0, left: 10, right: 10),
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
                      Column(
                        children: [
                          Center(
                            child: CircleAvatar(
                                backgroundColor: Color(0xFF319A4B),
                                radius: 70,
                                child: Image.asset(
                                  ImageAsset.imagePersonProfile,
                                  fit: BoxFit.fitHeight,
                                ) //Text
                                ), //CircleAvatar
                          ),
                          Container(
                            padding:
                            const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Visibility(
                                  visible: edit,
                                  child: GestureDetector(
                                    child: Column(
                                      children: [
                                        const Image(
                                          image: AssetImage(ImageAsset.imageCamera),
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
                                      //Get.back();
                                      List<ImageEntity> list =
                                      await Utils
                                          .getImagePicker(
                                          ImageSource
                                              .camera, multiSelect: false);
                                      setState(() {
                                        if (list.length > 0) {
                                          //listImage.addAll(list);
                                        }
                                      });
                                      //HoangCV pick camera
                                    },
                                  ),
                                ),
                                SizedBox(width: 30,),
                                Visibility(
                                  visible: edit,
                                  child: GestureDetector(
                                    child: Column(
                                      children: [
                                        const Image(
                                          image: AssetImage(ImageAsset.imageGallery),
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
                                      //Bkav DucLQ TODO: Tam tat tinh nang nay
                                      //Get.back();

                                      //HoangCV: chup anh
                                      List<ImageEntity> list =
                                      await Utils
                                          .getImagePicker(
                                          ImageSource
                                              .gallery, multiSelect: false);
                                      setState(() {
                                        if (list.length > 0) {
                                          //listImage.addAll(list);
                                        }
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          /*                   Container(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: RichText(
                                  text: TextSpan(
                                      text: "Cao Văn Hoàng",
                                      style: StyleBkav.textStyleFW700(
                                          Colors.white, 20,
                                          overflow: TextOverflow.visible)))),
                          RichText(
                              text: TextSpan(
                                  text: "Hộ nông dân",
                                  style: StyleBkav.textStyleFW400(
                                      Colors.white, 16,
                                      overflow: TextOverflow.visible))),*/
                        ],
                      ),
                    ],
                  ),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _listWidget.length,
                        itemBuilder: (_, index) => ContainerInputWidget(
                            contextParent: context,
                            inputRegisterModel: _listWidget[index],
                            onClick: () {
                              setState(() {});
                              onSelectValue(_listWidget[index], context);
                            }),
                      ),
                    ),
                  ),
                  /*         Container(
                    padding: const EdgeInsets.only(left: 16, right: 18),
                    margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFE1EEE1), Color(0xFFA9A7A7)],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "Họ và tên: Cao Văn Hoàng",
                              style: StyleBkav.textStyleFW400(AppColor.black22, 16),
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            indent: 1,
                            color: Colors.black26,
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "Giới tính: Nam",
                              style: StyleBkav.textStyleFW400(AppColor.black22, 16),
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            indent: 1,
                            color: Colors.black26,
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "Ngày sinh: 04/07/2000",
                              style: StyleBkav.textStyleFW400(AppColor.black22, 16),
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            indent: 1,
                            color: Colors.black26,
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "Địa chỉ: 421 Hoàng Quốc Việt, Cầu Giấy, Hà Nội, 421 Hoàng Quốc Việt, Cầu Giấy, Hà Nội",
                              style: StyleBkav.textStyleFW400(AppColor.black22, 16),
                              maxLines: 3,
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            indent: 1,
                            color: Colors.black26,
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "Trạng thái: Đang hoạt động",
                              style: StyleBkav.textStyleFW400(AppColor.black22, 16),
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            indent: 1,
                            color: Colors.black26,
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "Vai trò: Nông hộ",
                              style: StyleBkav.textStyleFW400(AppColor.black22, 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),*/
                  Container(
                    margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
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
                                    _listWidget.clear();
                                    if(edit) {
                                      _resetView();
                                    } else{
                                      _initView();
                                    }
                                  });
                                }),
                          ),
                        ),
                        Visibility(
                          visible: edit,
                          child: Expanded(
                            child: BkavButton(text: "Hủy", onPressed: () {}),
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
                            child: BkavButton(text: "Lưu", onPressed: () {}),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  void _initView() {
    _listWidget.add(InputRegisterModel<String, String>(
        title: "Họ và tên:",
        isCompulsory: false,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.text,
      maxLengthTextInput: 200,
      controller: nameController,
      image: ImageAsset.imageFarmerProfile
    ));
    _listWidget.add(InputRegisterModel(
      title: "Giới tính:",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.text,
      maxLengthTextInput: 200,
      controller: sexController,
        image: ImageAsset.imageSex
    ));
    _listWidget.add(InputRegisterModel(
      title: "Ngày sinh:",
        isCompulsory: false,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Non,
        controller: dateController,
        icon: Icons.calendar_today,
        image: ImageAsset.imageCalendarPick
    ));
    _listWidget.add(InputRegisterModel(
      title: "Địa chỉ:",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.text,
      maxLengthTextInput: 200,
      controller: addressController,
        image: ImageAsset.imageLocation
    ));

    _listWidget.add(InputRegisterModel<String, DateTime>(
        title: "Trạng thái hoạt động:",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.text,
      maxLengthTextInput: 200,
      controller: statusController,
        image: ImageAsset.imageStatus));

    _listWidget.add(InputRegisterModel<String, DateTime>(
        title: "Vai trò:",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.text,
      maxLengthTextInput: 200,
      controller: mainController,
        image: ImageAsset.imageCollaboration));
  }

  void _resetView() {
    _listWidget.add(InputRegisterModel<String, String>(
      title: "Họ và tên:",
      isCompulsory: false,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      maxLengthTextInput: 200,
      controller: nameController,
        image: ImageAsset.imageFarmerProfile));
    _listWidget.add(InputRegisterModel(
      title: "Giới tính:",
      isCompulsory: false,
      type: TypeInputRegister.Select,
      valueSelected: listSex.where((element) => element.compareTo(sexController.text.toString()) == 0),
      positionSelected: listSex.indexWhere((element) => element.compareTo(sexController.text.toString()) == 0),
      valueDefault: listSex.singleWhere((element) => element.compareTo(sexController.text.toString()) == 0),
      listValue: listSex,
      icon: Icons.arrow_drop_down,
        image: ImageAsset.imageSex
    ));
    _listWidget.add(InputRegisterModel(
        title: "Ngày sinh:",
        isCompulsory: false,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        valueSelected: Utils.formatStringToDateTime(dateController.text.toString()),
        valueDefault: dateController.text.toString(),
        //controller: dateController,
        icon: Icons.calendar_today,
        image: ImageAsset.imageCalendarPick
    ));
    _listWidget.add(InputRegisterModel(
      title: "Địa chỉ:",
      isCompulsory: false,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      maxLengthTextInput: 200,
      controller: addressController,
        image: ImageAsset.imageLocation
    ));

    _listWidget.add(InputRegisterModel<String, DateTime>(
      title: "Trạng thái hoạt động:",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.text,
      maxLengthTextInput: 200,
      controller: statusController,
        image: ImageAsset.imageStatus));

    _listWidget.add(InputRegisterModel<String, DateTime>(
      title: "Vai trò:",
      isCompulsory: false,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.text,
      maxLengthTextInput: 200,
      controller: mainController,
        image: ImageAsset.imageCollaboration));
  }

  @override
  void initState() {
    super.initState();
    _initView();
  }

  Future<void> onSelectValue(
      InputRegisterModel inputRegisterModel, BuildContext context) async {
    int result;
/*    if(inputRegisterModel.typeInputEnum == TypeInputEnum.dmucTinh && dMucTinhResponse.tinh == null) {
      Toast.showLongTop("Không có danh mục tỉnh");
      return;
    }else if(inputRegisterModel.typeInputEnum == TypeInputEnum.dmucHuyen && dMucHuyenResponse.dmucHuyenTPS == null) {
      Toast.showLongTop("Không có danh mục huyện");
      return;
    }else if(inputRegisterModel.typeInputEnum == TypeInputEnum.dmucXa && dMucXaResponse.dmucXaTPS == null) {
      Toast.showLongTop("Không có danh mục xã");
      return;
    }*/
    if (inputRegisterModel.valueSelected.runtimeType == DateTime ||
        inputRegisterModel.typeInputEnum == TypeInputEnum.date) {
      setState(() {
        ServiceInfoExtension().selectValue(inputRegisterModel, context, () {});
      });
    } else {
      result = await Extension().showBottomSheetSelection(
          context,
          inputRegisterModel.listValue,
          inputRegisterModel.positionSelected,
          "${inputRegisterModel.title}",
          hasSearch: inputRegisterModel.hasSearch ?? false);
      if (result != -1) {
        setState(() {
          inputRegisterModel.positionSelected = result;
          inputRegisterModel.valueDefault = null;
          inputRegisterModel.valueSelected =
          inputRegisterModel.listValue[result];
          inputRegisterModel.error = null;
        });
      }
    }
  }
}
