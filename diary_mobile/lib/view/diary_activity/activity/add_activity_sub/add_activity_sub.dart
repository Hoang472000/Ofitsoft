import 'dart:convert';

import 'package:diary_mobile/data/entity/image/image_entity.dart';
import 'package:diary_mobile/data/entity/item_default/material_entity.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/repository.dart';
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
import '../../../../view_model/diary/list_diary_bloc.dart';

class AddActivitySubPage extends StatefulWidget {
  AddActivitySubPage(
      {super.key, required this.listVatTuAdd, required this.listCongCuAdd, required this.listWidgetVT, required this.listWidgetCC, required this.isEdit});

  List<MaterialEntity> listVatTuAdd;
  List<Tool> listCongCuAdd;
  List<InputRegisterModel> listWidgetVT;
  List<InputRegisterModel> listWidgetCC;
  bool isEdit;

  @override
  _AddActivitySubPageState createState() => _AddActivitySubPageState();

  static Route route(List<MaterialEntity> listVatTuAdd, List<Tool> listCongCuAdd,  List<InputRegisterModel> listWidgetVT,
  List<InputRegisterModel> listWidgetCC, bool isEdit) {
    return Utils.pageRouteBuilder(
        AddActivitySubPage(
          listVatTuAdd: listVatTuAdd,
          listCongCuAdd: listCongCuAdd, isEdit: isEdit, listWidgetVT: listWidgetVT, listWidgetCC: listWidgetCC,
        ),
        true);
  }
}

class _AddActivitySubPageState extends State<AddActivitySubPage> {
  List<InputRegisterModel> _listWidget1 = [];
  List<InputRegisterModel> _listWidget2 = [];
  List<ImageEntity> listImage = [];


  TextEditingController nameController = TextEditingController();
  TextEditingController soCayController = TextEditingController();
  TextEditingController soLuongController = TextEditingController();
  TextEditingController donViController = TextEditingController();
  TextEditingController soLuong2Controller = TextEditingController();
  TextEditingController moTaController = TextEditingController();
  TextEditingController donVi2Controller = TextEditingController();

  void _initViewDetail() {
    _listWidget1.add(InputRegisterModel(
      title: "Số lượng:",
      isCompulsory: false,
      maxLengthTextInput: 15,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.number,
      controller: soLuongController,
        image: ImageAsset.imageBudget
    ));
    _listWidget2.add(InputRegisterModel(
      title: "Số lượng: ",
      isCompulsory: false,
      maxLengthTextInput: 15,
      type: TypeInputRegister.Non,
      typeInput: TextInputType.number,
      controller: soLuong2Controller,
        image: ImageAsset.imageBudget
    ));
  }
  void _initViewEdit() {
    _listWidget1.add(InputRegisterModel(
        title: "Số lượng:",
        isCompulsory: false,
        maxLengthTextInput: 15,
        type: TypeInputRegister.TextField,
        typeInput: TextInputType.number,
        controller: soLuongController,
        image: ImageAsset.imageBudget
    ));
    _listWidget2.add(InputRegisterModel(
        title: "Số lượng: ",
        isCompulsory: false,
        maxLengthTextInput: 15,
        type: TypeInputRegister.TextField,
        typeInput: TextInputType.number,
        controller: soLuong2Controller,
        image: ImageAsset.imageBudget
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isEdit) {
      _initViewEdit();
    } else{
      _initViewDetail();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListDiaryBloc(context.read<Repository>()),
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
              !widget.isEdit ? "Chi tiết vật tư/công cụ" : "Thêm mới vật tư/công cụ",
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
                               widget.isEdit ?
                               Column(
                                 children: [
                                   ContainerInputWidget(
                                            contextParent: context,
                                            inputRegisterModel: widget.listWidgetVT[0],
                                            onClick: () {
                                              setState(() {});
                                              onSelectValue(
                                                  widget.listWidgetVT[0], context);
                                            }),
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
                                             }, onEditingComplete: (text){},)),
                                       SizedBox(
                                         width: 8,
                                       ),
                                       Expanded(
                                           flex: 5,
                                           child: ContainerInputWidget(
                                             contextParent: context,
                                             inputRegisterModel: widget.listWidgetVT[1],
                                             onClick: () {
                                               setState(() {});
                                               onSelectValue(
                                                   widget.listWidgetVT[1], context);
                                             }, onEditingComplete: (text){},)),
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
                                         if (widget.listWidgetVT[0].valueSelected != null && widget.listWidgetVT[1].valueSelected != null) {
                                           print("HoangCV: listWidgetCC: ${widget.listWidgetVT[1].valueSelected.toJson()}");
                                           print("HoangCV: listWidgetVT: ${widget.listWidgetVT[0].valueSelected.toJson()}");
                                           widget.listVatTuAdd.add(MaterialEntity(materialName:
                                           widget.listWidgetVT[0].valueSelected.name,
                                               materialId: widget.listWidgetVT[0].valueSelected.id,
                                               quantity: double.parse(
                                                   soLuongController.text != "" ? soLuongController.text : "1"),
                                               unitName: widget.listWidgetVT[1].valueSelected.name,
                                               unitId: widget.listWidgetVT[1].valueSelected.id,
                                               mediaContent: widget.listWidgetVT[0].valueSelected.image
                                           ));
                                         }
                                         widget.listWidgetVT[0].valueSelected = null;
                                         widget.listWidgetVT[0].positionSelected = -1;
                                         widget.listWidgetVT[1].valueSelected = null;
                                         widget.listWidgetVT[1].positionSelected = -1;
                                         soLuongController.text = "";
                                         //donViController.text = "";
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
                                 ],
                               ) : const SizedBox(),
                                ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: widget.listVatTuAdd.length,
                                    itemBuilder: (_, index) => Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 4),
                                          child:
                                          widget.listVatTuAdd[index].mediaContent == '' || widget.listVatTuAdd[index].mediaContent == null ?
                                          const Image(
                                            image: AssetImage(ImageAsset.imageGardening),
                                            width: 40,
                                            fit: BoxFit.contain,
                                          ) : Image.memory(
                                                  base64Decode(widget.listVatTuAdd[index].mediaContent ?? ''),
                                                  gaplessPlayback: true,
                                                  fit: BoxFit.cover,
                                                  width: 70,
                                                  height: 70,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return const Image(
                                                      image: AssetImage(
                                                          ImageAsset
                                                              .imageGardening),
                                                      width: 40,
                                                      fit: BoxFit.contain,
                                                    );
                                                  },
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
                                                      Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: RichText(
                                                          text: Utils.convertText(
                                                              "Tên vật tư: ",
                                                              "${widget.listVatTuAdd[index].materialName}",
                                                              AppColor.blue15,
                                                              15),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 4,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(4.0),
                                                              child: RichText(
                                                                text: Utils.convertText(
                                                                    "SL: ",
                                                                    "${widget.listVatTuAdd[index].quantity}",
                                                                    AppColor.blue15,
                                                                    15),
                                                                maxLines: 2,
                                                                overflow: TextOverflow
                                                                    .ellipsis,
                                                              )
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 7,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(4.0),
                                                              child: RichText(
                                                                text: Utils.convertText(
                                                                    "Đơn vị: ",
                                                                    "${widget.listVatTuAdd[index].unitName}",
                                                                    AppColor.blue15,
                                                                    15),
                                                                maxLines: 2,
                                                                overflow: TextOverflow
                                                                    .ellipsis,
                                                              )
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                widget.isEdit ? IconButton(
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
                                                    : Container()
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
                                widget.isEdit ?
                                Column(
                                  children: [
                                    ContainerInputWidget(
                                            contextParent: context,
                                            inputRegisterModel: widget.listWidgetCC[0],
                                            onClick: () {
                                              setState(() {});
                                              onSelectValue(
                                                  widget.listWidgetCC[0], context);
                                            }, onEditingComplete: (text){},),
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
                                              }, onEditingComplete: (text){},)),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                            flex: 5,
                                            child: ContainerInputWidget(
                                                contextParent: context,
                                                inputRegisterModel: widget.listWidgetCC[1],
                                                onClick: () {
                                                  setState(() {});
                                                  onSelectValue(
                                                      widget.listWidgetCC[1], context);
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
                                          if (widget.listWidgetCC[0].valueSelected != null && widget.listWidgetCC[1].valueSelected != null) {
                                            print("HoangCV: listWidgetCC: ${widget.listWidgetCC[1].valueSelected.toJson()}");
                                            widget.listCongCuAdd.add(Tool(toolName:
                                            widget.listWidgetCC[0].valueSelected.name,
                                                toolId: widget.listWidgetCC[0].valueSelected.id,
                                                quantity: double.parse(
                                                    soLuong2Controller.text != "" ? soLuong2Controller.text : "1"),
                                                unitName: widget.listWidgetCC[1].valueSelected.name,
                                                unitId: widget.listWidgetCC[1].valueSelected.id,
                                                mediaContent: widget.listWidgetCC[0].valueSelected.image
                                            ));
                                          }
                                          widget.listWidgetCC[0].valueSelected = null;
                                          widget.listWidgetCC[0].positionSelected = -1;
                                          widget.listWidgetCC[1].valueSelected = null;
                                          widget.listWidgetCC[1].positionSelected = -1;
                                          soLuong2Controller.text = "";
                                          //donVi2Controller.text = "";
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
                                  ],
                                ) : const SizedBox(),
                                ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: widget.listCongCuAdd.length,
                                    itemBuilder: (_, index) => Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 4),
                                          child:  widget.listCongCuAdd[index].mediaContent == '' || widget.listCongCuAdd[index].mediaContent == null ?
                                          const Image(
                                            image: AssetImage(ImageAsset.imageTool),
                                            width: 40,
                                            fit: BoxFit.contain,
                                          ) : Image.memory(
                                            base64Decode(widget.listCongCuAdd[index].mediaContent ?? ''),
                                            gaplessPlayback: true,
                                            fit: BoxFit.cover,
                                            width: 70,
                                            height: 70,
                                            errorBuilder: (context, error,
                                                stackTrace) {
                                              return const Image(
                                                image: AssetImage(
                                                    ImageAsset
                                                        .imageTool),
                                                width: 40,
                                                fit: BoxFit.contain,
                                              );
                                            },
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
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                        child: RichText(
                                                          text: Utils.convertText(
                                                              "Tên công cụ: ",
                                                              "${widget.listCongCuAdd[index].toolName}",
                                                              AppColor.blue15,
                                                              15),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 4,
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets.all(
                                                                  4.0),
                                                              child: RichText(
                                                                text: Utils.convertText(
                                                                    "SL: ",
                                                                    "${widget.listCongCuAdd[index].quantity}",
                                                                    AppColor.blue15,
                                                                    15),
                                                                maxLines: 2,
                                                                overflow: TextOverflow
                                                                    .ellipsis,
                                                              )
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 7,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(4.0),
                                                              child: RichText(
                                                                text: Utils.convertText(
                                                                    "Đơn vị: ",
                                                                    "${widget.listCongCuAdd[index].unitName}",
                                                                    AppColor.blue15,
                                                                    15),
                                                                maxLines: 2,
                                                                overflow: TextOverflow
                                                                    .ellipsis,
                                                              )
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                widget.isEdit ? IconButton(
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
                                                    : Container()
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
        ServiceInfoExtension().selectValue(inputRegisterModel, context, (inputModel) {});
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
