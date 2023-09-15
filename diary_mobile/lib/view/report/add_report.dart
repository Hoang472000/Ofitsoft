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
                      //Navigator.pop(context, [true]);
                    }, () {
                      Get.back();
                      //Navigator.pop(context, [true]);
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
                            itemCount: state.listReport[1].questionAndPageIds.length,
                            itemBuilder: (context, index) {
                              return  ExpansionTile(
                                title: widgetMuc("${state.listReport[1].questionAndPageIds[index].title}"),
                                children: [
                                  tableDetailResult(state.listReport[1].questionAndPageIds[index].questionAndPageIds,
                                      state.listSelected[index], state.listController[index], state.listController, blocContext,
                                  state.listTable),
                                ],
                              );
                            }),
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
  Widget checkBox(int id, List<Select> listSelected, BuildContext contextBloc, {bool isFirst = false}) {
    int index = listSelected.indexWhere((element) => element.id == id);
    //print("HoangCV: checkbox: id: $id : $index : ${listSelected[index].title} : ${listSelected.length}");
    return Container(
      margin: EdgeInsets.only(top:isFirst? 14: 0),
      height: 24.0,
      width: 24.0,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        side: BorderSide(color: AppColor.black22),
        value: listSelected[index].value,
        onChanged: (value) {
          print("HoangC:V listID: ${listSelected[index].title} : ${listSelected[index].listId.toString()}");
          if(value == false){
            for(int i = 0; i< listSelected[index].listSubId.length; i++){
              int id = listSelected.indexWhere((element) => element.id == listSelected[index].listSubId[i]);
              setState(() {
                listSelected[id].value = value ?? false;
              });
            }
          } else{
            for(int i = 0; i< listSelected[index].listId.length; i++){
              int id = listSelected.indexWhere((element) => element.id == listSelected[index].listId[i]);
              print("HoangCV: listsub1: ${listSelected[id].id} : ${listSelected[id].title} : ${listSelected[id].listId} : ${listSelected[id].listSubId}");
              for(int i = 0; i< listSelected[id].listSubId.length; i++){
                int idSub = listSelected.indexWhere((element) => element.id == listSelected[id].listSubId[i]);
                print("HoangCV: listsub1: ${idSub} : ${listSelected[idSub].title} : ${listSelected[id].listId} : ${listSelected[id].listSubId}");
                setState(() {
                  listSelected[idSub].value = false;
                });
              }
              setState(() {
                listSelected[id].value = !(value ?? false);
              });
            }
          }
          setState(() {
            listSelected[index].value = value ?? false;

          });
          contextBloc.read<AddReportBloc>().add(
              UpdateAddReportEvent(id, '', listSelected));
        },
      ),
    );
  }
  TableRow tableRowCheckBox(String title, int id, List<Select> listSelected, BuildContext context, {bool isFirst = false}) {
    return TableRow(children: [
      checkBox(id, listSelected, context, isFirst: isFirst),
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
  Widget tableRowTextHasSub(String title, List<Answer> list) {
    List<Widget> tableWidgetText = [];
    for (int i = 0; i < list.length; i++) {
      tableWidgetText.add(tableRowText(list[i].value ?? ''));
    }
    return Table(
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
                    title,
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
              TableRow(children: tableWidgetText),
            ],
          ),
        ]),
      ],
    );
  }
  Table tableNon(int id,  List<Controller> controller, BuildContext context) {
    int index = controller.indexWhere((element) => element.id == id);
    //HoangCV: note table chua co controller
    return  Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      border: TableBorder.all(color: AppColor.black22),
      children: [
        TableRow(
          children: [
            Padding(
                padding: EdgeInsets.zero,
                child: TextField(
                  controller: controller[index].controller,
                  keyboardType: controller[index].type == 'text' ? TextInputType.text : TextInputType.number,
                  onSubmitted: (str){
                    context.read<AddReportBloc>().add(
                        UpdateAddReportEvent(id, str, const []));
                  },
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none, // No border or underline
                    contentPadding: EdgeInsets.only(bottom: 4, top: 4,left: 4, right: 4),
                  ),
                  maxLines: 10,
                  minLines: 1,
                )
            ),
          ],
        ),
      ],
    );
  }
  Table tableNonHasSub(List<Answer> list, int count, List<Controller> controller, BuildContext context) {
    List<Widget> tabNonSub = [];
    for (int i = 0; i < list.length; i++) {
      //print("HoangCV: tableNonHasSub+j+1:  ${count+i+1} :: ${controller.last.id}");

      controller.add(Controller(count+i+1, TextEditingController(), ''));
      tabNonSub.add(tableNon(count+i+1, controller,context));
    }
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
      },
      border: /*TableBorder.lerp(color: AppColor.black22),*/const TableBorder(horizontalInside: BorderSide(color: AppColor.black22)),
      children: [
        TableRow(children: tabNonSub),
      ],
    );
  }

  TableRow tableRowCheckBoxTextField(String title, int id, List<Select> listSelected, List<Controller> controller, BuildContext context, {bool isFirst = false}) {
    int index = controller.indexWhere((element) => element.id == id);
    return TableRow(children: [
      checkBox(id, listSelected, context, isFirst: isFirst),
      Padding(
        padding: EdgeInsets.only(top: isFirst ? 16 : 4, bottom: 16.0),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: StyleOfit.textStyleFW400(AppColor.black22, 14),
              ),
               WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: TextField(
                    controller: controller[index].controller,
                      keyboardType: controller[index].type == 'text' ? TextInputType.text : TextInputType.number,
                      onSubmitted: (str){
                        context.read<AddReportBloc>().add(
                            UpdateAddReportEvent(id, str, listSelected));
                      },
                      decoration: const InputDecoration(
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
                      ),
                    maxLines: 10,
                    minLines: 1,
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
  TableRow tableRowTextField(String title,int id, List<Controller> controller, BuildContext context, {bool isFirst = false}) {
    int index = controller.indexWhere((element) => element.id == id);
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
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: TextField(
                    controller: controller[index].controller,
                    keyboardType: controller[index].type == 'text' ? TextInputType.text : TextInputType.number,
                    onSubmitted: (str){
                      context.read<AddReportBloc>().add(
                          UpdateAddReportEvent(id, str, []));
                    },
                      decoration: const InputDecoration(
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
                      ),
                    maxLines: 10,
                    minLines: 1,
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
/*    listTable1.add(Table(
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
    ),);*/
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

  Widget tableDetailResult(List<Question> list, List<Select> listSelect, List<Controller> listController, List<List<Controller>> listCount, BuildContext context, List<Question> listTable,){
    List<Table> listTable1 =[];
    int form = 0;
    for(int i = 0 ; i < list.length; i++) {
      List<Table> tableSub = [];
      List<TableRow> tableRow = [];
      List<TableRow> tableRowSub = [];
      List<Widget> tableWidgetText = [];
      List<Table> tableWidgetNon = [];
      List<TableRow> tableWidgetRowNon = [];
      form = checkForm(list[i]);

      //print("HoangCV: $i : ${list[i].title} :  ${list.length} : $form");
      //print("HoangCV:commentAnswer $i : ${list[i].title} :  ${listController.last.id}");
      if(list[i].questionType == "simple_choice" || list[i].questionType == "multiple_choice"){
        if(list[i].suggestedAnswerIds.length<=2 || list[i].suggestedAnswerIds.length>=4){
          for (int j = 0; j < list[i].suggestedAnswerIds.length; j ++) {
            if (list[i].suggestedAnswerIds[j].questionAndPageIds.isNotEmpty){
              if (list[i].suggestedAnswerIds[j]
                  .commentAnswer == true) {
                //print("HoangCV:commentAnswer1 $i : $j : ${list[i].title} :  ${listController.last.id}");
                tableRow.add(tableRowCheckBoxTextField(
                    "${list[i].suggestedAnswerIds[j].value}",
                    list[i].suggestedAnswerIds[j].idSelected ?? -1, listSelect, listController, context,
                    isFirst: i == 0 ? true : false));
              } else {
                //print("HoangCV: $i : $j : ${list[i].title} : ${list[i].suggestedAnswerIds[j].value} : ${list.length}");
                tableRow.add(tableRowCheckBox(
                    "${list[i].suggestedAnswerIds[j].value}",
                    list[i].suggestedAnswerIds[j].idSelected ?? -1, listSelect, context, isFirst: i == 0 ? true : false));
              }
            for (int k = 0; k <
                list[i].suggestedAnswerIds[j].questionAndPageIds.length; k ++) {
              if (list[i].suggestedAnswerIds[j].questionAndPageIds[k].questionType == "numerical_box" ||
                  list[i].suggestedAnswerIds[j].questionAndPageIds[k].questionType == "char_box" ||
                  (list[i].suggestedAnswerIds[j].questionAndPageIds[k].questionType == "check_box" &&
                      list[i].suggestedAnswerIds[j].questionAndPageIds[k].commentAnswer == true)
              ) {
                tableRowSub.add(tableRowCheckBoxTextField(
                    "${list[i].suggestedAnswerIds[j].questionAndPageIds[k].title}",
                    list[i].suggestedAnswerIds[j].questionAndPageIds[k].idSelected ?? -1, listSelect, listController, context,
                    isFirst: i == 0 ? true : false));
              } else {
                tableRowSub.add(tableRowCheckBox(
                    "${list[i].suggestedAnswerIds[j].questionAndPageIds[k]
                        .title}",
                    list[i].suggestedAnswerIds[j].questionAndPageIds[k].idSelected ?? -1, listSelect, context,
                    isFirst: i == 0 ? true : false));
              }
            }
          } else{
              bool hasNonEmptyValues = list[i].suggestedAnswerIds.any((element) {
                return element.questionAndPageIds.isNotEmpty;
              });
              if(hasNonEmptyValues){
                //print("HoangCV:hasNonEmptyValues $i : $j : ${list[i].title} : ${list[i].suggestedAnswerIds[j].value} : ${list[i].suggestedAnswerIds[j].idSelected}");

                tableRow.add(tableRowCheckBox(
                    "${list[i].suggestedAnswerIds[j].value}",
                    list[i].suggestedAnswerIds[j].idSelected ?? -1, listSelect, context, isFirst: i == 0 ? true : false));
              }else {
                bool hasCommentAnswer = list[i].suggestedAnswerIds.any((element) {
                  return element.commentAnswer == true;
                });
                if(hasCommentAnswer) {
                  form = 2;
                  //print("HoangCV:hasCommentAnswer $i : $j : ${list[i].title} : ${list[i].suggestedAnswerIds[j].value} : ${list.length}");

                  if (list[i].suggestedAnswerIds[j].commentAnswer == true) {
                    tableSub.add(tableForm2TextField(
                        list[i].suggestedAnswerIds[j].value ?? '', list[i].suggestedAnswerIds[j].idSelected ?? -1,
                        listSelect, listController, context));
                  } else {
                    tableSub.add(tableForm2(
                        list[i].suggestedAnswerIds[j].value ?? '', list[i].suggestedAnswerIds[j].idSelected ?? -1,
                        listSelect, context, isFirst: i == 0 ? true : false));
                  }
                }else{
                  print("HoangCV:false $i : $j : ${list[i].title} : ${list[i].suggestedAnswerIds[j].value} : ${list.length}");

                  form = 3;
                  tableRow.add(
                  tableRowCheckBox(
                      list[i].suggestedAnswerIds[j].value ?? '', list[i].suggestedAnswerIds[j].idSelected ?? -1,
                      listSelect, context,));
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
                  list[i].suggestedAnswerIds[j].value ?? '', list[i].suggestedAnswerIds[j].idSelected ?? -1,
                  listSelect, listController, context));
            } else {
              tableSub.add(tableForm2(
                  list[i].suggestedAnswerIds[j].value ?? '', list[i].suggestedAnswerIds[j].idSelected ?? -1,
                  listSelect, context));
            }
          }
        }
      }
      else if(list[i].questionType == "table"){
        //int lengthController=  listController.length;
        int totalCount = listCount.fold(0, (count, innerList) => count + innerList.length);
        for (int j = 0; j < list[i].suggestedAnswerIds.length; j++) {
          //print("HoangCV: lengthController+j+1:  ${totalCount+j+1} : ${listSelect.last.id} : ${listController.last.id}");
          listController.add(Controller(totalCount+j+1, TextEditingController(), 'text'));
          if (list[i].suggestedAnswerIds[j].suggestedAnswerIds.isNotEmpty) {
            tableWidgetText.add(tableRowTextHasSub(
                list[i].suggestedAnswerIds[j].value ?? '',
                list[i].suggestedAnswerIds[j].suggestedAnswerIds));
       /*     tableWidgetNon.add(tableNonHasSub(
                list[i].suggestedAnswerIds[j].suggestedAnswerIds,totalCount+j+1, listController, context));*/
          } else {
            tableWidgetText
                .add(tableRowText(list[i].suggestedAnswerIds[j].value ?? ''));
            //tableWidgetNon.add(tableNon(totalCount+j+1, listController, context));
          }
        }
        for(int j = 0 ; j< listTable.length; j++){
          for(int k = 0 ; k < listTable[j].suggestedAnswerIds.length; k++){
            if (listTable[j].suggestedAnswerIds[k].suggestedAnswerIds.isNotEmpty) {
              tableWidgetNon.add(tableNonHasSub(
                  listTable[j].suggestedAnswerIds[k].suggestedAnswerIds,listTable[j].suggestedAnswerIds[k].idSelected!, listController, context));
            } else {
              tableWidgetNon.add(tableNon(listTable[j].suggestedAnswerIds[k].idSelected!, listController, context));
            }
          }
          tableWidgetRowNon.add(TableRow(children: tableWidgetNon ));
        }
      }
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
              tableSub.add(formCharTextField(list[i].title??'', list[i].idSelected ?? -1, listController, context));
            }else{
              tableSub.add(tableForm2TextField(list[i].title ?? '', list[i].idSelected ?? -1, listSelect, listController, context));
            }
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
                  children: [list[i].questionType == "char_box" ? formCharTextField(list[i].title??'', list[i].idSelected ?? -1, listController, context):
                  tableForm2TextField(list[i].title ?? '', list[i].idSelected ?? -1, listSelect, listController, context)]),
            ],
          ),);
        }
      else if(form == 1){
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
          },
          border: TableBorder.all(color: AppColor.black22),
          children: [
            TableRow(children: tableWidgetText),
          ],
        ),);
        for(int i = 0; i< tableWidgetRowNon.length; i++) {
          listTable1.add(Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.top,
              columnWidths: {
              },
              border: TableBorder.all(color: AppColor.black22),
              children: [tableWidgetRowNon[i]]
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
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*1.3),
          child: Column(
              children: listTable1
          ),
        ),
      ),
    );
  }

  Table tableForm2TextField(String title, int id, List<Select> listSelected, List<Controller> listController, BuildContext context, {bool isFirst = false}){
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: const {
        0: FlexColumnWidth(0.3),
        1: FlexColumnWidth(2),
      },
      children: [
        tableRowCheckBoxTextField(
            title,
            id, listSelected, listController, context, isFirst: true),
      ],
    );
  }
  Table formCharTextField(String title,int id, List<Controller> listController, BuildContext context, {bool isFirst = false}){
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: const {
        0: FlexColumnWidth(0.3),
        1: FlexColumnWidth(2),
      },
      children: [
        tableRowTextField(
            title, id, listController, context, isFirst: true),
      ],
    );
  }
  Table tableForm2(String title, int id, List<Select> listSelected, BuildContext context, {bool isFirst = false}){
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: const {
        0: FlexColumnWidth(0.7),
        1: FlexColumnWidth(2),
      },
      children: [
        tableRowCheckBox(
            title,
            id, listSelected, context, isFirst: isFirst),
      ],
    );

  }
  int checkForm(Question qs){
    int count = 0;
    //print("HoangCV: questiontype: ${qs.title} : ${qs.questionType}");
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
