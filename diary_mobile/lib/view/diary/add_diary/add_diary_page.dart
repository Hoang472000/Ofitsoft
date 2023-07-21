import 'package:diary_mobile/data/repository.dart';
import 'package:diary_mobile/view/diary/diary_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/entity/diary/diary.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/constans/name_icon.dart';
import '../../../utils/extenstion/extenstions.dart';
import '../../../utils/extenstion/input_register_model.dart';
import '../../../utils/extenstion/service_info_extension.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../../utils/widgets/button_widget.dart';
import '../../../utils/widgets/input/container_input_widget.dart';
import '../../../view_model/diary/list_diary_bloc.dart';

class AddDiaryView extends StatefulWidget {
  const AddDiaryView({super.key});

  @override
  _AddDiaryViewState createState() => _AddDiaryViewState();

  static Route route() {
    return Utils.pageRouteBuilder(AddDiaryView(), true);
  }
}

class _AddDiaryViewState extends State<AddDiaryView> {
  List<InputRegisterModel> _listWidget = [];
  List<String> _listDanhMuc = [
    "Tất cả",
    // "Nghĩa vụ tài chính về đất đai",
    "LPTB phương tiện"
  ];
  List<String> listTypePayment = [
    "Thửa ruộng 100.000 ha ",
    "Thửa ruộng 100.000.000. ha 2",
    "Thửa ruộng 100.000 ha 3",
    "Thửa ruộng 100.000 ha 4",
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
        title: "Thửa ruộng",
        isCompulsory: true,
        type: TypeInputRegister.Select,
/*        valueSelected: listTypePayment[0],
        valueDefault: listTypePayment[0],*/
        icon: Icons.arrow_drop_down,
        positionSelected: -1,
        listValue: listTypePayment));
    _listWidget.add(InputRegisterModel(
      title: "Tên nhật ký",
      isCompulsory: true,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.text,
      maxLengthTextInput: 200,
      controller: nameController,
    ));
    _listWidget.add(InputRegisterModel(
      title: "Số cây trồng",
      isCompulsory: true,
      maxLengthTextInput: 12,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.number,
      controller: soCayController,
    ));
    _listWidget.add(InputRegisterModel(
      title: "Sản lượng dự kiến",
      isCompulsory: true,
      maxLengthTextInput: 12,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.number,
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
    _listWidget.add(InputRegisterModel(
      title: "Mô tả",
      isCompulsory: true,
      maxLengthTextInput: 12,
      type: TypeInputRegister.TextField,
      typeInput: TextInputType.number,
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
      create: (context) => ListDiaryBloc(context.read<Repository>()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.background,
        appBar: BkavAppBar(
          context,
          centerTitle: true,
          showDefaultBackButton: true,
          title: Text(
            "Thêm mới nhật ký",
            style: StyleBkav.textStyleFW700(Colors.white, 20),
          ),
          backgroundColor: AppColor.background,
          leading: TextButton(
            onPressed: () {
              Navigator.of(context).push(DiaryView.route());
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 35,
            ),
          ),
          actions: [],
        ),
        //endDrawer: AppDrawer(),
        body: BlocConsumer<ListDiaryBloc, ListDiaryState>(
            listener: (context, state) async {},
            builder: (blocContext, state) {
              return Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ListView.builder(
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
      ServiceInfoExtension().selectValue(inputRegisterModel, context, (inputModel) {});
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
