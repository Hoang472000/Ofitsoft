import 'dart:async';
import 'dart:ffi';

import 'package:diary_mobile/data/entity/report/question_upload.dart';
import 'package:diary_mobile/utils/constants/shared_preferences_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
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
    on<AddTableRowEvent>(addNewTableRow);
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
        textAlign: TextAlign.left
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
    }/*else if(event.index == 2 && state.listInspector.isEmpty) {
      Toast.showLongTop("Không có danh sách thanh tra viên");
      checkPass = false;
    }*/
    if(checkPass) {
      if (event.list[event.index].valueSelected.runtimeType == DateTime ||
          event.list[event.index].typeInputEnum == TypeInputEnum.date) {
        //     setState(() {
        int result1 = await ServiceInfoExtension()
            .selectValue(
            event.list[event.index], event.context, (modelInput) {});
        if (result1 == 1) {
          state.farmerInspector!.visitDate = Utils.formatDateTimeToString(
              event.list[event.index].valueSelected);
          emit(state.copyWith(
            startTimeController: TextEditingController(
                text: Utils.formatDateTimeToString(
                    event.list[event.index].valueSelected)),
            farmerInspector: state.farmerInspector,
          ));
          if(state.reportId != null ) {
            if (event.id == -1) {
              emit(state.copyWith(
                  isShowProgress: true, formStatus: const InitialFormStatus()));

              FarmerInspectorUpload questionUpload = FarmerInspectorUpload(
                idOffline: state.idOffline,
                id: state.reportId,
                farmerId: state.farmerInspector!.farmerId,
                farmId: state.farmerInspector!.farmId,
                farmCode: state.farmerInspector!.farmCode,
                farmerCode: state.farmerInspector!.farmerCode,
                internalInspectorId: state.farmerInspector!
                    .internalInspectorId,
                monitoringVisitType: state.farmerInspector!
                    .monitoringVisitType,
                visitDate: state.farmerInspector!.visitDate,
              );
              ObjectResult result = await repository.editFarmerInspector(
                  questionUpload);
              if (result.responseCode == StatusConst.code00) {
                emit(state.copyWith(
                    isShowProgress: false,
                    reportId: result.response is int ? result.response : null,
                    formStatus: SubmissionSuccess(/*success: result.message*/)));
              } else if (result.responseCode == StatusConst.code01){
                emit(state.copyWith(
                    isShowProgress: false,
                    formStatus: SubmissionFailed("Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.")));
              }
            } else{
              print("HoangCV:  uplaods asdsaj 1121");
              QuestionUpload questionUpload = QuestionUpload(
                    idOffline: state.idOffline,
                    userInputId: state.reportId,
                    surveyId: state.listReport[0].id,
                    questionId: event.id,
                    answerType: event.type,
                    valueText: Utils.stringToFormattedString(Utils.formatDateTimeToString(
                        event.list[event.index].valueSelected)),
                    listIdSuggested: [],
                    isAnswerExist: true,
                );
              ObjectResult objectResult = await repository.uploadQuestion(questionUpload);
              if (objectResult.responseCode == StatusConst.code00) {
                emit(state.copyWith(
                    isShowProgress: false,
                    reportId: objectResult.response is int ? objectResult.response : null,
                    formStatus: SubmissionSuccess(/*success: result.message*/)));
              } else if (objectResult.responseCode == StatusConst.code01){
                emit(state.copyWith(
                    isShowProgress: false,
                    formStatus: SubmissionFailed("Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.")));
              }
            }
          }else if(state.reportId == null && event.id == 1){
            print("HoangCV:  uplaods asdsaj");
            QuestionUpload questionUpload = QuestionUpload(
              idOffline: state.idOffline,
              userInputId: state.reportId,
              surveyId: state.listReport[0].id,
              questionId: event.id,
              answerType: event.type,
              valueText: Utils.stringToFormattedString(Utils.formatDateTimeToString(
                  event.list[event.index].valueSelected)),
              listIdSuggested: [],
              isAnswerExist: true,
              farmerId: state.farmerInspector!.farmerId,
              farmerCode: state.farmerInspector!.farmerCode,
              farmId: state.farmerInspector!.farmId,
              farmCode: state.farmerInspector!.farmCode,
              internalInspectorId: state.farmerInspector!.internalInspectorId,
              monitoringVisitType: state.farmerInspector!.monitoringVisitType,
              visitDate: state.farmerInspector!.visitDate,
          );
            ObjectResult result = await repository.uploadQuestion(questionUpload);
            if (result.responseCode == StatusConst.code00) {
              emit(state.copyWith(
                  isShowProgress: false,
                  reportId: result.response is int ? result.response : null,
                  formStatus: SubmissionSuccess(/*success: result.message*/)));
            } else if (result.responseCode == StatusConst.code01){
              emit(state.copyWith(
                  isShowProgress: false,
                  formStatus: SubmissionFailed("Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.")));
            }
        }
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
            state.farmerInspector!.farmerId = state.listFarmer[result].id;
            state.farmerInspector!.farmerCode = state.listFarmer[result].code;
            state.farmerInspector!.farmId = null;
            state.farmerInspector!.farmCode = null;
            state.listWidget[4].listValue = state.listFarmer[result].farmIds;
            state.listWidget[4].valueSelected = null;
            state.listWidget[4].positionSelected = -1;
            emit(state.copyWith(
            idFarmerController: TextEditingController(text: "${state.listFarmer[result].id}"),
            farmerInspector: state.farmerInspector,
            listFarm: state.listFarmer[result].farmIds,
            ));
          } else if (event.index == 2) {
            state.farmerInspector!.internalInspectorId = state.listInspector[result].id;
            emit(state.copyWith(
              farmerInspector: state.farmerInspector,
            ));
          } else if (event.index == 4) {
            state.farmerInspector!.farmId = state.listFarm[result].id;
            state.farmerInspector!.farmCode = state.listFarm[result].code;
            emit(state.copyWith(
              farmerInspector: state.farmerInspector,
            ));
          }
          if(state.reportId != null ){
            emit(state.copyWith(
                isShowProgress: true, formStatus: const InitialFormStatus()));

            FarmerInspectorUpload  questionUpload = FarmerInspectorUpload(
              idOffline: state.idOffline,
              id: state.reportId,
              farmerId: state.farmerInspector!.farmerId,
              farmId: state.farmerInspector!.farmId,
              farmCode: state.farmerInspector!.farmCode,
              farmerCode: state.farmerInspector!.farmerCode,
              internalInspectorId: state.farmerInspector!.internalInspectorId,
              monitoringVisitType: state.farmerInspector!.monitoringVisitType,
              visitDate: state.farmerInspector!.visitDate,
            );
            ObjectResult result = await repository.editFarmerInspector(questionUpload);
            if (result.responseCode == StatusConst.code00) {
              emit(state.copyWith(
                  isShowProgress: false,
                  reportId: result.response is int ? result.response : null,
                  formStatus: SubmissionSuccess(/*success: result.message*/)));
            } else if (result.responseCode == StatusConst.code01){
              emit(state.copyWith(
                  isShowProgress: false,
                  formStatus: SubmissionFailed("Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.")));
            }
          }
        }
      }
    }
  }

  void _getAddReport(
      GetAddReportEvent event, Emitter<AddReportState> emitter) async {
    var uuid = Uuid();
    String idOffline = uuid.v1();
    print("String HoangCV: idOffline: $idOffline");
    emitter(state.copyWith(
      isShowProgress: true,
      startTimeController: TextEditingController(
          text: DateTime.now().toString() /*.split('.')[0]*/),
      idFarmerController: TextEditingController(text: ''),
      farmerInspector: FarmerInspectorUpload(visitDate: DateTime.now().toString().split('.')[0]),
      idOffline: idOffline,
    ));
    final report = await repository.getListActivityReport(event.id);
    List<List<Select>> listSelected = [];
    List<List<ListInputModel>> listInputModel = [];
    List<Select> listSelectedInspector = [];
    List<List<Visible>> listVisible = [];
    List<List<Controller>> listController = [];
    List<List<Controller>> listControllerTable = [];
    List<TableQuestion> listTable = [];
    List<People> listFarmer = [];
    List<People> listInspector = [];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? nameInspector = sharedPreferences.getString(SharedPreferencesKey.fullName);
    int? idInspector = sharedPreferences.getInt(SharedPreferencesKey.userId);
    state.farmerInspector!.internalInspectorId = idInspector;
    emit(state.copyWith(
      nameInspector: nameInspector,
    ));
    if (report.isNotEmpty) {
      listSelected = createSelectLists(report[0].questionAndPageIds);
      listInputModel = createInputLists(report[0].questionAndPageIds);
      listVisible = createVisibleLists(report[0].questionAndPageIds);
      listController = createTextEditingControllerLists(report[0].questionAndPageIds);
      listInputModel.forEach((element) {
        print("HoangCV:listInputModel:  ${element.length} : ${element.toString()}");
      });
 /*     listController.forEach((element) {
        print("HoangCV:listController:  ${element.length} : ${element[0].id}");
      });*/
      int i = 0;
      addTableRow(report[0].questionAndPageIds, listTable, i);
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

      List<GlobalExpand> expansionTileKeys = List.generate(
        report[0].questionAndPageIds.length,
            (index) => GlobalExpand(false,GlobalKey()),
      );
      emitter(state.copyWith(expansionTileKeys: expansionTileKeys,
          scrollController: AutoScrollController(
              viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, 0),
              axis: Axis.vertical
          )));
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
      listInputModel: listInputModel,
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

  List<List<ListInputModel>> createInputLists(List<Question> questions) {
    List<List<ListInputModel>> selectLists = [];

    for (Question question in questions) {
      List<ListInputModel> selectList = [];

      // Thêm Select cho câu hỏi cha
      if(question.questionType == 'date' || question.questionType == 'datetime' ) {
        InputRegisterModel inputRegisterModel = InputRegisterModel<String, DateTime>(
            title: "",
            isCompulsory: false,
            typeInputEnum: TypeInputEnum.date,
            type: TypeInputRegister.Select,
            //valueSelected: DateTime.now(),
            //controller: state.startTimeController,
            noBorder: true,
            textAlign: TextAlign.left
          //icon: Icons.calendar_today
        );
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
            InputRegisterModel inputRegisterModel = InputRegisterModel<String, DateTime>(
                title: "",
                isCompulsory: false,
                typeInputEnum: TypeInputEnum.date,
                type: TypeInputRegister.Select,
                //valueSelected: DateTime.now(),
                //controller: state.startTimeController,
                noBorder: true,
                textAlign: TextAlign.left
              //icon: Icons.calendar_today
            );
            selectList.add(ListInputModel(childQuestion.idSelected!, inputRegisterModel, TextEditingController()));
          }
          initInputValues(childQuestion, selectList);
        }
      }
     else if (item is Answer) {
      // Gọi hàm đệ quy cho danh sách câu hỏi con của câu trả lời con
      for (Question childQuestion in item.questionAndPageIds) {
        if(childQuestion.questionType == 'date' || childQuestion.questionType == 'datetime' ) {
          InputRegisterModel inputRegisterModel = InputRegisterModel<String, DateTime>(
              title: "",
              isCompulsory: false,
              typeInputEnum: TypeInputEnum.date,
              type: TypeInputRegister.Select,
              //valueSelected: DateTime.now(),
              //controller: state.startTimeController,
              noBorder: true,
              textAlign: TextAlign.left
            //icon: Icons.calendar_today
          );
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
        initTextControllersTable(childQuestion, textEditingControllerList);
      }

      for (Answer childAnswer in item.suggestedAnswerIds) {
        //print("HoangCV: childAnswer: ${childAnswer.rowId} : ${childAnswer.idSelected} : ${childAnswer.value}");
        textEditingControllerList.add(
            Controller(childAnswer.idSelected!, TextEditingController(),
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
    List<Question> listQs = state.listReport[0].questionAndPageIds;
    for (int i = 0; i < listQs.length; i++) {
      print("HoangCV: listQs: ${listQs[i].title}");
      if(listQs[i].questionAndPageIds.isNotEmpty) {
        for (int h = 0; h < listQs[i].questionAndPageIds.length; h++) {
          print("HoangCV: listQs[i].questionAndPageIds: ${listQs[i]
              .questionAndPageIds[h].title} : ${listQs[i].questionAndPageIds[h]
              .idSelected} : ${event.id}");
          if (listQs[i].questionAndPageIds[h].idSelected == event.id) {
            listQs[i].questionAndPageIds[h].isError = false;
            question = Question.copy(listQs[i].questionAndPageIds[h]);
            answerType = question.questionType ?? "";
            if (answerType == 'simple_choice') {
              listIdSuggested =
                  listQs[i].questionAndPageIds.map((item) => item.id ?? -1)
                      .toList();
            }
          } else {
            for (int j = 0;
            j < listQs[i].questionAndPageIds[h].suggestedAnswerIds.length;
            j++) {
              for (int k = 0;
              k < listQs[i].questionAndPageIds[h].suggestedAnswerIds[j]
                  .questionAndPageIds.length;
              k++) {
                if (listQs[i].questionAndPageIds[h].suggestedAnswerIds[j]
                    .questionAndPageIds[k].idSelected == event.id) {
                  listQs[i].questionAndPageIds[h].suggestedAnswerIds[j]
                      .isError = false;
                  listQs[i].questionAndPageIds[h].suggestedAnswerIds[j]
                      .questionAndPageIds[k].isError = false;
                  question = Question.copy(
                      listQs[i].questionAndPageIds[h].suggestedAnswerIds[j]
                          .questionAndPageIds[k]);
                  answerType = question.questionType ?? "";
                  if (question.commentAnswer == true) {
                    hasCommandAnswer = true;
                  }
                  /*answer = Answer.copy(
                    listQs[i].questionAndPageIds[h].suggestedAnswerIds[j]);*/
                }
              }
              if (listQs[i].questionAndPageIds[h].suggestedAnswerIds[j]
                  .idSelected == event.id) {
                listQs[i].questionAndPageIds[h].isError = false;
                question = Question.copy(listQs[i].questionAndPageIds[h]);
                answer = Answer.copy(
                    listQs[i].questionAndPageIds[h].suggestedAnswerIds[j]);
                if (answer.commentAnswer == true) {
                  hasCommandAnswer = true;
                }
                answerType = question.questionType ?? "";
                if (answerType == 'simple_choice') {
                  listIdSuggested =
                      listQs[i].questionAndPageIds[h].suggestedAnswerIds.map((
                          item) => item.id ?? -1).toList();
                }
              }
            }
            for (int l = 0;
            l < listQs[i].questionAndPageIds[h].questionAndPageIds.length;
            l++) {
              //print("HoangCV: listQs[i].questionAndPageIds,questionAndPageIds: ${listQs[i].questionAndPageIds[h].questionAndPageIds[l].title} :"
              //    " ${listQs[i].questionAndPageIds[h].questionAndPageIds[l].idSelected} : ${event.id}");
              if (listQs[i].questionAndPageIds[h].questionAndPageIds[l]
                  .idSelected == event.id) {
                listQs[i].questionAndPageIds[h].questionAndPageIds[l].isError =
                false;
                question = Question.copy(
                    listQs[i].questionAndPageIds[h].questionAndPageIds[l]);
                answerType = question.questionType ?? "";
                if (question.commentAnswer == true) {
                  hasCommandAnswer = true;
                }
              } else {
                for (int m = 0;
                m < listQs[i].questionAndPageIds[h].questionAndPageIds[l]
                    .suggestedAnswerIds.length;
                m++) {
                  if (listQs[i].questionAndPageIds[h].questionAndPageIds[l]
                      .suggestedAnswerIds[m].idSelected == event.id) {
                    listQs[i].questionAndPageIds[h].questionAndPageIds[l]
                        .isError = false;
                    listQs[i].questionAndPageIds[h].questionAndPageIds[l]
                        .suggestedAnswerIds[m].isError = false;
                    question = Question.copy(
                        listQs[i].questionAndPageIds[h].questionAndPageIds[l]);
                    answerType = question.questionType ?? "";
                    answer = Answer.copy(
                        listQs[i].questionAndPageIds[h].questionAndPageIds[l]
                            .suggestedAnswerIds[m]);
                    if (answer.commentAnswer == true) {
                      hasCommandAnswer = true;
                    }
                    if (answerType == 'simple_choice') {
                      listIdSuggested =
                          listQs[i].questionAndPageIds[h].questionAndPageIds[l]
                              .suggestedAnswerIds.map((item) => item.id ?? -1)
                              .toList();
                    }
                  }
                  for (int n = 0;
                  n < listQs[i].questionAndPageIds[h].questionAndPageIds[l]
                      .suggestedAnswerIds[m].questionAndPageIds.length;
                  n++) {
                    if (listQs[i].questionAndPageIds[h].questionAndPageIds[l]
                        .suggestedAnswerIds[m].questionAndPageIds[n]
                        .idSelected == event.id) {
                      listQs[i].questionAndPageIds[h].questionAndPageIds[l]
                          .suggestedAnswerIds[m].isError = false;
                      question = Question.copy(
                          listQs[i].questionAndPageIds[h].questionAndPageIds[l]
                              .suggestedAnswerIds[m].questionAndPageIds[n]);
                      answerType = question.questionType ?? "";
                      if (question.commentAnswer == true) {
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
      } else{
        for (int j = 0;
        j < listQs[i].suggestedAnswerIds.length;
        j++) {
          for (int k = 0;
          k < listQs[i].suggestedAnswerIds[j].questionAndPageIds.length;
          k++) {
            if (listQs[i].suggestedAnswerIds[j].questionAndPageIds[k].idSelected == event.id) {
              listQs[i].suggestedAnswerIds[j].isError = false;
              listQs[i].suggestedAnswerIds[j].questionAndPageIds[k].isError = false;
              question = Question.copy(
                  listQs[i].suggestedAnswerIds[j].questionAndPageIds[k]);
              answerType = question.questionType ?? "";
              if(question.commentAnswer == true){
                hasCommandAnswer = true;
              }
              /*answer = Answer.copy(
                    listQs[i].questionAndPageIds[h].suggestedAnswerIds[j]);*/
            }
          }
          if (listQs[i].suggestedAnswerIds[j].idSelected ==event.id) {
            listQs[i].isError = false;
            question = Question.copy(listQs[i]);
            answer = Answer.copy(
                listQs[i].suggestedAnswerIds[j]);
            if(answer.commentAnswer == true){
              hasCommandAnswer = true;
            }
            answerType = question.questionType ?? "";
            if(answerType == 'simple_choice'){
              listIdSuggested = listQs[i].suggestedAnswerIds.map((item) => item.id ?? -1).toList();
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
            idOffline: state.idOffline,
            userInputId: state.reportId,
            surveyId: state.listReport[0].id,
            questionId: question.id,
            suggestedAnswerId: answer.id,
            answerType: answerType == '' ? null : answerType,
            valueText: /*event.value*/text,
            // value default ko ro Anh Dung de lam gi
            isAnswerExist: index != -1
                ? event.listSelect[index].value
                : false,
            // value khi tich chon va bo tich chon
            //table_row_id: 1,
            listIdSuggested: listIdSuggested
        );
      } else {
        questionUpload = QuestionUpload(
          idOffline: state.idOffline,
          userInputId: state.reportId,
          surveyId: state.listReport[0].id,
          questionId: question.id,
          suggestedAnswerId: answer.id,
          answerType: answerType == '' ? null : answerType,
          valueText: event.value,
          // value default ko ro Anh Dung de lam gi
          isAnswerExist: index != -1 ? event.listSelect[index].value : false,
          // value khi tich chon va bo tich chon
          //table_row_id: 1,
          listIdSuggested: listIdSuggested,
          farmerId: state.farmerInspector!.farmerId,
          farmerCode: state.farmerInspector!.farmerCode,
          farmId: state.farmerInspector!.farmId,
          farmCode: state.farmerInspector!.farmCode,
          internalInspectorId: state.farmerInspector!.internalInspectorId,
          monitoringVisitType: state.farmerInspector!.monitoringVisitType,
          visitDate: state.farmerInspector!.visitDate,
        );
      }

      ObjectResult result = await repository.uploadQuestion(questionUpload);
      if (result.responseCode == StatusConst.code00) {
        emit(state.copyWith(
            isShowProgress: false,
            reportId: result.response is int ? result.response : null,
            formStatus: SubmissionSuccess(/*success: result.message*/)));
      } else if (result.responseCode == StatusConst.code01){
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionFailed("Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.")));
      }
    }
  }

  Future<FutureOr<void>> updateAddTable(
      UpdateAddTableEvent event, Emitter<AddReportState> emit) async {
    emit(state.copyWith(
        isShowProgress: true, formStatus: const InitialFormStatus()));

    List<Question> listQs = state.listReport[0].questionAndPageIds;
    bool checkBreak = false;
    for (int i = 0; i < listQs.length; i++) {
      for (int h = 0; h < listQs[i].questionAndPageIds.length; h++) {
        if (listQs[i].questionAndPageIds[h].questionType == "table") {
          for (int k = 0; k < listQs[i].questionAndPageIds[h].suggestedAnswerIds.length; k++) {
            print("HoangCV: table controller: ${event.answerId} : ${listQs[i].questionAndPageIds[h].suggestedAnswerIds[k].id} ");
            if (event.answerId == listQs[i].questionAndPageIds[h].suggestedAnswerIds[k].id) {
              if(event.value.isNotEmpty) {
                listQs[i].questionAndPageIds[h].suggestedAnswerIds[k].isError =
                false;
              }
              checkBreak = true;
              break;
            }
          }
        }
        if (checkBreak) {
          break;
        }
      }
      if (checkBreak) {
        break;
      }
    }

    if(event.value.isNotEmpty) {
      QuestionUpload questionUpload = QuestionUpload(
          idOffline: state.idOffline,
          userInputId: state.reportId,
          surveyId: state.listReport[0].id,
          questionId: event.questionId,
          suggestedAnswerId: event.answerId,
          answerType: 'table',
          valueText: event.value,
          isAnswerExist: true,
          tableRowId: event.rowId + 1,
          listIdSuggested: []
      );
      ObjectResult result = await repository.uploadQuestion(questionUpload);
      if (result.responseCode == StatusConst.code00) {
        emit(state.copyWith(
            isShowProgress: false,
            reportId: result.response is int ? result.response : null,
            formStatus: SubmissionSuccess(/*success: result.message*/)));
      } else if (result.responseCode == StatusConst.code01){
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionFailed("Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.")));
      }
    }
  }

  Future<FutureOr<void>> updateFarmerInspector(UpdateFarmerInspectorEvent event, Emitter<AddReportState> emit) async {
    state.farmerInspector!.monitoringVisitType = event.value;
    emit(state.copyWith(
      farmerInspector: state.farmerInspector
    ));
    if(state.reportId != null ){
      emit(state.copyWith(
          isShowProgress: true, formStatus: const InitialFormStatus()));

      FarmerInspectorUpload  questionUpload = FarmerInspectorUpload(
        idOffline: state.idOffline,
        id: state.reportId,
        farmerId: state.farmerInspector!.farmerId,
        farmId: state.farmerInspector!.farmId,
        farmCode: state.farmerInspector!.farmCode,
        farmerCode: state.farmerInspector!.farmerCode,
        internalInspectorId: state.farmerInspector!
            .internalInspectorId,
        monitoringVisitType: state.farmerInspector!
            .monitoringVisitType,
        visitDate: state.farmerInspector!.visitDate,
      );
      ObjectResult result = await repository.editFarmerInspector(questionUpload);
      if (result.responseCode == StatusConst.code00) {
        emit(state.copyWith(
            isShowProgress: false,
            reportId: result.response is int ? result.response : null,
            formStatus: SubmissionSuccess(/*success: result.message*/)));
      }else if (result.responseCode == StatusConst.code01){
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionFailed("Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.")));
      }
    }
  }

  Future<FutureOr<void>> submitReport(SubmitReportEvent event, Emitter<AddReportState> emit) async {
    emit(state.copyWith(
        isShowProgress: true, formStatus: const InitialFormStatus()));

    bool submit = true;
    List<Question> listQs = state.listReport[0].questionAndPageIds;
    for (int i = 0; i < listQs.length; i++) {
      bool checkBreak = false;
      print("HoangCV: title: ${listQs[i].title}");
      for (int h = 0; h < listQs[i].questionAndPageIds.length; h++) {
        print("HoangCV: listQs[i].questionAndPageIds: ${listQs[i].questionAndPageIds[h].title} : ${listQs[i].questionAndPageIds[h].constrMandatory}");
        if (listQs[i].questionAndPageIds[h].constrMandatory == true) {
          print("HoanmgCV:h: ${listQs[i].questionAndPageIds[h].title}");
          String qsType = listQs[i].questionAndPageIds[h].questionType ?? "";
          Question qs = listQs[i].questionAndPageIds[h];
          if(qsType == "check_box"){
            int indexQs = -1;
            state.listSelected.forEach((element) {
              indexQs = element.indexWhere((el) => el.id == qs.idSelected);
              if(indexQs != -1){
                //đoạn này phải check th: nếu là câu check box thuộc câu con, mà câu trl cha có tich thì mới check .
                if(qs.commentAnswer == true){
                  if(!element[indexQs].value){

                    checkBreak = true;
                    listQs[i].questionAndPageIds[h].isError = true;
                    Toast.showLongTop("Vui lòng chọn đáp án cho câu ${listQs[i].questionAndPageIds[h].title}");
                    submit = false;
                  } else{
                    int indexCtrl = -1;
                    state.listController.forEach((element) {
                      indexCtrl = element.indexWhere((el) => el.id == qs.idSelected);
                      if(indexCtrl != -1 && element[indexCtrl].controller.text.isEmpty){
                        checkBreak = true;
                        listQs[i].questionAndPageIds[h].isError = true;
                        Toast.showLongTop("Vui lòng nhập đáp án cho câu ${listQs[i].questionAndPageIds[h].title}");
                        submit = false;
                      }
                    });
                  }
                }
              }
            });
          }
          else if(qsType == "simple_choice" || qsType == "multi_choice" ){
            int indexAs = -1;
            bool checkPass = false;
            state.listSelected.forEach((element) {
              for(int a = 0 ; a< qs.suggestedAnswerIds.length; a++) {
                indexAs = element.indexWhere((el) => el.id == qs.suggestedAnswerIds[a].idSelected);
                if(indexAs != -1) {
                  if(element[indexAs].value){
                    print("HoangCVqs.suggestedAnswerIds[a]: ${qs.suggestedAnswerIds[a].value} : ${qs.suggestedAnswerIds[a].commentAnswer}");
                    checkPass = true;
                    if(qs.suggestedAnswerIds[a].commentAnswer == true){
                      int indexCtrl = -1;
                      state.listController.forEach((element) {
                        indexCtrl = element.indexWhere((el) => el.id == qs.suggestedAnswerIds[a].idSelected);
                        if (indexCtrl != -1 && element[indexCtrl].controller.text.isEmpty) {
                          checkBreak = true;
                          listQs[i].questionAndPageIds[h].suggestedAnswerIds[a].isError = true;
                          Toast.showLongTop(
                              "Vui lòng nhập đáp án cho câu ${qs.suggestedAnswerIds[a].value}");
                          submit = false;
                        }
                      });
                    }
                    for(int b = 0 ; b< qs.suggestedAnswerIds[a].questionAndPageIds.length; b++) {
                      int indexQS;
                      state.listSelected.forEach((element) {
                        for (int a = 0; a < qs.suggestedAnswerIds[a].questionAndPageIds.length; a++) {
                          indexQS = element.indexWhere((el) => el.id ==
                              qs.suggestedAnswerIds[a].questionAndPageIds[b].idSelected);
                          if (indexQS != -1) {
                            print("HoangCASCSDV:");
                            if(qs.suggestedAnswerIds[a].questionAndPageIds[b].questionType == "check_box") {
                              if (qs.suggestedAnswerIds[a].questionAndPageIds[b]
                                  .commentAnswer == true) {
                                if (element[indexAs].value) {
                                  int indexCtrl = -1;
                                  state.listController.forEach((element) {
                                    indexCtrl = element.indexWhere((el) =>
                                    el.id == qs.suggestedAnswerIds[a].questionAndPageIds[b].idSelected);
                                    if (indexCtrl != -1 && element[indexCtrl].controller.text.isEmpty) {
                                      checkBreak = true;
                                      listQs[i].questionAndPageIds[h].suggestedAnswerIds[a].questionAndPageIds[b].isError = true;
                                      print("HoangCVqs.questionAndPageIds[b]: ${listQs[i].questionAndPageIds[h].suggestedAnswerIds[a].questionAndPageIds[b].title}");
                                      Toast.showLongTop(
                                          "Vui lòng nhập đáp án cho câu "
                                              "${qs.suggestedAnswerIds[a].questionAndPageIds[b].title}");
                                      submit = false;
                                    }
                                  });
                                }
                                if (!submit) {
                                  break;
                                }
                              }
                            }
                            else {
                              if (!element[indexQS].value) {
                                checkBreak = true;
                                listQs[i].questionAndPageIds[h].isError = true;
                                print("HoangCV:buubu ${listQs[i].questionAndPageIds[h].title}");
                                Toast.showLongTop(
                                    "Vui lòng chọn đáp án cho câu ${listQs[i]
                                        .questionAndPageIds[h].title}");
                                submit = false;
                                break;
                              }
                            }
                          }
                        }
                      });
                    }
                  }
                }
              }
            });
            if(!checkPass) {
              print("HjoangCV : ${qs.title}");
              state.listSelected.forEach((element) {
                for (int a = 0; a < qs.suggestedAnswerIds.length; a++) {
                  indexAs = element.indexWhere((el) => el.id ==
                      qs.suggestedAnswerIds[a].idSelected);
                  if (indexAs != -1) {
                    //đoạn này phải check th: nếu là câu check box thuộc câu con, mà câu trl cha có tich thì mới check .
                    if (qs.suggestedAnswerIds[a].commentAnswer == true) {
                      if (!element[indexAs].value) {
                        checkBreak = true;
                        listQs[i].questionAndPageIds[h].isError = true;
                        Toast.showLongTop(
                            "Vui lòng chọn đáp án cho câu ${listQs[i]
                                .questionAndPageIds[h].title}");
                        submit = false;
                      } else {
                        int indexCtrl = -1;
                        state.listController.forEach((element) {
                          indexCtrl = element.indexWhere((el) =>
                          el.id == qs.idSelected);
                          if (indexCtrl != -1 &&
                              element[indexCtrl].controller.text.isEmpty) {
                            checkBreak = true;
                            listQs[i].questionAndPageIds[h].isError = true;
                            Toast.showLongTop(
                                "Vui lòng nhập đáp án cho câu ${listQs[i]
                                    .questionAndPageIds[h].title}");
                            submit = false;
                          }
                        });
                      }
                      if (!submit) {
                        break;
                      }
                    }
                    else {
                      if (!element[indexAs].value) {
                        (state.scrollController?? AutoScrollController()).scrollToIndex(
                          i,
                          preferPosition: AutoScrollPosition.begin, // Scroll position (begin, middle, end)
                          //duration: Duration(seconds: 1), // Duration of the scroll animation
                        );
                        checkBreak = true;
                        listQs[i].questionAndPageIds[h].isError = true;

                        print("HoangCV:buubu ${listQs[i].questionAndPageIds[h].title} : "
                            "$i : ${state.scrollController}");

                        Toast.showLongTop(
                            "Vui lòng chọn đáp án cho câu ${listQs[i]
                                .questionAndPageIds[h].title}");
                        submit = false;
                        break;
                      }
                    }
                  }
                }
              });
            }
          }
          else{
            int indexCtrl = -1;
            state.listController.forEach((element) {
              indexCtrl = element.indexWhere((el) =>
              el.id == qs.idSelected);
              if (indexCtrl != -1 && element[indexCtrl].controller.text.isEmpty) {
                checkBreak = true;
                listQs[i].questionAndPageIds[h].isError = true;
                Toast.showLongTop(
                    "Vui lòng nhập đáp án cho câu ${listQs[i]
                        .questionAndPageIds[h].title}");
                submit = false;
              }
            });
          }
          if(!submit){
            break;
          }
        } else {
          for (int l = 0;
          l < listQs[i].questionAndPageIds[h].questionAndPageIds.length;
          l++) {
            print("HoangCV: listQs[i].questionAndPageIds,questionAndPageIds: ${listQs[i].questionAndPageIds[h].questionAndPageIds[l].title} :"
                " ${listQs[i].questionAndPageIds[h].questionAndPageIds[l].constrMandatory} ");
            if (listQs[i].questionAndPageIds[h].questionAndPageIds[l].constrMandatory == true) {
              String qsType = listQs[i].questionAndPageIds[h].questionAndPageIds[l].questionType ?? "";
              Question qs = listQs[i].questionAndPageIds[h].questionAndPageIds[l];
              print("HoanmgCV:l: ${qs.title} : ${qsType}");
              if(qsType == "check_box"){
                int indexQs = -1;
                state.listSelected.forEach((element) {
                  indexQs = element.indexWhere((el) => el.id == qs.idSelected);
                  if(indexQs != -1){
                    //đoạn này phải check th: nếu là câu check box thuộc câu con, mà câu trl cha có tich thì mới check .
                    if(qs.commentAnswer == true){
                      if(!element[indexQs].value){
                        checkBreak = true;
                        listQs[i].questionAndPageIds[h].isError = true;
                        Toast.showLongTop("Vui lòng chọn đáp án cho câu ${listQs[i].questionAndPageIds[h].title}");
                        submit = false;
                      } else{
                        int indexCtrl = -1;
                        state.listController.forEach((element) {
                          indexCtrl = element.indexWhere((el) => el.id == qs.idSelected);
                          if(indexCtrl != -1 && element[indexCtrl].controller.text.isEmpty){
                            checkBreak = true;
                            listQs[i].questionAndPageIds[h].isError = true;
                            Toast.showLongTop("Vui lòng nhập đáp án cho câu ${listQs[i].questionAndPageIds[h].title}");
                            submit = false;
                          }
                        });
                      }
                    }
                  }
                });
              } else if(qsType == "simple_choice" || qsType == "multi_choice" ){
                int indexAs = -1;
                bool checkPass = false;
                state.listSelected.forEach((element) {
                  for(int a = 0 ; a< qs.suggestedAnswerIds.length; a++) {
                    indexAs = element.indexWhere((el) => el.id == qs.suggestedAnswerIds[a].idSelected);
                    if(indexAs != -1) {
                      if(element[indexAs].value){
                        print("HoangCVqs.suggestedAnswerIds[a] sub : ${qs.suggestedAnswerIds[a].value} : ${qs.suggestedAnswerIds[a].commentAnswer}");
                        checkPass = true;
                        if(qs.suggestedAnswerIds[a].commentAnswer == true){
                          int indexCtrl = -1;
                          state.listController.forEach((element) {
                            indexCtrl = element.indexWhere((el) => el.id == qs.suggestedAnswerIds[a].idSelected);
                            if (indexCtrl != -1 && element[indexCtrl].controller.text.isEmpty) {
                              checkBreak = true;
                              qs.suggestedAnswerIds[a].isError = true;
                              Toast.showLongTop(
                                  "Vui lòng nhập đáp án cho câu ${qs.suggestedAnswerIds[a].value}");
                              submit = false;
                            }
                          });
                        }
                        for(int b = 0 ; b< qs.suggestedAnswerIds[a].questionAndPageIds.length; b++) {
                          int indexQS;
                          state.listSelected.forEach((element) {
                            for (int a = 0; a < qs.suggestedAnswerIds[a].questionAndPageIds.length; a++) {
                              indexQS = element.indexWhere((el) => el.id ==
                                  qs.suggestedAnswerIds[a].questionAndPageIds[b].idSelected);
                              if (indexQS != -1) {
                                print("HoangCASCSDV sub:");
                                if(qs.suggestedAnswerIds[a].questionAndPageIds[b].questionType == "check_box") {
                                  if (qs.suggestedAnswerIds[a].questionAndPageIds[b]
                                      .commentAnswer == true) {
                                    if (element[indexAs].value) {
                                      int indexCtrl = -1;
                                      state.listController.forEach((element) {
                                        indexCtrl = element.indexWhere((el) =>
                                        el.id == qs.suggestedAnswerIds[a].questionAndPageIds[b].idSelected);
                                        if (indexCtrl != -1 && element[indexCtrl].controller.text.isEmpty) {
                                          checkBreak = true;
                                          qs.suggestedAnswerIds[a].questionAndPageIds[b].isError = true;
                                          print("HoangCVqs.questionAndPageIds[b] sub : ${qs.suggestedAnswerIds[a].questionAndPageIds[b].title}");
                                          Toast.showLongTop(
                                              "Vui lòng nhập đáp án cho câu "
                                                  "${qs.suggestedAnswerIds[a].questionAndPageIds[b].title}");
                                          submit = false;
                                        }
                                      });
                                    }
                                    if (!submit) {
                                      break;
                                    }
                                  }
                                }
                                else {
                                  if (!element[indexQS].value) {
                                    checkBreak = true;
                                    qs.isError = true;
                                    print("HoangCV:buubu sub: ${qs.title}");
                                    Toast.showLongTop(
                                        "Vui lòng chọn đáp án cho câu ${qs.title}");
                                    submit = false;
                                    break;
                                  }
                                }
                              }
                            }
                          });
                        }
                      }
                    }
                  }
                });
                if(!checkPass) {
                  print("HjoangCV sub : ${qs.title}");
                  state.listSelected.forEach((element) {
                    for (int a = 0; a < qs.suggestedAnswerIds.length; a++) {
                      indexAs = element.indexWhere((el) => el.id ==
                          qs.suggestedAnswerIds[a].idSelected);
                      if (indexAs != -1) {
                        //đoạn này phải check th: nếu là câu check box thuộc câu con, mà câu trl cha có tich thì mới check .
                        if (qs.suggestedAnswerIds[a].commentAnswer == true) {
                          if (!element[indexAs].value) {
                            checkBreak = true;
                            qs.isError = true;
                            Toast.showLongTop(
                                "Vui lòng chọn đáp án cho câu ${listQs[i]
                                    .questionAndPageIds[h].title}");
                            submit = false;
                          } else {
                            int indexCtrl = -1;
                            state.listController.forEach((element) {
                              indexCtrl = element.indexWhere((el) =>
                              el.id == qs.idSelected);
                              if (indexCtrl != -1 &&
                                  element[indexCtrl].controller.text.isEmpty) {
                                checkBreak = true;
                                qs.isError = true;
                                Toast.showLongTop(
                                    "Vui lòng nhập đáp án cho câu ${listQs[i]
                                        .questionAndPageIds[h].title}");
                                submit = false;
                              }
                            });
                          }
                          if (!submit) {
                            break;
                          }
                        }
                        else {
                          if (!element[indexAs].value) {
                            (state.scrollController?? AutoScrollController()).scrollToIndex(
                              i,
                              preferPosition: AutoScrollPosition.begin, // Scroll position (begin, middle, end)
                              //duration: Duration(seconds: 1), // Duration of the scroll animation
                            );
                            checkBreak = true;
                            qs.isError = true;

                            print("HoangCV:buubu sub 1: ${qs.title} : "
                                "$i : ${state.scrollController}");

                            Toast.showLongTop(
                                "Vui lòng chọn đáp án cho câu ${qs.title}");
                            submit = false;
                            break;
                          }
                        }
                      }
                    }
                  });
                }
              }
              else{
                checkBreak = true;
                qs.isError = true;
                Toast.showLongTop("Vui lòng nhập đáp án cho câu ${listQs[i].questionAndPageIds[h].title}");
                submit = false;
              }
            } else{
              for (int m = 0;
              m < listQs[i].questionAndPageIds[h].questionAndPageIds[l].suggestedAnswerIds.length;
              m++) {
                for (int n = 0;
                n < listQs[i].questionAndPageIds[h].questionAndPageIds[l].suggestedAnswerIds[m].questionAndPageIds.length;
                n++) {
                  if (listQs[i].questionAndPageIds[h].questionAndPageIds[l].suggestedAnswerIds[m].
                  questionAndPageIds[n].constrMandatory == true) {
                    print("HoanmgCV:n: ${listQs[i].questionAndPageIds[h].questionAndPageIds[l].suggestedAnswerIds[m].questionAndPageIds[n].title}");
                    String qsType = listQs[i].questionAndPageIds[h].questionAndPageIds[l].suggestedAnswerIds[m].questionAndPageIds[n].questionType ?? "";
                    Question qs = listQs[i].questionAndPageIds[h].questionAndPageIds[l].suggestedAnswerIds[m].questionAndPageIds[n];
                    if(qsType == "simple_choice" || qsType == "multi_choice" || qsType == "check_box"){
                      int indexQs = -1;
                      state.listSelected.forEach((element) {
                        indexQs = element.indexWhere((el) => el.id == qs.idSelected);
                        if(indexQs != -1){
                          //đoạn này phải check th: nếu là câu check box thuộc câu con, mà câu trl cha có tich thì mới check .
                          if(qs.commentAnswer == true){
                            if(!element[indexQs].value){
                              checkBreak = true;
                              listQs[i].questionAndPageIds[h].questionAndPageIds[l].suggestedAnswerIds[m].questionAndPageIds[n].isError = true;
                              Toast.showLongTop("Vui lòng chọn đáp án cho câu "
                                  "${listQs[i].questionAndPageIds[h].questionAndPageIds[l].suggestedAnswerIds[m].questionAndPageIds[n].title}");
                              submit = false;
                            } else{
                              int indexCtrl = -1;
                              state.listController.forEach((element) {
                                indexCtrl = element.indexWhere((el) => el.id == qs.idSelected);
                                if(indexCtrl != -1 && element[indexCtrl].controller.text.isEmpty){
                                  checkBreak = true;
                                  listQs[i].questionAndPageIds[h].questionAndPageIds[l].suggestedAnswerIds[m].questionAndPageIds[n].isError = true;
                                  Toast.showLongTop("Vui lòng nhập đáp án cho câu "
                                      "${listQs[i].questionAndPageIds[h].questionAndPageIds[l].suggestedAnswerIds[m].questionAndPageIds[n].title}");
                                  submit = false;
                                }
                              });
                            }
                          }
                        }
                      });
                    } else{
                      checkBreak = true;
                      listQs[i].questionAndPageIds[h].questionAndPageIds[l].suggestedAnswerIds[m].questionAndPageIds[n].isError = true;
                      Toast.showLongTop("Vui lòng nhập đáp án cho câu "
                          "${listQs[i].questionAndPageIds[h].questionAndPageIds[l].suggestedAnswerIds[m].questionAndPageIds[n].title}");
                      submit = false;
                    }
                  }
                }
              }
            }
          }
          for (int l = 0;
          l < listQs[i].questionAndPageIds[h].suggestedAnswerIds.length;
          l++) {
            print("HoangCV: listQs[i].suggestedAnswerIds: ${listQs[i].questionAndPageIds[h].suggestedAnswerIds[l].value}");
            int indexAsSub = -1;
            state.listSelected.forEach((element) {
              indexAsSub = element.indexWhere((el) => el.id == listQs[i].questionAndPageIds[h].suggestedAnswerIds[l].idSelected);
              if(indexAsSub != -1){
                if(element[indexAsSub].value){
                  for (int u = 0; u < listQs[i].questionAndPageIds[h].suggestedAnswerIds[l].questionAndPageIds.length; u++) {
                      print("HoangCV: listQs[i].questionAndPageIds u:: "
                          "${listQs[i].questionAndPageIds[h].suggestedAnswerIds[l].questionAndPageIds[u].title} : "
                          "${listQs[i].questionAndPageIds[h].suggestedAnswerIds[l].questionAndPageIds[u].constrMandatory}");
                      if (listQs[i].questionAndPageIds[h].suggestedAnswerIds[l].questionAndPageIds[u].constrMandatory == true) {
                        print("HoanmgCV:h: ${listQs[i].questionAndPageIds[h].suggestedAnswerIds[l].questionAndPageIds[u].title}");
                        String qsType = listQs[i].questionAndPageIds[h].suggestedAnswerIds[l].questionAndPageIds[u].questionType ?? "";
                        Question qs = listQs[i].questionAndPageIds[h].suggestedAnswerIds[l].questionAndPageIds[u];
                        if(qsType == "check_box"){
                          int indexQs = -1;
                          //check box: ko tích thì vẫn là ko , còn nếu tích thì phải check comment answer
                          state.listSelected.forEach((element) {
                            indexQs = element.indexWhere((el) => el.id == qs.idSelected);
                            if(indexQs != -1){
                              //đoạn này phải check th: nếu là câu check box thuộc câu con, mà câu trl cha có tich thì mới check .
                              if(qs.commentAnswer == true){
                                if(!element[indexQs].value){
                                  checkBreak = true;
                                  listQs[i].questionAndPageIds[h].suggestedAnswerIds[l].questionAndPageIds[u].isError = true;
                                  Toast.showLongTop("Vui lòng chọn đáp án cho câu ${qs.title}");
                                  submit = false;
                                } else{
                                  int indexCtrl = -1;
                                  state.listController.forEach((element) {
                                    indexCtrl = element.indexWhere((el) => el.id == qs.idSelected);
                                    if(indexCtrl != -1 && element[indexCtrl].controller.text.isEmpty){
                                      checkBreak = true;
                                      listQs[i].questionAndPageIds[h].suggestedAnswerIds[l].questionAndPageIds[u].isError = true;
                                      Toast.showLongTop("Vui lòng nhập đáp án cho câu ${qs.title}");
                                      submit = false;
                                    }
                                  });
                                }
                              }
                            }
                          });
                        } else if(qsType == "simple_choice" || qsType == "multi_choice" ){

                        } else{
                          int indexCtrl = -1;
                          state.listController.forEach((element) {
                            indexCtrl = element.indexWhere((el) => el.id == qs.idSelected);
                            if (indexCtrl != -1 && element[indexCtrl].controller.text.isEmpty) {
                              checkBreak = true;
                              listQs[i].questionAndPageIds[h].suggestedAnswerIds[l].questionAndPageIds[u].isError = true;
                              Toast.showLongTop("Vui lòng nhập đáp án cho câu ${qs.title}");
                              submit = false;
                            }
                          });
                        }
                        if(!submit){
                          break;
                        }
                      }
                    }
                }
              }
            });
          }
        }
      }
      if(checkBreak){
        print("HoangCV: index: $i");
        state.scrollController!.scrollToIndex(i+1, preferPosition: AutoScrollPosition.begin);
        break;
      }
    }
    if(submit){
      bool checkBreak = false;
      for (var element in state.listControllerTable) {
        for (var e in element) {
          print("HoangCV: table controller: ${e.title} : ${e.value} : ${e.controller.text.isEmpty} : ${e.constrMandatory}");
          if (e.constrMandatory == true && e.controller.text.isEmpty) {
            for (int i = 0; i < listQs.length; i++) {
              for (int h = 0; h < listQs[i].questionAndPageIds.length; h++) {
                if (listQs[i].questionAndPageIds[h].questionType == "table") {
                  for (int k = 0; k < listQs[i].questionAndPageIds[h].suggestedAnswerIds.length; k++) {
                    print("HoangCV: table controller: ${e.value} : ${e.idRow} : ${e.id} :"
                        " ${listQs[i].questionAndPageIds[h].suggestedAnswerIds[k].idSelected} : $checkBreak");
                    if (e.id == listQs[i].questionAndPageIds[h].suggestedAnswerIds[k].idSelected) {
                      listQs[i].questionAndPageIds[h].suggestedAnswerIds[k].isError = true;
                      if (!checkBreak) {
                        Toast.showLongTop("Vui lòng nhập đáp án cho cột ${e.value}");
                      }
                      submit = false;
                      checkBreak = true;
                    }
                    else {
                      for (int l = 0; l < listQs[i].questionAndPageIds[h].suggestedAnswerIds[k].suggestedAnswerIds.length; l++) {
                        print("HoangCV: table controller:sub ${e.value} : ${e.idRow} : ${e.id} : "
                            "${listQs[i].questionAndPageIds[h].suggestedAnswerIds[k].suggestedAnswerIds[l].idSelected} : $checkBreak");
                        if (e.id == listQs[i].questionAndPageIds[h].suggestedAnswerIds[k].suggestedAnswerIds[l].idSelected) {
                          listQs[i].questionAndPageIds[h].suggestedAnswerIds[k].suggestedAnswerIds[l].isError = true;
                          if (!checkBreak) {
                            Toast.showLongTop("Vui lòng nhập đáp án cho cột ${e.value}");
                          }
                          submit = false;
                          checkBreak = true;
                        }
                      }
                    }
                  }
                  if (checkBreak) {
                    break;
                  }
                }
              }
              if (checkBreak) {
                print("HoangCV: run wat: $i ${listQs[i].title}");
                state.scrollController!.scrollToIndex(i + 1, preferPosition: AutoScrollPosition.begin);
                break;
              }
            }
          }
          if (checkBreak) {
            break;
          }
        }
        if (checkBreak) {
          break;
        }
      }
    }
    emit(state.copyWith(
        scrollController: state.scrollController));
    print("HoangCV: submit: ${submit} : ${state.scrollController}");
    if(submit){
      FarmerInspectorUpload  questionUpload = FarmerInspectorUpload(
          idOffline: state.idOffline,
          id: state.reportId,
          farmerId: state.farmerInspector!.farmerId,
          farmId: state.farmerInspector!.farmId,
          farmCode: state.farmerInspector!.farmCode,
          farmerCode: state.farmerInspector!.farmerCode,
          internalInspectorId: state.farmerInspector!
              .internalInspectorId,
          monitoringVisitType: state.farmerInspector!
              .monitoringVisitType,
          visitDate: state.farmerInspector!.visitDate,
        state: 'done'
      );
      ObjectResult result = await repository.editFarmerInspector(questionUpload);
      if (result.responseCode == StatusConst.code00) {
        emit(state.copyWith(
            isShowProgress: false,
            reportId: result.response is int ? result.response : null,
            formStatus: SubmissionSuccess(success: "Hoàn thành báo cáo đánh giá.")));
      } else if (result.responseCode == StatusConst.code01){
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionFailed("Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.")));
      }
    }
  }

  FutureOr<void> addNewTableRow(AddTableRowEvent event, Emitter<AddReportState> emit) {
    emit(state.copyWith(
        isShowProgress: true
    ));
    List<TableQuestion> listTable = state.listTable;
    //int indexTable = listTable.indexWhere((element) => element.id == event.idTable);
    int i = state.listTable[event.idTable].listQuestion.length;
    addNewRow(event.list, listTable, i, event.idTable);
      listTable.forEach((element) {
        print("HoangCV:listTable:  ${listTable.toString()}");
        element.listQuestion.forEach((e) {
          print("HoangCV:listTable e:  ${element.listQuestion.toString()}");
        });
      });
    List<List<Controller>> listCtrlTable = createTECTBLists(listTable);
    state.listControllerTable.addAll(listCtrlTable);
    emit(state.copyWith(
      listTable: listTable,
      listControllerTable: state.listControllerTable,
      isShowProgress: false
      // listReport: state.listReport
    ));
    state.listTable.forEach((element) {
      print("HoangCV:state.listTable:  ${listTable.toString()}");
      element.listQuestion.forEach((e) {
        print("HoangCV:state.listTable e:  ${element.listQuestion.toString()}");
      });
    });
  }

  void addNewRow(List<dynamic> items, List<TableQuestion> listTable, int id, int idTable) {
    for (dynamic item in items) {
      if (item is Question) {
        if (item.questionType == 'table') {
          print("HaongCV: item: ${item.title}");
          List<Question> list = [];
            List<Answer> listAs = [];
            for (Answer answer in item.suggestedAnswerIds) {

              print("HaongCV: answer: ${answer.value}");
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
          listTable[idTable].listQuestion.add(qs);
        }
      }
    }

    // Gọi đệ quy sau khi xử lý toàn bộ danh sách items
    for (dynamic item in items) {
      if (item is Question) {
        addNewRow(item.questionAndPageIds, listTable, id, idTable);
      }
    }
  }
}

class AddTableRowEvent extends AddReportEvent {
  final List<Question> list;
  int idTable;

  AddTableRowEvent(this.list, this.idTable);

  @override
  List<Object?> get props => [list, idTable];
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
  int id;
  String type;

  //bug date time

  OnSelectValueEvent(this.list, this.index, this.context, {this.id = -1, this.type = 'date'});

  @override
  List<Object?> get props => [list, index, context, id, type];
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
        expansionTileKeys,
        scrollController,
        nameInspector,
        idOffline
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
  FarmerInspectorUpload? farmerInspector;
  final bool isShowProgress;
  final int? reportId;
  final List<GlobalExpand> expansionTileKeys;
  AutoScrollController? scrollController = AutoScrollController();
  final String? nameInspector;
  final String? idOffline;

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
    this.listInputModel = const [],
    this.listFarmer = const [],
    this.listInspector = const [],
    this.listFarm = const [],
    this.startTimeController,
    this.idFarmerController,
    this.farmerInspector,
    this.reportId,
    this.expansionTileKeys = const [],
    this.scrollController,
    this.nameInspector,
    this.idOffline,
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
    List<List<ListInputModel>>? listInputModel,
    List<People>? listFarmer,
    List<People>? listInspector,
    List<People>? listFarm,
    TextEditingController? startTimeController,
    TextEditingController? idFarmerController,
    FarmerInspectorUpload? farmerInspector,
    int? reportId,
    List<GlobalExpand>? expansionTileKeys,
    AutoScrollController? scrollController,
    String? nameInspector,
    String? idOffline,
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
        listInputModel: listInputModel ?? this.listInputModel,
        listFarmer: listFarmer ?? this.listFarmer,
        listFarm: listFarm ?? this.listFarm,
        listInspector: listInspector ?? this.listInspector,
        startTimeController: startTimeController ?? this.startTimeController,
        idFarmerController: idFarmerController ?? this.idFarmerController,
        farmerInspector: farmerInspector ?? this.farmerInspector,
        reportId: reportId ?? this.reportId,
        expansionTileKeys: expansionTileKeys ?? this.expansionTileKeys,
        scrollController: scrollController ?? this.scrollController,
        nameInspector: nameInspector ?? this.nameInspector,
        idOffline: idOffline ?? this.idOffline,
    );
  }
}

class GlobalExpand{
  bool expand;
  GlobalKey key;

  GlobalExpand(this.expand, this.key);
}

class ListInputModel {
  int id;
  InputRegisterModel inputModel;
  TextEditingController controller;

  ListInputModel(this.id, this.inputModel, this.controller);
}
