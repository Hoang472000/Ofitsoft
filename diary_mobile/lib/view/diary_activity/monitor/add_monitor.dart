import 'package:diary_mobile/data/repository.dart';
import 'package:diary_mobile/view/diary/diary_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import '../../../utils/widgets/button_widget.dart';
import '../../../utils/widgets/dialog_manager.dart';
import '../../../utils/widgets/input/container_input_widget.dart';
import '../../../view_model/diary/list_diary_bloc.dart';
import 'add_monitor_sub/add_monitor_sub.dart';

class AddMonitorPage extends StatefulWidget {
  const AddMonitorPage({super.key});

  @override
  _AddMonitorPageState createState() => _AddMonitorPageState();

  static Route route() {
    return Utils.pageRouteBuilder(AddMonitorPage(), true);
  }
}

class _AddMonitorPageState extends State<AddMonitorPage> {
  List<InputRegisterModel> _listWidget = [];
  List<InputRegisterModel> _listWidget1 = [];
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
  List<CardType> listMutiChoice = [
    CardType(cardName: "Tỉa cành", description: "Kiểm tra tỉa lá xâu, cành xâu",isSelected: false, cardCode: "1", status: "1"),
    CardType(cardName: "Tỉa cành", description: "Kiểm tra tỉa cành to, cành nhỏ",isSelected: false, cardCode: "1", status: "1"),
    CardType(cardName: "Tỉa cành", description: "Kiểm tra đã loại bỏ cành khô",isSelected: false, cardCode: "1", status: "1"),
    CardType(cardName: "Tỉa cành", description: "Kiểm tra đã hoàn thành tất cả",isSelected: false, cardCode: "1", status: "1"),
  ];
  List<CardType> listVatTu = [
    CardType(cardName: "Nước", description: "Nước tưới tiêu", isSelected: false, cardCode: "1", status: "0"),
    CardType(cardName: "Phân bón", description: "Nước Phân bón", isSelected: false, cardCode: "2", status: "0"),
    CardType(cardName: "Đất", description: "Đất tưới tiêu", isSelected: false, cardCode: "3", status: "0"),
    CardType(cardName: "Hạt giống", description: "Hạt giống tiêu", isSelected: false, cardCode: "4", status: "0"),
  ];

  List<String> listCongCu = [
    "Cuốc",
    "xẻng",
    "Dao",
    "Máy cày",
    "Kéo",
  ];
  List<ImageEntity> listImage = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController soCayController = TextEditingController();
  TextEditingController soLuongController = TextEditingController();
  TextEditingController moTaController = TextEditingController();
  TextEditingController ngayKPController = TextEditingController();
  TextEditingController cachGQController = TextEditingController();
  TextEditingController noiDungCYController = TextEditingController();

  bool isSecretCode = true;
  bool isMstKinhDoanh = false;

  void _initView() {
    _listWidget.add(InputRegisterModel<String, String>(
        title: "Các hoạt động",
        isCompulsory: true,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        listValue: listActivity,
        image: ImageAsset.imageActivityFarm
    ));
    _listWidget.add(InputRegisterModel<String, DateTime>(
        title: "Thời gian",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        // valueSelected: DateTime.now(),
        image: ImageAsset.imageCalendarBegin,
        icon: Icons.calendar_today));
    _listWidget.add(InputRegisterModel(
        title: "Nội dung cần chú ý",
        isCompulsory: true,
      maxLengthTextInput: 2000,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      image: ImageAsset.imageFile,
      controller: noiDungCYController,
    ));

    _listWidget1.add(InputRegisterModel(
        title: "Biện pháp khắc phục",
        isCompulsory: true,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        image: ImageAsset.imageTherapy,
        listValue: listActivity
    ));
    _listWidget1.add(InputRegisterModel<String, DateTime>(
        title: "Thời gian khắc phục",
        isCompulsory: true,
      maxLengthTextInput: 50,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      image: ImageAsset.imageCalendarPick,
      controller: ngayKPController,));
    _listWidget1.add(InputRegisterModel(
      title: "Mô tả",
      isCompulsory: true,
      maxLengthTextInput: 2000,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      controller: moTaController,
      image: ImageAsset.imageFile,
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColor.background,
      appBar: BkavAppBar(
        context,
        centerTitle: true,
        showDefaultBackButton: true,
        title: Text(
          "Thêm mới giám sát",
          style: StyleBkav.textStyleFW700(Colors.white, 20),
        ),
        backgroundColor: AppColor.main,
        actions: [],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: SingleChildScrollView(
            //physics: NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ListView.builder(
                    physics:  NeverScrollableScrollPhysics(),
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
                    },)),
                itemAccount(context,
                    text: "Biện pháp khắc phục",
                    image: ImageAsset.imageTherapy,
                    voidCallback: () async {
                      var result = await Navigator.of(context).push(AddMonitorSubPage.route(_listWidget1));
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
                                      icon:const SizedBox(
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
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: BkavButton(
                    text: "Hoàn thành",
                    onPressed: () async {},
                    color: AppColor.main,
                  ),
                )
              ],
            ),
          )),
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
    if (inputRegisterModel.valueSelected.runtimeType == DateTime || inputRegisterModel.typeInputEnum == TypeInputEnum.date) {
      setState(() {
        ServiceInfoExtension().selectValue(inputRegisterModel, context, (inputModel) {

        });
      });
    }else {
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
        if(inputRegisterModel.title.compareTo("Các hoạt động")== 0){
          _listWidget.insert(1, InputRegisterModel<String, CardType>(
              title: "Các hoạt động đã thực hiện: ",
              isCompulsory: false,
              type: TypeInputRegister.MultiSelection,
              listMutiChoice: listMutiChoice));
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
