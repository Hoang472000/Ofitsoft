import 'package:diary_mobile/view/diary/diary_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/extenstion/extenstions.dart';
import '../../../utils/extenstion/input_register_model.dart';
import '../../../utils/extenstion/service_info_extension.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../../utils/widgets/button_widget.dart';
import '../../../utils/widgets/input/container_input_widget.dart';
import '../../../view_model/list_diary/list_diary_bloc.dart';

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
        title: "Các hoạt động",
        isCompulsory: true,
        type: TypeInputRegister.Select,
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        listValue: listActivity));
    _listWidget.add(InputRegisterModel<String, DateTime>(
        title: "Thời gian",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        // valueSelected: DateTime.now(),
        icon: Icons.calendar_today));
    _listWidget.add(InputRegisterModel(
        title: "Nội dung cần chú ý",
        isCompulsory: true,
      maxLengthTextInput: 2000,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      controller: soLuongController,
    ));

    _listWidget.add(InputRegisterModel(
        title: "Cách giải quyết",
        isCompulsory: true,
      maxLengthTextInput: 2000,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      controller: soLuongController,
    ));
    _listWidget.add(InputRegisterModel<String, DateTime>(
        title: "Thời gian khắc phục",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        // valueSelected: DateTime.now(),
        icon: Icons.calendar_today));
    _listWidget.add(InputRegisterModel(
      title: "Mô tả",
      isCompulsory: true,
      maxLengthTextInput: 2000,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      controller: moTaController,
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
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
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
                            itemCount: _listWidget.length,
                            itemBuilder: (_, index) => ContainerInputWidget(
                                contextParent: context,
                                inputRegisterModel: _listWidget[index],
                                onClick: () {
                                  setState(() {});
                                  onSelectValue(_listWidget[index], context);
                                })),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
      }
    }
  }
}
