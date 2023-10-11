import 'dart:convert';
import 'package:diary_mobile/data/entity/report/question_upload.dart';
import 'package:diary_mobile/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../generated/l10n.dart';
import '../../../resource/color.dart';
import '../../../resource/style.dart';
import '../../data/entity/report/answer.dart';
import '../../data/entity/report/question.dart';
import '../../data/entity/report/report.dart';
import '../../utils/extenstion/input_register_model.dart';
import '../../utils/status/form_submission_status.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/bkav_app_bar.dart';
import '../../utils/widgets/button_widget.dart';
import '../../utils/widgets/dialog/dialog_manager.dart';
import '../../utils/widgets/input/container_input_widget.dart';
import '../../view_model/report/edit_report_bloc.dart';

class EditReportViewPage extends StatefulWidget {
  EditReportViewPage({super.key, required this.diary, required this.id});
  final Diary diary;
  final int id;
  @override
  _EditReportViewPageState createState() => _EditReportViewPageState();

  static Route route(Diary diary, int id) {
    return Utils.pageRouteBuilder(
        EditReportViewPage(diary: diary, id: id,
        ),
        true);
  }
}

class _EditReportViewPageState extends State<EditReportViewPage> {
  bool edit = false;
  bool checkUpdate = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditReportBloc(context.read<Repository>())
        ..add(GetEditReportEvent(widget.diary, widget.id)),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.background,
        appBar: OfitAppBar(
          context,
          centerTitle: true,
          showDefaultBackButton: true,
          callback: [checkUpdate],
          title: Text(
            "Sửa báo cáo đánh giá",
            style: StyleOfit.textStyleFW700(Colors.white, 20),
          ),
          backgroundColor: AppColor.main,
          actions: [],
        ),
        body: SafeArea(
          child: BlocConsumer<EditReportBloc, EditReportState>(
              listener: (blocContext, state) async {
                final formStatus = state.formStatus;
                if (formStatus is SubmissionFailed) {
                  DiaLogManager.displayDialog(context, "", formStatus.exception, () {
                    Get.back();
                  }, () {
                    Get.back();
                  }, '', S.of(context).close_dialog);
                } else if (formStatus is SubmissionSuccess) {
                  if(!checkUpdate){
                    setState(() {
                      checkUpdate = true;
                    });
                  }
                  if ((formStatus.success ?? "").isNotEmpty) {
                    DiaLogManager.displayDialog(context, "", formStatus.success ?? "",
                            () {
                          Get.back();
                          //check bug
                          //Navigator.of(context).pop([checkUpdate]);
                        }, () {
                          Get.back();
                        }, '', S.of(context).close_dialog, dismissible: false);
                  }
                } else if (formStatus is FormSubmitting) {
                  DiaLogManager.showDialogLoading(context);
                }
              },
              builder: (blocContext, state) {
            return WillPopScope(
                onWillPop: () async{
                  Navigator.pop(context);
                  return false;
                },
                child: state.listReport.isEmpty
                    ? Container()
                    : ListView.builder(
                  controller: state.scrollController,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  //physics: NeverScrollableScrollPhysics(),
                  itemCount: state.listReport[0].questionAndPageIds.length + 2,
                  itemBuilder: (context, index) {
                    return AutoScrollTag(
                      controller: state.scrollController!,
                      index: index,
                      key: ValueKey(index),
                      child: index == 0 ? detailHeader("${state.listReport[0].title}",
                          state.listSelectedInspector, state.listWidget, state.nameInspector ?? '', blocContext) :
                      index == state.listReport[0].questionAndPageIds.length + 1 ? detailEnd(blocContext) :
                      state.listReport[0].questionAndPageIds[index -1].isPage == true ?
                      ExpansionTile(
                        title: widgetMuc("${state.listReport[0].questionAndPageIds[index -1].title}"),
                        children: [
                          tableDetailResult(
                              state.listReport[0].questionAndPageIds[index -1].questionAndPageIds,
                              state.listReport[0].questionAndPageIds[index -1].questionParentTitleId,
                              state.listSelected[index-1],
                              state.listController[index-1],
                              state.listControllerTable,
                              blocContext,
                              state.listTable,
                              state.farmerInspector ?? FarmerInspectorUpload(),
                              state.listInputModel[index -1]
                          ),
                        ],
                      ) :
                      tableDetailResult(
                          [state.listReport[0].questionAndPageIds[index-1]],
                          [state.listReport[0].questionAndPageIds[index-1]],
                          state.listSelected[index-1],
                          state.listController[index-1],
                          state.listControllerTable,
                          blocContext,
                          state.listTable,
                          state.farmerInspector ?? FarmerInspectorUpload(),
                          state.listInputModel[index -1]
                      ),
                    );
                  },
                )
            );
          }),
        ),
      ),
    );
  }

  Widget detailHeader(String title, List<Select> listSelect, List<InputRegisterModel> listWidget,
      String nameInspector, BuildContext context){
    return Column(
      children: [
        tableFooter(),
        tableMuc(title),
        SizedBox(height: 10,),
        tableDetail(listSelect, listWidget, nameInspector, context),
      ],
    );
  }
  Widget detailEnd(BuildContext context){
    return Column(
      children: [
        ExpansionTile(
          title: widgetMuc("(*)  Rủi ro"),
          children: [
            tableDetail16(),
          ],
        ),
        tableDetailEnd(),
        Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: OfitButton(
            text: "Hoàn Thành",
            onPressed: () {
              context.read<EditReportBloc>().add(SubmitReportEvent());
            },
          ),
        ),
      ],
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
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW700(AppColor.black22, 16),
              maxLines: 5,
            ),
          ),
        ]),
      ],
    ),);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: AppColor.black22),
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
  Widget checkBox(int id, List<Select> listSelected, BuildContext contextBloc, FarmerInspectorUpload farmerInspector,
      {bool isFirst = false, List<Controller> listController = const []}) {
    int index = listSelected.indexWhere((element) => element.id == id);
    /*print("HoangCV: checkbox: id: $id : $index : ${listSelected[index].title} : ${listSelected.length}");
    */return Container(
      margin: EdgeInsets.only(top:isFirst? 14: 0),
      height: 24.0,
      width: 24.0,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        side: BorderSide(color: AppColor.black22),
        value: listSelected[index].value,
        onChanged: (value) {
          bool checkPass = true;
          checkPass = Utils.checkPassFarm(farmerInspector);
          if (checkPass) {
            bool checkParent = true;
            print("HoangC:V listID: $id : $index : ${listSelected[index]
                .title} : ${listSelected[index]
                .parentId} : ${listSelected[index].listId.toString()}");
            if (value == false) {
              for (int i = 0; i < listSelected[index].listSubId.length; i++) {
                int id = listSelected.indexWhere((element) =>
                element.id == listSelected[index].listSubId[i]);
                setState(() {
                  listSelected[id].value = value ?? false;
                });
              }
            } else {
              if (listSelected[index].parentId != -1) {
                int indexParent = listSelected.indexWhere((element) =>
                element.id == listSelected[index].parentId);
                if (indexParent != -1) {
                  print(
                      "HoangCV:listSelected[indexParent].value : ${listSelected[indexParent]
                          .value} : ${listSelected[indexParent].title}");
                  checkParent = listSelected[indexParent].value;
                }
              }
              for (int i = 0; i < listSelected[index].listId.length; i++) {
                int id = listSelected.indexWhere((element) =>
                element.id == listSelected[index].listId[i]);
                print("HoangCV: listsub1: ${listSelected[id]
                    .id} : ${listSelected[id].title} : ${listSelected[id]
                    .listId} : ${listSelected[id].listSubId}");
                for (int i = 0; i < listSelected[id].listSubId.length; i++) {
                  int idSub = listSelected.indexWhere((element) =>
                  element.id == listSelected[id].listSubId[i]);
                  print("HoangCV: listsub1: ${idSub} : ${listSelected[idSub]
                      .title} : ${listSelected[id].listId} : ${listSelected[id]
                      .listSubId}");
                  setState(() {
                    listSelected[idSub].value = false;
                  });
                }
                setState(() {
                  listSelected[id].value = !(value ?? false);
                });
              }
            }
            if (checkParent) {
              setState(() {
                listSelected[index].value = value ?? false;
              });
              contextBloc.read<EditReportBloc>().add(
                  UpdateEditReportEvent(
                      id, '', listSelected, listController: listController));
            }
          }
        },
      ),
    );
  }
  Widget checkBoxInspector(int id, List<Select> listSelected, BuildContext contextBloc, {bool isFirst = false}) {
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
          if(value == true){
            for(int i = 0; i< listSelected.length; i++){
              setState(() {
                listSelected[i].value = !(value ?? false);
              });
            }
          }
          setState(() {
            listSelected[index].value = value ?? false;
          });
          contextBloc.read<EditReportBloc>().add(
              UpdateFarmerInspectorEvent(id, listSelected[index].type, listSelected));
        },
      ),
    );
  }
  TableRow tableRowCheckBox(String title, bool isError, int id, List<Select> listSelected, BuildContext context, FarmerInspectorUpload farmerInspector, {bool isFirst = false}) {
    return TableRow(children: [
      checkBox(id, listSelected, context, farmerInspector, isFirst: isFirst),
      Padding(
        padding: EdgeInsets.only(bottom: 8, top: isFirst ? 18 : 4),
        child: Text(
          title,
          textAlign: TextAlign.left,
          style: StyleOfit.textStyleFW400(isError ? AppColor.red11: AppColor.black22, 14),
          maxLines: 7,
        ),
      ),
    ]);
  }

  TableRow rowCheckBoxInspector(String title, int id, List<Select> listSelected, BuildContext context, {bool isFirst = false}) {
    return TableRow(children: [
      checkBoxInspector(id, listSelected, context, isFirst: isFirst),
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
  Widget tableRowText(String title, bool isError) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8,left: 4, right: 4),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: StyleOfit.textStyleFW400(isError ? AppColor.red11: AppColor.black22, 14),
        maxLines: 7,
      ),
    );
  }
  Widget tableRowTextHasSub(String title, bool isError, List<Answer> list) {
    List<Widget> tableWidgetText = [];
    for (int i = 0; i < list.length; i++) {
      tableWidgetText.add(tableRowText(list[i].value ?? '', list[i].isError ?? false));
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
                    style: StyleOfit.textStyleFW400(isError ? AppColor.red11: AppColor.black22, 14),
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
  Widget tableNon(int questionId, int answerId, int idSelected, int idRow,
      List<List<Controller>> controllers, BuildContext context, FarmerInspectorUpload farmerInspector) {
    TextEditingController controller = TextEditingController();
    String type = '';
    int index = -1;

    for (var element in controllers) {
      index = element.indexWhere((element) => element.id == idSelected && element.idRow == idRow);

      if (index != -1) {
        //print("HoangCV: tableNon index: $index : ${element[index].toJson()} : $idRow : $idSelected");
        controller = element[index].controller;
        type = element[index].type;
        return Padding(
          padding: EdgeInsets.only(bottom: 4, top: 4),
          child: TextField(
            controller: controller,
            keyboardType: type == 'text' ? TextInputType.text : TextInputType.number,
            onSubmitted: (str) {
              context.read<EditReportBloc>().add(UpdateEditTableEvent(questionId, answerId, idRow, str));
            },
            onChanged: (str) {
              bool checkPass = true;
              checkPass = Utils.checkPassFarm(farmerInspector);
              if (checkPass) {
                //controller.text = str;
              } else{
                controller.text = '';
              }
            },
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none, // No border or underline
              contentPadding: EdgeInsets.only(bottom: 4, top: 4, left: 4, right: 4),
            ),
            maxLines: 10,
            minLines: 2,
          ),
        );
      }
    }

    // Trả về một giá trị mặc định nếu không tìm thấy phần tử thỏa mãn điều kiện
    return SizedBox(); // Hoặc bạn có thể trả về một Widget mặc định khác tuỳ ý
  }
  Table tableNonHasSub(int questionId, int idRow, List<Answer> list, List<List<Controller>> controller,
      BuildContext context, FarmerInspectorUpload farmerInspector) {
    List<Widget> tabNonSub = [];
    for (int i = 0; i < list.length; i++) {
      tabNonSub.add( tableNon(questionId, list[i].id!, list[i].idSelected!, idRow,
          controller, context, farmerInspector),);
    }
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
      },
      border: TableBorder.all(color: AppColor.black22),//const TableBorder(verticalInside: BorderSide(color: AppColor.black22)),
      children: [
        TableRow(children: tabNonSub),
      ],
    );
  }
  TableRow tableRowCheckBoxTextField(String title, bool isError, int id, List<Select> listSelected, List<Controller> controller, BuildContext context, FarmerInspectorUpload farmerInspector, {bool isFirst = false}) {
    int index = controller.indexWhere((element) => element.id == id);
    return TableRow(children: [
      checkBox(id, listSelected, context, farmerInspector, isFirst: isFirst, listController: controller),
      Padding(
        padding: EdgeInsets.only(top: isFirst ? 16 : 4, bottom: 16.0),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: StyleOfit.textStyleFW400(isError ? AppColor.red11: AppColor.black22, 14),
              ),
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: TextField(
                    controller: controller[index].controller,
                    keyboardType: controller[index].type == 'text' ? TextInputType.text : controller[index].type == 'none' ? TextInputType.none : TextInputType.number,
                    onSubmitted: (str){
                      context.read<EditReportBloc>().add(
                          UpdateEditReportEvent(id, str, listSelected));
                    },
                    onChanged: (str) {
                      bool checkPass = true;
                      checkPass = Utils.checkPassFarm(farmerInspector);
                      if (checkPass) {
                        //controller[index].controller.text = str;
                      } else{
                        controller[index].controller.text = '';
                      }
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
  TableRow tableRowTextField(String title, bool isError, int id, List<Controller> controller, BuildContext context,
      FarmerInspectorUpload farmerInspector,{bool isFirst = false}) {
    int index = controller.indexWhere((element) => element.id == id);
    return TableRow(children: [
      Padding(
        padding: EdgeInsets.only(top: isFirst ? 16 : 4, bottom: 16.0, left: 10),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: StyleOfit.textStyleFW400(isError ? AppColor.red11: AppColor.black22, 14),
              ),
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: TextField(
                    controller: controller[index].controller,
                    keyboardType: controller[index].type == 'text'
                        ? TextInputType.text
                        : TextInputType.number,
                    onSubmitted: (str) {
                      context.read<EditReportBloc>().add(
                          UpdateEditReportEvent(id, str, []));
                    },
                    onChanged: (str) {
                      bool checkPass = true;
                      checkPass = Utils.checkPassFarm(farmerInspector);
                      if (checkPass) {
                        //controller[index].controller.text = str;
                      } else{
                        controller[index].controller.text = '';
                      }
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

  TableRow tableRowTextFieldHasCheckbox(String title, bool isError, int id, List<Controller> controller,
      BuildContext context, FarmerInspectorUpload farmerInspector,
      {bool isFirst = false, bool hasCheckbox = false}) {
    int index = controller.indexWhere((element) => element.id == id);
    List<Widget> rowChildren = [];
// Kiểm tra nếu hasCheckbox là true, thêm SizedBox vào danh sách tạm thời
    if (hasCheckbox) {
      rowChildren.add( SizedBox.shrink());
    } else{
      rowChildren.add( Container(
        margin: EdgeInsets.only(top:isFirst? 14: 0),
        height: 24.0,
        width: 24.0,
        child: Visibility(
          visible: hasCheckbox,
          child: Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            side: BorderSide(color: AppColor.black22),
            value: false,
            onChanged: (bool? value) {  },
          ),
        ),
      ));
    }

    rowChildren.add(
      Padding(
        padding: EdgeInsets.only(top: isFirst ? 16 : 4, bottom: 16.0, /*left: 10*/),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: StyleOfit.textStyleFW400(isError ? AppColor.red11: AppColor.black22, 14),
              ),
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: TextField(
                    controller: controller[index].controller,
                    keyboardType: controller[index].type == 'text'
                        ? TextInputType.text
                        : TextInputType.number,
                    onSubmitted: (str) {
                      context.read<EditReportBloc>().add(
                          UpdateEditReportEvent(id, str, []));
                    },
                    onChanged: (str) {
                      bool checkPass = true;
                      checkPass = Utils.checkPassFarm(farmerInspector);
                      if (checkPass) {
                        //controller[index].controller.text = str;
                      } else{
                        controller[index].controller.text = '';
                      }
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
      ),
    );
    print("HoangCV: hasCheckbox |: ${hasCheckbox} : ${rowChildren.length}");
    return TableRow(children: rowChildren);
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
  Widget tableDetail(List<Select> listSelect, List<InputRegisterModel> listWidget, String nameInspector, BuildContext context){
    List<Table> listTable0 =[];
    List<TableRow> listRow = [];
    listSelect.forEach((element) {
      listRow.add(rowCheckBoxInspector(
          element.title,
          element.id, listSelect, context,
          isFirst: /*element.id == 0 ? true : */false));
    });
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
            padding: EdgeInsets.only(bottom: 16, top: 16, left: 8, right: 8),
            child: ContainerInputWidget(
              contextParent: context,
              color: AppColor.background,
              inputRegisterModel: listWidget[3],
              onClick: () {
                context
                    .read<EditReportBloc>()
                    .add(OnSelectValueEvent(listWidget, 3, context));
              },
            ),
          ),
        ]),
      ],
    ),);
    List<Table> listTable1 =[];
    listTable1.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1.5),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(0.5),

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
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: ContainerInputWidget(
              contextParent: context,
              color: AppColor.background,
              inputRegisterModel: listWidget[0],
              onClick: () {
                context
                    .read<EditReportBloc>()
                    .add(OnSelectValueEvent(listWidget, 0, context));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16, top: 16),
            child: Text(
              "Mã nông hộ",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: ContainerInputWidget(
              contextParent: context,
              color: AppColor.background,
              inputRegisterModel: listWidget[1],
              onClick: () {
              },
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
              "Tên vùng trồng",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW700(AppColor.black22, 14),
              maxLines: 3,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: ContainerInputWidget(
              contextParent: context,
              color: AppColor.background,
              inputRegisterModel: listWidget[4],
              onClick: () {
                context
                    .read<EditReportBloc>()
                    .add(OnSelectValueEvent(listWidget, 4, context));
              },
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
          Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 16, left: 14, right: 14),
            child: Text(
              nameInspector,
              textAlign: TextAlign.left,
              style: StyleOfit.textStyleFW400(AppColor.black22, 14),
              maxLines: 3,
            ),
          ),
          /*     Container(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: ContainerInputWidget(
              contextParent: context,
              color: AppColor.background,
              inputRegisterModel: listWidget[2],
              onClick: () {
                context
                    .read<AddReportBloc>()
                    .add(OnSelectValueEvent(listWidget, 2, context));
              },
            ),
          ),*/
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
              "Ngày thanh tra",
              textAlign: TextAlign.center,
              style: StyleOfit.textStyleFW700(AppColor.black22, 14),
              maxLines: 3,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: ContainerInputWidget(
              contextParent: context,
              color: AppColor.background,
              inputRegisterModel: listWidget[3],
              onClick: () {
                context
                    .read<EditReportBloc>()
                    .add(OnSelectValueEvent(listWidget, 3, context));
              },
            ),
          ),
        ]),
      ],
    ),);
    return Container(
      decoration: BoxDecoration(
        //border: Border.all(width: 0.5,color: AppColor.black22),
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

  Widget tableDetailResult(List<Question> list, List<Question> listParent,
      List<Select> listSelect, List<Controller> listController,
      List<List<Controller>> listControllerTable, BuildContext context,
      List<TableQuestion> listTable, FarmerInspectorUpload farmerInspector,
      List<ListInputModel> listInputModel){
    List<Table> listTable1 =[];
    int form = 0;
    bool checkFormFour = false;
    print("HoangCV: list : ${list} : ${form} : ${listSelect.length} : ${listSelect.first.toJson()}");
    for(int i = 0 ; i < list.length; i++) {
      List<Table> tableSub = [];
      List<TableRow> tableRow = [];
      List<TableRow> tableRowSub = [];
      List<Widget> tableWidgetText = [];
      List<List<Widget>> tableWidgetFive = [];
      List<List<Widget>> listRow= [];
      form = checkForm(list[i]);
      print("HoangCV: list title : ${list[i].title} ${list[i].questionType} : ${form} : ${list[i].questionAndPageIds.length}");
      if(list[i].questionType == "simple_choice" || list[i].questionType == "multiple_choice"
          || list[i].questionType == "title"){
        if(list[i].questionAndPageIds.length>0){
          checkFormFour = true;
          List<Question> listParent = list[i].questionAndPageIds;
          for(int i = 0 ; i < listParent.length; i++) {
            List<Table> tableSub = [];
            List<TableRow> tableRow = [];
            List<TableRow> tableRowSub = [];
            form = 5;
            for (int j = 0; j <
                listParent[i].suggestedAnswerIds.length; j ++) {
              if (listParent[i].suggestedAnswerIds[j].questionAndPageIds
                  .isNotEmpty) {
                if (listParent[i].suggestedAnswerIds[j].commentAnswer ==
                    true) {
                  tableRow.add(tableRowCheckBoxTextField(
                      "${listParent[i].suggestedAnswerIds[j].value}",
                      listParent[i].suggestedAnswerIds[j].isError ?? false,
                      listParent[i].suggestedAnswerIds[j].idSelected ?? -1,
                      listSelect, listController, context, farmerInspector,
                      isFirst: i == 0 ? true : false));
                } else {
                  tableRow.add(tableRowCheckBox(
                      "${listParent[i].suggestedAnswerIds[j].value}",
                      listParent[i].suggestedAnswerIds[j].isError ?? false,
                      listParent[i].suggestedAnswerIds[j].idSelected ?? -1,
                      listSelect,
                      context, farmerInspector, isFirst: i == 0 ? true : false));
                }
                bool hasCheckBox = listParent[i].suggestedAnswerIds[j].questionAndPageIds.any((element) => element.questionType == "check_box");
                for (int k = 0; k <
                    listParent[i].suggestedAnswerIds[j].questionAndPageIds
                        .length; k ++) {
                  if (listParent[i].suggestedAnswerIds[j]
                      .questionAndPageIds[k].questionType == "check_box" &&
                      listParent[i].suggestedAnswerIds[j]
                          .questionAndPageIds[k].commentAnswer == true) {
                    tableRowSub.add(tableRowCheckBoxTextField(
                        "${listParent[i].suggestedAnswerIds[j].questionAndPageIds[k].title}",
                        listParent[i].suggestedAnswerIds[j].questionAndPageIds[k].isError ?? false,
                        listParent[i].suggestedAnswerIds[j].questionAndPageIds[k].idSelected ?? -1,
                        listSelect, listController, context, farmerInspector,
                        isFirst: i == 0 ? true : false));
                  } else if(listParent[i].suggestedAnswerIds[j].questionAndPageIds[k].questionType == "numerical_box" ||
                      listParent[i].suggestedAnswerIds[j].questionAndPageIds[k].questionType == "char_box"){
                    tableRowSub.add(tableRowTextFieldHasCheckbox(
                        "${listParent[i].suggestedAnswerIds[j].questionAndPageIds[k].title}",
                        listParent[i].suggestedAnswerIds[j].questionAndPageIds[k].isError ?? false,
                        listParent[i].suggestedAnswerIds[j].questionAndPageIds[k].idSelected ?? -1,
                        listController, context, farmerInspector,
                        isFirst: i == 0 ? true : false, hasCheckbox: hasCheckBox));
                  } else {
                    tableRowSub.add(tableRowCheckBox(
                        "${listParent[i].suggestedAnswerIds[j].questionAndPageIds[k].title}",
                        listParent[i].suggestedAnswerIds[j].questionAndPageIds[k].isError ?? false,
                        listParent[i].suggestedAnswerIds[j].questionAndPageIds[k].idSelected ?? -1,
                        listSelect, context, farmerInspector,
                        isFirst: i == 0 ? true : false));
                  }
                }
              } else {
                bool hasNonEmptyValues = listParent[i].suggestedAnswerIds
                    .any((element) {
                  return element.questionAndPageIds.isNotEmpty;
                });
                if (hasNonEmptyValues) {
                  if (listParent[i].suggestedAnswerIds[j].commentAnswer ==
                      true) {
                    tableRow.add(tableRowCheckBoxTextField(
                        "${listParent[i].suggestedAnswerIds[j].value}",
                        listParent[i].suggestedAnswerIds[j].isError ?? false,
                        listParent[i].suggestedAnswerIds[j].idSelected ?? -1,
                        listSelect, listController, context, farmerInspector,
                        isFirst: i == 0 ? true : false));
                  } else {
                    tableRow.add(tableRowCheckBox(
                        "${listParent[i].suggestedAnswerIds[j].value}",
                        listParent[i].suggestedAnswerIds[j].isError ?? false,
                        listParent[i].suggestedAnswerIds[j].idSelected ?? -1,
                        listSelect, context, farmerInspector,
                        isFirst: i == 0 ? true : false));
                  }
                } else {
                  bool hasCommentAnswer = listParent[i].suggestedAnswerIds
                      .any((element) {
                    return element.commentAnswer == true;
                  });
                  if (hasCommentAnswer) {
                    if(form != 5 && form != 1) form = 2;
                    if (listParent[i].suggestedAnswerIds[j].commentAnswer ==
                        true) {
                      if(form == 5){
                        tableRow.add(tableRowCheckBoxTextField(
                            "${listParent[i].suggestedAnswerIds[j].value}",
                            listParent[i].suggestedAnswerIds[j].isError ?? false,
                            listParent[i].suggestedAnswerIds[j].idSelected ?? -1,
                            listSelect, listController, context, farmerInspector,
                            isFirst: i == 0 ? true : false));
                      } else{
                        tableSub.add(tableForm2TextField(
                            listParent[i].suggestedAnswerIds[j].value ?? '',
                            listParent[i].suggestedAnswerIds[j].isError ?? false,
                            listParent[i].suggestedAnswerIds[j].idSelected ?? -1,
                            listSelect, listController, context, farmerInspector));
                      }
                    } else {
                      if(form == 5){
                        tableRow.add(tableRowCheckBox(
                            "${listParent[i].suggestedAnswerIds[j].value}",
                            listParent[i].suggestedAnswerIds[j].isError ?? false,
                            listParent[i].suggestedAnswerIds[j].idSelected ?? -1,
                            listSelect, context, farmerInspector,
                            isFirst: i == 0 ? true : false));
                      } else {
                        tableSub.add(tableForm2(
                            listParent[i].suggestedAnswerIds[j].value ?? '',
                            listParent[i].suggestedAnswerIds[j].isError ?? false,
                            listParent[i].suggestedAnswerIds[j].idSelected ??
                                -1,
                            listSelect, context, farmerInspector,
                            isFirst: i == 0 ? true : false));
                      }
                    }
                  } else {
                    form = 3;
                    tableRow.add(
                        tableRowCheckBox(
                            listParent[i].suggestedAnswerIds[j].value ?? '',
                            listParent[i].suggestedAnswerIds[j].isError ?? false,
                            listParent[i].suggestedAnswerIds[j].idSelected ?? -1,
                            listSelect, context, farmerInspector));
                  }
                }
              }
            }
            if(form == 5){
              tableWidgetFive.add([
                Padding(
                  padding: EdgeInsets.only(bottom: 16, top: 16),
                  child: Text(
                    "${listParent[i].title}",
                    textAlign: TextAlign.center,
                    style: StyleOfit.textStyleFW400(listParent[i].isError == true ?
                    AppColor.red11 : AppColor.black22, 14),
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
              ]);
            }
            else if(tableSub.isEmpty && form != 0 && form != 1 && form != 2 && listParent[i].questionType != "table") {
              tableWidgetFive.add([
                Padding(
                  padding: EdgeInsets.only(bottom: 16, top: 16),
                  child: Text(
                    "${listParent[i].title}",
                    textAlign: TextAlign.center,
                    style: StyleOfit.textStyleFW400(listParent[i].isError == true ?
                    AppColor.red11 : AppColor.black22, 14),
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
              ]);
            }
            else if(tableRow.isNotEmpty && tableRowSub.isEmpty && form != 2
                && listParent[i].questionType != "table"){
            }
            if(tableSub.isNotEmpty && form != 0 && form != 1 && form != 2
                && listParent[i].questionType != "table") {
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
            else if(tableSub.isNotEmpty && form != 0 && form != 1 && form == 2
                && listParent[i].questionType != "table") {
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
                                  "${listParent[i].title}",
                                  textAlign: TextAlign.center,
                                  style: StyleOfit.textStyleFW400(listParent[i].isError == true ?
                                  AppColor.red11 : AppColor.black22, 14),
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
          }
          List<TableRow> tableR = [];
          for(var table in tableWidgetFive){
            tableR.add(TableRow(children: table));
          }
          // form 5. van chuyen sau thu hoach
          listTable1.add(Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FlexColumnWidth(0.7),
                1: FlexColumnWidth(3.8),
              },
              border: TableBorder.all(color: AppColor.black22),
              children: [TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16, top: 16),
                    child: Text(
                      list[i].title??"",
                      textAlign: TextAlign.center,
                      style: StyleOfit.textStyleFW400(list[i].isError == true ?
                      AppColor.red11 : AppColor.black22, 14),
                      maxLines: 10,
                    ),
                  ),
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    columnWidths: {
                      0: FlexColumnWidth(0.8),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(2),
                    },
                    border: TableBorder.all(color: AppColor.black22),
                    children: tableR,
                  ),
                ],)]
          ),);
        }
        //
        //
        else{
          checkFormFour = false;
          for (int j = 0; j < list[i].suggestedAnswerIds.length; j ++) {
            if (list[i].suggestedAnswerIds[j].questionAndPageIds.isNotEmpty){
              if (list[i].suggestedAnswerIds[j].commentAnswer == true) {
                tableRow.add(tableRowCheckBoxTextField(
                    "${list[i].suggestedAnswerIds[j].value}",
                    list[i].suggestedAnswerIds[j].isError ?? false,
                    list[i].suggestedAnswerIds[j].idSelected ?? -1,
                    listSelect, listController, context, farmerInspector,
                    isFirst: i == 0 ? true : false));
              } else {
                tableRow.add(tableRowCheckBox("${list[i].suggestedAnswerIds[j].value}",
                    list[i].suggestedAnswerIds[j].isError ?? false,
                    list[i].suggestedAnswerIds[j].idSelected ?? -1, listSelect,
                    context, farmerInspector, isFirst: i == 0 ? true : false));
              }
              for (int k = 0; k <
                  list[i].suggestedAnswerIds[j].questionAndPageIds.length; k ++) {
                if (list[i].suggestedAnswerIds[j].questionAndPageIds[k].questionType == "check_box" &&
                    list[i].suggestedAnswerIds[j].questionAndPageIds[k].commentAnswer == true) {
                  tableRowSub.add(tableRowCheckBoxTextField(
                      "${list[i].suggestedAnswerIds[j].questionAndPageIds[k].title}",
                      list[i].suggestedAnswerIds[j].questionAndPageIds[k].isError ?? false,
                      list[i].suggestedAnswerIds[j].questionAndPageIds[k].idSelected ?? -1,
                      listSelect, listController, context, farmerInspector,
                      isFirst: i == 0 ? true : false));
                } else if (list[i].suggestedAnswerIds[j].questionAndPageIds[k].questionType == "numerical_box" ||
                    list[i].suggestedAnswerIds[j].questionAndPageIds[k].questionType == "char_box"){
                  bool hasCheckBox = list[i].suggestedAnswerIds[j].questionAndPageIds.any((element) => element.questionType == "check_box");
                  tableRowSub.add(tableRowTextFieldHasCheckbox(
                      "${list[i].suggestedAnswerIds[j].questionAndPageIds[k].title}",
                      list[i].suggestedAnswerIds[j].questionAndPageIds[k].isError ?? false,
                      list[i].suggestedAnswerIds[j].questionAndPageIds[k].idSelected ?? -1,
                      listController, context, farmerInspector,
                      isFirst: i == 0 ? true : false, hasCheckbox: hasCheckBox));
                } else{
                  tableRowSub.add(tableRowCheckBox(
                      "${list[i].suggestedAnswerIds[j].questionAndPageIds[k].title}",
                      list[i].suggestedAnswerIds[j].questionAndPageIds[k].isError ?? false,
                      list[i].suggestedAnswerIds[j].questionAndPageIds[k].idSelected ?? -1,
                      listSelect, context, farmerInspector,
                      isFirst: i == 0 ? true : false));
                }
              }
            } else{
              bool hasNonEmptyValues = list[i].suggestedAnswerIds.any((element) {
                return element.questionAndPageIds.isNotEmpty;
              });
              if(hasNonEmptyValues){
                tableRow.add(tableRowCheckBox(
                    "${list[i].suggestedAnswerIds[j].value}",
                    list[i].suggestedAnswerIds[j].isError ?? false,
                    list[i].suggestedAnswerIds[j].idSelected ?? -1,
                    listSelect, context, farmerInspector, isFirst: i == 0 ? true : false));
              }else {
                form = 3;
                print("HoangCV:falseform = 3; $i : $j : ${list[i].title} : ${list[i].suggestedAnswerIds[j].value} : ${list.length}");
                if (list[i].suggestedAnswerIds[j].commentAnswer == true) {
                  tableRow.add(tableRowCheckBoxTextField(
                      list[i].suggestedAnswerIds[j].value ?? '',
                      list[i].suggestedAnswerIds[j].isError ?? false,
                      list[i].suggestedAnswerIds[j].idSelected ?? -1,
                      listSelect, listController, context, farmerInspector,
                      isFirst: i == 0 ? true : false));
                }else {
                  tableRow.add(tableRowCheckBox(
                    list[i].suggestedAnswerIds[j].value ?? '',
                    list[i].suggestedAnswerIds[j].isError ?? false,
                    list[i].suggestedAnswerIds[j].idSelected ?? -1,
                    listSelect, context, farmerInspector,/* isFirst: i == 0 ? true : false*/));
                }
              }
            }
          }
        }
      }
      else if(list[i].questionType == "table"){
        checkFormFour = false;
        for (int j = 0; j < list[i].suggestedAnswerIds.length; j++) {
          if (list[i].suggestedAnswerIds[j].suggestedAnswerIds.isNotEmpty) {
            tableWidgetText.add(tableRowTextHasSub(
                list[i].suggestedAnswerIds[j].value ?? '',
                list[i].suggestedAnswerIds[j].isError ?? false,
                list[i].suggestedAnswerIds[j].suggestedAnswerIds));
          } else {
            tableWidgetText.add(tableRowText(
              list[i].suggestedAnswerIds[j].value ?? '',
              list[i].suggestedAnswerIds[j].isError ?? false,));
          }
        }
        int index = listTable.indexWhere((element) =>
        element.id == list[i].id
        );
        for(int a = 0 ; a <listTable[index].listQuestion.length; a ++){
          List<Widget> tableWidgetNon = [];
          for(int g = 0 ; g <listTable[index].listQuestion[a].suggestedAnswerIds.length; g++){
            if (listTable[index].listQuestion[a].suggestedAnswerIds[g].suggestedAnswerIds.isNotEmpty) {
              tableWidgetNon.add(tableNonHasSub(listTable[index].listQuestion[a].id!,
                  listTable[index].listQuestion[a].rowId!,
                  listTable[index].listQuestion[a].suggestedAnswerIds[g].suggestedAnswerIds,
                  listControllerTable, context, farmerInspector));
            } else {
              tableWidgetNon.add(tableNon(listTable[index].listQuestion[a].id!,
                  listTable[index].listQuestion[a].suggestedAnswerIds[g].id!,
                  listTable[index].listQuestion[a].suggestedAnswerIds[g].idSelected!,
                  listTable[index].listQuestion[a].rowId!,listControllerTable, context, farmerInspector));
            }
          }
          listRow.add(tableWidgetNon);
        }
      }
      if(!checkFormFour) {
        if (tableSub.isEmpty && form != 0 && form != 1 && form != 2 &&
            list[i].questionType != "table") {
          print("HoangCV: tableSub.isEmpty: ${tableSub.isEmpty} : ${list[i].title} : ${tableRowSub.isNotEmpty}");
          if(tableRowSub.isNotEmpty) {
            listTable1.add(Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.top,
              columnWidths: {
                0: FlexColumnWidth(0.8),
                1: FlexColumnWidth(0.8),
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
                      style: StyleOfit.textStyleFW400(
                          list[i].isError == true ? AppColor.red11 : AppColor
                              .black22, 14),
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
          } else{
            listTable1.add(Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.top,
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(3),
              },
              border: TableBorder.all(color: AppColor.black22),
              children: [
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 16, top: 16),
                    child: Text(
                      "${list[i].title}",
                      textAlign: TextAlign.center,
                      style: StyleOfit.textStyleFW400(
                          list[i].isError == true ? AppColor.red11 : AppColor
                              .black22, 14),
                      maxLines: 7,
                    ),
                  ),
                  tableRow.isNotEmpty
                      ? Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    columnWidths: const {
                      0: FlexColumnWidth(0.2),
                      1: FlexColumnWidth(2),
                    },
                    children: tableRow,
                  )
                      : Container(),
                ]),
              ],
            ),);
          }
        }
        else if (tableRow.isNotEmpty && tableRowSub.isEmpty && form != 2 &&
            list[i].questionType != "table") {}
        if (tableSub.isNotEmpty && form != 0 && form != 1 && form != 2 &&
            list[i].questionType != "table") {
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
        else if (tableSub.isNotEmpty && form != 0 && form != 1 && form == 2 &&
            list[i].questionType != "table") {
          // form 5. thu hoach
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
                      defaultVerticalAlignment: TableCellVerticalAlignment
                          .middle,
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
                              style: StyleOfit.textStyleFW400(list[i].isError == true ? AppColor.red11 :
                              AppColor.black22, 14),
                              maxLines: 6,
                            ),
                          ),
                        ]),
                      ],
                    ),
                    for(int i = 0; i < tableSub.length; i++)
                      tableSub[i]
                  ]
              ),
            ],
          ),);
        }
      }
      if(form == 0){
        if(list[i].questionType == "char_box" || list[i].questionType =="numerical_box"){
          tableSub.add(formCharTextField(list[i].title??'',
              list[i].isError ?? false,
              list[i].idSelected ?? -1,
              listController, context, farmerInspector));
        }else if(list[i].questionType == "check_box"){
          tableSub.add(tableForm2TextField(list[i].title ?? '',
              list[i].isError ?? false,
              list[i].idSelected ?? -1,
              listSelect, listController, context, farmerInspector));
        }else if(list[i].questionType == "datetime" || list[i].questionType == "date"){
          tableSub.add(Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder.all(color: AppColor.black22),
            children: [
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 16, top: 16),
                  child: Text(
                    list[i].title!,
                    textAlign: TextAlign.center,
                    style: StyleOfit.textStyleFW400(AppColor.black22, 14),
                    maxLines: 2,
                  ),
                ),
              ]),
            ],
          ),);
          int indexInput = listInputModel.indexWhere((element) => element.id == list[i].idSelected);
          print("HoangCV: listInputModel: ${listInputModel.first.id} : ${list[i].idSelected} : ${indexInput}");
          tableSub.add(Table(

            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(children: [
                Container(
                  padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                  child: ContainerInputWidget(
                    contextParent: context,
                    color: AppColor.background,
                    inputRegisterModel: listInputModel[indexInput].inputModel,
                    onClick: () {
                      bool checkPass = true;
                      checkPass = Utils.checkPassFarm(farmerInspector);
                      if (checkPass) {
                        context
                            .read<EditReportBloc>()
                            .add(OnSelectValueEvent([listInputModel[indexInput].inputModel],
                            0, context, id: list[i].id!, type: list[i].questionType!));
                      }
                    },
                  ),
                ),
              ]),
            ],
          ));
        }
        print("HoangcVAS:DA sdas : ${tableSub.length}");
        listTable1.add(Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          columnWidths: {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(3),
          },
          border: TableBorder.all(color: AppColor.black22),
          children: [
            TableRow(
                children:
                tableSub

            ),
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
                  style: StyleOfit.textStyleFW400(list[i].isError == true ? AppColor.red11 : AppColor.black22, 14),
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
      else if(list[i].questionType  == "table" && tableWidgetText.isNotEmpty){
        // table
        //print("HoangCV: form == 7 :  ${listRow.length} ${listRow[0].length}");
        listTable1.add(Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          columnWidths: {
          },
          border: TableBorder.all(color: AppColor.black22),
          children: [
            TableRow(children: tableWidgetText),
          ],
        ),);
        for(int i = 0; i< listRow.length; i++) {
          listTable1.add(Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.top,
              columnWidths: {
              },
              border: TableBorder.all(color: AppColor.black22),
              children: [
                TableRow(
                    children: listRow[i]
                )
              ]
          ),);
        }
      }
    }

    return Container(
      decoration: BoxDecoration(
        border: list.length == 1 ? Border.symmetric() : Border.all(width: 0.5,color: AppColor.black22),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width* (list.length == 1 ? 1.1 : 1.3 )),
          child: Column(
              children: listTable1
          ),
        ),
      ),
    );
  }

  Table tableForm2TextField(String title, bool isError, int id, List<Select> listSelected, List<Controller> listController, BuildContext context, FarmerInspectorUpload farmerInspector, {bool isFirst = false}){
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: const {
        0: FlexColumnWidth(0.3),
        1: FlexColumnWidth(2),
      },
      children: [
        tableRowCheckBoxTextField(
            title, isError,
            id, listSelected, listController, context, farmerInspector, isFirst: true),
      ],
    );
  }
  Table formCharTextField(String title, bool isError, int id, List<Controller> listController,
      BuildContext context, FarmerInspectorUpload farmerInspector, {bool isFirst = false}){
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: const {
        0: FlexColumnWidth(0.3),
        1: FlexColumnWidth(2),
      },
      children: [
        tableRowTextField(
            title, isError, id, listController, context, farmerInspector, isFirst: true),
      ],
    );
  }
  Table tableForm2(String title, bool isError, int id, List<Select> listSelected, BuildContext context, FarmerInspectorUpload farmerInspector, {bool isFirst = false}){
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: const {
        0: FlexColumnWidth(0.7),
        1: FlexColumnWidth(2),
      },
      children: [
        tableRowCheckBox(
            title, isError,
            id, listSelected, context, farmerInspector, isFirst: isFirst),
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
        /*if(as[i].questionAndPageIds.isEmpty){
          count++;
          if(as[i].commentAnswer == true){
            count = count + 4;
          }
        }*/
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
        border: Border.all(width: 0.5,color: AppColor.black22),
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
        border: Border.all(width: 0.5,color: AppColor.black22),
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
