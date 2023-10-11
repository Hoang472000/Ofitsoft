import 'dart:async';
import 'dart:ffi';

import 'package:diary_mobile/data/entity/report/question_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../data/repository.dart';
import '../../data/entity/report/answer.dart';
import '../../data/entity/report/question.dart';
import '../../data/entity/report/report.dart';
import '../../data/remote_data/object_model/object_result.dart';
import '../../utils/constants/status_const.dart';
import '../../utils/extenstion/extenstions.dart';
import '../../utils/extenstion/input_register_model.dart';
import '../../utils/extenstion/service_info_extension.dart';
import '../../utils/status/form_submission_status.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/dialog/toast_widget.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class DetailReportBloc extends Bloc<DetailReportEvent, DetailReportState> {
  final Repository repository;

  DetailReportBloc(this.repository) : super(DetailReportState()) {
    on<GetDetailReportEvent>(_getDetailReport);
  }

  void _initViewDetail(Emitter<DetailReportState> emitter) {
    List<InputRegisterModel> list= [];
    print("HoangCV: state.listFarmer : ${state.listFarmer.length}");
    if(state.indexFarmer != -1) {
      list.add(InputRegisterModel<People, People>(
          title: "",
          isCompulsory: false,
          type: TypeInputRegister.Select,
          icon: Icons.arrow_drop_down,
          positionSelected: state.indexFarmer ?? -1,
          valueSelected: state.listFarmer[state.indexFarmer ?? 0],
          listValue: state.listFarmer,
          typeInputEnum: TypeInputEnum.dmucItem,
          noBorder: true,
          hasSearch: true,
          textAlign: TextAlign.left
      ));
    } else{
      list.add(InputRegisterModel<People, People>(
          title: "",
          isCompulsory: false,
          type: TypeInputRegister.Select,
          icon: Icons.arrow_drop_down,
          positionSelected: -1,
          listValue: state.listFarmer,
          typeInputEnum: TypeInputEnum.dmucItem,
          noBorder: true,
          hasSearch: true,
          textAlign: TextAlign.left
      ));
    }

    list.add(InputRegisterModel(
        title: "",
        isCompulsory: false,
        type: TypeInputRegister.Non,
        controller: state.idFarmerController,
        noBorder: true,
        textAlign: TextAlign.center
    ));

    if(state.indexInspector != -1) {
      list.add(InputRegisterModel<People, People>(
          title: "",
          isCompulsory: false,
          type: TypeInputRegister.Select,
          icon: Icons.arrow_drop_down,
          positionSelected: state.indexInspector ?? -1,
          valueSelected: state.listInspector[state.indexInspector ?? 0],
          listValue: state.listInspector,
          typeInputEnum: TypeInputEnum.dmucItem,
          hasSearch: true,
          noBorder: true,
          textAlign: TextAlign.left
      ));
    } else{
      list.add(InputRegisterModel<People, People>(
          title: "",
          isCompulsory: false,
          type: TypeInputRegister.Select,
          icon: Icons.arrow_drop_down,
          positionSelected: -1,
          listValue: state.listInspector,
          typeInputEnum: TypeInputEnum.dmucItem,
          hasSearch: true,
          noBorder: true,
          textAlign: TextAlign.left
      ));
    }

    list.add(InputRegisterModel<String, DateTime>(
        title: "",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        valueSelected: Utils.stringToDate(state.startTimeController!.text),
        controller: state.startTimeController,
        noBorder: true,
        textAlign: TextAlign.left
      //icon: Icons.calendar_today
    ));

    if(state.indexFarm != -1) {
      list.add(InputRegisterModel<People, People>(
          title: "",
          isCompulsory: false,
          type: TypeInputRegister.Select,
          icon: Icons.arrow_drop_down,
          positionSelected: state.indexFarm ?? -1,
          valueSelected: state.listFarm[state.indexFarm ?? 0],
          listValue: state.listFarm,
          typeInputEnum: TypeInputEnum.dmucItem,
          noBorder: true,
          hasSearch: true,
          textAlign: TextAlign.left
      ));
    } else{
      list.add(InputRegisterModel<People, People>(
          title: "",
          isCompulsory: false,
          type: TypeInputRegister.Select,
          icon: Icons.arrow_drop_down,
          positionSelected: -1,
          listValue: state.listFarm,
          typeInputEnum: TypeInputEnum.dmucItem,
          noBorder: true,
          hasSearch: true,
          textAlign: TextAlign.left
      ));
    }

    emitter(state.copyWith(
        listWidget: list,
        formStatus: const InitialFormStatus()));
  }

  void _getDetailReport(
      GetDetailReportEvent event, Emitter<DetailReportState> emitter) async {
    emitter(state.copyWith(
      isShowProgress: true,
      idFarmerController: TextEditingController(text: ''),
      farmerInspector: FarmerInspectorUpload(visit_date: DateTime.now().toString().split('.')[0]),
    ));
    final report = await repository.getDetailReport(event.id);
    List<List<Select>> listSelected = [];
    List<List<ListInputModel>> listInputModel = [];
    List<Select> listSelectedInspector = [];
    List<List<Visible>> listVisible = [];
    List<List<Controller>> listController = [];
    List<List<Controller>> listControllerTable = [];
    List<TableQuestion> listTable = [];
    List<People> listFarmer = [];
    List<People> listInspector = [];
    if (report[1].surveyId.isNotEmpty) {
      listSelected = createSelectLists(report[1].surveyId[0].questionAndPageIds);
      listInputModel = createInputLists(report[1].surveyId[0].questionAndPageIds);
      listVisible = createVisibleLists(report[1].surveyId[0].questionAndPageIds);
      listController = createTextEditingControllerLists(report[1].surveyId[0].questionAndPageIds);
      int i = 0;
      addTableRow(report[1].surveyId[0].questionAndPageIds, listTable, i);
      List<List<Controller>> listCtrlTable = createTECTBLists(listTable);
      listControllerTable.addAll(listCtrlTable);
      for (int i = 0; i < report[0].listMonitoringVisitType.length; i++) {
        listSelectedInspector.add(Select(i,
            report[0].listMonitoringVisitType[i].type == report[0].monitoringVisitType ? true : false,
            report[0].listMonitoringVisitType[i].value,
            type: report[0].listMonitoringVisitType[i].type));
      }
      int indexFarmer = report[0].listFarmers.indexWhere((element) => element.id == report[0].farmerId);
      int indexInspector = report[0].listInternalInspector.indexWhere((element) => element.id == report[0].internalInspectorId);
      int indexFarm = -1;
      if(indexFarmer != -1){
        indexFarm = report[0].listFarmers[indexFarmer].farmIds.indexWhere((element) => element.id == report[0].farmId);
      }
      state.farmerInspector!.farmer_id = report[0].farmerId;
      state.farmerInspector!.farm_id = report[0].farmId;
      state.farmerInspector!.internal_inspector_id = report[0].internalInspectorId;
      state.farmerInspector!.monitoring_visit_type = report[0].monitoringVisitType;
      state.farmerInspector!.visit_date = report[0].visitDate;
      print("HoangCV:state.farmerInspector!.visit_date: ${state.farmerInspector!.toJson()} : ${report[0].visitDate}");
      emitter(state.copyWith(
        listFarmer: report[0].listFarmers,
        listInspector: report[0].listInternalInspector,
        listFarm: indexFarmer != -1 ? report[0].listFarmers[indexFarmer].farmIds : [],
        farmerInspector: state.farmerInspector,
        indexFarmer: indexFarmer,
        indexInspector: indexInspector,
        indexFarm: indexFarm,
        idFarmerController: TextEditingController(text: "${report[0].farmerId == -1 ? "" : report[0].farmerId}"),
        startTimeController: TextEditingController(
            text: Utils.formatDate(report[0].visitDate ?? "")),
      ));
      _initViewDetail(emitter);
    }
    emitter(state.copyWith(
      isShowProgress: false,
      listReport: report[1].surveyId,
      listSelected: listSelected,
      listVisible: listVisible,
      listController: listController,
      listControllerTable: listControllerTable,
      listTable: listTable,
      listSelectedInspector: listSelectedInspector,
      listInputModel: listInputModel,
    ));
  }

  void addTableRow(List<dynamic> items, List<TableQuestion> listTable, int id) {
    for (dynamic item in items) {
      if (item is Question) {
        if (item.questionType == 'table') {
          List<Question> list = [];
          if(item.userInputLines.isNotEmpty) {
            for (RowLine row in item.userInputLines) {
              List<Answer> listAs = [];
              for (Answer answer in row.userInputLineId) {
                Answer clonedAnswer = Answer.copy(answer);
                clonedAnswer.id = clonedAnswer.suggestedAnswerId;
                if (clonedAnswer.tableRowId == null || clonedAnswer.tableRowId == -1) {
                  clonedAnswer.tableRowId = row.rowId;
                  clonedAnswer.rowId = row.rowId;
                }
                List<Answer> las = [];
                for (Answer as in clonedAnswer.suggestedAnswerIds) {
                  Answer clonedAs = Answer.copy(as);
                  clonedAs.id = clonedAs.suggestedAnswerId;
                  if (clonedAs.tableRowId == null || clonedAs.tableRowId == -1) {
                    clonedAs.tableRowId = row.rowId;
                    clonedAs.rowId = row.rowId;
                  }
                  las.add(clonedAs);
                }
                if (clonedAnswer.suggestedAnswerIds.isNotEmpty) {
                  clonedAnswer.suggestedAnswerIds = las;
                }
                listAs.add(clonedAnswer);
              }
              Question qs = Question.copy(item);
              qs.suggestedAnswerIds = listAs;
              qs.rowId = row.rowId;
              id++;
              list.add(qs);
            }
          } else{
            for (int i = 0; i < 3; i++) {
              List<Answer> listAs = [];
              for (Answer answer in item.suggestedAnswerIds) {
                Answer clonedAnswer = Answer.copy(answer);
                clonedAnswer.tableRowId = id;
                List<Answer> las = [];
                for (Answer as in clonedAnswer.suggestedAnswerIds) {
                  Answer clonedAs = Answer.copy(as);
                  clonedAs.tableRowId = id;
                  las.add(clonedAs);
                }
                if (clonedAnswer.suggestedAnswerIds.isNotEmpty) {
                  clonedAnswer.suggestedAnswerIds = las;
                }
                listAs.add(clonedAnswer);
              }
              Question qs = Question.copy(item);
              qs.suggestedAnswerIds = listAs;
              qs.rowId = id;
              id++;
              list.add(qs);
            }
          }
          listTable.add(TableQuestion(item.id!, item.title!, list));
        }
      }
      id = 0;
    }

    // Gọi đệ quy sau khi xử lý toàn bộ danh sách items
    for (dynamic item in items) {
      if (item is Question) {
        addTableRow(item.questionAndPageIds, listTable, id);
      }
    }
  }

  List<List<Select>> createSelectLists(List<Question> questions) {
    List<List<Select>> selectLists = [];

    for (Question question in questions) {
      List<Select> selectList = [];

      // Thêm Select cho câu hỏi cha
      selectList.add(Select(question.idSelected!, question.checkResult ?? false, question.title!));

      // Gọi hàm đệ quy để thêm Select cho câu hỏi và câu trả lời con
      initSelectValues(question, selectList);

      selectLists.add(selectList);
    }

    return selectLists;
  }

  void initSelectValues(dynamic item, List<Select> selectList) {
    if (item is Question) {
      // Gọi hàm đệ quy cho danh sách câu trả lời con
      for (Answer answer in item.suggestedAnswerIds) {
        List<int> selectedIdsList = item.suggestedAnswerIds.map((answer) => answer.idSelected!).toList();
        List<int> selectedIdsListSub = answer.questionAndPageIds.map((qs) => qs.idSelected!).toList();
        /*print(
            "HoangCV: Question:1 ${item.title} : ${item.questionType} : ${answer.value} : ${answer.idSelected} : ${answer.checkResult}");
        */selectList.add(Select(answer.idSelected!, answer.checkResult ?? false,
            answer.value!, listId: selectedIdsList,
            listSubId: selectedIdsListSub, type: item.questionType ?? '')); // Thêm Select cho câu trả lời con
        initSelectValues(answer, selectList);
      }

      // Gọi hàm đệ quy cho danh sách câu hỏi con
      for (Question childQuestion in item.questionAndPageIds) {
        /*print(
            "HoangCV: childQuestion:1 ${item.title} : ${childQuestion.title} : ${childQuestion.idSelected} : ${childQuestion.checkResult}");
        */selectList.add(Select(childQuestion.idSelected!, childQuestion.checkResult ?? false,
            childQuestion.title!, listId: [], listSubId: [])); // Thêm Select cho câu hỏi con
        initSelectValues(childQuestion, selectList);
      }
    } else if (item is Answer) {
      // Gọi hàm đệ quy cho danh sách câu hỏi con của câu trả lời con
      for (Question childQuestion in item.questionAndPageIds) {
        //   List<int> selectedIdsList = item.questionAndPageIds.map((answer) => answer.idSelected!).toList();
        /*print(
            "HoangCV: childQuestion: ${item.value} : ${childQuestion.title} : ${childQuestion.idSelected} : ${childQuestion.checkResult}");
        */selectList.add(Select(
            childQuestion.idSelected!,
            childQuestion.checkResult ?? false,
            childQuestion
                .title!, /*listId: selectedIdsList*/ parentId: item.idSelected!)); // Thêm Select cho câu hỏi con của câu trả lời con
        initSelectValues(childQuestion, selectList);
      }

      // Gọi hàm đệ quy cho danh sách câu trả lời con của câu trả lời con
      for (Answer childAnswer in item.suggestedAnswerIds) {
        /*print(
            "HoangCV: childAnswer: ${item.value} : ${childAnswer.value} : ${childAnswer.idSelected} : ${childAnswer.checkResult} : ${childAnswer.valueRowTable}");
        */selectList.add(Select(
            childAnswer.idSelected!,
            childAnswer.checkResult ?? false,
            childAnswer
                .value!)); // Thêm Select cho câu trả lời con của câu trả lời con
        initSelectValues(childAnswer, selectList);
      }
    }
  }

  List<List<ListInputModel>> createInputLists(List<Question> questions) {
    List<List<ListInputModel>> selectLists = [];

    for (Question question in questions) {
      List<ListInputModel> selectList = [];

      // Thêm Select cho câu hỏi cha
      if(question.questionType == 'date' || question.questionType == 'datetime' ) {
        InputRegisterModel inputRegisterModel;
        print("HoangCV: question.valueResult: ${question.valueResult} : ${question.title}");
        if(question.valueResult != null) {
          inputRegisterModel = InputRegisterModel<String, DateTime>(
              title: "",
              isCompulsory: false,
              typeInputEnum: TypeInputEnum.date,
              type: TypeInputRegister.Select,
              valueSelected: Utils.formatStringToDate(question.valueResult!),
              //controller: state.startTimeController,
              noBorder: true,
              textAlign: TextAlign.left
            //icon: Icons.calendar_today
          );
        } else{
          inputRegisterModel = InputRegisterModel<String, DateTime>(
              title: "",
              isCompulsory: false,
              typeInputEnum: TypeInputEnum.date,
              type: TypeInputRegister.Select,
              //controller: state.startTimeController,
              noBorder: true,
              textAlign: TextAlign.left
            //icon: Icons.calendar_today
          );
        }
        selectList.add(ListInputModel(question.idSelected!, inputRegisterModel, TextEditingController()));
      }

      // Gọi hàm đệ quy để thêm Select cho câu hỏi và câu trả lời con
      initInputValues(question, selectList);

      selectLists.add(selectList);
    }

    return selectLists;
  }

  void initInputValues(dynamic item, List<ListInputModel> selectList) {
    if (item is Question) {
      // Gọi hàm đệ quy cho danh sách câu trả lời con
      for (Answer answer in item.suggestedAnswerIds) {
        initInputValues(answer, selectList);
      }

      // Gọi hàm đệ quy cho danh sách câu hỏi con
      for (Question childQuestion in item.questionAndPageIds) {
        if(childQuestion.questionType == 'date' || childQuestion.questionType == 'datetime' ) {
          InputRegisterModel inputRegisterModel;
          print("HoangCV: childQuestion.valueResult: ${childQuestion.valueResult}");
          if(childQuestion.valueResult != null){
            inputRegisterModel = InputRegisterModel<String, DateTime>(
                title: "",
                isCompulsory: false,
                typeInputEnum: TypeInputEnum.date,
                type: TypeInputRegister.Select,
                valueSelected: Utils.formatStringToDate(childQuestion.valueResult!),
                //controller: state.startTimeController,
                noBorder: true,
                textAlign: TextAlign.left
              //icon: Icons.calendar_today
            );
          } else{
            inputRegisterModel = InputRegisterModel<String, DateTime>(
                title: "",
                isCompulsory: false,
                typeInputEnum: TypeInputEnum.date,
                type: TypeInputRegister.Select,
                //valueSelected: Utils.formatStringToDate(childQuestion.valueResult!),
                //controller: state.startTimeController,
                noBorder: true,
                textAlign: TextAlign.left
              //icon: Icons.calendar_today
            );
          }
          selectList.add(ListInputModel(childQuestion.idSelected!, inputRegisterModel, TextEditingController()));
        }
        initInputValues(childQuestion, selectList);
      }
    }
    else if (item is Answer) {
      // Gọi hàm đệ quy cho danh sách câu hỏi con của câu trả lời con
      for (Question childQuestion in item.questionAndPageIds) {
        if(childQuestion.questionType == 'date' || childQuestion.questionType == 'datetime' ) {
          InputRegisterModel inputRegisterModel;
          print("HoangCV: childQuestion.valueResult: ${childQuestion.valueResult}");
          if(childQuestion.valueResult != null){
            inputRegisterModel = InputRegisterModel<String, DateTime>(
                title: "",
                isCompulsory: false,
                typeInputEnum: TypeInputEnum.date,
                type: TypeInputRegister.Select,
                valueSelected: Utils.formatStringToDate(childQuestion.valueResult!),
                //controller: state.startTimeController,
                noBorder: true,
                textAlign: TextAlign.left
              //icon: Icons.calendar_today
            );
          } else{
            inputRegisterModel = InputRegisterModel<String, DateTime>(
                title: "",
                isCompulsory: false,
                typeInputEnum: TypeInputEnum.date,
                type: TypeInputRegister.Select,
                //valueSelected: Utils.formatStringToDate(childQuestion.valueResult!),
                //controller: state.startTimeController,
                noBorder: true,
                textAlign: TextAlign.left
              //icon: Icons.calendar_today
            );
          }
          selectList.add(ListInputModel(childQuestion.idSelected!, inputRegisterModel, TextEditingController()));
        }
        initInputValues(childQuestion, selectList);
      }

      // Gọi hàm đệ quy cho danh sách câu trả lời con của câu trả lời con
      for (Answer childAnswer in item.suggestedAnswerIds) {
        initInputValues(childAnswer, selectList);
      }
    }
  }

  List<List<Visible>> createVisibleLists(List<Question> questions) {
    List<List<Visible>> visibleLists = [];

    for (Question question in questions) {
      List<Visible> visibleList = [];

      // Thêm Select cho câu hỏi cha
      visibleList.add(Visible(question.idSelected!, false, question.title!));

      // Gọi hàm đệ quy để thêm Select cho câu hỏi và câu trả lời con
      initVisibleValues(question, visibleList);

      visibleLists.add(visibleList);
    }

    return visibleLists;
  }

  void initVisibleValues(dynamic item, List<Visible> selectList) {
    if (item is Question || item is Answer) {
      for (Answer childAnswer in item.suggestedAnswerIds) {
        //print("HoangCV: Visible: ${item.title} : ${childAnswer.value} : ${childAnswer.idSelected}");
        selectList.add(Visible(childAnswer.idSelected!, false, childAnswer.value!));
        initVisibleValues(childAnswer, selectList);
      }

      for (Question childQuestion in item.questionAndPageIds) {
        //print("HoangCV: Visible: ${item.title} : ${childQuestion.title} : ${childQuestion.idSelected}");
        selectList.add(Visible(childQuestion.idSelected!, false, childQuestion.title!));
        initVisibleValues(childQuestion, selectList);
      }
    }
  }
  List<List<Controller>> createTextEditingControllerLists(
      List<Question> questions) {
    final List<List<Controller>> textEditingControllerLists = [];

    for (Question question in questions) {
      final List<Controller> textEditingControllerList = [];

      // Thêm TextEditingController cho câu hỏi cha
      textEditingControllerList.add(Controller(question.idSelected!, TextEditingController(text: question.valueResult ?? ''), checkQuestionType(question.questionType ?? ''), question.title!));

      // Gọi hàm đệ quy để thêm TextEditingController cho câu hỏi và câu trả lời con
      initTextControllers(question, textEditingControllerList);

      textEditingControllerLists.add(textEditingControllerList);
    }

    return textEditingControllerLists;
  }

  List<List<Controller>> createTECTBLists(
      List<TableQuestion> tableQs) {
    final List<List<Controller>> textEditingControllerLists = [];
    tableQs.forEach((questions) {
      for (Question question in questions.listQuestion) {
        final List<Controller> textEditingControllerList = [];

        // Thêm TextEditingController cho câu hỏi cha
        textEditingControllerList.add(Controller(question.idSelected!, TextEditingController(),
            checkQuestionType(question.questionType ?? ''), question.title!));

        // Gọi hàm đệ quy để thêm TextEditingController cho câu hỏi và câu trả lời con
        initTextControllersTable(question, textEditingControllerList);

        textEditingControllerLists.add(textEditingControllerList);
      }
    });
    return textEditingControllerLists;
  }

  void initTextControllers(dynamic item, List<Controller> textEditingControllerList) {
    if (item is Question || item is Answer) {
      for (Question childQuestion in item.questionAndPageIds) {
        textEditingControllerList.add(
            Controller(childQuestion.idSelected!, TextEditingController(text: childQuestion.valueResult ?? ''),
                checkQuestionType(childQuestion.questionType ?? ''), childQuestion.title!));
        initTextControllers(childQuestion, textEditingControllerList);
      }

      for (Answer childAnswer in item.suggestedAnswerIds) {
        textEditingControllerList.add(
            Controller(childAnswer.idSelected!, TextEditingController(text: childAnswer.valueResult ?? ''),
                checkQuestionType(childAnswer.commentAnswer == true ? '' : ''), childAnswer.value!,
                idRow: childAnswer.tableRowId));
        if(item is Question && item.questionType == 'table'){
          //print("HoangCV: qs table: ${childAnswer.value} : ${childAnswer.rowId} : ${childAnswer.idSelected}");
        }
        /*if(item is Question && item.questionType == 'table'){
          print("HoangCV: qs table: ${item.rowId} : ${item.idSelected}");
        }*/
        initTextControllers(childAnswer, textEditingControllerList);
      }
    }
  }
  void initTextControllersTable(dynamic item, List<Controller> textEditingControllerList) {
    if (item is Question || item is Answer) {
      //print("HoangCV: initTextControllersTable: ${item.rowId} : ${item.idSelected} : ${item is Answer ? item.valueRowTable : ''}");
      for (Question childQuestion in item.questionAndPageIds) {
        textEditingControllerList.add(
            Controller(childQuestion.idSelected!, TextEditingController(),
                checkQuestionType(childQuestion.questionType ?? ''), childQuestion.title!));
        initTextControllersTable(childQuestion, textEditingControllerList);
      }

      for (Answer childAnswer in item.suggestedAnswerIds) {
        print("HoangCV: childAnswer: ${childAnswer.tableRowId} : ${childAnswer.valueRowTable} : ${childAnswer.value}");
        textEditingControllerList.add(
            Controller(childAnswer.idSelected!, TextEditingController(text: childAnswer.valueRowTable ?? ''),
                checkQuestionType(childAnswer.commentAnswer == true ? '' : ''), childAnswer.value!,
                idRow: childAnswer.tableRowId, title: childAnswer.value,
                constrMandatory: childAnswer.constrMandatory));
        initTextControllersTable(childAnswer, textEditingControllerList);
      }
    }
  }
  String checkQuestionType(String type){
    switch(type){
      case 'numerical_box':
        return 'number';
        break;
      default:
        return 'text';
        break;
    }
  }

}

class DetailReportEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetDetailReportEvent extends DetailReportEvent {
  final int id;

  GetDetailReportEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class DetailReportState extends BlocState {
  @override
  List<Object?> get props => [
    detailDiary,
    formStatus,
    isShowProgress,
    listReport,
    listSelected,
    listController,
    reportId,
    listVisible,
    listTable,
    listControllerTable,
    listSelectedInspector,
    listWidget,
    listFarmer,
    listInspector,
    listFarm,
    startTimeController,
    idFarmerController,
    inspectorController,
    farmerController,
    farmerInspector,
    nameInspector,
  ];
  final Diary? detailDiary;
  final List<Report> listReport;
  final List<List<Select>> listSelected;
  final List<Select> listSelectedInspector;
  final List<List<Controller>> listController;
  final List<List<Controller>> listControllerTable;
  final List<List<Visible>> listVisible;
  final List<TableQuestion> listTable;
  final FormSubmissionStatus formStatus;
  final List<InputRegisterModel> listWidget;
  final List<List<ListInputModel>> listInputModel;
  final List<People> listFarmer;
  final List<People> listInspector;
  final List<People> listFarm;
  TextEditingController? startTimeController = TextEditingController();
  TextEditingController? idFarmerController = TextEditingController();
  TextEditingController? farmerController = TextEditingController();
  TextEditingController? inspectorController = TextEditingController();
  TextEditingController? farmController = TextEditingController();
  FarmerInspectorUpload? farmerInspector;
  final bool isShowProgress;
  final int? reportId;

  final int? indexFarm;
  final int? indexFarmer;
  final int? indexInspector;
  final String? nameInspector;

  DetailReportState({
    this.detailDiary,
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.listReport = const [],
    this.listSelected = const [],
    this.listController = const [],
    this.listVisible = const [],
    this.listTable = const [],
    this.listControllerTable = const [],
    this.listSelectedInspector = const [],
    this.listWidget = const [],
    this.listInputModel = const [],
    this.listFarmer = const [],
    this.listInspector = const [],
    this.listFarm = const [],
    this.startTimeController,
    this.idFarmerController,
    this.farmerController,
    this.inspectorController,
    this.farmController,
    this.farmerInspector,
    this.reportId,
    this.indexFarmer,
    this.indexFarm,
    this.indexInspector,
    this.nameInspector,
  });

  DetailReportState copyWith({
    Diary? detailDiary,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    List<Report>? listReport,
    List<List<Select>>? listSelected,
    List<List<Visible>>? listVisible,
    List<List<Controller>>? listController,
    List<TableQuestion>? listTable,
    List<List<Controller>>? listControllerTable,
    List<Select>? listSelectedInspector,
    List<InputRegisterModel>? listWidget,
    List<List<ListInputModel>>? listInputModel,
    List<People>? listFarmer,
    List<People>? listInspector,
    List<People>? listFarm,
    TextEditingController? startTimeController,
    TextEditingController? idFarmerController,
    TextEditingController? farmerController,
    TextEditingController? farmController,
    TextEditingController? inspectorController,
    FarmerInspectorUpload? farmerInspector,
    int? reportId,
    int? indexFarmer,
    int? indexFarm,
    int? indexInspector,
    String? nameInspector,

  }) {
    return DetailReportState(
        detailDiary: detailDiary ?? this.detailDiary,
        formStatus: formStatus ?? this.formStatus,
        isShowProgress: isShowProgress ?? this.isShowProgress,
        listReport: listReport ?? this.listReport,
        listSelected: listSelected ?? this.listSelected,
        listController: listController ?? this.listController,
        listVisible: listVisible ?? this.listVisible,
        listTable: listTable ?? this.listTable,
        listControllerTable: listControllerTable ?? this.listControllerTable,
        listSelectedInspector: listSelectedInspector ?? this.listSelectedInspector,
        listWidget: listWidget ?? this.listWidget,
        listInputModel: listInputModel ?? this.listInputModel,
        listFarmer: listFarmer ?? this.listFarmer,
        listFarm: listFarm ?? this.listFarm,
        listInspector: listInspector ?? this.listInspector,
        startTimeController: startTimeController ?? this.startTimeController,
        idFarmerController: idFarmerController ?? this.idFarmerController,
        farmerController: farmerController ?? this.farmerController,
        farmerInspector: farmerInspector ?? this.farmerInspector,
        inspectorController: inspectorController ?? this.inspectorController,
        farmController: farmController ?? this.farmController,
        indexFarmer: indexFarmer ?? this.indexFarmer,
        indexInspector: indexInspector ?? this.indexInspector,
        indexFarm: indexFarm ?? this.indexFarm,
        reportId: reportId ?? this.reportId,
        nameInspector: nameInspector ?? this.nameInspector);
  }
}

class ListInputModel {
  int id;
  InputRegisterModel inputModel;
  TextEditingController controller;

  ListInputModel(this.id, this.inputModel, this.controller);
}