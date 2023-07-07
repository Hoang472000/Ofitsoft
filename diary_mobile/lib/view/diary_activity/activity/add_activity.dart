import 'package:diary_mobile/data/entity/image/image_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../generated/l10n.dart';
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
import '../../../view_model/list_diary/list_diary_bloc.dart';

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
  List<String> _listDanhMuc = [
    "Tất cả",
    // "Nghĩa vụ tài chính về đất đai",
    "LPTB phương tiện"
  ];
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

  List<String> listVatTuAdd = [];
  List<String> listCongCuAdd = [];
  List<String> listCongCu = [
    "Cuốc",
    "xẻng",
    "Dao",
    "Máy cày",
    "Kéo",
  ];

  String loaiThanhToan = 'Account', soThe = '', tenTinh = '', dbhc_tinh = '';
  bool isAddNgayPhatHanh = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController soCayController = TextEditingController();
  TextEditingController soLuongController = TextEditingController();
  TextEditingController moTaController = TextEditingController();

  bool isSecretCode = true;
  bool isMstKinhDoanh = false;

  void _initView() {
    _listWidget.add(InputRegisterModel<String, String>(
        title: "Tên công việc ",
        isCompulsory: true,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        listValue: listActivity));
    _listWidget.add(InputRegisterModel(
      title: "Chi tiết công việc",
      isCompulsory: true,
      maxLengthTextInput: 2000,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      controller: moTaController,
    ));
    _listWidgetVT.add(InputRegisterModel(
        title: "Vật tư liên quan",
        isCompulsory: true,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        //listMutiChoice: listVatTu,
        listValue: listVatTu));

    _listWidgetCC.add(InputRegisterModel(
        title: "Công cụ sử dụng",
        isCompulsory: true,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        listValue: listCongCu));

    _listWidget.add(InputRegisterModel(
      title: "Người liên quan",
      isCompulsory: true,
      maxLengthTextInput: 200,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      controller: soLuongController,
    ));

    _listWidget.add(InputRegisterModel<String, DateTime>(
        title: "Ngày bắt đầu",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        // valueSelected: DateTime.now(),
        icon: Icons.calendar_today));

    _listWidget.add(InputRegisterModel<String, DateTime>(
        title: "Ngày kết thúc",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        // valueSelected: DateTime.now(),
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
        backgroundColor: Colors.white,
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
                              }),
                        ),
                        Row(
                          children: [
                            Text(
                              "Danh sách vật tư",
                              style:
                                  StyleBkav.textStyleFW500(AppColor.gray57, 16),
                            ),
                          ],
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _listWidgetVT.length,
                            itemBuilder: (_, index) => ContainerInputWidget(
                                contextParent: context,
                                inputRegisterModel: _listWidgetVT[index],
                                onClick: () {
                                  setState(() {});
                                  onSelectValue(_listWidgetVT[index], context);
                                })),
                        Row(
                          children: [
                            Expanded(
                                child: inputText("Số lượng")
                            ),
                            Expanded(
                              child: inputText("Đơn vị")
                            ),
                          ],
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_listWidgetVT[0].valueSelected != null)
                                listVatTuAdd
                                    .add(_listWidgetVT[0].valueSelected);
                              _listWidgetVT[0].valueSelected = null;
                              _listWidgetVT[0].positionSelected = -1;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 0, right: 6),
                                  child: Icon(
                                    Icons.add_circle_outline,
                                    color: AppColor.main,
                                  )),
                              Padding(
                                padding: EdgeInsets.only(top: 0),
                                child: Text(
                                  "Thêm vật tư",
                                  style: StyleBkav.textStyleUnderline500(
                                      AppColor.main, 16),
                                ),
                              )
                            ],
                          ),
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listVatTuAdd.length,
                            itemBuilder: (_, index) => Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  padding: EdgeInsets.only(left: 6),
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
                                      Text(
                                        listVatTuAdd[index],
                                        style: StyleBkav.textStyleFW500(
                                            AppColor.gray57, 14),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            listVatTuAdd.removeAt(index);
                                          });
                                        },
                                        icon: Icon(
                                          Icons.delete_forever,
                                          color: AppColor.red11,
                                        ),
                                        padding: EdgeInsets.all(9),
                                        constraints: BoxConstraints(),
                                      )
                                    ],
                                  ),
                                )),
                        Row(
                          children: [
                            Text(
                              "Danh sách công cụ",
                              style:
                                  StyleBkav.textStyleFW500(AppColor.gray57, 16),
                            ),
                          ],
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _listWidgetCC.length,
                            itemBuilder: (_, index) => ContainerInputWidget(
                                contextParent: context,
                                inputRegisterModel: _listWidgetCC[index],
                                onClick: () {
                                  setState(() {});
                                  onSelectValue(_listWidgetCC[index], context);
                                })),
                        TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_listWidgetCC[0].valueSelected != null)
                                listCongCuAdd
                                    .add(_listWidgetCC[0].valueSelected);
                              _listWidgetCC[0].valueSelected = null;
                              _listWidgetCC[0].positionSelected = -1;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 0, right: 6),
                                  child: Icon(
                                    Icons.add_circle_outline,
                                    color: AppColor.main,
                                  )),
                              Padding(
                                padding: EdgeInsets.only(top: 0),
                                child: Text(
                                  "Thêm công cụ",
                                  style: StyleBkav.textStyleUnderline500(
                                      AppColor.main, 16),
                                ),
                              )
                            ],
                          ),
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listCongCuAdd.length,
                            itemBuilder: (_, index) => Container(
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
                                      Text(
                                        listCongCuAdd[index],
                                        style: StyleBkav.textStyleFW500(
                                            AppColor.gray57, 14),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              listCongCuAdd.removeAt(index);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.delete_forever,
                                            color: AppColor.red11,
                                          ))
                                    ],
                                  ),
                                )),
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
                                                      const Icon(
                                                        Icons.camera_alt,
                                                        size: 40,
                                                        color: AppColor.gray57,
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
                                                      const Icon(
                                                        Icons.photo_library,
                                                        size: 40,
                                                        color: AppColor.gray57,
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 13),
                                  child: Icon(
                                    Icons.camera_alt_rounded,
                                    color: AppColor.gray57,
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
                                          top: -2,
                                          right: -16,
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
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 20,
                                              )),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
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

  Widget inputText(String text) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFB2B8BB),
            width: 1.5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white),
      child: Padding(
        padding: EdgeInsets.all(6),
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
                  Expanded(child: _rightWidget(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rightWidget(context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            //obscureText: inputRegisterModel.isPassword,

            /// Chỉ cho phép nhận số. Kể cả dấu chấm
            // inputFormatters: TypeInputRegister.TextField,
            focusNode: FocusNode(),
            keyboardType: TextInputType.text,
            controller: moTaController,
            /*textCapitalization:
                        inputRegisterModel.textCapitalization == null
                            ? TextCapitalization.none
                            : inputRegisterModel.textCapitalization!,*/
            textAlign: TextAlign.right,
            autofocus: true,
            onChanged: (newText) {},
            //onSubmitted: ,
            maxLength: 1000,
            style: TextStyle(
                color: /*inputRegisterModel.unit == null
                                ? Colors.black
                                : */
                    Color(0xFFA3A3A3),
                fontSize: 14),
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
      }
    }
  }

  Widget textField(String label, TextEditingController textEditingController){
    return Padding(
      padding: EdgeInsets.all(6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          label.length > 25 ?
          Expanded(
            flex: 5,
            child: Text(
              label,
              style: TextStyle(
                  color: Color(0xFFB2B8BB),
                  fontSize: 14),
            ),
          ) : Text(label,
            style: TextStyle(
                color: Color(0xFFB2B8BB),
                fontSize: 14)
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            flex: 3,
            child: Expanded(child: _rightWidget(context)),
          ),
        ],
      ),
    );
  }
}
