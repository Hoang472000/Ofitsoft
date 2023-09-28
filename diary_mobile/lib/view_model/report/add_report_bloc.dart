import 'dart:async';

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

class AddReportBloc extends Bloc<AddReportEvent, AddReportState> {
  final Repository repository;

  AddReportBloc(this.repository) : super(AddReportState()) {
    on<GetAddReportEvent>(_getAddReport);
    on<OnSelectValueEvent>(_onSelectValue);
    on<UpdateAddReportEvent>(updateAddReport);
    on<UpdateAddTableEvent>(updateAddTable);
    on<UpdateFarmerInspectorEvent>(updateFarmerInspector);
    on<SubmitReportEvent>(submitReport);
  }

  void _initViewAdd(Emitter<AddReportState> emitter) {
    List<InputRegisterModel> list= [];
    print("HoangCV: state.listFarmer : ${state.listFarmer.length}");
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

    list.add(InputRegisterModel(
        title: "",
        isCompulsory: false,
        type: TypeInputRegister.Non,
        controller: state.idFarmerController,
        noBorder: true,
        textAlign: TextAlign.center
    ));

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

    list.add(InputRegisterModel<String, DateTime>(
        title: "",
        isCompulsory: true,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Select,
        valueSelected: DateTime.now(),
        controller: state.startTimeController,
        noBorder: true,
        textAlign: TextAlign.center
        //icon: Icons.calendar_today
    ));

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

    emitter(state.copyWith(
        listWidget: list,
        formStatus: const InitialFormStatus()));
  }

  Future<FutureOr<void>> _onSelectValue(
      OnSelectValueEvent event, Emitter<AddReportState> emit) async {
    int result;
    bool checkPass = true;
    print("HoangCV: state.listFarm: ${state.listFarm}");
    if(event.index == 0 && state.listFarmer.isEmpty) {
      Toast.showLongTop("Không có danh sách nông hộ");
      checkPass = false;
    }else if(event.index == 4 && state.listFarm.isEmpty) {
      Toast.showLongTop("Không có danh sách vùng trồng");
      checkPass = false;
    }else if(event.index == 2 && state.listInspector.isEmpty) {
      Toast.showLongTop("Không có danh sách thanh tra viên");
      checkPass = false;
    }
    if(checkPass) {
      if (event.list[event.index].valueSelected.runtimeType == DateTime ||
          event.list[event.index].typeInputEnum == TypeInputEnum.date) {
        //     setState(() {
        int result1 = await ServiceInfoExtension()
            .selectValue(
            event.list[event.index], event.context, (modelInput) {});
        if (result1 == 1) {
          state.farmerInspector!.visit_date = Utils.formatDateTimeToString(
              event.list[event.index].valueSelected);
          emit(state.copyWith(
            startTimeController: TextEditingController(
                text: Utils.formatDateTimeToString(
                    event.list[event.index].valueSelected)),
            farmerInspector: state.farmerInspector,
          ));
        }
      } else {
        print("HoangCV: event.list[event.index].listValue: ${event.index} : ${event.list[event.index].toString()} : ${event.list[event.index].listValue.length} ");
        result = await Extension().showBottomSheetSelection(
            event.context,
            event.list[event.index].listValue,
            event.list[event.index].positionSelected,
            "${event.list[event.index].title}",
            hasSearch: event.list[event.index].hasSearch ?? false);
        if (result != -1) {
          //   setState(() {
          event.list[event.index].positionSelected = result;
          event.list[event.index].valueDefault = null;
          event.list[event.index].valueSelected =
          event.list[event.index].listValue[result];
          event.list[event.index].error = null;
          // });

          if (event.index == 0) {
            event.list[1].controller = TextEditingController(text: "${state.listFarmer[result].id}");
            state.farmerInspector!.farmer_id = state.listFarmer[result].id;
            state.farmerInspector!.farmer_code = state.listFarmer[result].code;
            state.farmerInspector!.farm_id = null;
            state.farmerInspector!.farm_code = null;
            state.listWidget[4].listValue = state.listFarmer[result].farmIds;
            state.listWidget[4].valueSelected = null;
            state.listWidget[4].positionSelected = -1;
            emit(state.copyWith(
            idFarmerController: TextEditingController(text: "${state.listFarmer[result].id}"),
            farmerInspector: state.farmerInspector,
            listFarm: state.listFarmer[result].farmIds,
            ));
          } else if (event.index == 2) {
            state.farmerInspector!.internal_inspector_id = state.listInspector[result].id;
            emit(state.copyWith(
              farmerInspector: state.farmerInspector,
            ));
            print("HoangCV: state.farmerInspector!.internal_inspector_id : ${ state.farmerInspector!.internal_inspector_id} ");
          } else if (event.index == 4) {
            state.farmerInspector!.farm_id = state.listFarm[result].id;
            state.farmerInspector!.farm_code = state.listFarm[result].code;
            emit(state.copyWith(
              farmerInspector: state.farmerInspector,
            ));
            print("HoangCV: state.farmerInspector!.internal_inspector_id : ${ state.farmerInspector!.internal_inspector_id} ");
          }
          if(state.reportId != null ){
            emit(state.copyWith(
                isShowProgress: true, formStatus: const InitialFormStatus()));

            FarmerInspectorUpload  questionUpload = FarmerInspectorUpload(
              id: state.reportId,
              farmer_id: state.farmerInspector!.farmer_id,
              farm_id: state.farmerInspector!.farm_id,
              farm_code: state.farmerInspector!.farm_code,
              farmer_code: state.farmerInspector!.farmer_code,
              internal_inspector_id: state.farmerInspector!.internal_inspector_id,
              monitoring_visit_type: state.farmerInspector!.monitoring_visit_type,
              visit_date: state.farmerInspector!.visit_date,
            );
            ObjectResult result = await repository.editFarmerInspector(questionUpload);
            if (result.responseCode == StatusConst.code00) {
              emit(state.copyWith(
                  isShowProgress: false,
                  reportId: result.response is int ? result.response : null,
                  formStatus: SubmissionSuccess(/*success: result.message*/)));
            } else {
              emit(state.copyWith(
                  isShowProgress: false, formStatus: SubmissionFailed(result.message)));
            }
          }
        }
      }
    }
  }

  void _getAddReport(
      GetAddReportEvent event, Emitter<AddReportState> emitter) async {
    emitter(state.copyWith(
      isShowProgress: true,
      startTimeController: TextEditingController(
          text: DateTime.now().toString() /*.split('.')[0]*/),
      idFarmerController: TextEditingController(text: ''),
      farmerInspector: FarmerInspectorUpload(visit_date: DateTime.now().toString().split('.')[0]),
    ));
    final report = await repository.getListActivityReport(event.id);
    List<List<Select>> listSelected = [];
    List<Select> listSelectedInspector = [];
    List<List<Visible>> listVisible = [];
    List<List<Controller>> listController = [];
    List<List<Controller>> listControllerTable = [];
    List<TableQuestion> listTable = [];
    List<People> listFarmer = [];
    List<People> listInspector = [];
    if (report.isNotEmpty) {
      listSelected = createSelectLists(report[1].questionAndPageIds);
      listVisible = createVisibleLists(report[1].questionAndPageIds);
      listController = createTextEditingControllerLists(report[1].questionAndPageIds);
/*      listSelected.forEach((element) {
        print("HoangCV:listSelected:  ${element.length} : ${element[0].id}");
      });
      listController.forEach((element) {
        print("HoangCV:listController:  ${element.length} : ${element[0].id}");
      });*/
      int i = 0;
      addTableRow(report[1].questionAndPageIds, listTable, i);
/*      listTable.forEach((element) {
        print("HoangCV:listTable:  ${listTable.toString()}");
        element.listQuestion.forEach((e) {
          print("HoangCV:listTable e:  ${element.listQuestion.toString()}");
          e.suggestedAnswerIds.forEach((el){
            print("HoangCV:listQuestion:  ${el.toString()} : ${el.rowId}");
          });
        });
      });*/
      List<List<Controller>> listCtrlTable = createTECTBLists(listTable);
      listControllerTable.addAll(listCtrlTable);
      for (int i = 0; i < report[0].listMonitoringVisitType.length; i++) {
        listSelectedInspector.add(Select(
            i, false, report[0].listMonitoringVisitType[i].value,
            type: report[0].listMonitoringVisitType[i].type));
      }

      emitter(state.copyWith(
        listFarmer: report[0].listFarmers,
        listInspector: report[0].listInternalInspector,
        listFarm: [],
      ));
      _initViewAdd(emitter);
    }
    emitter(state.copyWith(
      isShowProgress: false,
      listReport: report,
      listSelected: listSelected,
      listVisible: listVisible,
      listController: listController,
      listControllerTable: listControllerTable,
      listTable: listTable,
      listSelectedInspector: listSelectedInspector,
    ));
/*    state.listControllerTable.forEach((element) {
      element.forEach((e) {
        print("HoangCV:listController:  ${e.toJson()}");
      });
    });*/
  }

  void addTableRow(List<dynamic> items, List<TableQuestion> listTable, int id) {
    for (dynamic item in items) {
      if (item is Question) {
        if (item.questionType == 'table') {
          List<Question> list = [];
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
      selectList.add(Select(question.idSelected!, false, question.title!));

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
            "HoangCV: Question:1 ${item.title} : ${item.questionType} : ${answer.value} : ${answer.idSelected} : ${selectedIdsList.toString()}");
        */selectList.add(Select(answer.idSelected!, false,
            answer.value!, listId: selectedIdsList,
        listSubId: selectedIdsListSub, type: item.questionType ?? '')); // Thêm Select cho câu trả lời con
        initSelectValues(answer, selectList);
      }

      // Gọi hàm đệ quy cho danh sách câu hỏi con
      for (Question childQuestion in item.questionAndPageIds) {
/*        print(
            "HoangCV: childQuestion:1 ${item.title} : ${childQuestion.title} : ${childQuestion.idSelected}");*/
        selectList.add(Select(childQuestion.idSelected!, false,
            childQuestion.title!, listId: [], listSubId: [])); // Thêm Select cho câu hỏi con
        initSelectValues(childQuestion, selectList);
      }
    } else if (item is Answer) {
      // Gọi hàm đệ quy cho danh sách câu hỏi con của câu trả lời con
      for (Question childQuestion in item.questionAndPageIds) {
     /*   List<int> selectedIdsList = item.questionAndPageIds.map((answer) => answer.idSelected!).toList();
        print(
            "HoangCV: childQuestion: ${item.value} : ${childQuestion.title} : ${childQuestion.idSelected} : ${selectedIdsList.toString()}");
       */ selectList.add(Select(
            childQuestion.idSelected!,
            false,
            childQuestion
                .title!, /*listId: selectedIdsList*/parentId: item.idSelected!)); // Thêm Select cho câu hỏi con của câu trả lời con
        initSelectValues(childQuestion, selectList);
      }

      // Gọi hàm đệ quy cho danh sách câu trả lời con của câu trả lời con
      for (Answer childAnswer in item.suggestedAnswerIds) {
     /*   print(
            "HoangCV: childAnswer: ${item.value} : ${childAnswer.value} : ${childAnswer.idSelected}");*/
        selectList.add(Select(
            childAnswer.idSelected!,
            false,
            childAnswer
                .value!)); // Thêm Select cho câu trả lời con của câu trả lời con
        initSelectValues(childAnswer, selectList);
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
      textEditingControllerList.add(Controller(question.idSelected!, TextEditingController(), checkQuestionType(question.questionType ?? ''), question.title!));

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
        textEditingControllerList.add(Controller(question.idSelected!, TextEditingController(), checkQuestionType(question.questionType ?? ''), question.title!));

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
            Controller(childQuestion.idSelected!, TextEditingController(), checkQuestionType(childQuestion.questionType ?? ''), childQuestion.title!));
        initTextControllers(childQuestion, textEditingControllerList);
      }

      for (Answer childAnswer in item.suggestedAnswerIds) {
        textEditingControllerList.add(
            Controller(childAnswer.idSelected!, TextEditingController(),
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
        //print("HoangCV: initTextControllersTable: ${item.rowId} : ${item.idSelected}");
      for (Question childQuestion in item.questionAndPageIds) {
        textEditingControllerList.add(
            Controller(childQuestion.idSelected!, TextEditingController(),
                checkQuestionType(childQuestion.questionType ?? ''), childQuestion.title!));
        initTextControllers(childQuestion, textEditingControllerList);
      }

      for (Answer childAnswer in item.suggestedAnswerIds) {
        //print("HoangCV: childAnswer: ${childAnswer.rowId} : ${childAnswer.idSelected} : ${childAnswer.value}");
        textEditingControllerList.add(
            Controller(childAnswer.idSelected!, TextEditingController(),
                checkQuestionType(childAnswer.commentAnswer == true ? '' : ''), childAnswer.value!,
                idRow: childAnswer.tableRowId));
        initTextControllers(childAnswer, textEditingControllerList);
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

/*  List<dynamic> findQuestionAndAnswerById(List<Question> questions, int id, List<int> listIdSuggested) {
    for (Question question in questions) {
      if (question.idSelected == id) {
        return [question, null, listIdSuggested];
      }
      if (question.suggestedAnswerIds.isNotEmpty) {
        for (Answer answer in question.suggestedAnswerIds) {
          if (answer.idSelected == id) {
            return [question, answer, listIdSuggested];
          }
          if (answer.questionAndPageIds.isNotEmpty) {
            List<dynamic> nested = findQuestionAndAnswerById(answer.questionAndPageIds, id, listIdSuggested);
            if (nested[0] != null) {
              return nested;
            }
          }
          if (question.questionType == 'simple_choice') {
            print("HoangCV: simple_choice: ${question.questionAndPageIds.length}: ${question.title}");
            listIdSuggested = question.questionAndPageIds.map((item) => item.id ?? -1).toList();
          }
        }
      }
      if (question.questionAndPageIds.isNotEmpty) {
        List<dynamic> nested = findQuestionAndAnswerById(question.questionAndPageIds, id, listIdSuggested);
        if (nested[0] != null) {
          return nested;
        }
      }
    }
    return [null, null, listIdSuggested];
  }*/

  List<dynamic> findQuestionAndAnswerById(List<Question> questions, int id, List<int> listIdSuggested, String answerType) {
    Question question = Question();
    Answer answer = Answer();

    for (Question q in questions) {
      if (q.idSelected == id) {
        question = Question.copy(q);
        answerType = question.questionType ?? "";
        if (answerType == 'simple_choice') {
          listIdSuggested = questions.map((item) => item.id ?? -1).toList();
        }
        return [question, answer, listIdSuggested, answerType];
      }

      if (q.suggestedAnswerIds.isNotEmpty) {
        for (Answer a in q.suggestedAnswerIds) {
          if (a.idSelected == id) {
            question = Question.copy(q);
            answer = Answer.copy(a);
            answerType = question.questionType ?? "";
            return [question, answer, listIdSuggested, answerType];
          }

          if (a.questionAndPageIds.isNotEmpty) {
            List<dynamic> nestedResult = findQuestionAndAnswerById(a.questionAndPageIds, id, listIdSuggested, answerType);
            question = nestedResult[0] ?? Question();
            answer = nestedResult[1] ?? Answer();
            listIdSuggested = nestedResult[2];
            answerType = nestedResult[3];
            return [question, answer, listIdSuggested, answerType];
          }
        }
      }

      if (q.questionAndPageIds.isNotEmpty) {
        List<dynamic> nestedResult = findQuestionAndAnswerById(q.questionAndPageIds, id, listIdSuggested, answerType);
        question = nestedResult[0];
        answer = nestedResult[1];
        listIdSuggested = nestedResult[2];
        answerType = nestedResult[3];
        return [question, answer, listIdSuggested, answerType];
      }
    }
    return [null, null, listIdSuggested, answerType];
  }

  Future<FutureOr<void>> updateAddReport(
      UpdateAddReportEvent event, Emitter<AddReportState> emit) async {
    emit(state.copyWith(
        isShowProgress: true, formStatus: const InitialFormStatus()));
    print("HoanghCV123213412");
    Question question = Question();
    Answer answer = Answer();
    List<int> listIdSuggested = [];
    String answerType = '';
    bool hasCommandAnswer = false;
    List<Question> listQs = state.listReport[1].questionAndPageIds;
    for (int i = 0; i < listQs.length; i++) {
      //print("HoangCV: listQs: ${listQs[i].title}");
      for (int h = 0; h < listQs[i].questionAndPageIds.length; h++) {
        //print("HoangCV: listQs[i].questionAndPageIds: ${listQs[i].questionAndPageIds[h].title} : ${listQs[i].questionAndPageIds[h].idSelected} : ${event.id}");
        if (listQs[i].questionAndPageIds[h].idSelected == event.id) {
          question = Question.copy(listQs[i].questionAndPageIds[h]);
          answerType = question.questionType ?? "";
          if(answerType == 'simple_choice'){
            listIdSuggested = listQs[i].questionAndPageIds.map((item) => item.id ?? -1).toList();
          }
        } else {
          for (int j = 0;
              j < listQs[i].questionAndPageIds[h].suggestedAnswerIds.length;
              j++) {
            for (int k = 0;
                k < listQs[i].questionAndPageIds[h].suggestedAnswerIds[j].questionAndPageIds.length;
                k++) {
              if (listQs[i].questionAndPageIds[h].suggestedAnswerIds[j].questionAndPageIds[k].idSelected == event.id) {
                question = Question.copy(
                    listQs[i].questionAndPageIds[h].suggestedAnswerIds[j].questionAndPageIds[k]);
                answerType = question.questionType ?? "";
                if(question.commentAnswer == true){
                  hasCommandAnswer = true;
                }
                /*answer = Answer.copy(
                    listQs[i].questionAndPageIds[h].suggestedAnswerIds[j]);*/
              }
            }
            if (listQs[i].questionAndPageIds[h].suggestedAnswerIds[j].idSelected ==event.id) {
              question = Question.copy(listQs[i].questionAndPageIds[h]);
              answer = Answer.copy(
                  listQs[i].questionAndPageIds[h].suggestedAnswerIds[j]);
              if(answer.commentAnswer == true){
                hasCommandAnswer = true;
              }
              answerType = question.questionType ?? "";
              if(answerType == 'simple_choice'){
                listIdSuggested = listQs[i].questionAndPageIds[h].suggestedAnswerIds.map((item) => item.id ?? -1).toList();
              }
            }
          }
          for (int l = 0;
              l < listQs[i].questionAndPageIds[h].questionAndPageIds.length;
              l++) {
            //print("HoangCV: listQs[i].questionAndPageIds,questionAndPageIds: ${listQs[i].questionAndPageIds[h].questionAndPageIds[l].title} :"
            //    " ${listQs[i].questionAndPageIds[h].questionAndPageIds[l].idSelected} : ${event.id}");
            if (listQs[i].questionAndPageIds[h].questionAndPageIds[l].idSelected == event.id) {
              question = Question.copy(
                  listQs[i].questionAndPageIds[h].questionAndPageIds[l]);
              answerType = question.questionType ?? "";
              if(question.commentAnswer == true){
                hasCommandAnswer = true;
              }
            } else{
              for (int m = 0;
              m < listQs[i].questionAndPageIds[h].questionAndPageIds[l].suggestedAnswerIds.length;
              m++) {
                  if (listQs[i].questionAndPageIds[h].questionAndPageIds[l].suggestedAnswerIds[m].idSelected == event.id) {
                    question = Question.copy(
                        listQs[i].questionAndPageIds[h].questionAndPageIds[l]);
                    answerType = question.questionType ?? "";
                    answer = Answer.copy(
                        listQs[i].questionAndPageIds[h].questionAndPageIds[l].suggestedAnswerIds[m]);
                    if(answer.commentAnswer == true){
                      hasCommandAnswer = true;
                    }
                    if(answerType == 'simple_choice'){
                      listIdSuggested = listQs[i].questionAndPageIds[h].questionAndPageIds[l].suggestedAnswerIds.map((item) => item.id ?? -1).toList();
                    }
                  }
                  for (int n = 0;
                  n < listQs[i].questionAndPageIds[h].questionAndPageIds[l].suggestedAnswerIds[m].questionAndPageIds.length;
                  n++) {
                    if (listQs[i].questionAndPageIds[h].questionAndPageIds[l].suggestedAnswerIds[m].questionAndPageIds[n].idSelected == event.id) {
                      question = Question.copy(
                          listQs[i].questionAndPageIds[h].questionAndPageIds[l].suggestedAnswerIds[m].questionAndPageIds[n]);
                      answerType = question.questionType ?? "";
                      if(question.commentAnswer == true){
                        hasCommandAnswer = true;
                      }
/*                      answer = Answer.copy(
                          listQs[i].questionAndPageIds[h].questionAndPageIds[l].suggestedAnswerIds[m]);*/
                    }
                  }
                }
              }
            }
          }
        }
      }
    //List<dynamic> resultUpload = findQuestionAndAnswerById(state.listReport[1].questionAndPageIds, event.id, listIdSuggested, answerType);
/*    findQuestionAndAnswerById(state.listReport[1].questionAndPageIds, event.id, question,
        answer, listIdSuggested, answerType);*/
/*    if (resultUpload[0] != null) {
      question = resultUpload[0];
      answer = resultUpload[1];
      answerType = question.questionType ?? "";
      listIdSuggested = resultUpload[2];
    }*/
    int index = event.listSelect.indexWhere((element) => element.id == event.id);
    int indexController = event.listController.indexWhere((element) => element.id == event.id);
    String text = indexController != -1 ? event.listController[indexController].controller.text.toString() : '';
    if(event.value != null || event.value.isNotEmpty){
      text = event.value;
    }
    QuestionUpload questionUpload;
    //print("HoangCV: question: ${question.id} : ${question.idSelected} : ${question.title} : ${answer.id} : ${answerType} : ${listIdSuggested} : $text : $index : ${event.listSelect[index].value}");
    if(answerType == "check_box" && text.isNotEmpty && index != -1 && event.listSelect[index].value == false){

    } else if(answerType == "simple_choice" && text.isNotEmpty && index != -1 && event.listSelect[index].value == false){

    } else if(answerType == "char_box" && text.isEmpty){

    } else if(answerType == "check_box" && text.isEmpty && hasCommandAnswer){

    } else if(answerType == "simple_choice" && text.isEmpty && hasCommandAnswer){

    } else {
      if (state.reportId != null) {
        questionUpload = QuestionUpload(
            user_input_id: state.reportId,
            survey_id: state.listReport[1].id,
            question_id: question.id,
            suggested_answer_id: answer.id,
            answer_type: answerType == '' ? null : answerType,
            value_text: /*event.value*/text,
            test_entry: false,
            // value default ko ro Anh Dung de lam gi
            is_answer_exist: index != -1
                ? event.listSelect[index].value
                : false,
            // value khi tich chon va bo tich chon
            //table_row_id: 1,
            list_id_suggested: listIdSuggested
        );
      } else {
        questionUpload = QuestionUpload(
          user_input_id: state.reportId,
          survey_id: state.listReport[1].id,
          question_id: question.id,
          suggested_answer_id: answer.id,
          answer_type: answerType == '' ? null : answerType,
          value_text: event.value,
          test_entry: false,
          // value default ko ro Anh Dung de lam gi
          is_answer_exist: index != -1 ? event.listSelect[index].value : false,
          // value khi tich chon va bo tich chon
          //table_row_id: 1,
          list_id_suggested: listIdSuggested,
          farmer_id: state.farmerInspector!.farmer_id,
          farmer_code: state.farmerInspector!.farmer_code,
          farm_id: state.farmerInspector!.farm_id,
          farm_code: state.farmerInspector!.farm_code,
          internal_inspector_id: state.farmerInspector!.internal_inspector_id,
          monitoring_visit_type: state.farmerInspector!.monitoring_visit_type,
          visit_date: state.farmerInspector!.visit_date,
        );
      }

      ObjectResult result = await repository.uploadQuestion(questionUpload);
      if (result.responseCode == StatusConst.code00) {
        emit(state.copyWith(
            isShowProgress: false,
            reportId: result.response is int ? result.response : null,
            formStatus: SubmissionSuccess(/*success: result.message*/)));
      } else {
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionFailed(result.message)));
      }
    }
  }

  Future<FutureOr<void>> updateAddTable(
      UpdateAddTableEvent event, Emitter<AddReportState> emit) async {
    emit(state.copyWith(
        isShowProgress: true, formStatus: const InitialFormStatus()));

    QuestionUpload questionUpload = QuestionUpload(
      user_input_id: state.reportId,
      survey_id: state.listReport[1].id,
      question_id: event.questionId,
      suggested_answer_id: event.answerId,
      answer_type: 'table',
      value_text: event.value,
      is_answer_exist: true,
      table_row_id: event.rowId + 1,
        list_id_suggested: []
    );
    ObjectResult result = await repository.uploadQuestion(questionUpload);
    if (result.responseCode == StatusConst.code00) {
      emit(state.copyWith(
          isShowProgress: false,
          reportId: result.response is int ? result.response : null,
          formStatus: SubmissionSuccess(/*success: result.message*/)));
    } else {
      emit(state.copyWith(
          isShowProgress: false, formStatus: SubmissionFailed(result.message)));
    }
  }

  Future<FutureOr<void>> updateFarmerInspector(UpdateFarmerInspectorEvent event, Emitter<AddReportState> emit) async {
    state.farmerInspector!.monitoring_visit_type = event.value;
    emit(state.copyWith(
      farmerInspector: state.farmerInspector
    ));
    if(state.reportId != null ){
      emit(state.copyWith(
          isShowProgress: true, formStatus: const InitialFormStatus()));

      FarmerInspectorUpload  questionUpload = FarmerInspectorUpload(
        id: state.reportId,
        farmer_id: state.farmerInspector!.farmer_id,
        farmer_code: state.farmerInspector!.farmer_code,
        internal_inspector_id: state.farmerInspector!.internal_inspector_id,
        monitoring_visit_type: state.farmerInspector!.monitoring_visit_type,
        visit_date: state.farmerInspector!.visit_date,
      );
      ObjectResult result = await repository.editFarmerInspector(questionUpload);
      if (result.responseCode == StatusConst.code00) {
        emit(state.copyWith(
            isShowProgress: false,
            reportId: result.response is int ? result.response : null,
            formStatus: SubmissionSuccess(/*success: result.message*/)));
      } else {
        emit(state.copyWith(
            isShowProgress: false, formStatus: SubmissionFailed(result.message)));
      }
    }
  }

  Future<FutureOr<void>> submitReport(SubmitReportEvent event, Emitter<AddReportState> emit) async {
    emit(state.copyWith(
        isShowProgress: true, formStatus: const InitialFormStatus()));

    FarmerInspectorUpload  questionUpload = FarmerInspectorUpload(
      id: state.reportId,
      state: 'done'
    );
    ObjectResult result = await repository.editFarmerInspector(questionUpload);
    if (result.responseCode == StatusConst.code00) {
      emit(state.copyWith(
          isShowProgress: false,
          reportId: result.response is int ? result.response : null,
          formStatus: SubmissionSuccess(success: result.message)));
    } else {
      emit(state.copyWith(
          isShowProgress: false, formStatus: SubmissionFailed(result.message)));
    }
  }
}

class AddReportEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetAddReportEvent extends AddReportEvent {

  final int id;

  GetAddReportEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateAddReportEvent extends AddReportEvent {
  final int id;
  final String value;
  final List<Select> listSelect;
  final List<Controller> listController;

  UpdateAddReportEvent(this.id, this.value, this.listSelect, {this.listController = const []});

  @override
  List<Object?> get props => [id, value, listSelect, listController];
}

class UpdateFarmerInspectorEvent extends AddReportEvent {
  final int id;
  final String value;
  final List<Select> listSelect;

  UpdateFarmerInspectorEvent(this.id, this.value, this.listSelect);

  @override
  List<Object?> get props => [id, value, listSelect];
}

class OnSelectValueEvent extends AddReportEvent {
  List<InputRegisterModel> list;
  int index;
  BuildContext context;

  OnSelectValueEvent(this.list, this.index, this.context);

  @override
  List<Object?> get props => [list, index, context];
}

class UpdateAddTableEvent extends AddReportEvent {
  final int questionId;
  final int answerId;
  final int rowId;
  final String value;

  UpdateAddTableEvent(this.questionId, this.answerId, this.rowId, this.value);

  @override
  List<Object?> get props => [questionId, answerId, rowId, value];
}

class SubmitReportEvent extends AddReportEvent {


  SubmitReportEvent();

  @override
  List<Object?> get props => [];
}

class AddReportState extends BlocState {
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
        farmerInspector,
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
  final List<People> listFarmer;
  final List<People> listInspector;
  final List<People> listFarm;
  TextEditingController? startTimeController = TextEditingController();
  TextEditingController? idFarmerController = TextEditingController();
  FarmerInspectorUpload? farmerInspector;
  final bool isShowProgress;
  final int? reportId;

  AddReportState({
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
    this.listFarmer = const [],
    this.listInspector = const [],
    this.listFarm = const [],
    this.startTimeController,
    this.idFarmerController,
    this.farmerInspector,
    this.reportId,
  });

  AddReportState copyWith({
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
    List<People>? listFarmer,
    List<People>? listInspector,
    List<People>? listFarm,
    TextEditingController? startTimeController,
    TextEditingController? idFarmerController,
    FarmerInspectorUpload? farmerInspector,
    int? reportId,
  }) {
    return AddReportState(
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
        listFarmer: listFarmer ?? this.listFarmer,
        listFarm: listFarm ?? this.listFarm,
        listInspector: listInspector ?? this.listInspector,
        startTimeController: startTimeController ?? this.startTimeController,
        idFarmerController: idFarmerController ?? this.idFarmerController,
        farmerInspector: farmerInspector ?? this.farmerInspector,
        reportId: reportId ?? this.reportId);
  }
}
