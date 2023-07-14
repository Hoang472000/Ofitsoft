import 'package:diary_mobile/data/entity/image/image_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../resource/assets.dart';
import '../../../../resource/color.dart';
import '../../../../resource/style.dart';
import '../../../../utils/extenstion/extenstions.dart';
import '../../../../utils/extenstion/input_register_model.dart';
import '../../../../utils/extenstion/service_info_extension.dart';
import '../../../../utils/utils.dart';
import '../../../../utils/widgets/bkav_app_bar.dart';
import '../../../../utils/widgets/button_widget.dart';
import '../../../../utils/widgets/input/container_input_widget.dart';
import '../../../../view_model/list_diary/list_diary_bloc.dart';

class AddActivitySubPage extends StatefulWidget {
  AddActivitySubPage(
      {super.key, required this.listVatTuAdd, required this.listCongCuAdd});

  List<VatTu> listVatTuAdd;
  List<VatTu> listCongCuAdd;

  @override
  _AddActivitySubPageState createState() => _AddActivitySubPageState();

  static Route route(List<VatTu> listVatTuAdd, List<VatTu> listCongCuAdd) {
    return Utils.pageRouteBuilder(
        AddActivitySubPage(
          listVatTuAdd: listVatTuAdd,
          listCongCuAdd: listCongCuAdd,
        ),
        true);
  }
}

class _AddActivitySubPageState extends State<AddActivitySubPage> {
  List<InputRegisterModel> _listWidget1 = [];
  List<InputRegisterModel> _listWidget2 = [];
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

/*  List<VatTu> listVatTuAdd = [];
  List<VatTu> listCongCuAdd = [];*/
  List<String> listCongCu = [
    "Cuốc",
    "xẻng",
    "Dao",
    "Máy cày",
    "Kéo",
  ];

  List<CardType> listMutiChoice = [
    CardType(
        cardName: "Tỉa cành",
        description: "Tỉa lá xâu, cành xâu",
        isSelected: false,
        cardCode: "1",
        status: "1"),
    CardType(
        cardName: "Tỉa cành",
        description: "Tỉa cành to, cành nhỏ",
        isSelected: false,
        cardCode: "1",
        status: "1"),
    CardType(
        cardName: "Tỉa cành",
        description: "Loại bỏ cành khô",
        isSelected: false,
        cardCode: "1",
        status: "1"),
    CardType(
        cardName: "Tỉa cành",
        description: "Vệ sinh khu vực tỉa cành",
        isSelected: false,
        cardCode: "1",
        status: "1"),
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController soCayController = TextEditingController();
  TextEditingController soLuongController = TextEditingController();
  TextEditingController donViController = TextEditingController();
  TextEditingController soLuong2Controller = TextEditingController();
  TextEditingController moTaController = TextEditingController();
  TextEditingController donVi2Controller = TextEditingController();

  void _initView() {
    _listWidgetVT.add(InputRegisterModel(
        title: "Vật tư liên quan",
        isCompulsory: true,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
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
    _listWidget1.add(InputRegisterModel(
      title: "Số lượng:",
      isCompulsory: false,
      maxLengthTextInput: 2000,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      controller: soLuongController,
        image: ImageAsset.imageBudget
    ));
    _listWidget1.add(InputRegisterModel(
      title: "Đơn vị:",
      isCompulsory: false,
      maxLengthTextInput: 2000,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      controller: donViController,
    ));
    _listWidget2.add(InputRegisterModel(
      title: "Số lượng: ",
      isCompulsory: false,
      maxLengthTextInput: 2000,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      controller: soLuong2Controller,
        image: ImageAsset.imageBudget
    ));
    _listWidget2.add(InputRegisterModel(
      title: "Đơn vị: ",
      isCompulsory: false,
      maxLengthTextInput: 2000,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      controller: donVi2Controller,
    ));
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
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return false;
        },
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
                  //color: Color(0xff3008ce),
                    //padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: SingleChildScrollView(
                      //physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColor.grayEC, AppColor.grayC7], // Đặt 2 màu ở đây
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(12))
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Danh sách vật tư",
                                      style: StyleBkav.textStyleFW500(
                                          AppColor.main, 16),
                                    ),
                                  ],
                                ),
                                ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _listWidgetVT.length,
                                    itemBuilder: (_, index) => ContainerInputWidget(
                                        contextParent: context,
                                        inputRegisterModel: _listWidgetVT[index],
                                        onClick: () {
                                          setState(() {});
                                          onSelectValue(
                                              _listWidgetVT[index], context);
                                        })),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 5,
                                        child:
                                        ContainerInputWidget(
                                            contextParent: context,
                                            inputRegisterModel: _listWidget1[0],
                                            onClick: () {
                                              setState(() {});
                                              onSelectValue(
                                                  _listWidget1[0], context);
                                            })),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        flex: 5,
                                        child: ContainerInputWidget(
                                            contextParent: context,
                                            inputRegisterModel: _listWidget1[1],
                                            onClick: () {
                                              setState(() {});
                                              onSelectValue(
                                                  _listWidget1[1], context);
                                            })),
                                  ],
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.only(top: 4,bottom: 4),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (_listWidgetVT[0].valueSelected != null) {
                                        widget.listVatTuAdd.add(VatTu(
                                            _listWidgetVT[0].valueSelected,
                                            int.parse(
                                                soLuongController.text != "" ? soLuongController.text : "1"),
                                            donViController.text.toString(),
                                            1));
                                      }
                                      _listWidgetVT[0].valueSelected = null;
                                      _listWidgetVT[0].positionSelected = -1;
                                      soLuongController.text = "";
                                      donViController.text = "";
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Padding(
                                          padding: EdgeInsets.only(top: 0, right: 6),
                                          child: Icon(
                                            Icons.add_circle_outline,
                                            color: AppColor.main,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 0),
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
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: widget.listVatTuAdd.length,
                                    itemBuilder: (_, index) => Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 4),
                                          child: Image(
                                            image: AssetImage(ImageAsset.imageGardening),
                                            width: 40,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(vertical: 8),
                                            padding: const EdgeInsets.only(left: 6),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: const Color(0xFFB2B8BB),
                                                  width: 1.5,
                                                ),
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(5)),
                                                color: Colors.white),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            widget.listVatTuAdd[index].name,
                                                            style: StyleBkav
                                                                .textStyleFW500(
                                                                AppColor.gray57,
                                                                14),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Text(
                                                            "SL: ${widget.listVatTuAdd[index].amount}",
                                                            style: StyleBkav
                                                                .textStyleFW500(
                                                                AppColor.gray57,
                                                                14),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            top: 4.0),
                                                        child: Text(
                                                          "Đơn vị: ${widget.listVatTuAdd[index].donVi}",
                                                          style:
                                                          StyleBkav.textStyleFW500(
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
                                                      widget.listVatTuAdd.removeAt(index);
                                                    });
                                                  },
                                                  icon: const Padding(
                                                    padding: EdgeInsets.only(right: 4),
                                                    child: Image(
                                                      image: AssetImage(ImageAsset.imageBin),
                                                      //width: 40,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.all(9),
                                                  constraints: BoxConstraints(),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],

                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColor.grayEC, AppColor.grayC7],   // Đặt 2 màu ở đây
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Danh sách công cụ",
                                      style: StyleBkav.textStyleFW500(
                                          AppColor.main, 16),
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
                                          onSelectValue(
                                              _listWidgetCC[index], context);
                                        })),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 5,
                                        child:
                                        ContainerInputWidget(
                                            contextParent: context,
                                            inputRegisterModel: _listWidget2[0],
                                            onClick: () {
                                              setState(() {});
                                              onSelectValue(
                                                  _listWidget2[0], context);
                                            })),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        flex: 5,
                                        child: ContainerInputWidget(
                                            contextParent: context,
                                            inputRegisterModel: _listWidget2[1],
                                            onClick: () {
                                              setState(() {});
                                              onSelectValue(
                                                  _listWidget2[1], context);
                                            })),
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
                                      if (_listWidgetCC[0].valueSelected != null) {
                                        widget.listCongCuAdd.add(VatTu(
                                            _listWidgetCC[0].valueSelected,
                                            int.parse(
                                                soLuong2Controller.text != "" ? soLuongController.text : "1"),
                                            donVi2Controller.text,
                                            2));
                                      }
                                      _listWidgetCC[0].valueSelected = null;
                                      _listWidgetCC[0].positionSelected = -1;
                                      soLuong2Controller.text = "";
                                      donVi2Controller.text = "";
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
                                    itemCount: widget.listCongCuAdd.length,
                                    itemBuilder: (_, index) => Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 4),
                                          child: Image(
                                            image: AssetImage(ImageAsset.imageTools),
                                            width: 40,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(vertical: 8),
                                            padding: EdgeInsets.only(left: 6),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Color(0xFFB2B8BB),
                                                  width: 1.5,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                color: Colors.white),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(
                                                                4.0),
                                                            child: Text(
                                                              widget.listCongCuAdd[index].name,
                                                              style: StyleBkav
                                                                  .textStyleFW500(
                                                                  AppColor.gray57,
                                                                  14),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(
                                                                4.0),
                                                            child: Text(
                                                              "SL: ${widget.listCongCuAdd[index].amount}",
                                                              style: StyleBkav
                                                                  .textStyleFW500(
                                                                  AppColor.gray57,
                                                                  14),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 4.0,
                                                            right: 4,
                                                            bottom: 4),
                                                        child: Text(
                                                          "Đơn vị: ${widget.listCongCuAdd[index].donVi}",
                                                          style:
                                                          StyleBkav.textStyleFW500(
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
                                                      widget.listCongCuAdd.removeAt(index);
                                                    });
                                                  },
                                                  icon: const Padding(
                                                    padding: EdgeInsets.only(right: 4),
                                                    child: Image(
                                                      image: AssetImage(ImageAsset.imageBin),
                                                      //width: 40,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.all(9),
                                                  constraints: BoxConstraints(),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: BkavButton(
                              text: "Tiếp tục",
                              onPressed: () async {
                                //widget.listVatTuAdd.addAll(widget.listCongCuAdd);
                                Navigator.pop(context, /*[widget.listVatTuAdd, widget.listCongCuAdd]*/);
                              },
                              color: AppColor.main,
                            ),
                          )
                        ],
                      ),
                    ));
              }),
        ),
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
        if (inputRegisterModel.title.compareTo("Tên công việc") == 0) {
        }
      }
    }
  }
}

class VatTu {
  final String name;
  final int amount;
  final String donVi;
  final int type;

  VatTu(this.name, this.amount, this.donVi, this.type);
}
