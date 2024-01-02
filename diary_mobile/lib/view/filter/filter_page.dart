import 'dart:convert';
import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:diary_mobile/data/entity/image/image_entity.dart';
import 'package:diary_mobile/data/repository.dart';
import 'package:diary_mobile/view_model/filter/filter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../generated/l10n.dart';
import '../../../resource/assets.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../../utils/utils.dart';
import '../../utils/status/forget_password_status.dart';
import '../../utils/widgets/input/container_input_widget.dart';
import '../../utils/widgets/input/text_form_input_text.dart';

class FilterPage extends StatefulWidget {
  FilterPage({super.key, required this.list, required this.onClose, required this.type, required this.callBack});

  List<dynamic> list;
  final String type;
  final VoidCallback onClose;
  final Function(dynamic) callBack;

  @override
  _FilterPageState createState() => _FilterPageState();

  static Route route(List<dynamic> list, String type, VoidCallback onClose, Function(dynamic) callBack) {
    return Utils.pageRouteBuilder(
        FilterPage(
            list: list,
            type: type,
            onClose: onClose,
            callBack: callBack,
        ),
        true);
  }
}

class _FilterPageState extends State<FilterPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _showModalBottomSheet(BuildContext context) {
    final myModel =
    BlocProvider.of<FilterBloc>(context, listen: false);
    String startTime = "";
    String endTime = "";
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: myModel,
          child: SizedBox(
            //  height: MediaQuery.of(context).copyWith().size.height * 0.53,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                /* const SizedBox(
                  height: 12,
                ),*/
                Expanded(
                  child: SizedBox(
                    //height: MediaQuery.of(context).copyWith().size.height * 0.45,
                    child: CalendarDatePicker2(
                      config: CalendarDatePicker2Config(
                          calendarType: CalendarDatePicker2Type.range,
                          selectedDayHighlightColor: AppColor.main,
                          weekdayLabelTextStyle: StyleOfit.textStyleFW500(
                              AppColor.gray1, 14,
                              overflow: TextOverflow.visible),
                          //disableYearPicker: true,
                          //lastDate: DateTime.now(),
                          dayBorderRadius: BorderRadius.circular(12),
                          controlsTextStyle: StyleOfit.textStyleFW500(
                              AppColor.black22, 18,
                              overflow: TextOverflow.visible)),
                      onValueChanged: (dates) => {
                        startTime = Utils.formatDateToString(dates[0]!),
                        endTime = Utils.formatDateToString(
                            dates.length > 1 ? dates[1]! : dates[0]!),
                      }, value: [],
                     // initialValue: [],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColor.main,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(S.of(context).cancel,
                              style: StyleOfit.textScore(Colors.white)),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColor.main,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(S.of(context).agree,
                              style: StyleOfit.textScore(AppColor.whiteE8)),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          context
                              .read<FilterBloc>()
                              .add(OnChangeDateTime(startTime, endTime));
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterBloc(context.read<Repository>())
        ..add(InitFilterEvent( widget.type, widget.list)),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.background,
        body: SafeArea(
          child: BlocBuilder<FilterBloc, FilterState>(
            builder: (contextBloc, state) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(12),
                        child: Text("Bộ lọc tìm kiếm",
                            style: StyleOfit.textStyleFW500(AppColor.black22, 18)),
                      ),
                      Text("Khoảng thời gian",
                          style: StyleOfit.textStyleFW500(
                              AppColor.black22, 15)),
                      Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 5),
                          child: GestureDetector(
                            onTap: () {
                              _showModalBottomSheet(contextBloc);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5),
                              child: FormField<String>(
                                builder:
                                    (FormFieldState<String> stateFrom) {
                                  return Container(
                                      padding: const EdgeInsets.only(
                                          top: 10.0,
                                          left: 10.0,
                                          bottom: 10.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                          color: Colors.white),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                "${state.startTime} - ${state.endTime}",
                                                style: StyleOfit
                                                    .textStyleFW400(
                                                    AppColor.black22,
                                                    15),
                                              )),
                                          Container(
                                              padding:
                                              const EdgeInsets.only(
                                                  right: 8),
                                              child: SvgPicture.asset(
                                                  IconAsset
                                                      .icLich))
                                        ],
                                      ));
                                },
                              ),
                            ),
                          )),
                      Container(
                        padding:
                        const EdgeInsets.only(top: 7, bottom: 5),
                        child: Text("Lọc theo",
                            style: StyleOfit.textStyleFW500(
                                AppColor.black22, 15)),
                      ),
                      state.list.length > 0  && state.isShowProgress == false?
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.list.length,
                          itemBuilder: (_, index) => ContainerInputWidget(
                              contextParent: context,
                              inputRegisterModel: state.list[index],
                              onClick: () {
                                setState(() {});
                                contextBloc.read<FilterBloc>().add(
                                    OnSelectValueEvent(
                                        state.list, index, context));
                              })) : SizedBox(),

                      if(widget.type == "season")
                        Container(
                          padding: const EdgeInsets.only(top: 7, bottom: 5),
                          child: Text("Số tiền",
                              style: StyleOfit.textStyleFW500(
                                  AppColor.black22, 15)),
                        ),
                      if(widget.type == "season")
                        Row(
                        children: [
                          Expanded(
                            child: Container(
                              //margin: const EdgeInsets.only(top: 25),
                                child: TextFormFieldInputText(
                                  isNumber: true,
                                  "TỐI THIỂU",
                                  state.minPrice ?? TextEditingController(),
                                  false,
                                  state.minPriceFocus ?? FocusNode(),
                                  (state.formStatus is ValidatePassFail) ? "" : "",
                                      (lostFocus) {
                                  },
                                  false,
                                  onChangeCallBack: (text) {
                                    print("text: SaveReplyEvent: $text");
                                    contextBloc.read<FilterBloc>().add(
                                        SaveValueTextEvent(text, "minPrice"));
                                  },// textCapitalization: false,
                                )),
                          ),Container(child: Text(" — "),),
                          Expanded(
                            child: Container(
                              //margin: const EdgeInsets.only(top: 25),
                                child: TextFormFieldInputText(
                                  isNumber: true,
                                  "TỐI ĐA",
                                  state.maxPrice ?? TextEditingController(),
                                  false,
                                  state.maxPriceFocus ?? FocusNode(),
                                  (state.formStatus is ValidatePassFail) ? "" : "",
                                      (lostFocus) {
                                  },
                                  false,
                                  onChangeCallBack: (text) {
                                    print("text: SaveReplyEvent: $text");
                                    contextBloc.read<FilterBloc>().add(
                                        SaveValueTextEvent(text, "maxPrice"));
                                  },// textCapitalization: false,
                                )),
                          ),
                        ],
                      ),
                      if (widget.type == "season")
                        Container(
                          padding: const EdgeInsets.only(top: 7, bottom: 5),
                          child: Text("Số lượng",
                              style: StyleOfit.textStyleFW500(
                                  AppColor.black22, 15)),
                        ),
                      if(widget.type == "season")
                        Row(
                        children: [
                          Expanded(
                            child: Container(
                              //margin: const EdgeInsets.only(top: 25),
                                child: TextFormFieldInputText(
                                  isNumber: true,
                                  "TỐI THIỂU",
                                  state.minQuantity ?? TextEditingController(),
                                  false,
                                  state.minQuantityFocus ?? FocusNode(),
                                  (state.formStatus is ValidatePassFail) ? "" : "",
                                      (lostFocus) {
                                  },
                                  false,
                                  onChangeCallBack: (text) {
                                    print("text: SaveReplyEvent: $text");
                                    contextBloc.read<FilterBloc>().add(
                                        SaveValueTextEvent(text, "minQuantity"));
                                  },// textCapitalization: false,
                                )),
                          ),Container(child: Text(" — "),),
                          Expanded(
                            child: Container(
                              //margin: const EdgeInsets.only(top: 25),
                                child: TextFormFieldInputText(
                                  isNumber: true,
                                  "TỐI ĐA",
                                  state.maxQuantity ?? TextEditingController(),
                                  false,
                                  state.maxQuantityFocus ?? FocusNode(),
                                  (state.formStatus is ValidatePassFail) ? "" : "",
                                      (lostFocus) {
                                  },
                                  false,
                                  onChangeCallBack: (text) {
                                    print("text: SaveReplyEvent: $text");
                                    contextBloc.read<FilterBloc>().add(
                                        SaveValueTextEvent(text, "maxQuantity"));
                                  },// textCapitalization: false,
                                )),
                          ),
                        ],
                      ),
                      if(widget.type == "harvesting")
                        Container(
                          padding: const EdgeInsets.only(top: 7, bottom: 5),
                          child: Text("Sản lượng",
                              style: StyleOfit.textStyleFW500(
                                  AppColor.black22, 15)),
                        ),
                      if(widget.type == "harvesting")
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                //margin: const EdgeInsets.only(top: 25),
                                  child: TextFormFieldInputText(
                                    isNumber: true,
                                    "TỐI THIỂU",
                                    state.minQuantity ?? TextEditingController(),
                                    false,
                                    state.minQuantityFocus ?? FocusNode(),
                                    (state.formStatus is ValidatePassFail) ? "" : "",
                                        (lostFocus) {
                                    },
                                    false,
                                    onChangeCallBack: (text) {
                                      print("text: SaveReplyEvent: $text");
                                      contextBloc.read<FilterBloc>().add(
                                          SaveValueTextEvent(text, "minPrice"));
                                    },// textCapitalization: false,
                                  )),
                            ),Container(child: Text(" — "),),
                            Expanded(
                              child: Container(
                                //margin: const EdgeInsets.only(top: 25),
                                  child: TextFormFieldInputText(
                                    isNumber: true,
                                    "TỐI ĐA",
                                    state.maxQuantity ?? TextEditingController(),
                                    false,
                                    state.maxQuantityFocus ?? FocusNode(),
                                    (state.formStatus is ValidatePassFail) ? "" : "",
                                        (lostFocus) {
                                    },
                                    false,
                                    onChangeCallBack: (text) {
                                      print("text: SaveReplyEvent: $text");
                                      contextBloc.read<FilterBloc>().add(
                                          SaveValueTextEvent(text, "maxPrice"));
                                    },// textCapitalization: false,
                                  )),
                            ),
                          ],
                        ),
                    ],
                  ),
                  Positioned(
                     right: 0, bottom: 0,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.only(left: 8, right: 8),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.main,
                                  blurRadius: 1,
                                  spreadRadius: 2,
                                  offset: Offset(0, 0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white),
                          child: TextButton(
                            child: Text("Thiết lập lại",
                              style: StyleOfit.textStyleFW500(AppColor.main, 16),),
                            onPressed: (){
                              contextBloc.read<FilterBloc>().add(InitFilterEvent(widget.type, widget.list));
                            },),
                        ),
                        SizedBox(width: 8,),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.only(left: 16, right: 16),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.gray57,
                                  blurRadius: 1,
                                  offset: Offset(0, 0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(4),
                              color: AppColor.main),
                          child: TextButton(
                            child: Text("Áp dụng",
                              style: StyleOfit.textStyleFW500(AppColor.whiteF2, 16),),
                            onPressed: (){
                              if (widget.type == "season") {
                                widget.callBack([
                                  state.startTime,
                                  state.endTime,
                                  state.minPrice!.text,
                                  state.maxPrice!.text,
                                  state.minQuantity!.text,
                                  state.maxQuantity!.text,
                                  state.indexFilter0,
                                  state.indexFilter1,
                                ]);
                              } else if (widget.type == "diary") {
                                widget.callBack([
                                  state.startTime,
                                  state.endTime,
                                  state.indexFilter0,
                                  state.indexFilter1,
                                  state.indexFilter2,
                                  state.indexFilter3,
                                ]);
                              }  else if (widget.type == "report") {
                                widget.callBack([
                                  state.startTime,
                                  state.endTime,
                                  state.indexFilter0,
                                  state.indexFilter1,
                                  state.indexFilter2,
                                  state.indexFilter3,
                                ]);
                              }
                              else if (widget.type == "activity") {
                                widget.callBack([
                                  state.startTime,
                                  state.endTime,
                                  state.minQuantity!.text,
                                  state.maxQuantity!.text,
                                  state.indexFilter0,
                                  state.indexFilter1,
                                ]);
                              }
                              else if (widget.type == "harvesting") {
                                widget.callBack([
                                  state.startTime,
                                  state.endTime,
                                  state.minQuantity!.text,
                                  state.maxQuantity!.text,
                                  state.indexFilter0,
                                  state.indexFilter1,
                                ]);
                              }
                              widget.onClose();
                            },),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

}
