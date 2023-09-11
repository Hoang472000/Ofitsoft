import 'dart:convert';
import 'package:diary_mobile/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../generated/l10n.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../data/entity/report/answer.dart';
import '../../data/entity/report/question.dart';
import '../../utils/status/form_submission_status.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../utils/widgets/dialog/dialog_manager.dart';
import '../../view_model/report/add_report_bloc.dart';

class AddReportViewPage extends StatefulWidget {
  AddReportViewPage({super.key, required this.diary});
  final Diary diary;

  @override
  _AddReportViewPageState createState() => _AddReportViewPageState();

  static Route route(Diary diary) {
    return Utils.pageRouteBuilder(
        AddReportViewPage(diary: diary
        ),
        true);
  }
}

class _AddReportViewPageState extends State<AddReportViewPage> {
  bool edit = false;
  List<bool> listSelected = [false, false, false];
  List<bool> listSelected1 = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
  List<bool> listSelected2 = [false, false, false];
  List<bool> listSelected3 = [false, false, false];
  List<bool> listSelected4 = [false, false, false, false, false, false, false, false, false, false, false];
  List<bool> listSelected5 = [false, false, false, false, false, false, false, false, false, false, false, false];
  List<bool> listSelected6 = [false, false, false, false];
  List<bool> listSelected8 = [false, false, false, false, false, false, false];
  List<bool> listSelected9 = [false, false, false, false, false, false, false, false, false, false, false, false];
  List<bool> listSelected10 = [false, false, false, false];
  List<bool> listSelected11 = [false, false, false, false, false, false, false, false, false, false, false, false];
  List<bool> listSelected12 = [false, false, false, false, false];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddReportBloc(context.read<Repository>())
        ..add(GetAddReportEvent(widget.diary)),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.background,
        appBar: OfitAppBar(
          context,
          centerTitle: true,
          showDefaultBackButton: true,
          title: Text(
            "Báo cáo đánh giá",
            style: StyleOfit.textStyleFW700(Colors.white, 20),
          ),
          backgroundColor: AppColor.main,
          actions: [],
        ),
        body: BlocConsumer<AddReportBloc, AddReportState>(
            listener: (blocContext, state) async {
              final formStatus = state.formStatus;
              if (formStatus is SubmissionFailed) {
                DiaLogManager.displayDialog(context, "", formStatus.exception, () {
                  Get.back();
                }, () {
                  Get.back();
                }, '', S.of(context).close_dialog);
              } else if (formStatus is SubmissionSuccess) {
                DiaLogManager.displayDialog(context, "", formStatus.success ?? "",
                        () {
                      Get.back();
                      Navigator.pop(context, [true]);
                    }, () {
                      Get.back();
                      Navigator.pop(context, [true]);
                    }, '', S.of(context).close_dialog, dismissible: false);
              } else if (formStatus is FormSubmitting) {
                DiaLogManager.showDialogLoading(context);
              }
            }, builder: (blocContext, state) {
          return WillPopScope(
            onWillPop: () async{
              Navigator.pop(context);
              return false;
            },
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: SingleChildScrollView(
                  //physics: NeverScrollableScrollPhysics(),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        tableFooter(),
                        tableMuc("BÁO CÁO KIỂM SOÁT NỘI BỘ VÀ THỰC ĐỊA NÔNG HỘ"),
                        SizedBox(height: 10,),
                        tableDetail(),
                        state.listReport.isEmpty ? Container():
                        ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: state.listReport[0].questionAndPageIds.length,
                            itemBuilder: (context, index) {
                              return  ExpansionTile(
                                title: widgetMuc("${state.listReport[0].questionAndPageIds[index].title}"),
                                children: [
                                  tableDetailResult(state.listReport[0].questionAndPageIds[index].questionAndPageIds),
                                ],
                              );
                            }),
                        ExpansionTile(
                          title: widgetMuc("1)  Biểu mẫu trang trại do nông dân sử dụng."),
                          children: [
                            tableDetail1(),
                          ],
                        ),
                        ExpansionTile(
                          title: widgetMuc("2)  Kiến thức và sự hiểu biết của người nông dân."),
                          children: [
                            tableDetail2(),
                          ],
                        ),
                        ExpansionTile(
                          title: widgetMuc("3)  Hạt giống, cây giống."),
                          children: [
                            tableDetail3(),
                          ],
                        ),
                        ExpansionTile(
                          title: widgetMuc("4)  Lưu giữ hóa chất tại nhà."),
                          children: [
                            tableDetail4(),
                          ],
                        ),
                        ExpansionTile(
                          title: widgetMuc("5)  Thu hoạch và vận chuyển sau thu hoạch."),
                          children: [
                            tableDetail5(),
                          ],
                        ),
                        ExpansionTile(
                          title: widgetMuc("6)  Quản lý sản phẩm hữu cơ và sản phẩm chuyển đổi."),
                          children: [
                            tableDetail6(),
                          ],
                        ),
                        ExpansionTile(
                          title: widgetMuc("7)  Đánh giá rủi ro và ước tính sản lượng sản phẩm tươi."),
                          children: [
                            tableDetail7(),
                          ],
                        ),
                        ExpansionTile(
                          title: widgetMuc("8)  Mô tả cây trồng trên các nương sản phẩm trong quá trình thanh tra."),
                          children: [
                            tableDetail8(),
                          ],
                        ),
                        ExpansionTile(
                          title: widgetMuc("9)  Rủi ro lẫn tạp với cây trồng không  hữu cơ."),
                          children: [
                            tableDetail9(),
                          ],
                        ),
                        ExpansionTile(
                          title: widgetMuc("10)  Rủi ro lẫn tạp phân hóa học."),
                          children: [
                            tableDetail10(),
                          ],
                        ),
                        ExpansionTile(
                          title: widgetMuc("11)  Rủi ro lẫn tạp thuốc trừ sâu hóa học."),
                          children: [
                            tableDetail11(),
                          ],
                        ),
                        ExpansionTile(
                          title: widgetMuc("12)  Tóm tắt chuyến thanh tra nội bộ."),
                          children: [
                            tableDetail12(),
                          ],
                        ),
                        ExpansionTile(
                          title: widgetMuc("13)  Tình hình thực hiện những đề xuất của lần thanh tra trước.(nếu có)"),
                          children: [
                            tableDetail13(),
                          ],
                        ),
                        ExpansionTile(
                          title: widgetMuc("14)  Đề xuất của thanh tra đối với nông dân."),
                          children: [
                            tableDetail14(),
                          ],
                        ),
                        ExpansionTile(
                          title: widgetMuc("15)  Chữ ký."),
                          children: [
                            tableDetail15(),
                          ],
                        ),
                        ExpansionTile(
                          title: widgetMuc("(*)  Rủi ro"),
                          children: [
                            tableDetail16(),
                          ],
                        ),
                        tableDetailEnd(),
                      ]
                  ),
                )),
          );
        }),
      ),
    );
  }


  Widget tableMuc(String text){
    List<Table> listTable1 =[];
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: StyleOfit.textStyleFW700(AppColor.black22, 16),
              maxLines: 5,
            ),
          ),
        ]),
      ],
    ),);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: AppColor.black22),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width* 1.0),
          child: Column(
              children: listTable1
          ),
        ),
      ),
    );
  }
  Widget widgetMuc(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0, top: 0, left: 0),
      child: Text(
        text,
        style: StyleOfit.textStyleFW700(AppColor.black22, 14),
        textAlign: TextAlign.left,
        maxLines: 5,
      ),
    );
  }
  Widget checkBox(int index, List<bool> listSelected, {bool isFirst = false}) {
    return   Container(
      margin: EdgeInsets.only(top:isFirst? 14: 0),
      height: 24.0,
      width: 24.0,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        side: BorderSide(color: AppColor.black22),
        value: listSelected[index],
        onChanged: (value) {
          setState(() {
            listSelected[index] = value ?? false;
          });
        },
      ),
    );
  }
  TableRow tableRowCheckBox(String title, int index, List<bool> listSelected,{bool isFirst = false}) {
    return TableRow(children: [
      checkBox(index, listSelected, isFirst: isFirst),
      Padding(
        padding: EdgeInsets.only(bottom: 8, top: isFirst ? 18 : 4),
        child: Text(
          title,
          textAlign: TextAlign.left,
          style: StyleOfit.textStyleFW400(AppColor.black22, 14),
          maxLines: 7,
        ),
      ),
    ]);
  }
  Widget tableRowText(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8,left: 4, right: 4),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: StyleOfit.textStyleFW400(AppColor.black22, 14),
        maxLines: 7,
      ),
    );
  }
  Widget tableNon() {
    return const Padding(
        padding: EdgeInsets.zero,
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none, // No border or underline
            contentPadding: EdgeInsets.only(bottom: 4, top: 4,left: 4, right: 4),
          ),
          maxLines: 10,
          minLines: 1,
        )
    );
  }
  TableRow tableRowCheckBoxTextField(String title, int index, List<bool> listSelected, TextEditingController controller, {bool isFirst = false}) {
    return TableRow(children: [
      checkBox(index, listSelected, isFirst: isFirst),
      Padding(
        padding: EdgeInsets.only(top: isFirst ? 16 : 4, bottom: 16.0),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: StyleOfit.textStyleFW400(AppColor.black22, 14),
              ),
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.back09),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:  AppColor.back09),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color:  AppColor.back09),
                        ),
                      )
                  ),
                ),
              ),
            ],
          ),
          textScaleFactor: MediaQuery.of(context).textScaleFactor,
        ),
      )
    ]);
  }
  TableRow tableRowTextField(String title, TextEditingController controller, {bool isFirst = false}) {
    return TableRow(children: [
      Padding(
        padding: EdgeInsets.only(top: isFirst ? 16 : 4, bottom: 16.0, left: 10),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: StyleOfit.textStyleFW400(AppColor.black22, 14),
              ),
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.back09),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:  AppColor.back09),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color:  AppColor.back09),
                        ),
                      )
                  ),
                ),
              ),
            ],
          ),
          textScaleFactor: MediaQuery.of(context).textScaleFactor,
        ),
      )
    ]);
  }
  Widget tableFooter(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8, left: 0),
      child: Text(
        "P02-06",
        style: StyleOfit.textStyleFW400(AppColor.black22, 16),
        textAlign: TextAlign.left,
        maxLines: 2,
      ),
    );
  }
  Widget tableDetail(){
    List<Table> listTable0 =[];
    listTable0.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Ngày thanh tra",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW700(AppColor.black22, 14),
              maxLines: 2,
            ),
          ),
        ]),
      ],
    ),);
    listTable0.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
      },
      //border: TableBorder.all(color: Colors.grey),
      children: [
        TableRow(children: [
          Padding(
              padding: EdgeInsets.only(bottom: 16, top: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none, // No border or underline
                  contentPadding: EdgeInsets.only(left: 4, right: 4),
                ),
              )
          ),
        ]),
      ],
    ),);
    List<Table> listTable1 =[];
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),

      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Tên nông dân",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW700(AppColor.black22, 14),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: InputBorder.none, // No border or underline
              contentPadding: EdgeInsets.only(left: 4, right: 4),
              // No padding
            ),
            //maxLength: 200,
            //maxLines: 5,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Mã nông hộ",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: InputBorder.none, // No border or underline
              contentPadding: EdgeInsets.zero, // No padding
            ),
          ),
        ]),
      ],
    ),);
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(3),
      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Thanh tra viên nội bộ",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW700(AppColor.black22, 14),
              maxLines: 3,
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: InputBorder.none, // No border or underline
              contentPadding: EdgeInsets.only(left: 4, right: 4),
            ),
          ),
        ]),
      ],
    ),);
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1),
      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Hình thức chuyến kiểm soát nội bộ",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW700(AppColor.black22, 14),
              maxLines: 3,
            ),
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            columnWidths: const {
              0: FlexColumnWidth(0.3),
              1: FlexColumnWidth(2),
            },
            children: [
              tableRowCheckBox(
                  "Thanh tra ban đầu trước khi cho phép tham gia vào dự án",
                  0, listSelected, isFirst: true),
              tableRowCheckBox(
                "Thanh tra hàng năm.",
                1, listSelected,),
              tableRowCheckBox(
                "Thanh tra không báo trước.",
                2, listSelected,),
            ],
          ),
          Column(
              children: listTable0
          ),
        ]),
      ],
    ),);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: AppColor.black22),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*1.0),
          child: Column(
              children: listTable1
          ),
        ),
      ),
    );
  }

  Widget tableDetailResult(List<Question> list){
    List<Table> listTable1 =[];
    int form = 0;
    for(int i = 0 ; i < list.length; i++) {
      List<Table> tableSub = [];
      List<TableRow> tableRow = [];
      List<TableRow> tableRowSub = [];
      List<TableRow> tableRowSubSub = [];
      List<Widget> tableWidgetText = [];
      List<Widget> tableWidgetNon = [];
      form = checkForm(list[i]);

      print("HoangCV: list[i].questionType == : ${list[i].questionType == "table"}");
      if(list[i].questionType == "simple_choice" || list[i].questionType == "multiple_choice"){
        if(list[i].suggestedAnswerIds.length<=2 || list[i].suggestedAnswerIds.length>=4){
          for (int j = 0; j < list[i].suggestedAnswerIds.length; j ++) {
            print("HongcV: list . as: ${list[i].title} : ${list[i].suggestedAnswerIds[j].value} : ${form} ");
            if (list[i].suggestedAnswerIds[j].questionAndPageIds.isNotEmpty){
              if (list[i].suggestedAnswerIds[j]
                  .commentAnswer == true) {
                tableRow.add(tableRowCheckBoxTextField(
                    "${list[i].suggestedAnswerIds[j].value}",
                    3, listSelected1, TextEditingController(),
                    isFirst: i == 0 ? true : false));
              } else {
                print("HongcV: list no as: ${list[i].title} : ${list[i].suggestedAnswerIds[j].value}");
                tableRow.add(tableRowCheckBox(
                    "${list[i].suggestedAnswerIds[j].value}",
                    j, listSelected1, isFirst: i == 0 ? true : false));
              }
            for (int k = 0; k <
                list[i].suggestedAnswerIds[j].questionAndPageIds.length; k ++) {
              print("HongcV: list . title: ${list[i].suggestedAnswerIds[j]
                  .questionAndPageIds[k].title} : ${list[i]
                  .suggestedAnswerIds[j]
                  .questionAndPageIds[k].questionType} ");
              if (list[i].suggestedAnswerIds[j].questionAndPageIds[k]
                  .questionType == "numerical_box" ||
                  list[i].suggestedAnswerIds[j].questionAndPageIds[k]
                      .questionType == "char_box") {
                tableRowSub.add(tableRowCheckBoxTextField(
                    "${list[i].suggestedAnswerIds[j].questionAndPageIds[k]
                        .title}",
                    3, listSelected1, TextEditingController(),
                    isFirst: i == 0 ? true : false));
              } else {
                tableRowSub.add(tableRowCheckBox(
                    "${list[i].suggestedAnswerIds[j].questionAndPageIds[k]
                        .title}",
                    list[i].suggestedAnswerIds.length + k, listSelected1,
                    isFirst: i == 0 ? true : false));
              }
            }
          } else{
              bool hasNonEmptyValues = list[i].suggestedAnswerIds.any((element) {
                return element.questionAndPageIds.isNotEmpty;
              });
              print("HoangCV: hasNonEmptyValues:${list[i].title} : ${list[i].suggestedAnswerIds[j].value} : ${hasNonEmptyValues}");
              if(hasNonEmptyValues){
                tableRow.add(tableRowCheckBox(
                    "${list[i].suggestedAnswerIds[j].value}",
                    j, listSelected1, isFirst: i == 0 ? true : false));
              }else {
                bool hasCommentAnswer = list[i].suggestedAnswerIds.any((element) {
                  return element.commentAnswer == true;
                });
                if(hasCommentAnswer) {
                  form = 2;
                  if (list[i].suggestedAnswerIds[j].commentAnswer == true) {
                    tableSub.add(tableForm2TextField(
                        list[i].suggestedAnswerIds[j].value ?? '', j,
                        listSelected2, TextEditingController()));
                  } else {
                    tableSub.add(tableForm2(
                        list[i].suggestedAnswerIds[j].value ?? '', j,
                        listSelected2, isFirst: i == 0 ? true : false));
                  }
                }else{
                  form = 3;
                  tableRow.add(
                  tableRowCheckBox(
                      list[i].suggestedAnswerIds[j].value ?? '', j,
                      listSelected2));
                }
              }
            }
          }
        }
        else if(list[i].suggestedAnswerIds.length>2 && list[i].suggestedAnswerIds.length<4){
          form = 1;
          for (int j = 0; j < list[i].suggestedAnswerIds.length; j ++) {
            if (list[i].suggestedAnswerIds[j]
                .commentAnswer == true) {
              tableSub.add(tableForm2TextField(
                  list[i].suggestedAnswerIds[j].value ?? '', j,
                  listSelected2, TextEditingController()));
            } else {
              tableSub.add(tableForm2(
                  list[i].suggestedAnswerIds[j].value ?? '', j,
                  listSelected2));
            }
          }
        }
      }
      else if(list[i].questionType == "table"){
        print("HoangCV: list[i].questionType 112== : ${list[i].questionType == "table"} : ${list[i].questionAndPageIds.length}");
        for(int j = 0 ; j< list[i].suggestedAnswerIds.length; j ++){
          tableWidgetText.add(
              tableRowText(
                  list[i].suggestedAnswerIds[j].value ?? ''));
          tableWidgetNon.add(
              tableNon());
        }
      }
      print("HaongCV: table sub khac null: ${list[i].title} : ${tableRow.isNotEmpty} : ${tableSub.isEmpty} : ${tableRowSub.isEmpty} : ${tableRow.isNotEmpty}");
      if(tableSub.isEmpty && form != 0 && form != 1 && form != 2 && form != 7) {
        listTable1.add(Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          columnWidths: {
            0: FlexColumnWidth(0.6),
            1: FlexColumnWidth(0.6),
            2: FlexColumnWidth(2),
          },
          border: TableBorder.all(color: AppColor.black22),
          children: [
            TableRow(children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16, top: 16),
                child: Text(
                  "${list[i].title}",
                  textAlign: TextAlign.center,
                  style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                  maxLines: 7,
                ),
              ),
              tableRow.isNotEmpty
                  ? Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: tableRow,
              )
                  : Container(),
              tableRowSub.isNotEmpty ?
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.3),
                  1: FlexColumnWidth(2),
                },
                children: tableRowSub,
              ) : Container(),
            ]),
          ],
        ),);
      }
      else if(tableRow.isNotEmpty && tableRowSub.isEmpty && form != 2 && form != 7){
      }
      if(tableSub.isNotEmpty && form != 0 && form != 1 && form != 2 && form !=7) {
        listTable1.add(Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          columnWidths: {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(2),
          },
          border: TableBorder.all(color: AppColor.black22),
          children: [
            TableRow(
                children: tableSub
            ),
          ],
        ),);
      }
      else if(tableSub.isNotEmpty && form != 0 && form != 1 && form == 2 && form !=7) {
        listTable1.add(Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          columnWidths: {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(2),
          },
          border: TableBorder.all(color: AppColor.black22),
          children: [
            TableRow(
                children: [
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FlexColumnWidth(0.7),
                      1: FlexColumnWidth(2),
                    },
                    children: [
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 16, top: 16),
                          child: Text(
                            "${list[i].title}",
                            textAlign: TextAlign.center,
                            style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                            maxLines: 6,
                          ),
                        ),
                      ]),
                    ],
                  ),
                  for(int i =0; i<tableSub.length; i++)
                    tableSub[i]
                ]
            ),
          ],
        ),);
      }
      if(form == 0){
          for(int j = 0 ; j< list[i].suggestedAnswerIds.length; j++){
            if(list[i].questionType == "char_box"){
              tableSub.add(formCharTextField(list[i].title??'',TextEditingController()));
            }else{
              tableSub.add(tableForm2TextField(list[i].title ?? '', i, listSelected3, TextEditingController()));
            }
      /*      if(list[i].suggestedAnswerIds[j].commentAnswer == true){
              tableSub.add(tableForm2TextField(list[i].suggestedAnswerIds[j].value ?? '', j, listSelected2, TextEditingController()));
            } else {
              tableSub.add(tableForm2(list[i].suggestedAnswerIds[j].value ?? '', j, listSelected2));
            }*/
          }
          listTable1.add(Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            columnWidths: {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(2),

            },
            border: TableBorder.all(color: AppColor.black22),
            children: [
              TableRow(
                  children: [list[i].questionType == "char_box" ? formCharTextField(list[i].title??'',TextEditingController()):
                  tableForm2TextField(list[i].title ?? '', i, listSelected3, TextEditingController())]),
            ],
          ),);
        }
      else if(form == 1){
        print("HoangCV: 121312             ${list[i].title}");
        listTable1.add(Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          columnWidths: { },
          border: TableBorder.all(color: AppColor.black22),
          children: [
            TableRow(children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16, top: 16),
                child: Text(
                  "${list[i].title}",
                  textAlign: TextAlign.center,
                  style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                  maxLines: 3,
                ),
              ),
            ]),
          ],
        ),);
        listTable1.add(Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(2),

          },
          border: TableBorder.all(color: AppColor.black22),
          children: [
            TableRow(
                children: tableSub
            ),
          ],
        ),);
      }
      else if(form ==7 && tableWidgetText.isNotEmpty){
        listTable1.add(Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          columnWidths: {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1),
            5: FlexColumnWidth(1),

          },
          border: TableBorder.all(color: AppColor.black22),
          children: [
            TableRow(children: tableWidgetText),
          ],
        ),);
        for(int i =0 ; i< 2; i++){
          listTable1.add(Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            columnWidths: {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
              4: FlexColumnWidth(1),
              5: FlexColumnWidth(1),

            },
            border: TableBorder.all(color: AppColor.black22),
            children: [
              TableRow(children: tableWidgetNon),
            ],
          ),);
        }
      }
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: AppColor.black22),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*1.1),
          child: Column(
              children: listTable1
          ),
        ),
      ),
    );
  }

  Table tableForm2TextField(String title, int index, List<bool> listSelected, TextEditingController controller, {bool isFirst = false}){
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: const {
        0: FlexColumnWidth(0.3),
        1: FlexColumnWidth(2),
      },
      children: [
        tableRowCheckBoxTextField(
            title,
            index, listSelected,TextEditingController(), isFirst: true),
      ],
    );
  }
  Table formCharTextField(String title, TextEditingController controller, {bool isFirst = false}){
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: const {
        0: FlexColumnWidth(0.3),
        1: FlexColumnWidth(2),
      },
      children: [
        tableRowTextField(
            title,TextEditingController(), isFirst: true),
      ],
    );
  }
  Table tableForm2(String title, int index, List<bool> listSelected, {bool isFirst = false}){
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: const {
        0: FlexColumnWidth(0.7),
        1: FlexColumnWidth(2),
      },
      children: [
        tableRowCheckBox(
            title,
            index, listSelected, isFirst: isFirst),
      ],
    );

  }
  int checkForm(Question qs){
    int count = 0;
    print("HoangCV: questiontype: ${qs.title} : ${qs.questionType}");
    if(qs.questionType=="table"){
      return 7;
    }
    if(qs.suggestedAnswerIds.isNotEmpty){
      count++;
      List<Answer> as = qs.suggestedAnswerIds;
      bool checkAdd = true;
      for(int i = 0 ; i< as.length ; i++){
        if(as[i].questionAndPageIds.isEmpty){
          count++;
          if(as[i].commentAnswer == true){
            count = count + 4;
          }
        }
        if(as[i].questionAndPageIds.isNotEmpty && checkAdd){
          checkAdd = false;
          count++;
          List<Question> qsSub = as[i].questionAndPageIds;
          for(int j = 0 ; j< qsSub.length ; j++){
            if(qsSub[j].suggestedAnswerIds.isNotEmpty){
              count++;
            } else{
              count++;
            }
          }
        }
      }
    }

    return count;
  }

  Widget tableDetail1(){
    List<Table> listTable1 =[];
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(0.6),
        1: FlexColumnWidth(0.6),
        2: FlexColumnWidth(2),

      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Thẻ thành viên ICS",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
              maxLines: 3,
            ),
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            columnWidths: const {
              0: FlexColumnWidth(0.7),
              1: FlexColumnWidth(2),
            },
            children: [
              tableRowCheckBox(
                  "Có",
                  0, listSelected1, isFirst: true),
              tableRowCheckBox(
                  "Không",
                  1, listSelected1),
            ],
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            columnWidths: const {
              0: FlexColumnWidth(0.3),
              1: FlexColumnWidth(2),
            },
            children: [
              tableRowCheckBox(
                  "Có mang đến khi bán sản phầm không?",
                  2, listSelected1, isFirst: true),
              tableRowCheckBoxTextField(
                  "Tỷ lệ số lần không mang đến:",
                  3, listSelected1, TextEditingController()),
            ],
          ),
        ]),
      ],
    ),);
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(0.6),
        1: FlexColumnWidth(0.6),
        2: FlexColumnWidth(2),

      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Phiếu biên nhận bán sản phẩm",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
              maxLines: 3,
            ),
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            columnWidths: const {
              0: FlexColumnWidth(0.7),
              1: FlexColumnWidth(2),
            },
            children: [
              tableRowCheckBox(
                  "Có",
                  4, listSelected1, isFirst: true),
              tableRowCheckBox(
                  "Không",
                  5, listSelected1),
            ],
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            columnWidths: const {
              0: FlexColumnWidth(0.3),
              1: FlexColumnWidth(2),
            },
            children: [
              tableRowCheckBoxTextField(
                  "Số lần bán sản phẩm cho xưởng",
                  6, listSelected1, TextEditingController(), isFirst: true),
              tableRowCheckBoxTextField(
                  "Số tờ giữ được",
                  7, listSelected1, TextEditingController()),
              tableRowCheckBoxTextField(
                  "Số tờ thiếu",
                  8, listSelected1, TextEditingController()),
            ],
          ),
        ]),
      ],
    ),);
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(0.6),
        1: FlexColumnWidth(0.6),
        2: FlexColumnWidth(2),

      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Tài liệu tóm tắt yêu cầu của Tiêu chuẩn hữu cơ",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            columnWidths: const {
              0: FlexColumnWidth(0.7),
              1: FlexColumnWidth(2),
            },
            children: [
              tableRowCheckBox(
                  "Có",
                  9, listSelected1, isFirst: true),
              tableRowCheckBox(
                  "Không",
                  10, listSelected1),
            ],
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            columnWidths: const {
              0: FlexColumnWidth(0.3),
              1: FlexColumnWidth(2),
            },
            children: [
              tableRowCheckBox(
                  "Được giữ gìn cẩn thận",
                  11, listSelected1, isFirst: true),
              tableRowCheckBoxTextField(
                  "Không được giữ gìn cẩn thận",
                  12, listSelected1, TextEditingController()),
            ],
          ),
        ]),
      ],
    ),);
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(0.6),
        1: FlexColumnWidth(0.6),
        2: FlexColumnWidth(2),

      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Sổ tay nông hộ",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            columnWidths: const {
              0: FlexColumnWidth(0.7),
              1: FlexColumnWidth(2),
            },
            children: [
              tableRowCheckBox(
                  "Có",
                  13, listSelected1, isFirst: true),
              tableRowCheckBox(
                  "Không",
                  14, listSelected1),
            ],
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            columnWidths: const {
              0: FlexColumnWidth(0.3),
              1: FlexColumnWidth(2),
            },
            children: [
              tableRowCheckBox(
                  "Được ghi chép đầy đủ",
                  15, listSelected1, isFirst: true),
              tableRowCheckBoxTextField(
                  "Không được ghi chép đầy đủ",
                  16, listSelected1, TextEditingController()),
            ],
          ),
        ]),
      ],
    ),);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: AppColor.black22),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*1.1),
          child: Column(
              children: listTable1
          ),
        ),
      ),
    );
  }
  Widget tableDetail2(){
    List<Table> listTable1 =[];
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: { },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Người nông dân có hiểu những yếu tố cơ bản của nông nghiệp hữu cơ không?",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
              maxLines: 3,
            ),
          ),
        ]),
      ],
    ),);
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(2),

      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBox(
                      "Xuất sắc",
                      0, listSelected2, isFirst: true),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBox(
                      "Trung bình",
                      1, listSelected2, isFirst: true),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBoxTextField(
                      "Cần cải tiến về lĩnh vực",
                      2, listSelected2,TextEditingController(), isFirst: true),
                ],
              ),
            ]
        ),
      ],
    ),);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: AppColor.black22),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*1.0),
          child: Column(
              children: listTable1
          ),
        ),
      ),
    );
  }
  Widget tableDetail3(){
    List<Table> listTable1 =[];
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(2),

      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.2),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBoxTextField(
                      "Hạt giống/cây giống sản phẩm lấy ở đâu?",
                      0, listSelected3, TextEditingController(),isFirst: true),
                ],
              ),
            ]
        ),
        TableRow(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.2),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBoxTextField(
                      "Xử lý trước khi trồng thế nào?",
                      1, listSelected3, TextEditingController(),isFirst: true),
                ],
              ),
            ]
        ),
        TableRow(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.2),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBoxTextField(
                      "Tên giống sử dụng",
                      2, listSelected3, TextEditingController(),isFirst: true),
                ],
              ),
            ]
        ),
      ],
    ),);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: AppColor.black22),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.95),
          child: Column(
              children: listTable1
          ),
        ),
      ),
    );
  }
  Widget tableDetail4(){
    List<Table> listTable1 =[];
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(0.7),
        2: FlexColumnWidth(2),
      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16, top: 16),
                      child: Text(
                        "Người nông dân có lưu trữ/ để dành phân bón trong nhà không?",
                        textAlign: TextAlign.center,
                        style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                        maxLines: 6,
                      ),
                    ),
                  ]),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBox(
                      "Có",
                      0, listSelected4, isFirst: true),
                  tableRowCheckBox(
                      "Không",
                      1, listSelected4),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.3),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBoxTextField(
                      "Có, ở khu vực nào?",
                      2, listSelected4, TextEditingController(), isFirst: true),
                  tableRowCheckBoxTextField(
                      "Loại phân, số lượng:",
                      3, listSelected4, TextEditingController()),
                ],
              ),
            ]
        ),
      ],
    ),);
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(0.7),
        2: FlexColumnWidth(2),
      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16, top: 16),
                      child: Text(
                        "Người nông dân có lưu trữ/ để dành thuốc trừ sâu/trừ cỏ trong nhà không?",
                        textAlign: TextAlign.center,
                        style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                        maxLines: 6,
                      ),
                    ),
                  ]),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBox(
                      "Có",
                      4, listSelected4, isFirst: true),
                  tableRowCheckBox(
                      "Không",
                      5, listSelected4),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.3),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBoxTextField(
                      "Có, ở khu vực nào?",
                      6, listSelected4, TextEditingController(), isFirst: true),
                  tableRowCheckBoxTextField(
                      "Loại thuốc, số lượng?",
                      7, listSelected4, TextEditingController()),
                ],
              ),
            ]
        ),
      ],
    ),);
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(0.7),
        2: FlexColumnWidth(2),
      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16, top: 16),
                      child: Text(
                        "Có bình phun thuốc trừ sâu ở nhà không? ",
                        textAlign: TextAlign.center,
                        style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                        maxLines: 6,
                      ),
                    ),
                  ]),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBox(
                      "Có",
                      8, listSelected4, isFirst: true),
                  tableRowCheckBox(
                      "Không",
                      9, listSelected4),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.3),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBoxTextField(
                      "Có, ở khu vực nào?",
                      10, listSelected4, TextEditingController(), isFirst: true),
                ],
              ),
            ]
        ),
      ],
    ),);


    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: AppColor.black22),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*1.1),
          child: Column(
              children: listTable1
          ),
        ),
      ),
    );
  }
  Widget tableDetail5(){
    List<Table> listTable1 =[];
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(3),
      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16, top: 16),
                      child: Text(
                        "Thu hoạch",
                        textAlign: TextAlign.center,
                        style: StyleOfit.textStyleFW700(AppColor.black22, 14),
                        maxLines: 6,
                      ),
                    ),
                  ]),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBox(
                      "Thủ công",
                      0, listSelected5, isFirst: true),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.3),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBoxTextField(
                      "Bằng máy",
                      1, listSelected5, TextEditingController(), isFirst: true),
                ],
              ),
            ]
        ),
      ],
    ),);
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(4),
      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                children: [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16, top: 16),
                      child: Text(
                        "Vận chuyển sau thu hoạch",
                        textAlign: TextAlign.center,
                        style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                        maxLines: 6,
                      ),
                    ),
                  ]),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                children: [
                  TableRow(children: [
                    Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1.5),
                        2: FlexColumnWidth(1.5),
                      },
                      border: TableBorder.all(color: AppColor.black22),
                      children: [
                        TableRow(children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 16, top: 16),
                            child: Text(
                              "Từ nương/ ruộng về nhà máy",
                              textAlign: TextAlign.center,
                              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                              maxLines: 6,
                            ),
                          ),
                          Table(
                            defaultVerticalAlignment: TableCellVerticalAlignment.top,
                            columnWidths: const {
                              0: FlexColumnWidth(0.7),
                              1: FlexColumnWidth(2),
                            },
                            children: [
                              tableRowCheckBox(
                                  "Bao, gói?",
                                  2, listSelected5, isFirst: true),
                              tableRowCheckBoxTextField(
                                  "Cách khác?",
                                  3, listSelected5, TextEditingController()),
                            ],
                          ),
                          Table(
                            defaultVerticalAlignment: TableCellVerticalAlignment.top,
                            columnWidths: const {
                              0: FlexColumnWidth(0.4),
                              1: FlexColumnWidth(2),
                            },
                            children: [
                              tableRowCheckBox(
                                  "Bao, gói của nông dân",
                                  4, listSelected5, isFirst: true),
                              tableRowCheckBox(
                                "Bao gói do nhà máy cung",
                                5, listSelected5,),
                            ],
                          ),
                        ]),
                      ],
                    ),
                  ]),
                  TableRow(children: [
                    Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1.5),
                        2: FlexColumnWidth(1.5),
                      },
                      border: TableBorder.all(color: AppColor.black22),
                      children: [
                        TableRow(children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 16, top: 16),
                            child: Text(
                              "Từ nhà đến nha máy",
                              textAlign: TextAlign.center,
                              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                              maxLines: 6,
                            ),
                          ),
                          Table(
                            defaultVerticalAlignment: TableCellVerticalAlignment.top,
                            columnWidths: const {
                              0: FlexColumnWidth(0.7),
                              1: FlexColumnWidth(2),
                            },
                            children: [
                              tableRowCheckBox(
                                  "Bao, gói?",
                                  6, listSelected5, isFirst: true),
                              tableRowCheckBoxTextField(
                                  "Cách khác?",
                                  7, listSelected5, TextEditingController()),
                            ],
                          ),
                          Table(
                            defaultVerticalAlignment: TableCellVerticalAlignment.top,
                            columnWidths: const {
                              0: FlexColumnWidth(0.4),
                              1: FlexColumnWidth(2),
                            },
                            children: [
                              tableRowCheckBox(
                                  "Bao, gói của nông dân",
                                  8, listSelected5, isFirst: true),
                              tableRowCheckBox(
                                "Bao gói do nhà máy cung",
                                9, listSelected5,),
                            ],
                          ),
                        ]),
                      ],
                    ),
                  ]),
                ],
              ),
            ]
        ),
      ],
    ),);
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(2),
      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16, top: 16),
                      child: Text(
                        "Có sử dụng bao đựng phân bón cũ để vận chuyển sản phẩm không?",
                        textAlign: TextAlign.center,
                        style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                        maxLines: 6,
                      ),
                    ),
                  ]),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBox(
                      "Có",
                      8, listSelected4, isFirst: true),
                  tableRowCheckBox(
                      "Không",
                      9, listSelected4),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.3),
                  1: FlexColumnWidth(2),
                },
                children: [
                ],
              ),
            ]
        ),
      ],
    ),);


    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: AppColor.black22),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*1.2),
          child: Column(
              children: listTable1
          ),
        ),
      ),
    );
  }
  Widget tableDetail6(){
    List<Table> listTable1 =[];
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(2),

      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16, top: 16),
                      child: Text(
                        "Người nông dân có cả nương sản phẩm hữu cơ và nương sản phẩm chuyển đổi không?",
                        textAlign: TextAlign.center,
                        style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                        maxLines: 8,
                      ),
                    ),
                  ]),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBox(
                      "Có",
                      0, listSelected6, isFirst: true),
                  tableRowCheckBox(
                      "Không",
                      1, listSelected6),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.3),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBox(
                      "Ghi chép hoàn chỉnh và cập nhật",
                      2, listSelected6, isFirst: true),
                  tableRowCheckBoxTextField(
                      "Cần cải tiến hơn nữa",
                      3, listSelected6, TextEditingController()),
                ],
              ),
            ]
        ),
      ],
    ),);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: AppColor.black22),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*1.1),
          child: Column(
              children: listTable1
          ),
        ),
      ),
    );
  }
  Widget tableDetail7(){
    List<Table> listTable1 =[];
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
        4: FlexColumnWidth(3),

      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Tên nương/ ruộng",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "ở đội nào? Gần nhà ai",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Đánh giá rủi ro (cao, trung bình, thấp)",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Diện tích canh tác (m2)",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            columnWidths: {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
            },
            border: TableBorder.all(color: AppColor.black22),
            children: [
              TableRow(children: [
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.top,
                  border: TableBorder.all(color: AppColor.black22),
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 16, top: 16),
                        child: Text(
                          "Ước tính sản lượng sản phẩm (kg) 1 năm Annual yeild estimation",
                          textAlign: TextAlign.center,
                          style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                          maxLines: 5,
                        ),
                      ),
                    ]),
                  ],
                ),
              ]),
              TableRow(children: [
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.top,
                  border: TableBorder.all(color: AppColor.black22),
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 16, top: 16),
                        child: Text(
                          "Số công hái sản phẩm",
                          textAlign: TextAlign.center,
                          style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                          maxLines: 5,
                        ),
                      ),      Padding(
                        padding: EdgeInsets.only(bottom: 16, top: 16),
                        child: Text(
                          "Lượng sản phẩm",
                          textAlign: TextAlign.center,
                          style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                          maxLines: 5,
                        ),
                      ),
                    ]),
                  ],
                ),
              ]),
            ],
          )
        ]),
      ],
    ),);
    for(int i =0 ; i< 2; i++){
      listTable1.add(Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        columnWidths: {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
          3: FlexColumnWidth(1),
          4: FlexColumnWidth(3),

        },
        border: TableBorder.all(color: AppColor.black22),
        children: [
          TableRow(children: [
            Padding(
                padding: EdgeInsets.zero,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none, // No border or underline
                    contentPadding: EdgeInsets.only(left: 4, right: 4),
                  ),
                )
            ),
            Padding(
                padding: EdgeInsets.zero,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none, // No border or underline
                    contentPadding: EdgeInsets.only(left: 4, right: 4),
                  ),
                )
            ),
            Padding(
                padding: EdgeInsets.zero,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none, // No border or underline
                    contentPadding: EdgeInsets.only(left: 4, right: 4),
                  ),
                )
            ),
            Padding(
                padding: EdgeInsets.zero,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none, // No border or underline
                    contentPadding: EdgeInsets.only(left: 4, right: 4),
                  ),
                )
            ),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.top,
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
              },
              border: TableBorder.all(color: AppColor.black22),
              children: [
                TableRow(children: [
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    border: TableBorder.all(color: AppColor.black22),
                    children: [
                      TableRow(children: [
                        Padding(
                            padding: EdgeInsets.zero,
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none, // No border or underline
                                contentPadding: EdgeInsets.only(left: 4, right: 4),
                              ),
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.zero,
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none, // No border or underline
                                contentPadding: EdgeInsets.only(left: 4, right: 4),
                              ),
                            )
                        ),
                      ]),
                    ],
                  ),
                ]),
              ],
            )
          ]),
        ],
      ),);
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: AppColor.black22),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*1.3),
          child: Column(
              children: listTable1
          ),
        ),
      ),
    );
  }
  Widget tableDetail8(){
    List<Table> listTable1 =[];
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(0.7),
        2: FlexColumnWidth(2),

      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16, top: 16),
                      child: Text(
                        "Có dấu hiệu sử dụng phân ủ cho sản phẩm không?",
                        textAlign: TextAlign.center,
                        style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                        maxLines: 8,
                      ),
                    ),
                  ]),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBox(
                      "Có",
                      0, listSelected8, isFirst: true),
                  tableRowCheckBox(
                      "Không",
                      1, listSelected8),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.3),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBoxTextField(
                      "Có, trên nương/ ruộng số",
                      2, listSelected8, TextEditingController(), isFirst: true),
                  tableRowCheckBoxTextField(
                      "Giải thích loại gì?",
                      3, listSelected8, TextEditingController()),
                ],
              ),
            ]
        ),
      ],
    ),);
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(0.7),
        2: FlexColumnWidth(2),

      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16, top: 16),
                      child: Text(
                        "Rủi ro xói mòn đất?",
                        textAlign: TextAlign.center,
                        style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                        maxLines: 8,
                      ),
                    ),
                  ]),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBox(
                      "Có",
                      4, listSelected8, isFirst: true),
                  tableRowCheckBox(
                      "Không",
                      5, listSelected8),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.3),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBoxTextField(
                      "Có, trên nương/ ruộng số",
                      6, listSelected8, TextEditingController(), isFirst: true),
                ],
              ),
            ]
        ),
      ],
    ),);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: AppColor.black22),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*1.1),
          child: Column(
              children: listTable1
          ),
        ),
      ),
    );
  }
  Widget tableDetail9(){
    List<Table> listTable1 =[];
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(0.7),
        2: FlexColumnWidth(2),

      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16, top: 16),
                      child: Text(
                        "Vườn cây canh tác cạnh vườn cây trồng khác?",
                        textAlign: TextAlign.center,
                        style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                        maxLines: 8,
                      ),
                    ),
                  ]),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBox(
                      "Có",
                      0, listSelected9, isFirst: true),
                  tableRowCheckBox(
                      "Không",
                      1, listSelected9),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.3),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBoxTextField(
                      "Có ở nương sản phẩm nào?",
                      2, listSelected9, TextEditingController(), isFirst: true),
                  tableRowCheckBoxTextField(
                      "Mô tả cụ thể, gần nhà ai?",
                      3, listSelected9, TextEditingController()),
                ],
              ),
            ]
        ),
      ],
    ),);
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(0.7),
        2: FlexColumnWidth(2),

      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16, top: 16),
                      child: Text(
                        "Vưởn cây nằm bên dưới, bên cạnh câu trồng khác có sử dụng phân bón thuốc trừ sâu không?",
                        textAlign: TextAlign.center,
                        style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                        maxLines: 8,
                      ),
                    ),
                  ]),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBox(
                      "Có",
                      4, listSelected9, isFirst: true),
                  tableRowCheckBox(
                      "Không",
                      5, listSelected9),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.3),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBoxTextField(
                      "Có ở nương sản phẩm nào?",
                      6, listSelected9, TextEditingController(), isFirst: true),
                  tableRowCheckBoxTextField(
                      "Mô tả cụ thể, gần nhà ai?",
                      7, listSelected9, TextEditingController()),
                ],
              ),
            ]
        ),
      ],
    ),);
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(0.7),
        2: FlexColumnWidth(2),

      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16, top: 16),
                      child: Text(
                        "Có vườn cây nào bên cạnh được trồng mới không?",
                        textAlign: TextAlign.center,
                        style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                        maxLines: 8,
                      ),
                    ),
                  ]),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBox(
                      "Có",
                      8, listSelected9, isFirst: true),
                  tableRowCheckBox(
                      "Không",
                      9, listSelected9),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.3),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBoxTextField(
                      "Có ở nương sản phẩm nào?",
                      10, listSelected9, TextEditingController(), isFirst: true),
                  tableRowCheckBoxTextField(
                      "Mô tả cụ thể, gần nhà ai?",
                      11, listSelected9, TextEditingController()),
                ],
              ),
            ]
        ),
      ],
    ),);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: AppColor.black22),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*1.1),
          child: Column(
              children: listTable1
          ),
        ),
      ),
    );
  }
  Widget tableDetail10(){
    List<Table> listTable1 =[];
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(0.7),
        2: FlexColumnWidth(2),

      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16, top: 16),
                      child: Text(
                        "Có dấu hiệu dùng bón phân hóa học cho cây trồng không?",
                        textAlign: TextAlign.center,
                        style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                        maxLines: 8,
                      ),
                    ),
                  ]),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBox(
                      "Có",
                      0, listSelected10, isFirst: true),
                  tableRowCheckBox(
                      "Không",
                      1, listSelected10),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.3),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBoxTextField(
                      "Có, trên nương/ ruộng số",
                      2, listSelected10, TextEditingController(), isFirst: true),
                  tableRowCheckBoxTextField(
                      "Giải thích loại gì?",
                      3, listSelected10, TextEditingController()),
                ],
              ),
            ]
        ),
      ],
    ),);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: AppColor.black22),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*1.1),
          child: Column(
              children: listTable1
          ),
        ),
      ),
    );
  }
  Widget tableDetail11(){
    List<Table> listTable1 =[];
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(0.7),
        2: FlexColumnWidth(2),

      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16, top: 16),
                      child: Text(
                        "Có dấu hiệu sâu hại trên nương sản phẩm không?",
                        textAlign: TextAlign.center,
                        style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                        maxLines: 8,
                      ),
                    ),
                  ]),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBox(
                      "Có",
                      0, listSelected11, isFirst: true),
                  tableRowCheckBox(
                      "Không",
                      1, listSelected11),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.3),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBoxTextField(
                      "Có, trên nương/ ruộng số",
                      2, listSelected11, TextEditingController(), isFirst: true),
                  tableRowCheckBoxTextField(
                      "Giải thích loại gì?",
                      3, listSelected11, TextEditingController()),
                ],
              ),
            ]
        ),
      ],
    ),);
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(0.7),
        2: FlexColumnWidth(2),

      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16, top: 16),
                      child: Text(
                        "Có dấu hiệu sử dụng thuốc trừ sâu không?",
                        textAlign: TextAlign.center,
                        style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                        maxLines: 8,
                      ),
                    ),
                  ]),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBox(
                      "Có",
                      4, listSelected11, isFirst: true),
                  tableRowCheckBox(
                      "Không",
                      5, listSelected11),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.3),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBoxTextField(
                      "Có, trên nương/ ruộng số",
                      6, listSelected11, TextEditingController(), isFirst: true),
                  tableRowCheckBoxTextField(
                      "Giải thích loại gì?",
                      7, listSelected11, TextEditingController()),
                ],
              ),
            ]
        ),
      ],
    ),);
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(0.7),
        2: FlexColumnWidth(2),

      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16, top: 16),
                      child: Text(
                        "Có dấu hiệu sử dụng thuốc trừ cỏ không?",
                        textAlign: TextAlign.center,
                        style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                        maxLines: 8,
                      ),
                    ),
                  ]),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBox(
                      "Có",
                      8, listSelected11, isFirst: true),
                  tableRowCheckBox(
                      "Không",
                      9, listSelected11),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(0.3),
                  1: FlexColumnWidth(2),
                },
                children: [
                  tableRowCheckBoxTextField(
                      "Có, trên nương/ ruộng số",
                      10, listSelected11, TextEditingController(), isFirst: true),
                  tableRowCheckBoxTextField(
                      "Giải thích loại gì?",
                      11, listSelected11, TextEditingController()),
                ],
              ),
            ]
        ),
      ],
    ),);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: AppColor.black22),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*1.1),
          child: Column(
              children: listTable1
          ),
        ),
      ),
    );
  }
  Widget tableDetail12(){
    List<Table> listTable1 =[];
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(children: [
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            columnWidths: const {
              0: FlexColumnWidth(0.2),
              1: FlexColumnWidth(2),
            },
            children: [
              tableRowCheckBoxTextField("Các giấy tờ thành viên?", 0,
                  listSelected12, TextEditingController(),
                  isFirst: true),
            ],
          ),
        ]),
        TableRow(children: [
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            columnWidths: const {
              0: FlexColumnWidth(0.2),
              1: FlexColumnWidth(2),
            },
            children: [
              tableRowCheckBoxTextField("Kiến thức về tiêu chuẩn hữu cơ:", 1,
                  listSelected12, TextEditingController(),
                  isFirst: true),
            ],
          ),
        ]),
        TableRow(children: [
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            columnWidths: const {
              0: FlexColumnWidth(0.2),
              1: FlexColumnWidth(2),
            },
            children: [
              tableRowCheckBoxTextField("Lưu giữ hóa chất trong nhà?", 2,
                  listSelected12, TextEditingController(),
                  isFirst: true),
            ],
          ),
        ]),
        TableRow(children: [
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            columnWidths: const {
              0: FlexColumnWidth(0.2),
              1: FlexColumnWidth(2),
            },
            children: [
              tableRowCheckBoxTextField("Bảo quản ở nhà nông dân?", 3,
                  listSelected12, TextEditingController(),
                  isFirst: true),
            ],
          ),
        ]),
        TableRow(children: [
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            columnWidths: const {
              0: FlexColumnWidth(0.2),
              1: FlexColumnWidth(2),
            },
            children: [
              tableRowCheckBoxTextField("Khác", 4,
                  listSelected12, TextEditingController(),
                  isFirst: true),
            ],
          ),
        ]),
      ],
    ),);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: AppColor.black22),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*1.1),
          child: Column(
              children: listTable1
          ),
        ),
      ),
    );
  }
  Widget tableDetail13(){
    List<Table> listTable1 =[];
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(3),
      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Điều kiện",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW700(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Hạn cuối cùng",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW700(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Tình hình thực hiện",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW700(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
        ]),
      ],
    ),);
    for(int i =0 ; i< 2; i++){
      listTable1.add(Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        columnWidths: {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(3),
        },
        border: TableBorder.all(color: AppColor.black22),
        children: [
          TableRow(children: [
            Padding(
                padding: EdgeInsets.zero,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none, // No border or underline
                    contentPadding: EdgeInsets.only(left: 4, right: 4),
                  ),
                )
            ),
            Padding(
                padding: EdgeInsets.zero,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none, // No border or underline
                    contentPadding: EdgeInsets.only(left: 4, right: 4),
                  ),
                )
            ),
            Padding(
                padding: EdgeInsets.zero,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none, // No border or underline
                    contentPadding: EdgeInsets.only(left: 4, right: 4),
                  ),
                )
            ),
          ]),
        ],
      ),);
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: AppColor.black22),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*1.2),
          child: Column(
              children: listTable1
          ),
        ),
      ),
    );
  }
  Widget tableDetail14(){
    List<Row> rows = [];
    for (int i = 0 ; i< 3; i++){
      rows.add(Row(
        children: [
          Flexible(child: Padding(
            padding: EdgeInsets.only(bottom: 8, top: 12),
            child: Text(
              "${i+1}. ",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW700(AppColor.black22, 14),
            ),
          ),),
          Flexible(
            flex: 20,
            child: TextField(
              //maxLines: 5,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.only(top: 0),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColor.back09),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:  AppColor.back09),
                  ),
                  /* border: UnderlineInputBorder(
                    borderSide: BorderSide(color:  AppColor.back09),
                  ),*/
                )
            ),
          ),
        ],
      ));
    }
    return Container(
      padding: EdgeInsets.only(left: 4, right: 4, top: 0, bottom: 16),
      child: Column(
        children: rows,
      ),
    );
  }
  Widget tableDetail15(){
    List<Table> listTable1 =[];
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Thanh tra kiểm soát  nội bộ",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Người nông dân",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
        ]),
      ],
    ),);
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(children: [
          Padding(
              padding: EdgeInsets.zero,
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none, // No border or underline
                  contentPadding: EdgeInsets.only(left: 4, right: 4),
                ),
              )
          ),
          Padding(
              padding: EdgeInsets.zero,
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none, // No border or underline
                  contentPadding: EdgeInsets.only(left: 4, right: 4),
                ),
              )
          ),
        ]),
      ],
    ),);

    return Container(
      decoration: BoxDecoration(
        //border: Border.all(width: 2,color: AppColor.black22),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.95),
          child: Column(
              children: listTable1
          ),
        ),
      ),
    );
  }
  Widget tableDetail16(){
    List<Table> listTable1 =[];
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(0.5),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Mức độ rủi ro",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW700(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Tình trạng",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW700(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Situation",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW700(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
        ]),
      ],
    ),);
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(0.5),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Cao",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW700(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Nương sản phẩm trồng gần và bên dưới ruộng lúa, ruộng ngô có sử dụng phân bón thuốc sâu thường xuyên",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Organic field near/under  rice/corn which use chemical frequently",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
        ]),
      ],
    ),);
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(0.5),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Trung bình",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW700(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Nương sản phẩm gần hoặc bên cạnh, bên trên ruộng lúa, ngô có sử dụng phân bón, thuốc sâu không thường xuyên hoặc rất ít sử dụng",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Medium: organic field near/beside rice/corn which use chemical unfrequently or rarelly",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
        ]),
      ],
    ),);
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(0.5),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
      },
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Thấp",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW700(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Nương sản phẩm nằm tách biệt hoàn toàn với các khu vực trồng lúa, ngô",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Organic field which is separated from convetional rice/corn",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
              maxLines: 5,
            ),
          ),
        ]),
      ],
    ),);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: AppColor.black22),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*1.1),
          child: Column(
              children: listTable1
          ),
        ),
      ),
    );
  }
  Widget tableDetailEnd(){
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            color: AppColor.back09,
            height: 1.0,
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: "Báo cáo thanh tra nội bộ nông hộ- thực địa và tại nhà.\t\t\t\t\t\t",
                style: StyleOfit.textStyleFW400(AppColor.black22, 12),
              ),
              TextSpan(
                text: "Hiệu chỉnh: 06/2020",
                style: StyleOfit.textStyleFW400(AppColor.black22, 12),
              ),
            ]),
            textScaleFactor: MediaQuery.of(context).textScaleFactor,
          )
        ],
      ),
    );
  }
}
