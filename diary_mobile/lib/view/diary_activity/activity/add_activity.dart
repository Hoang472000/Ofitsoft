import 'package:diary_mobile/data/entity/image/image_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/extenstion/extenstions.dart';
import '../../../utils/extenstion/input_register_model.dart';
import '../../../utils/extenstion/service_info_extension.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../../utils/widgets/button_widget.dart';
import '../../../utils/widgets/dialog_manager.dart';
import '../../../utils/widgets/input/container_input_widget.dart';
import '../../../view_model/diary/list_diary_bloc.dart';
import 'add_activity_sub/add_activity_sub.dart';

class AddActivityPage extends StatefulWidget {
  const AddActivityPage({super.key});

  @override
  _AddActivityPageState createState() => _AddActivityPageState();

  static Route route() {
    return Utils.pageRouteBuilder(AddActivityPage(), true);
  }
}

class _AddActivityPageState extends State<AddActivityPage> {
  List<InputRegisterModel> _listWidget = [];
  List<InputRegisterModel> _listWidgetVT = [];
  List<InputRegisterModel> _listWidgetCC = [];
  List<ImageEntity> listImage = [];

  List<String> listActivity = [
    "Tỉa cành",
    "Gieo hạt",
    "Tưới nước",
    "Chăm sóc",
    "Thu hoạch",
    "Làm đất",
  ];
  List<String> listVatTu = [
    "Nước",
    "Phân bón",
    "Đất",
    "Hạt giống",
    "Găng tay",
  ];

  List<VatTu> listVatTuAdd = [];
  List<VatTu> listCongCuAdd = [];
  List<String> listCongCu = [
    "Cuốc",
    "xẻng",
    "Dao",
    "Máy cày",
    "Kéo",
  ];

  List<CardType> listMutiChoice = [
    CardType(cardName: "Tỉa cành", description: "Tỉa lá xâu, cành xâu",isSelected: false, cardCode: "1", status: "1"),
    CardType(cardName: "Tỉa cành", description: "Tỉa cành to, cành nhỏ",isSelected: false, cardCode: "1", status: "1"),
    CardType(cardName: "Tỉa cành", description: "Loại bỏ cành khô",isSelected: false, cardCode: "1", status: "1"),
    CardType(cardName: "Tỉa cành", description: "Vệ sinh khu vực tỉa cành",isSelected: false, cardCode: "1", status: "1"),
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController soCayController = TextEditingController();
  TextEditingController soLuongController = TextEditingController();
  TextEditingController moTaController = TextEditingController();
  TextEditingController donViController = TextEditingController();
  TextEditingController peopleController = TextEditingController();

  bool isSecretCode = true;
  bool isMstKinhDoanh = false;

  void _initView() {
    _listWidget.add(InputRegisterModel<String, String>(
        title: "Tên công việc",
        isCompulsory: true,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        listValue: listActivity,
        image: ImageAsset.imageActivityFarm
    ));
    _listWidget.add(InputRegisterModel(
      title: "Chi tiết công việc",
      isCompulsory: true,
      maxLengthTextInput: 2000,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      controller: moTaController,
        image: ImageAsset.imageFile
    ));
    _listWidgetVT.add(InputRegisterModel(
        title: "Vật tư liên quan",
        isCompulsory: true,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        //listMutiChoice: listVatTu,
        listValue: listVatTu,
      image: ImageAsset.imageGardening
    ));

    _listWidgetCC.add(InputRegisterModel(
        title: "Công cụ sử dụng",
        isCompulsory: true,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        listValue: listCongCu,
      image: ImageAsset.imageTools,
    ));

    _listWidget.add(InputRegisterModel(
      title: "Người liên quan",
      isCompulsory: true,
      maxLengthTextInput: 200,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      controller: peopleController,
      image: ImageAsset.imageMan,
    ));

    _listWidget.add(InputRegisterModel<String, DateTime>(
        title: "Ngày bắt đầu",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        // valueSelected: DateTime.now(),
        image: ImageAsset.imageCalendarBegin,
        icon: Icons.calendar_today));

    _listWidget.add(InputRegisterModel<String, DateTime>(
        title: "Ngày kết thúc",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        // valueSelected: DateTime.now(),
        image: ImageAsset.imageCalendarEnd,
        icon: Icons.calendar_today));
/*    _listWidget.add(InputRegisterModel<String, DateTime>(
        title: "Hình ảnh",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        icon: Icons.camera_alt_rounded));*/
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initView();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListDiaryBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.background,
        appBar: BkavAppBar(
          context,
          centerTitle: true,
          showDefaultBackButton: true,
          title: Text(
            "Thêm mới hoạt động",
            style: StyleBkav.textStyleFW700(Colors.white, 20),
          ),
          backgroundColor: AppColor.main,
          actions: [],
        ),
        body: BlocConsumer<ListDiaryBloc, ListDiaryState>(
            listener: (context, state) async {},
            builder: (blocContext, state) {
              return Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: SingleChildScrollView(
                    //physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _listWidget.length,
                          itemBuilder: (_, index) => ContainerInputWidget(
                              contextParent: context,
                              inputRegisterModel: _listWidget[index],
                              onClick: () {
                                setState(() {});
                                onSelectValue(_listWidget[index], context);
                              }, onMutiChoice: (id){
                            setState(() {
                              _listWidget[index].listMutiChoice![id].isSelected = !_listWidget[index].listMutiChoice![id].isSelected;
                            });
                          }),
                        ),
                        itemAccount(context,
                            text: "Danh sách vật tư, công cụ",
                            image: ImageAsset.imageGardening,
                            voidCallback: () async {
                              var result = await Navigator.of(context).push(AddActivitySubPage.route(listVatTuAdd, listCongCuAdd, true));
                    /*          if(result != null && result[0].length > 0 ){
                                setState(() {
                                  listVatTuAdd.addAll(result[0] as List<VatTu>);
                                  if(result[1].length > 0) {
                                    listCongCuAdd.addAll(
                                        result[1] as List<VatTu>);
                                  }
                                });
                              }*/
                            }),
                  /*      ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listVatTuAdd.length,
                            itemBuilder: (_, index) => Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  padding: EdgeInsets.only(left: 8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xFFB2B8BB),
                                        width: 1.5,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: Colors.white),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  (listVatTuAdd[index].type == 1 ? "Vật tư: " : "Công cụ: ")+ listVatTuAdd[index].name,
                                                  style: StyleBkav.textStyleFW500(
                                                      AppColor.gray57, 14),
                                                ),
                                                SizedBox(width: 20,),
                                                Text(
                                                  "SL: ${listVatTuAdd[index].amount}",
                                                  style: StyleBkav.textStyleFW500(
                                                      AppColor.gray57, 14),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4.0),
                                              child: Text(
                                                "Đơn vị: ${listVatTuAdd[index].donVi}",
                                                style: StyleBkav.textStyleFW500(
                                                    AppColor.gray57, 14),
                                                maxLines: 5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            listVatTuAdd.removeAt(index);
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.delete_forever,
                                          color: AppColor.red11,
                                        ),
                                        padding: EdgeInsets.all(9),
                                        constraints: BoxConstraints(),
                                      )
                                    ],
                                  ),
                                )),*/
 /*                       itemAccount(context,
                            text: "Danh sách công cụ",
                            icon: IconAsset.icPersonSetting,
                            voidCallback: () {
                              Navigator.of(context).push(AddActivitySubPage.route());
                            }),*/
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            height: listImage.length > 0 ? 120 : 0,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: listImage.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                            child: Image.file(
                                              listImage[index].fileImage!,
                                              height: 120,
                                              width: 100,
                                              fit: BoxFit.cover,
                                            )),
                                        Positioned(
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
                                                        listImage.removeAt(index);
                                                      });
                                                    }, () {
                                                  Get.back();
                                                }, S.of(context).cancel,
                                                    S.of(context).agree);
                                              },
                                              icon: const SizedBox(
                                                height: 25,
                                                child: Image(
                                                  image: AssetImage(ImageAsset.imageBin),
                                                  //width: 40,
                                                  fit: BoxFit.contain,
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                        TextButton(
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
                                                    topRight:
                                                        Radius.circular(12),
                                                    topLeft:
                                                        Radius.circular(12)),
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          top: 8,
                                                          bottom: 8),
                                                  child: Text(
                                                      S
                                                          .of(context)
                                                          .pick_a_photo,
                                                      style: StyleBkav
                                                          .textStyleFW700(
                                                              Colors.white,
                                                              18)),
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
                                                        image: AssetImage(ImageAsset.imageCamera),
                                                        width: 40,
                                                        fit: BoxFit.contain,
                                                       ),
                                                      const SizedBox(
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
                                                        listImage.addAll(list);
                                                      }
                                                    });
                                                    //HoangCV pick camera
                                                  },
                                                ),
                                                GestureDetector(
                                                  child: Column(
                                                    children: [
                                                      const Image(
                                                        image: AssetImage(ImageAsset.imageGallery),
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
                                                                AppColor
                                                                    .black22,
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
                                                        listImage.addAll(list);
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
                              color: AppColor.gray1.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 5),
                                  child:   Image(
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: BkavButton(
                            text: "Hoàn thành",
                            onPressed: () async {},
                            color: AppColor.main,
                          ),
                        )
                      ],
                    ),
                  ));
            }),
      ),
    );
  }

  Widget inputText(String text, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(top: 0),
      decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFB2B8BB),
            width: 1.5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            text.length > 25
                ? Expanded(
                    flex: 5,
                    child: Text(
                      text,
                      style: TextStyle(
                          color: Color(0xFFB2B8BB),
                          fontSize:
                              14) /*
                    .merge(titleStyle)*/
                      ,
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                        color: Color(0xFFB2B8BB),
                        fontSize: 14) /*
                  .merge(titleStyle)*/
                    ,
                  ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(child: _rightWidget(context, controller)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rightWidget(context, TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            //obscureText: inputRegisterModel.isPassword,

            /// Chỉ cho phép nhận số. Kể cả dấu chấm
            // inputFormatters: TypeInputRegister.TextField,
            focusNode: FocusNode(),
            keyboardType: TextInputType.text,
            controller: controller,
            /*textCapitalization:
                        inputRegisterModel.textCapitalization == null
                            ? TextCapitalization.none
                            : inputRegisterModel.textCapitalization!,*/
            textAlign: TextAlign.right,
            //autofocus: true,
            onChanged: (newText) {},
            //onSubmitted: ,
            maxLength: 1000,
            style: TextStyle(
                color: Colors.black /*Color(0xFFA3A3A3)*/, fontSize: 14),
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                isDense: true,
                hintText: "",
                border: InputBorder.none,
                counterText: ''),
            minLines: 1,
            maxLines: 5,
          ),
        ),
      ],
    );
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
        if(inputRegisterModel.title.compareTo("Tên công việc")== 0){
/*          _listWidget.insert(2, InputRegisterModel<String, String>(
              title: "Các công việc liên quan:",
              isCompulsory: false,
              type: TypeInputRegister.MultiSelection,
              listMutiChoice: listMutiChoice));*/
        }
      }
    }
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
                  borderRadius:
                  BorderRadius.all(Radius.circular(5)),
                  color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        text,
                        style:
                        StyleBkav.textStyleFW400(AppColor.black22, 16),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      voidCallback();
                    },
                    icon: SvgPicture.asset(iconRight ?? IconAsset.icArrowRight, color: AppColor.main,),
                    padding:
                    const EdgeInsets.only(left: 8, right: 0, top: 10, bottom: 10),
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

