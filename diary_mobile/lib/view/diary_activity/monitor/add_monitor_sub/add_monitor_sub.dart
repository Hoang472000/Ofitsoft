import 'package:diary_mobile/view/diary/diary_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../data/entity/image/image_entity.dart';
import '../../../../generated/l10n.dart';
import '../../../../resource/assets.dart';
import '../../../../resource/color.dart';
import '../../../../resource/style.dart';
import '../../../../utils/extenstion/extenstions.dart';
import '../../../../utils/extenstion/input_register_model.dart';
import '../../../../utils/extenstion/service_info_extension.dart';
import '../../../../utils/utils.dart';
import '../../../../utils/widgets/bkav_app_bar.dart';
import '../../../../utils/widgets/button_widget.dart';
import '../../../../utils/widgets/dialog_manager.dart';
import '../../../../utils/widgets/input/container_input_widget.dart';
import '../../../../view_model/list_diary/list_diary_bloc.dart';

class AddMonitorSubPage extends StatefulWidget {
  AddMonitorSubPage({super.key, required this.listWidget});
  List<InputRegisterModel> listWidget;
  @override
  _AddMonitorSubPageState createState() => _AddMonitorSubPageState();

  static Route route(List<InputRegisterModel> listWidget) {
    return Utils.pageRouteBuilder(AddMonitorSubPage(listWidget: listWidget,), true);
  }
}

class _AddMonitorSubPageState extends State<AddMonitorSubPage> {
  //List<InputRegisterModel> _listWidget = [];
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_initView();
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
              "Thêm mới giám sát",
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
                              physics:  NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.listWidget.length,
                              itemBuilder: (_, index) => ContainerInputWidget(
                                contextParent: context,
                                inputRegisterModel: widget.listWidget[index],
                                onClick: () {
                                  setState(() {});
                                  onSelectValue(widget.listWidget[index], context);
                                },)),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: BkavButton(
                              text: "Tiếp tục",
                              onPressed: () async {
                                Navigator.pop(context);
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
        ServiceInfoExtension().selectValue(inputRegisterModel, context, () {

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
        }
      }
    }
  }
}
