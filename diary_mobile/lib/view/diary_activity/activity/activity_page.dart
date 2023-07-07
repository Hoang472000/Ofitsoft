import 'package:diary_mobile/view/diary/diary_view.dart';
import 'package:diary_mobile/view/diary_activity/monitor/add_monitor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../resource/assets.dart';
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
import 'add_activity.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key, required this.action});
  final String action;

  @override
  _ActivityPageState createState() => _ActivityPageState();

  static Route route(String action) {
    return Utils.pageRouteBuilder(ActivityPage(action: action,), true);
  }
}

class _ActivityPageState extends State<ActivityPage> {
  List<InputRegisterModel> _listWidget = [];
  List<String> _listDanhMuc = [
    "Tất cả",
    // "Nghĩa vụ tài chính về đất đai",
    "LPTB phương tiện"
  ];
  List<String> listTypePayment = [
    "Ruộng 1",
    "Ruộng 2",
    "Ruộng 3",
    "Ruộng 4",
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
        //resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.green99,
          child: Icon(Icons.add),
          onPressed: () {
            widget.action.compareTo("activity")==0 ?
            Navigator.of(context).push(AddActivityPage.route()) :
            Navigator.of(context).push(AddMonitorPage.route());
          },
        ),
        body: BlocConsumer<ListDiaryBloc, ListDiaryState>(
            listener: (context, state) {},
            builder: (blocContext, state) {
              return ListView.builder(
                  itemCount: 5 /*state.listDiary!.length*/,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {},
                      onLongPress: () {},
                      child: Container(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 12,
                              bottom: 12,
                              left: 24,
                              right: 16),
                          margin: const EdgeInsets.only(
                              left: 20,
                              right: 16,
                              top: 4,
                              bottom: 4),
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColor.green53,
                                  blurRadius: 0,
                                  offset: Offset(-5.0, 0),
                                ),
                              ],
                              borderRadius:
                              BorderRadius.circular(8),
                              color: /*widget.isChoose ? Colors.red[100] :*/
                              Colors.white),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                    const EdgeInsets.only(
                                        bottom: 5),
                                    child: Text(
                                      "Dọn vườn chuẩn bị mùa chăm sóc mới",
                                      style:
                                      StyleBkav.textStyleFW700(
                                          AppColor.gray500, 16),
                                    ),
                                  ),
                                  Container(
                                      alignment:
                                      Alignment.centerLeft,
                                      margin:
                                      const EdgeInsets.only(
                                          bottom: 5, top: 5),
                                      child: Text(
                                        "Ngày: 05/07/2023",
                                        style: StyleBkav
                                            .textStyleFW400(
                                            AppColor.gray57,
                                            14),
                                        maxLines: 1,
                                        overflow:
                                        TextOverflow.ellipsis,
                                      )),
                                  SizedBox(
                                    child: Container(
                                        alignment:
                                        Alignment.centerLeft,
                                        margin:
                                        const EdgeInsets.only(
                                            top: 5),
                                        child: RichText(
                                          text: Utils.convertText(
                                              "Trạng thái: ",
                                              "Mới thực hiện",
                                              AppColor.blue15),
                                          maxLines: 1,
                                          overflow: TextOverflow
                                              .ellipsis,
                                        )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.delete, color: Colors.red,),
                                  onPressed: () async {},
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
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
