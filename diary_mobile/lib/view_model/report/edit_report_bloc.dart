import 'dart:async';
import 'dart:ffi';

import 'package:diary_mobile/data/entity/report/question_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../data/repository.dart';
import '../../data/entity/item_default/item_basic.dart';
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

class EditReportBloc extends Bloc<EditReportEvent, EditReportState> {
  final Repository repository;

  EditReportBloc(this.repository) : super(EditReportState()) {
    on<GetEditReportEvent>(_getEditReport);
    on<OnSelectValueEvent>(_onSelectValue);
    on<OnSelectionValueEvent>(_onSelectionValue);
    on<OnSelectionFieldValueEvent>(_onSelectionFieldValue);
    on<UpdateEditReportEvent>(updateEditReport);
    on<UpdateEditTableEvent>(updateEditTable);
    on<UpdateAddTableFieldEvent>(updateAddTableField);
    on<UpdateFarmerInspectorEvent>(updateFarmerInspector);
    on<SubmitReportEvent>(submitReport);
    on<AddTableRowEvent>(addNewTableRow);
  }

  void _initViewEdit(Emitter<EditReportState> emitter) {
    List<InputRegisterModel> list = [];
    print("HoangCV: state.listFarmer : ${state.listFarmer.length}");

    list.add(InputRegisterModel<People, People>(
          title: "",
          isCompulsory: false,
          type: TypeInputRegister.Non,
          icon: Icons.arrow_drop_down,
          positionSelected: -1,
          controller: state.farmerController,
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
        textAlign: TextAlign.left
    ));

    list.add(InputRegisterModel<People, People>(
          title: "",
          isCompulsory: false,
          type: TypeInputRegister.Non,
          icon: Icons.arrow_drop_down,
          positionSelected: -1,
          controller: state.inspectorController,
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
        valueSelected: Utils.stringToDate(state.startTimeController!.text),
        controller: state.startTimeController,
        noBorder: true,
        textAlign: TextAlign.left
      //icon: Icons.calendar_today
    ));

    emitter(state.copyWith(
        listWidget: list,
        formStatus: const InitialFormStatus()));
  }

  Future<FutureOr<void>> _onSelectValue(OnSelectValueEvent event,
      Emitter<EditReportState> emit) async {
    int result;
    bool checkPass = true;
    if (event.index == 0 && state.listFarmer.isEmpty) {
      Toast.showLongTop("Không có danh sách nông hộ");
      checkPass = false;
    } else if (event.index == 4 && state.listFarm.isEmpty) {
      Toast.showLongTop("Không có danh sách lô trồng");
      checkPass = false;
    }
    /*else if(event.index == 2 && state.listInspector.isEmpty) {
      Toast.showLongTop("Không có danh sách thanh tra viên");
      checkPass = false;
    }*/
    if (checkPass) {
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
          if (state.reportId != null) {
            if (event.id == -1) {
              emit(state.copyWith(
                  isShowProgress: true, formStatus: const InitialFormStatus()));

              FarmerInspectorUpload questionUpload = FarmerInspectorUpload(
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
              } else if (result.responseCode == StatusConst.code01) {
                emit(state.copyWith(
                    isShowProgress: false,
                    formStatus: SubmissionFailed(
                        "Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.")));
              }
            } else {
              print("HoangCV:  uplaods asdsaj 1121");
              QuestionUpload questionUpload = QuestionUpload(
                userInputId: state.reportId,
                surveyId: state.listReport[0].id,
                questionId: event.id,
                answerType: event.type,
                valueText: Utils.stringToFormattedString(
                    Utils.formatDateTimeToString(
                        event.list[event.index].valueSelected)),
                listIdSuggested: [],
                isAnswerExist: true,
              );
              ObjectResult result = await repository.uploadQuestion(
                  questionUpload);
              if (result.responseCode == StatusConst.code00) {
                emit(state.copyWith(
                    isShowProgress: false,
                    reportId: result.response is int ? result.response : null,
                    formStatus: SubmissionSuccess(/*success: result.message*/)));
              } else if (result.responseCode == StatusConst.code01) {
                emit(state.copyWith(
                    isShowProgress: false,
                    formStatus: SubmissionFailed(
                        "Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.")));
              }
            }
          }
        }
      } else {
        print("HoangCV: event.list[event.index].listValue: ${event
            .index} : ${event.list[event.index].toString()} : ${event.list[event
            .index].listValue.length} ");
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
            event.list[1].controller =
                TextEditingController(text: "${state.listFarmer[result].id}");
            state.farmerInspector!.farmerId = state.listFarmer[result].id;
            state.farmerInspector!.farmerCode = state.listFarmer[result].code;
            state.farmerInspector!.farmId = null;
            state.farmerInspector!.farmCode = null;
            state.listWidget[4].listValue = state.listFarmer[result].farmIds;
            state.listWidget[4].valueSelected = null;
            state.listWidget[4].positionSelected = -1;
            emit(state.copyWith(
                idFarmerController: TextEditingController(
                    text: "${state.listFarmer[result].login}"),
                farmerInspector: state.farmerInspector,
                listFarm: state.listFarmer[result].farmIds
            ));
          } else if (event.index == 2) {
            state.farmerInspector!.internalInspectorId =
                state.listInspector[result].id;
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
          if (state.reportId != null) {
            emit(state.copyWith(
                isShowProgress: true, formStatus: const InitialFormStatus()));

            FarmerInspectorUpload questionUpload = FarmerInspectorUpload(
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
            } else if (result.responseCode == StatusConst.code01) {
              emit(state.copyWith(
                  isShowProgress: false,
                  formStatus: SubmissionFailed(
                      "Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.")));
            }
          }
        }
      }
    }
  }

  Future<FutureOr<void>> _onSelectionValue(
      OnSelectionValueEvent event, Emitter<EditReportState> emit) async {
    int result;
    bool checkPass = true;
    if(checkPass) {
      result = await Extension().showBottomSheetSelection(
          event.context,
          event.input.listValue,
          event.input.positionSelected,
          "${event.input.title}",
          hasSearch: event.input.hasSearch ?? false);
      if (result != -1) {
        //   setState(() {
        event.input.positionSelected = result;
        event.input.valueDefault = null;
        event.input.valueSelected =
        event.input.listValue[result];
        event.input.error = null;
        // });
        // can gi de update report
        print("HoangC:V:  ${event.rowId} : ${event.input}");
        QuestionUpload questionUpload = QuestionUpload(
            userInputId: state.reportId,
            surveyId: state.listReport[0].id,
            questionId: event.questionId,
            suggestedAnswerId: event.answerId,
            answerType: 'table',
            valueText: '',
            tableAnswerId: event.input.listValue[result].id,
            isAnswerExist: true,
            tableRowId: event.rowId,
            listIdSuggested: []
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
    }
  }

  Future<FutureOr<void>> _onSelectionFieldValue(
      OnSelectionFieldValueEvent event, Emitter<EditReportState> emit) async {
    int result;
    bool checkPass = true;
    if(state.listFarm.isEmpty){
      checkPass == false;
      Toast.showLongTop("Lô trồng không thuộc quyền quản lý!\n Vui lòng kiểm tra lại.");
      return false;
    }
    if(checkPass) {
      result = await Extension().showBottomSheetSelection(
          event.context,
          event.input.listValue,
          event.input.positionSelected,
          "${event.input.title}",
          hasSearch: event.input.hasSearch ?? false);
      if (result != -1) {
        //   setState(() {
        event.input.positionSelected = result;
        event.input.valueDefault = null;
        event.input.valueSelected =
        event.input.listValue[result];
        event.input.error = null;
        // });
        // can gi de update report
        QuestionUpload questionUpload = QuestionUpload(
            userInputId: state.reportId,
            surveyId: state.listReport[0].id,
            questionId: event.questionId,
            suggestedAnswerId: event.answerId,
            answerType: 'table',
            valueText: '',
            tableAnswerId: event.input.listValue[result].id,
            rowLinkId: state.listFarm[event.rowId-1].id,
            isAnswerExist: true,
            tableRowId: event.rowId,
            listIdSuggested: []
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
    }
  }

  void _getEditReport(GetEditReportEvent event,
      Emitter<EditReportState> emitter) async {
    emitter(state.copyWith(
        isShowProgress: true,
/*      startTimeController: TextEditingController(
          text: DateTime.now().toString() */ /*.split('.')[0]*/ /*),*/
        idFarmerController: TextEditingController(text: ''),
        farmerInspector: FarmerInspectorUpload(
            visitDate: DateTime.now().toString().split('.')[0]),
        reportId: event.id
    ));
    final report = await repository.getDetailReport(event.id);
    List<List<Select>> listSelected = [];
    List<List<ListInputModel>> listInputModel = [];
    List<Select> listSelectedInspector = [];
    List<List<Visible>> listVisible = [];
    List<List<Controller>> listController = [];
    List<List<Controller>> listControllerTable = [];
    List<List<Controller>> listControllerTableField = [];
    List<TableQuestion> listTableField = [];
    List<TableQuestion> listTable = [];
    List<People> listFarmer = [];
    List<People> listInspector = [];
    if (report[1].surveyId.isNotEmpty) {
      listSelected =
          createSelectLists(report[1].surveyId[0].questionAndPageIds);
      listInputModel =
          createInputLists(report[1].surveyId[0].questionAndPageIds);
      listVisible =
          createVisibleLists(report[1].surveyId[0].questionAndPageIds);
      listController = createTextEditingControllerLists(
          report[1].surveyId[0].questionAndPageIds);
/*      listSelected.forEach((element) {
        print("HoangCV:listSelected:  ${element.length} : ${element[0].id}");
      });
      listController.forEach((element) {
        print("HoangCV:listController:  ${element.length} : ${element[0].id}");
      });*/
      int i = 1;
      int i1 = 0;
      addTableRow(report[1].surveyId[0].questionAndPageIds, listTable, i);
      List<List<Controller>> listCtrlTable = createTECTBLists(listTable);
      listControllerTable.addAll(listCtrlTable);

      addTableFieldRow(report[1].surveyId[0].questionAndPageIds, listTableField, i1,
          []/*report[0].listFarmers[report[0].listFarmers.indexWhere((element) =>
          element.id == report[0].farmerId)].farmIds*/);
      List<List<Controller>> listCtrlTableField = createTECTBListsField(listTableField,);
      listControllerTableField.addAll(listCtrlTableField);

      for (int i = 0; i < report[0].listMonitoringVisitType.length; i++) {
        listSelectedInspector.add(Select(i,
            report[0].listMonitoringVisitType[i].type ==
                report[0].monitoringVisitType ? true : false,
            report[0].listMonitoringVisitType[i].value,
            type: report[0].listMonitoringVisitType[i].type));
      }
      int indexFarmer = report[0].listFarmers.indexWhere((element) =>
      element.id == report[0].farmerId);
      int indexInspector = report[0].listInternalInspector.indexWhere((
          element) => element.id == report[0].internalInspectorId);
      int indexFarm = -1;
      if (indexFarmer != -1) {
        indexFarm = report[0].listFarmers[indexFarmer].farmIds.indexWhere((
            element) => element.id == report[0].farmId);
      }
      state.farmerInspector!.farmerId = report[0].farmerId;
      state.farmerInspector!.farmId = report[0].farmId;
      state.farmerInspector!.internalInspectorId =
          report[0].internalInspectorId;
      state.farmerInspector!.monitoringVisitType =
          report[0].monitoringVisitType;
      state.farmerInspector!.visitDate = report[0].visitDate;
/*      print("HoangCV:state.farmerInspector!.visit_date: ${state.farmerInspector!
          .toJson()} : ${report[0].internalInspector}");*/
      emitter(state.copyWith(
        listFarmer: report[0].listFarmers,
        listInspector: report[0].listInternalInspector,
        listFarm: indexFarmer != -1
            ? report[0].listFarmers[indexFarmer].farmIds
            : [],
        farmerInspector: state.farmerInspector,
        nameInspector: report[0].internalInspector,
        indexFarmer: indexFarmer,
        indexInspector: indexInspector,
        indexFarm: indexFarm,
        idFarmerController: TextEditingController(
            text: "${report[0].farmerLogin}"),
        startTimeController: TextEditingController(
            text: Utils.formatDate(report[0].visitDate ?? "")),
        farmerController: TextEditingController(
            text: "${report[0].farmerName}"),
        inspectorController: TextEditingController(
            text: "${report[0].internalInspector}"),
      ));
      _initViewEdit(emitter);

      List<GlobalExpand> expansionTileKeys = List.generate(
        report[1].surveyId[0].questionAndPageIds.length,
            (index) => GlobalExpand(false, GlobalKey()),
      );
      print("HoangCV: expansionTileKeys: ${expansionTileKeys
          .length} :  ${expansionTileKeys[0]} : ${report[1].surveyId[0]
          .questionAndPageIds.length}");
      emitter(state.copyWith(expansionTileKeys: expansionTileKeys,
          scrollController: AutoScrollController(
              viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, 0),
              axis: Axis.vertical
          )));
    }
    emitter(state.copyWith(
      isShowProgress: false,
      listReport: report[1].surveyId,
      listSelected: listSelected,
      listVisible: listVisible,
      listController: listController,
      listControllerTable: listControllerTable,
      listTable: listTable,
      listControllerTableField: listControllerTableField,
      listTableField: listTableField,
      listSelectedInspector: listSelectedInspector,
      listInputModel: listInputModel,
    ));
  }

  void addTableRow(List<dynamic> items, List<TableQuestion> listTable, int id) {
    for (dynamic item in items) {
      if (item is Question) {
        if (item.questionType == 'table') {
          List<Question> list = [];
          if (item.userInputLines.isNotEmpty) {
            for (RowLine row in item.userInputLines) {
              List<Answer> listAs = [];
              for (Answer answer in row.userInputLineId) {
                Answer clonedAnswer = Answer.copy(answer);
                clonedAnswer.id = clonedAnswer.suggestedAnswerId;
                if (clonedAnswer.tableRowId == null ||
                    clonedAnswer.tableRowId == -1) {
                  clonedAnswer.tableRowId = row.rowId;
                  clonedAnswer.rowId = row.rowId;
                }
                List<Answer> las = [];
                for (Answer as in clonedAnswer.suggestedAnswerIds) {
                  Answer clonedAs = Answer.copy(as);
                  clonedAs.id = clonedAs.suggestedAnswerId;
                  if (clonedAs.tableRowId == null ||
                      clonedAs.tableRowId == -1) {
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
            for (int i = item.userInputLines.last.rowId! + 1; i <
                item.userInputLines.last.rowId! + 2; i++) {
              List<Answer> listAs = [];
              for (Answer answer in item.suggestedAnswerIds) {
                Answer clonedAnswer = Answer.copy(answer);
                clonedAnswer.tableRowId = i;
                List<Answer> las = [];
                for (Answer as in clonedAnswer.suggestedAnswerIds) {
                  Answer clonedAs = Answer.copy(as);
                  clonedAs.tableRowId = i;
                  las.add(clonedAs);
                }
                if (clonedAnswer.suggestedAnswerIds.isNotEmpty) {
                  clonedAnswer.suggestedAnswerIds = las;
                }
                listAs.add(clonedAnswer);
              }
              Question qs = Question.copy(item);
              qs.suggestedAnswerIds = listAs;
              qs.rowId = i;
              list.add(qs);
            }
          } else {
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
      id = 1;
    }

    // Gọi đệ quy sau khi xử lý toàn bộ danh sách items
    for (dynamic item in items) {
      if (item is Question) {
        addTableRow(item.questionAndPageIds, listTable, id);
      }
    }
  }

  void addTableFieldRow(List<dynamic> items, List<TableQuestion> listTable, int id, List<People> listFarm) {
    for (dynamic item in items) {
      if (item is Question) {
        if (item.questionType == 'table_field') {
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
                /*int index = listFarm[(row.rowId ?? -1)-1].linkkinkField.indexWhere((element) =>
                element.id == clonedAnswer.linkingField);
                if(index != -1){
                  clonedAnswer.valueRowTable = listFarm[(row.rowId ?? -1)-1].linkkinkField[index].name;
                }*/
                List<Answer> las = [];
                for (Answer as in clonedAnswer.suggestedAnswerIds) {
                  Answer clonedAs = Answer.copy(as);
                  clonedAs.id = clonedAs.suggestedAnswerId;
                  if (clonedAs.tableRowId == null || clonedAs.tableRowId == -1) {
                    clonedAs.tableRowId = row.rowId;
                    clonedAs.rowId = row.rowId;
                  }
                  /*int index = listFarm[(row.rowId ?? -1)-1].linkkinkField.indexWhere((element) =>
                  element.id == clonedAs.linkingField);
                  if(index != -1){
                    clonedAs.valueRowTable = listFarm[(row.rowId ?? -1)-1].linkkinkField[index].name;
                  }*/
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
          }
          listTable.add(TableQuestion(item.id!, item.title!, list));
        }
      }
      id = 0;
    }

    // Gọi đệ quy sau khi xử lý toàn bộ danh sách items
    for (dynamic item in items) {
      if (item is Question) {
        addTableFieldRow(item.questionAndPageIds, listTable, id, listFarm);
      }
    }
  }

  List<List<Select>> createSelectLists(List<Question> questions) {
    List<List<Select>> selectLists = [];

    for (Question question in questions) {
      List<Select> selectList = [];

      // Thêm Select cho câu hỏi cha
      selectList.add(Select(question.idSelected!, question.checkResult ?? false,
          question.title!));

      // Gọi hàm đệ quy để thêm Select cho câu hỏi và câu trả lời con
      initSelectValues(question, selectList);

      selectLists.add(selectList);
    }

    return selectLists;
  }

  List<List<ListInputModel>> createInputLists(List<Question> questions) {
    List<List<ListInputModel>> selectLists = [];

    for (Question question in questions) {
      List<ListInputModel> selectList = [];

      // Thêm Select cho câu hỏi cha
      if (question.questionType == 'date' ||
          question.questionType == 'datetime') {
        InputRegisterModel inputRegisterModel;
        print(
            "HoangCV: question.valueResult: ${question.valueResult} : ${question
                .title}");
        if (question.valueResult != null) {
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
        } else {
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
        selectList.add(ListInputModel(
            question.idSelected!, inputRegisterModel, TextEditingController()));
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
        if (childQuestion.questionType == 'date' ||
            childQuestion.questionType == 'datetime') {
          InputRegisterModel inputRegisterModel;
          print("HoangCV: childQuestion.valueResult: ${childQuestion
              .valueResult}");
          if (childQuestion.valueResult != null) {
            inputRegisterModel = InputRegisterModel<String, DateTime>(
                title: "",
                isCompulsory: false,
                typeInputEnum: TypeInputEnum.date,
                type: TypeInputRegister.Select,
                valueSelected: Utils.formatStringToDate(
                    childQuestion.valueResult!),
                //controller: state.startTimeController,
                noBorder: true,
                textAlign: TextAlign.left
              //icon: Icons.calendar_today
            );
          } else {
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
          selectList.add(ListInputModel(
              childQuestion.idSelected!, inputRegisterModel,
              TextEditingController()));
        }
        initInputValues(childQuestion, selectList);
      }
    }
    else if (item is Answer) {
      // Gọi hàm đệ quy cho danh sách câu hỏi con của câu trả lời con
      for (Question childQuestion in item.questionAndPageIds) {
        if (childQuestion.questionType == 'date' ||
            childQuestion.questionType == 'datetime') {
          InputRegisterModel inputRegisterModel;
          print("HoangCV: childQuestion.valueResult: ${childQuestion
              .valueResult}");
          if (childQuestion.valueResult != null) {
            inputRegisterModel = InputRegisterModel<String, DateTime>(
                title: "",
                isCompulsory: false,
                typeInputEnum: TypeInputEnum.date,
                type: TypeInputRegister.Select,
                valueSelected: Utils.formatStringToDate(
                    childQuestion.valueResult!),
                //controller: state.startTimeController,
                noBorder: true,
                textAlign: TextAlign.left
              //icon: Icons.calendar_today
            );
          } else {
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
          selectList.add(ListInputModel(
              childQuestion.idSelected!, inputRegisterModel,
              TextEditingController()));
        }
        initInputValues(childQuestion, selectList);
      }

      // Gọi hàm đệ quy cho danh sách câu trả lời con của câu trả lời con
      for (Answer childAnswer in item.suggestedAnswerIds) {
        initInputValues(childAnswer, selectList);
      }
    }
  }

  void initSelectValues(dynamic item, List<Select> selectList) {
    if (item is Question) {
      // Gọi hàm đệ quy cho danh sách câu trả lời con
      for (Answer answer in item.suggestedAnswerIds) {
        List<int> selectedIdsList = item.suggestedAnswerIds.map((
            answer) => answer.idSelected!).toList();
        List<int> selectedIdsListSub = answer.questionAndPageIds.map((qs) =>
        qs.idSelected!).toList();
        /*print(
            "HoangCV: Question:1 ${item.title} : ${item.questionType} : ${answer.value} : ${answer.idSelected} : ${answer.checkResult}");
        */
        selectList.add(Select(answer.idSelected!, answer.checkResult ?? false,
            answer.value!, listId: selectedIdsList,
            listSubId: selectedIdsListSub,
            type: item.questionType ?? '')); // Thêm Select cho câu trả lời con
        initSelectValues(answer, selectList);
      }

      // Gọi hàm đệ quy cho danh sách câu hỏi con
      for (Question childQuestion in item.questionAndPageIds) {
        /*print(
            "HoangCV: childQuestion:1 ${item.title} : ${childQuestion.title} : ${childQuestion.idSelected} : ${childQuestion.checkResult}");
        */ selectList.add(Select(
            childQuestion.idSelected!, childQuestion.checkResult ?? false,
            childQuestion.title!, listId: [],
            listSubId: [])); // Thêm Select cho câu hỏi con
        initSelectValues(childQuestion, selectList);
      }
    } else if (item is Answer) {
      // Gọi hàm đệ quy cho danh sách câu hỏi con của câu trả lời con
      for (Question childQuestion in item.questionAndPageIds) {
        //   List<int> selectedIdsList = item.questionAndPageIds.map((answer) => answer.idSelected!).toList();
        /*print(
            "HoangCV: childQuestion: ${item.value} : ${childQuestion.title} : ${childQuestion.idSelected} : ${childQuestion.checkResult}");
        */ selectList.add(Select(
            childQuestion.idSelected!,
            childQuestion.checkResult ?? false,
            childQuestion
                .title!, /*listId: selectedIdsList*/parentId: item
            .idSelected!)); // Thêm Select cho câu hỏi con của câu trả lời con
        initSelectValues(childQuestion, selectList);
      }

      // Gọi hàm đệ quy cho danh sách câu trả lời con của câu trả lời con
      for (Answer childAnswer in item.suggestedAnswerIds) {
        /*print(
            "HoangCV: childAnswer: ${item.value} : ${childAnswer.value} : ${childAnswer.idSelected} : ${childAnswer.checkResult} : ${childAnswer.valueRowTable}");
        */ selectList.add(Select(
            childAnswer.idSelected!,
            childAnswer.checkResult ?? false,
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
        selectList.add(
            Visible(childAnswer.idSelected!, false, childAnswer.value!));
        initVisibleValues(childAnswer, selectList);
      }

      for (Question childQuestion in item.questionAndPageIds) {
        //print("HoangCV: Visible: ${item.title} : ${childQuestion.title} : ${childQuestion.idSelected}");
        selectList.add(
            Visible(childQuestion.idSelected!, false, childQuestion.title!));
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
      textEditingControllerList.add(Controller(question.idSelected!,
          TextEditingController(text: question.valueResult ?? ''),
          checkQuestionType(question.questionType ?? ''), question.title!));

      // Gọi hàm đệ quy để thêm TextEditingController cho câu hỏi và câu trả lời con
      initTextControllers(question, textEditingControllerList);

      textEditingControllerLists.add(textEditingControllerList);
    }

    return textEditingControllerLists;
  }

  List<List<Controller>> createTECTBLists(List<TableQuestion> tableQs) {
    final List<List<Controller>> textEditingControllerLists = [];
    tableQs.forEach((questions) {
      for (Question question in questions.listQuestion) {
        final List<Controller> textEditingControllerList = [];

        // Thêm TextEditingController cho câu hỏi cha
        textEditingControllerList.add(
            Controller(question.idSelected!, TextEditingController(),
                checkQuestionType(question.questionType ?? ''),
                question.title!));

        // Gọi hàm đệ quy để thêm TextEditingController cho câu hỏi và câu trả lời con
        initTextControllersTable(question, textEditingControllerList);

        textEditingControllerLists.add(textEditingControllerList);
      }
    });
    return textEditingControllerLists;
  }

  List<List<Controller>> createTECTBListsField(
      List<TableQuestion> tableQs,) {
    final List<List<Controller>> textEditingControllerLists = [];
    tableQs.forEach((questions) {
      for (Question question in questions.listQuestion) {
        final List<Controller> textEditingControllerList = [];

        // Thêm TextEditingController cho câu hỏi cha
        textEditingControllerList.add(Controller(question.idSelected!, TextEditingController()
            , checkQuestionType(question.questionType ?? ''), question.title!));

        // Gọi hàm đệ quy để thêm TextEditingController cho câu hỏi và câu trả lời con
        initTextControllersTableField(question, textEditingControllerList);

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
      //print("HoangCV: initTextControllersTable: ${item.rowId} : ${item.idSelected}");
      for (Question childQuestion in item.questionAndPageIds) {
        textEditingControllerList.add(
            Controller(childQuestion.idSelected!, TextEditingController(text: childQuestion.valueResult ?? ''),
                checkQuestionType(childQuestion.questionType ?? ''), childQuestion.title!));
        initTextControllersTable(childQuestion, textEditingControllerList);
      }

      for (Answer childAnswer in item.suggestedAnswerIds) {
        //print("HoangCV: childAnswer selectionAnswerIds111: ${childAnswer.isSelectionAnswer} : ${childAnswer.selectionAnswerIds} : ${childAnswer.value}");

        if(childAnswer.isSelectionAnswer == true) {
          //print("HoangCV: childAnswer selectionAnswerIds: ${childAnswer.rowId} : ${childAnswer.selectionAnswerIds} : ${childAnswer.value}");
          int index = childAnswer.selectionAnswerIds.indexWhere((element) => element.id == childAnswer.tableAnswerId);
          textEditingControllerList.add(
              Controller(childAnswer.idSelected!, TextEditingController(text: childAnswer.valueRowTable ?? ''),
                  checkQuestionType(
                      childAnswer.commentAnswer == true ? '' : ''),
                  childAnswer.value!,
                  idRow: childAnswer.tableRowId, title: childAnswer.value,
                  constrMandatory: childAnswer.constrMandatory,
                  input: InputRegisterModel<ItemBasic, ItemBasic>(
                      noBorder: true,
                      title: "",
                      isCompulsory: false,
                      type: TypeInputRegister.Select,
                      icon: Icons.arrow_drop_down,
                      positionSelected: index != -1 ? index : -1,
                      listValue: childAnswer.selectionAnswerIds,
                      valueSelected: index != -1 ? childAnswer.selectionAnswerIds[index] : null,
                      controller: TextEditingController(text: index != -1 ? childAnswer.selectionAnswerIds[index].name : ""),
                      typeInputEnum: TypeInputEnum.dmucItem,
                      textAlign: TextAlign.left
                  )));
        } else{
          textEditingControllerList.add(
              Controller(childAnswer.idSelected!, TextEditingController(text: childAnswer.valueRowTable ?? ''),
                  checkQuestionType(
                      childAnswer.commentAnswer == true ? '' : ''),
                  childAnswer.value!,
                  idRow: childAnswer.tableRowId, title: childAnswer.value,
                  constrMandatory: childAnswer.constrMandatory));
        }
        initTextControllersTable(childAnswer, textEditingControllerList);
      }
    }
  }
  void initTextControllersTableField(dynamic item, List<Controller> textEditingControllerList) {
    if (item is Question || item is Answer) {
      //print("HoangCV: initTextControllersTable: ${item.rowId} : ${item.idSelected}");
      for (Question childQuestion in item.questionAndPageIds) {
        textEditingControllerList.add(
            Controller(childQuestion.idSelected!, TextEditingController(text: childQuestion.valueResult ?? ""),
                checkQuestionType(childQuestion.questionType ?? ''), childQuestion.title!));
        initTextControllersTableField(childQuestion, textEditingControllerList);
      }

      for (Answer childAnswer in item.suggestedAnswerIds) {
        //print("HoangCV: childAnswer selectionAnswerIds111: ${childAnswer.isSelectionAnswer} : ${childAnswer.selectionAnswerIds} : ${childAnswer.value}");

        if(childAnswer.isSelectionAnswer == true) {
          //print("HoangCV: childAnswer selectionAnswerIds real: ${childAnswer.rowId} : ${childAnswer.selectionAnswerIds} : ${childAnswer.value} : ${childAnswer.idSelected!}");
          int index = childAnswer.selectionAnswerIds.indexWhere((element) => element.id == childAnswer.tableAnswerId);
          textEditingControllerList.add(
              Controller(childAnswer.idSelected!, TextEditingController(text: childAnswer.valueRowTable ?? ''),
                  checkQuestionType(
                      childAnswer.commentAnswer == true ? '' : ''),
                  childAnswer.value!,
                  idRow: childAnswer.tableRowId, title: childAnswer.value,
                  constrMandatory: childAnswer.constrMandatory,
                  input: InputRegisterModel<ItemBasic, ItemBasic>(
                      noBorder: true,
                      title: "",
                      isCompulsory: false,
                      type: TypeInputRegister.Select,
                      icon: Icons.arrow_drop_down,
                      positionSelected: index != -1 ? index : -1,
                      listValue: childAnswer.selectionAnswerIds,
                      valueSelected: index != -1 ? childAnswer.selectionAnswerIds[index] : null,
                      controller: TextEditingController(text: index != -1 ? childAnswer.selectionAnswerIds[index].name : ""),
                      typeInputEnum: TypeInputEnum.dmucItem,
                      textAlign: TextAlign.left
                  )));
        } else if(childAnswer.linkingField != -1) {
          //print("HoangCV: childAnswer selectionAnswerIds real: ${childAnswer.rowId} : ${childAnswer.selectionAnswerIds} : ${childAnswer.value} : ${childAnswer.idSelected!}");
          textEditingControllerList.add(
              Controller(childAnswer.idSelected!, TextEditingController(text: childAnswer.valueRowTable),
                  "none",
                  childAnswer.value!,
                  idRow: childAnswer.tableRowId, title: childAnswer.value,
                  constrMandatory: childAnswer.constrMandatory));
        } else{
          //print("HoangCV: childAnswer selectionAnswerIds fake: ${childAnswer.rowId} : ${childAnswer.selectionAnswerIds} : ${childAnswer.value} : ${childAnswer.idSelected!}");

          textEditingControllerList.add(
              Controller(childAnswer.idSelected!, TextEditingController(text: childAnswer.valueRowTable ?? ""),
                  checkQuestionType(
                      childAnswer.commentAnswer == true ? '' : ''),
                  childAnswer.value!,
                  idRow: childAnswer.tableRowId, title: childAnswer.value,
                  constrMandatory: childAnswer.constrMandatory));
        }
        initTextControllersTableField(childAnswer, textEditingControllerList);
      }
    }
  }

  String checkQuestionType(String type) {
    switch (type) {
      case 'numerical_box':
        return 'number';
        break;
      default:
        return 'text';
        break;
    }
  }

  Future<FutureOr<void>> updateEditReport(UpdateEditReportEvent event,
      Emitter<EditReportState> emit) async {
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
      if (listQs[i].questionAndPageIds.isNotEmpty) {
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
      } else {
        for (int j = 0;
        j < listQs[i].suggestedAnswerIds.length;
        j++) {
          for (int k = 0;
          k < listQs[i].suggestedAnswerIds[j].questionAndPageIds.length;
          k++) {
            if (listQs[i].suggestedAnswerIds[j].questionAndPageIds[k]
                .idSelected == event.id) {
              listQs[i].suggestedAnswerIds[j].isError = false;
              listQs[i].suggestedAnswerIds[j].questionAndPageIds[k].isError =
              false;
              question = Question.copy(
                  listQs[i].suggestedAnswerIds[j].questionAndPageIds[k]);
              answerType = question.questionType ?? "";
              if (question.commentAnswer == true) {
                hasCommandAnswer = true;
              }
              /*answer = Answer.copy(
                    listQs[i].questionAndPageIds[h].suggestedAnswerIds[j]);*/
            }
          }
          if (listQs[i].suggestedAnswerIds[j].idSelected == event.id) {
            listQs[i].isError = false;
            question = Question.copy(listQs[i]);
            answer = Answer.copy(
                listQs[i].suggestedAnswerIds[j]);
            if (answer.commentAnswer == true) {
              hasCommandAnswer = true;
            }
            answerType = question.questionType ?? "";
            if (answerType == 'simple_choice') {
              listIdSuggested =
                  listQs[i].suggestedAnswerIds.map((item) => item.id ?? -1)
                      .toList();
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
    int index = event.listSelect.indexWhere((element) =>
    element.id == event.id);
    int indexController = event.listController.indexWhere((element) =>
    element.id == event.id);
    String text = indexController != -1 ? event.listController[indexController]
        .controller.text.toString() : '';
    if (event.value != null || event.value.isNotEmpty) {
      text = event.value;
    }
    QuestionUpload questionUpload;
    //print("HoangCV: question: ${question.id} : ${question.idSelected} : ${question.title} : ${answer.id} : ${answerType} : ${listIdSuggested} : $text : $index : ${event.listSelect[index].value}");
    if (answerType == "check_box" && text.isNotEmpty && index != -1 &&
        event.listSelect[index].value == false) {

    } else
    if (answerType == "simple_choice" && text.isNotEmpty && index != -1 &&
        event.listSelect[index].value == false) {

    } else if (answerType == "char_box" && text.isEmpty) {

    } else if (answerType == "check_box" && text.isEmpty && hasCommandAnswer) {

    } else
    if (answerType == "simple_choice" && text.isEmpty && hasCommandAnswer) {

    } else {
      questionUpload = QuestionUpload(
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
          state: 'in_progress');

      ObjectResult result = await repository.uploadQuestion(questionUpload);
      if (result.responseCode == StatusConst.code00) {
        emit(state.copyWith(
            isShowProgress: false,
            reportId: result.response is int ? result.response : null,
            formStatus: SubmissionSuccess(/*success: result.message*/)));
      } else if (result.responseCode == StatusConst.code01) {
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionFailed(
                "Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.")));
      }
    }
  }

  Future<FutureOr<void>> updateEditTable(UpdateEditTableEvent event,
      Emitter<EditReportState> emit) async {
    emit(state.copyWith(
        isShowProgress: true, formStatus: const InitialFormStatus()));

    List<Question> listQs = state.listReport[0].questionAndPageIds;
    bool checkBreak = false;
    for (int i = 0; i < listQs.length; i++) {
      for (int h = 0; h < listQs[i].questionAndPageIds.length; h++) {
        if (listQs[i].questionAndPageIds[h].questionType == "table") {
          for (int k = 0; k <
              listQs[i].questionAndPageIds[h].suggestedAnswerIds.length; k++) {
            print("HoangCV: table controller: ${event.answerId} : ${listQs[i]
                .questionAndPageIds[h].suggestedAnswerIds[k].id} ");
            if (event.answerId ==
                listQs[i].questionAndPageIds[h].suggestedAnswerIds[k].id) {
              if (event.value.isNotEmpty) {
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

    if (event.value.isNotEmpty) {
      QuestionUpload questionUpload = QuestionUpload(
          userInputId: state.reportId,
          surveyId: state.listReport[0].id,
          questionId: event.questionId,
          suggestedAnswerId: event.answerId,
          answerType: 'table',
          valueText: event.value,
          isAnswerExist: true,
          tableRowId: event.rowId,
          listIdSuggested: [],
          state: 'in_progress'
      );
      ObjectResult result = await repository.uploadQuestion(questionUpload);
      if (result.responseCode == StatusConst.code00) {
        emit(state.copyWith(
            isShowProgress: false,
            reportId: result.response is int ? result.response : null,
            formStatus: SubmissionSuccess(/*success: result.message*/)));
      } else if (result.responseCode == StatusConst.code01) {
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionFailed(
                "Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.")));
      }
    }
  }

  Future<FutureOr<void>> updateAddTableField(
      UpdateAddTableFieldEvent event, Emitter<EditReportState> emit) async {
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
      if(state.listFarm.isEmpty){
        Toast.showLongTop("Lô trồng không thuộc quyền quản lý!\n Vui lòng kiểm tra lại.");
        return false;
/*        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionFailed(
                "Lô trồng không thuộc quyền quản lý!\n Vui lòng kiểm tra lại.")));*/
      } else {
        QuestionUpload questionUpload = QuestionUpload(
            userInputId: state.reportId,
            surveyId: state.listReport[0].id,
            questionId: event.questionId,
            suggestedAnswerId: event.answerId,
            answerType: 'table',
            valueText: event.value,
            isAnswerExist: true,
            tableRowId: event.rowId,
            rowLinkId: state.listFarm[event.rowId - 1].id,
            listIdSuggested: []
        );
        ObjectResult result = await repository.uploadQuestion(questionUpload);
        if (result.responseCode == StatusConst.code00) {
          emit(state.copyWith(
              isShowProgress: false,
              reportId: result.response is int ? result.response : null,
              formStatus: SubmissionSuccess(/*success: result.message*/)));
        } else if (result.responseCode == StatusConst.code01) {
          emit(state.copyWith(
              isShowProgress: false,
              formStatus: SubmissionFailed(
                  "Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.")));
        }
      }
    }
  }

  Future<FutureOr<void>> updateFarmerInspector(UpdateFarmerInspectorEvent event,
      Emitter<EditReportState> emit) async {
    state.farmerInspector!.monitoringVisitType = event.value;
    emit(state.copyWith(
        farmerInspector: state.farmerInspector
    ));
    if (state.reportId != null) {
      emit(state.copyWith(
          isShowProgress: true, formStatus: const InitialFormStatus()));

      FarmerInspectorUpload questionUpload = FarmerInspectorUpload(
        id: state.reportId,
        farmerId: state.farmerInspector!.farmerId,
        farmId: state.farmerInspector!.farmId,
        farmerCode: state.farmerInspector!.farmerCode,
        internalInspectorId: state.farmerInspector!.internalInspectorId,
        monitoringVisitType: state.farmerInspector!.monitoringVisitType,
        visitDate: state.farmerInspector!.visitDate,
      );
      ObjectResult result = await repository.editFarmerInspector(
          questionUpload);
      if (result.responseCode == StatusConst.code00) {
        emit(state.copyWith(
            isShowProgress: false,
            reportId: result.response is int ? result.response : null,
            formStatus: SubmissionSuccess()));
      } else if (result.responseCode == StatusConst.code01) {
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionFailed(
                "Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.")));
      }
    }
  }

  Future<FutureOr<void>> submitReport(SubmitReportEvent event,
      Emitter<EditReportState> emit) async {
    emit(state.copyWith(
        isShowProgress: true, formStatus: const InitialFormStatus()));

    bool submit = true;
    List<Question> listQs = state.listReport[0].questionAndPageIds;
    for (int i = 0; i < listQs.length; i++) {
      bool checkBreak = false;
      //print("HoangCV: title: ${listQs[i].title}");
      for (int h = 0; h < listQs[i].questionAndPageIds.length; h++) {
        //("HoangCV: listQs[i].questionAndPageIds: ${listQs[i].questionAndPageIds[h].title} : ${listQs[i].questionAndPageIds[h].constrMandatory}");
        if (listQs[i].questionAndPageIds[h].constrMandatory == true) {
          //print("HoanmgCV:h: ${listQs[i].questionAndPageIds[h].title}");
          String qsType = listQs[i].questionAndPageIds[h].questionType ?? "";
          Question qs = listQs[i].questionAndPageIds[h];
          if (qsType == "check_box") {
            int indexQs = -1;
            state.listSelected.forEach((element) {
              indexQs = element.indexWhere((el) => el.id == qs.idSelected);
              if (indexQs != -1) {
                //đoạn này phải check th: nếu là câu check box thuộc câu con, mà câu trl cha có tich thì mới check .
                if (qs.commentAnswer == true) {
                  if (!element[indexQs].value) {
                    checkBreak = true;
                    listQs[i].questionAndPageIds[h].isError = true;
                    Toast.showLongTop("Vui lòng chọn đáp án cho câu ${listQs[i]
                        .questionAndPageIds[h].title}");
                    submit = false;
                  } else {
                    int indexCtrl = -1;
                    state.listController.forEach((element) {
                      indexCtrl =
                          element.indexWhere((el) => el.id == qs.idSelected);
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
                }
              }
            });
          }
          else if (qsType == "simple_choice" || qsType == "multi_choice") {
            int indexAs = -1;
            bool checkPass = false;
            state.listSelected.forEach((element) {
              for (int a = 0; a < qs.suggestedAnswerIds.length; a++) {
                indexAs = element.indexWhere((el) => el.id ==
                    qs.suggestedAnswerIds[a].idSelected);
                if (indexAs != -1) {
                  if (element[indexAs].value) {
                    print("HoangCVqs.suggestedAnswerIds[a]: ${qs
                        .suggestedAnswerIds[a].value} : ${qs
                        .suggestedAnswerIds[a].commentAnswer}");
                    checkPass = true;
                    if (qs.suggestedAnswerIds[a].commentAnswer == true) {
                      int indexCtrl = -1;
                      state.listController.forEach((element) {
                        indexCtrl = element.indexWhere((el) =>
                        el.id == qs.suggestedAnswerIds[a].idSelected);
                        if (indexCtrl != -1 && element[indexCtrl].controller
                            .text.isEmpty) {
                          checkBreak = true;
                          listQs[i].questionAndPageIds[h].suggestedAnswerIds[a]
                              .isError = true;
                          Toast.showLongTop(
                              "Vui lòng nhập đáp án cho câu ${qs
                                  .suggestedAnswerIds[a].value}");
                          submit = false;
                        }
                      });
                    }
                    for (int b = 0; b <
                        qs.suggestedAnswerIds[a].questionAndPageIds
                            .length; b++) {
                      int indexQS;
                      state.listSelected.forEach((element) {
                        for (int a = 0; a < qs.suggestedAnswerIds[a]
                            .questionAndPageIds.length; a++) {
                          indexQS = element.indexWhere((el) =>
                          el.id ==
                              qs.suggestedAnswerIds[a].questionAndPageIds[b]
                                  .idSelected);
                          if (indexQS != -1) {
                            print("HoangCASCSDV:");
                            if (qs.suggestedAnswerIds[a].questionAndPageIds[b]
                                .questionType == "check_box") {
                              if (qs.suggestedAnswerIds[a].questionAndPageIds[b]
                                  .commentAnswer == true) {
                                if (element[indexAs].value) {
                                  int indexCtrl = -1;
                                  state.listController.forEach((element) {
                                    indexCtrl = element.indexWhere((el) =>
                                    el.id == qs.suggestedAnswerIds[a]
                                        .questionAndPageIds[b].idSelected);
                                    if (indexCtrl != -1 &&
                                        element[indexCtrl].controller.text
                                            .isEmpty) {
                                      checkBreak = true;
                                      listQs[i].questionAndPageIds[h]
                                          .suggestedAnswerIds[a]
                                          .questionAndPageIds[b].isError = true;
                                      print(
                                          "HoangCVqs.questionAndPageIds[b]: ${listQs[i]
                                              .questionAndPageIds[h]
                                              .suggestedAnswerIds[a]
                                              .questionAndPageIds[b].title}");
                                      Toast.showLongTop(
                                          "Vui lòng nhập đáp án cho câu "
                                              "${qs.suggestedAnswerIds[a]
                                              .questionAndPageIds[b].title}");
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
                                print("HoangCV:buubu ${listQs[i]
                                    .questionAndPageIds[h].title}");
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
            if (!checkPass) {
              print("HjoangCV : ${qs.title}");
              state.listSelected.forEach((element) {
                for (int a = 0; a < qs.suggestedAnswerIds.length; a++) {
                  indexAs = element.indexWhere((el) =>
                  el.id ==
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
                        (state.scrollController ?? AutoScrollController())
                            .scrollToIndex(
                          i,
                          preferPosition: AutoScrollPosition
                              .begin, // Scroll position (begin, middle, end)
                          //duration: Duration(seconds: 1), // Duration of the scroll animation
                        );
                        checkBreak = true;
                        listQs[i].questionAndPageIds[h].isError = true;

                        print("HoangCV:buubu ${listQs[i].questionAndPageIds[h]
                            .title} : "
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
          else if (qsType == "datetime" || qsType == "date") {
            int indexCtrl = -1;
            print("Hoangcv111 : ${qs.idSelected} ${qs.id} : ");
            state.listInputModel.forEach((element) {
              indexCtrl = element.indexWhere((el) =>
              el.id == qs.idSelected);
              print("Hoangcv11113213 : ${element.length > 0
                  ? element.first.id
                  : 0} : ${indexCtrl} ");
              if (indexCtrl != -1) {
                print(
                    "indexCtrl : ${element[indexCtrl].inputModel.valueSelected!
                        .toString().isNotEmpty} : ${indexCtrl} ");
              }
              if (indexCtrl != -1 &&
                  element[indexCtrl].inputModel.valueSelected!
                      .toString().isEmpty) {
                checkBreak = true;
                listQs[i].questionAndPageIds[h].isError = true;
                Toast.showLongTop(
                    "Vui lòng nhập đáp án cho câu ${listQs[i]
                        .questionAndPageIds[h].title}");
                submit = false;
              }
            });
          } else {
            int indexCtrl = -1;
            print("Hoangcv111");
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
        } else {
          for (int l = 0;
          l < listQs[i].questionAndPageIds[h].questionAndPageIds.length;
          l++) {
            print(
                "HoangCV: listQs[i].questionAndPageIds,questionAndPageIds: ${listQs[i]
                    .questionAndPageIds[h].questionAndPageIds[l].title} :"
                    " ${listQs[i].questionAndPageIds[h].questionAndPageIds[l]
                    .constrMandatory} ");
            if (listQs[i].questionAndPageIds[h].questionAndPageIds[l]
                .constrMandatory == true) {
              String qsType = listQs[i].questionAndPageIds[h]
                  .questionAndPageIds[l].questionType ?? "";
              Question qs = listQs[i].questionAndPageIds[h]
                  .questionAndPageIds[l];
              print("HoanmgCV:l: ${qs.title} : ${qsType}");
              if (qsType == "check_box") {
                int indexQs = -1;
                state.listSelected.forEach((element) {
                  indexQs = element.indexWhere((el) => el.id == qs.idSelected);
                  if (indexQs != -1) {
                    //đoạn này phải check th: nếu là câu check box thuộc câu con, mà câu trl cha có tich thì mới check .
                    if (qs.commentAnswer == true) {
                      if (!element[indexQs].value) {
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
                          if (indexCtrl != -1 && element[indexCtrl].controller
                              .text.isEmpty) {
                            checkBreak = true;
                            listQs[i].questionAndPageIds[h].isError = true;
                            Toast.showLongTop(
                                "Vui lòng nhập đáp án cho câu ${listQs[i]
                                    .questionAndPageIds[h].title}");
                            submit = false;
                          }
                        });
                      }
                    }
                  }
                });
              } else
              if (qsType == "simple_choice" || qsType == "multi_choice") {
                int indexAs = -1;
                bool checkPass = false;
                state.listSelected.forEach((element) {
                  for (int a = 0; a < qs.suggestedAnswerIds.length; a++) {
                    indexAs = element.indexWhere((el) => el.id ==
                        qs.suggestedAnswerIds[a].idSelected);
                    if (indexAs != -1) {
                      if (element[indexAs].value) {
                        print("HoangCVqs.suggestedAnswerIds[a] sub : ${qs
                            .suggestedAnswerIds[a].value} : ${qs
                            .suggestedAnswerIds[a].commentAnswer}");
                        checkPass = true;
                        if (qs.suggestedAnswerIds[a].commentAnswer == true) {
                          int indexCtrl = -1;
                          state.listController.forEach((element) {
                            indexCtrl = element.indexWhere((el) => el.id ==
                                qs.suggestedAnswerIds[a].idSelected);
                            if (indexCtrl != -1 &&
                                element[indexCtrl].controller.text.isEmpty) {
                              checkBreak = true;
                              qs.suggestedAnswerIds[a].isError = true;
                              Toast.showLongTop(
                                  "Vui lòng nhập đáp án cho câu ${qs
                                      .suggestedAnswerIds[a].value}");
                              submit = false;
                            }
                          });
                        }
                        for (int b = 0; b <
                            qs.suggestedAnswerIds[a].questionAndPageIds
                                .length; b++) {
                          int indexQS;
                          state.listSelected.forEach((element) {
                            for (int a = 0; a <
                                qs.suggestedAnswerIds[a].questionAndPageIds
                                    .length; a++) {
                              indexQS = element.indexWhere((el) =>
                              el.id ==
                                  qs.suggestedAnswerIds[a].questionAndPageIds[b]
                                      .idSelected);
                              if (indexQS != -1) {
                                print("HoangCASCSDV sub:");
                                if (qs.suggestedAnswerIds[a]
                                    .questionAndPageIds[b].questionType ==
                                    "check_box") {
                                  if (qs.suggestedAnswerIds[a]
                                      .questionAndPageIds[b]
                                      .commentAnswer == true) {
                                    if (element[indexAs].value) {
                                      int indexCtrl = -1;
                                      state.listController.forEach((element) {
                                        indexCtrl = element.indexWhere((el) =>
                                        el.id == qs.suggestedAnswerIds[a]
                                            .questionAndPageIds[b].idSelected);
                                        if (indexCtrl != -1 &&
                                            element[indexCtrl].controller.text
                                                .isEmpty) {
                                          checkBreak = true;
                                          qs.suggestedAnswerIds[a]
                                              .questionAndPageIds[b].isError =
                                          true;
                                          print(
                                              "HoangCVqs.questionAndPageIds[b] sub : ${qs
                                                  .suggestedAnswerIds[a]
                                                  .questionAndPageIds[b]
                                                  .title}");
                                          Toast.showLongTop(
                                              "Vui lòng nhập đáp án cho câu "
                                                  "${qs.suggestedAnswerIds[a]
                                                  .questionAndPageIds[b]
                                                  .title}");
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
                                        "Vui lòng chọn đáp án cho câu ${qs
                                            .title}");
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
                if (!checkPass) {
                  print("HjoangCV sub : ${qs.title}");
                  state.listSelected.forEach((element) {
                    for (int a = 0; a < qs.suggestedAnswerIds.length; a++) {
                      indexAs = element.indexWhere((el) =>
                      el.id ==
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
                            (state.scrollController ?? AutoScrollController())
                                .scrollToIndex(
                              i,
                              preferPosition: AutoScrollPosition
                                  .begin, // Scroll position (begin, middle, end)
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
              else {
                checkBreak = true;
                qs.isError = true;
                Toast.showLongTop("Vui lòng nhập đáp án cho câu ${listQs[i]
                    .questionAndPageIds[h].title}");
                submit = false;
              }
            } else {
              for (int m = 0;
              m < listQs[i].questionAndPageIds[h].questionAndPageIds[l]
                  .suggestedAnswerIds.length;
              m++) {
                for (int n = 0;
                n < listQs[i].questionAndPageIds[h].questionAndPageIds[l]
                    .suggestedAnswerIds[m].questionAndPageIds.length;
                n++) {
                  if (listQs[i].questionAndPageIds[h].questionAndPageIds[l]
                      .suggestedAnswerIds[m].
                  questionAndPageIds[n].constrMandatory == true) {
                    print("HoanmgCV:n: ${listQs[i].questionAndPageIds[h]
                        .questionAndPageIds[l].suggestedAnswerIds[m]
                        .questionAndPageIds[n].title}");
                    String qsType = listQs[i].questionAndPageIds[h]
                        .questionAndPageIds[l].suggestedAnswerIds[m]
                        .questionAndPageIds[n].questionType ?? "";
                    Question qs = listQs[i].questionAndPageIds[h]
                        .questionAndPageIds[l].suggestedAnswerIds[m]
                        .questionAndPageIds[n];
                    if (qsType == "simple_choice" || qsType == "multi_choice" ||
                        qsType == "check_box") {
                      int indexQs = -1;
                      state.listSelected.forEach((element) {
                        indexQs =
                            element.indexWhere((el) => el.id == qs.idSelected);
                        if (indexQs != -1) {
                          //đoạn này phải check th: nếu là câu check box thuộc câu con, mà câu trl cha có tich thì mới check .
                          if (qs.commentAnswer == true) {
                            if (!element[indexQs].value) {
                              checkBreak = true;
                              listQs[i].questionAndPageIds[h]
                                  .questionAndPageIds[l].suggestedAnswerIds[m]
                                  .questionAndPageIds[n].isError = true;
                              Toast.showLongTop("Vui lòng chọn đáp án cho câu "
                                  "${listQs[i].questionAndPageIds[h]
                                  .questionAndPageIds[l].suggestedAnswerIds[m]
                                  .questionAndPageIds[n].title}");
                              submit = false;
                            } else {
                              int indexCtrl = -1;
                              state.listController.forEach((element) {
                                indexCtrl = element.indexWhere((el) => el.id ==
                                    qs.idSelected);
                                if (indexCtrl != -1 &&
                                    element[indexCtrl].controller.text
                                        .isEmpty) {
                                  checkBreak = true;
                                  listQs[i].questionAndPageIds[h]
                                      .questionAndPageIds[l]
                                      .suggestedAnswerIds[m]
                                      .questionAndPageIds[n].isError = true;
                                  Toast.showLongTop(
                                      "Vui lòng nhập đáp án cho câu "
                                          "${listQs[i].questionAndPageIds[h]
                                          .questionAndPageIds[l]
                                          .suggestedAnswerIds[m]
                                          .questionAndPageIds[n].title}");
                                  submit = false;
                                }
                              });
                            }
                          }
                        }
                      });
                    } else {
                      print("asdasdj");
                      checkBreak = true;
                      listQs[i].questionAndPageIds[h].questionAndPageIds[l]
                          .suggestedAnswerIds[m].questionAndPageIds[n].isError =
                      true;
                      Toast.showLongTop("Vui lòng nhập đáp án cho câu "
                          "${listQs[i].questionAndPageIds[h]
                          .questionAndPageIds[l].suggestedAnswerIds[m]
                          .questionAndPageIds[n].title}");
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
            //print("HoangCV: listQs[i].suggestedAnswerIds: ${listQs[i].questionAndPageIds[h].suggestedAnswerIds[l].value}");
            int indexAsSub = -1;
            state.listSelected.forEach((element) {
              indexAsSub = element.indexWhere((el) => el.id ==
                  listQs[i].questionAndPageIds[h].suggestedAnswerIds[l]
                      .idSelected);
              if (indexAsSub != -1) {
                if (element[indexAsSub].value) {
                  for (int u = 0; u <
                      listQs[i].questionAndPageIds[h].suggestedAnswerIds[l]
                          .questionAndPageIds.length; u++) {
                    print("HoangCV: listQs[i].questionAndPageIds u:: "
                        "${listQs[i].questionAndPageIds[h].suggestedAnswerIds[l]
                        .questionAndPageIds[u].title} : "
                        "${listQs[i].questionAndPageIds[h].suggestedAnswerIds[l]
                        .questionAndPageIds[u].constrMandatory}");
                    if (listQs[i].questionAndPageIds[h].suggestedAnswerIds[l]
                        .questionAndPageIds[u].constrMandatory == true) {
                      print("HoanmgCV:h: ${listQs[i].questionAndPageIds[h]
                          .suggestedAnswerIds[l].questionAndPageIds[u].title}");
                      String qsType = listQs[i].questionAndPageIds[h]
                          .suggestedAnswerIds[l].questionAndPageIds[u]
                          .questionType ?? "";
                      Question qs = listQs[i].questionAndPageIds[h]
                          .suggestedAnswerIds[l].questionAndPageIds[u];
                      if (qsType == "check_box") {
                        int indexQs = -1;
                        //check box: ko tích thì vẫn là ko , còn nếu tích thì phải check comment answer
                        state.listSelected.forEach((element) {
                          indexQs = element.indexWhere((el) =>
                          el.id == qs.idSelected);
                          if (indexQs != -1) {
                            //đoạn này phải check th: nếu là câu check box thuộc câu con, mà câu trl cha có tich thì mới check .
                            if (qs.commentAnswer == true) {
                              if (!element[indexQs].value) {
                                checkBreak = true;
                                listQs[i].questionAndPageIds[h]
                                    .suggestedAnswerIds[l].questionAndPageIds[u]
                                    .isError = true;
                                Toast.showLongTop(
                                    "Vui lòng chọn đáp án cho câu ${qs.title}");
                                submit = false;
                              } else {
                                int indexCtrl = -1;
                                state.listController.forEach((element) {
                                  indexCtrl =
                                      element.indexWhere((el) => el.id ==
                                          qs.idSelected);
                                  if (indexCtrl != -1 &&
                                      element[indexCtrl].controller.text
                                          .isEmpty) {
                                    checkBreak = true;
                                    listQs[i].questionAndPageIds[h]
                                        .suggestedAnswerIds[l]
                                        .questionAndPageIds[u].isError = true;
                                    Toast.showLongTop(
                                        "Vui lòng nhập đáp án cho câu ${qs
                                            .title}");
                                    submit = false;
                                  }
                                });
                              }
                            }
                          }
                        });
                      } else if (qsType == "simple_choice" ||
                          qsType == "multi_choice") {

                      } else {
                        int indexCtrl = -1;
                        print("12312");
                        state.listController.forEach((element) {
                          indexCtrl = element.indexWhere((el) =>
                          el.id == qs.idSelected);
                          if (indexCtrl != -1 &&
                              element[indexCtrl].controller.text.isEmpty) {
                            checkBreak = true;
                            listQs[i].questionAndPageIds[h]
                                .suggestedAnswerIds[l].questionAndPageIds[u]
                                .isError = true;
                            Toast.showLongTop(
                                "Vui lòng nhập đáp án cho câu ${qs.title}");
                            submit = false;
                          }
                        });
                      }
                      if (!submit) {
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
      if (checkBreak) {
        // print("HoangCV: index: $i");
        state.scrollController!.scrollToIndex(
            i + 1, preferPosition: AutoScrollPosition.begin);
        break;
      }
    }
    if (submit) {
      bool checkBreak = false;
      for (var element in state.listControllerTable) {
        for (var e in element) {
          print("HoangCV: table controller: ${e.title} : ${e.value} : ${e
              .controller.text.isEmpty} : ${e.constrMandatory}");
          if (e.constrMandatory == true && e.controller.text.isEmpty) {
            for (int i = 0; i < listQs.length; i++) {
              for (int h = 0; h < listQs[i].questionAndPageIds.length; h++) {
                if (listQs[i].questionAndPageIds[h].questionType == "table") {
                  for (int k = 0; k <
                      listQs[i].questionAndPageIds[h].suggestedAnswerIds
                          .length; k++) {
                    if (e.id ==
                        listQs[i].questionAndPageIds[h].suggestedAnswerIds[k]
                            .idSelected) {
                      listQs[i].questionAndPageIds[h].suggestedAnswerIds[k]
                          .isError = true;
                      if (!checkBreak) {
                        Toast.showLongTop(
                            "Vui lòng nhập đáp án cho cột ${e.value}");
                      }
                      submit = false;
                      checkBreak = true;
                    }
                    else {
                      for (int l = 0; l <
                          listQs[i].questionAndPageIds[h].suggestedAnswerIds[k]
                              .suggestedAnswerIds.length; l++) {
                        print("HoangCV: table controller:sub ${e.value} : ${e
                            .idRow} : ${e.id} : "
                            "${listQs[i].questionAndPageIds[h]
                            .suggestedAnswerIds[k].suggestedAnswerIds[l]
                            .idSelected} : $checkBreak");
                        if (e.id == listQs[i].questionAndPageIds[h]
                            .suggestedAnswerIds[k].suggestedAnswerIds[l]
                            .idSelected) {
                          listQs[i].questionAndPageIds[h].suggestedAnswerIds[k]
                              .suggestedAnswerIds[l].isError = true;
                          if (!checkBreak) {
                            Toast.showLongTop(
                                "Vui lòng nhập đáp án cho cột ${e.value}");
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
                state.scrollController!.scrollToIndex(
                    i + 1, preferPosition: AutoScrollPosition.begin);
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
    if (submit) {
      FarmerInspectorUpload questionUpload = FarmerInspectorUpload(
          id: state.reportId,
          state: 'done'
      );
      ObjectResult result = await repository.editFarmerInspector(
          questionUpload);
      if (result.responseCode == StatusConst.code00) {
        emit(state.copyWith(
            isShowProgress: false,
            reportId: result.response is int ? result.response : null,
            formStatus: SubmissionSuccess(success: "Sửa báo cáo đánh giá hoàn thành.")));
      } else if (result.responseCode == StatusConst.code01) {
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionFailed(
                "Dữ liệu không hợp lệ! \n Vui lòng kiểm tra lại.")));
      }
    }
  }

  FutureOr<void> addNewTableRow(AddTableRowEvent event,
      Emitter<EditReportState> emit) {
    emit(state.copyWith(
        isShowProgress: true
    ));
    List<TableQuestion> listTable = state.listTable.map((e) => TableQuestion.copy(e)).toList();
    //int indexTable = listTable.indexWhere((element) => element.id == event.idTable);
    int i = state.listTable[event.idTable].listQuestion.last.rowId! + 1;
    print("HoangCV:111bug ${state.listTable[event.idTable].listQuestion.last.rowId}");
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
        print("HoangCV:state.listTable e:  ${e.rowId} : ${e.userInputLines.last.userInputLineId.last.toJson()}");
      });
    });
  }

  void addNewRow(List<dynamic> items, List<TableQuestion> listTable, int id,
      int idTable) {
    for (dynamic item in items) {
      if (item is Question) {
        if (item.questionType == 'table') {
          print("HaongCV: item: ${item.title}");
          List<Question> list = listTable[idTable].listQuestion;
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
          //list.add(qs);
          listTable[idTable].listQuestion.add(qs);
          //listTable[idTable].listQuestion[0].userInputLines.add(RowLine(rowId: id, userInputLineId: listAs));
          //listTable.add(TableQuestion(item.id!, item.title!, list));
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

class AddTableRowEvent extends EditReportEvent {
  final List<Question> list;
  int idTable;

  AddTableRowEvent(this.list, this.idTable);

  @override
  List<Object?> get props => [list, idTable];
}

class EditReportEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetEditReportEvent extends EditReportEvent {
  final int id;

  GetEditReportEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class SubmitReportEvent extends EditReportEvent {

  SubmitReportEvent();

  @override
  List<Object?> get props => [];
}

class UpdateEditReportEvent extends EditReportEvent {
  final int id;
  final String value;
  final List<Select> listSelect;
  final List<Controller> listController;

  UpdateEditReportEvent(this.id, this.value, this.listSelect, {this.listController = const []});

  @override
  List<Object?> get props => [id, value, listSelect, listController];
}

class UpdateFarmerInspectorEvent extends EditReportEvent {
  final int id;
  final String value;
  final List<Select> listSelect;

  UpdateFarmerInspectorEvent(this.id, this.value, this.listSelect);

  @override
  List<Object?> get props => [id, value, listSelect];
}

class OnSelectValueEvent extends EditReportEvent {
  List<InputRegisterModel> list;
  int index;
  BuildContext context;
  int id;
  String type;

  OnSelectValueEvent(this.list, this.index, this.context, {this.id = -1, this.type = 'date'});

  @override
  List<Object?> get props => [list, index, context, id, type];
}

class OnSelectionValueEvent extends EditReportEvent {
  InputRegisterModel input;
  BuildContext context;
  final int questionId;
  final int answerId;
  final int rowId;

  OnSelectionValueEvent(this.input, this.context, this.questionId, this.answerId, this.rowId,);

  @override
  List<Object?> get props => [questionId, answerId, rowId, input, context,];
}

class OnSelectionFieldValueEvent extends EditReportEvent {
  InputRegisterModel input;
  BuildContext context;
  final int questionId;
  final int answerId;
  final int rowId;

  OnSelectionFieldValueEvent(this.input, this.context, this.questionId, this.answerId, this.rowId,);

  @override
  List<Object?> get props => [questionId, answerId, rowId, input, context,];
}

class UpdateAddTableFieldEvent extends EditReportEvent {
  final int questionId;
  final int answerId;
  final int rowId;
  final String value;

  UpdateAddTableFieldEvent(this.questionId, this.answerId, this.rowId, this.value);

  @override
  List<Object?> get props => [questionId, answerId, rowId, value];
}

class UpdateEditTableEvent extends EditReportEvent {
  final int questionId;
  final int answerId;
  final int rowId;
  final String value;

  UpdateEditTableEvent(this.questionId, this.answerId, this.rowId, this.value);

  @override
  List<Object?> get props => [questionId, answerId, rowId, value];
}

class EditReportState extends BlocState {
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
    listTableField,
    listControllerTable,
    listControllerTableField,
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
    indexFarm,
    indexFarmer,
    indexInspector,
    farmController,
    expansionTileKeys,
    scrollController,
    nameInspector,
  ];
  final Diary? detailDiary;
  final List<Report> listReport;
  final List<List<Select>> listSelected;
  final List<Select> listSelectedInspector;
  final List<List<Controller>> listController;
  final List<List<Controller>> listControllerTable;
  List<List<Controller>> listControllerTableField;
  List<TableQuestion> listTableField;
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
  final List<GlobalExpand> expansionTileKeys;
  AutoScrollController? scrollController = AutoScrollController();
  final String? nameInspector;

  final int? indexFarm;
  final int? indexFarmer;
  final int? indexInspector;

  EditReportState({
    this.detailDiary,
    this.formStatus = const InitialFormStatus(),
    this.isShowProgress = true,
    this.listReport = const [],
    this.listSelected = const [],
    this.listController = const [],
    this.listVisible = const [],
    this.listTable = const [],
    this.listTableField = const [],
    this.listControllerTable = const [],
    this.listControllerTableField = const [],
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
    this.expansionTileKeys = const [],
    this.scrollController,
    this.nameInspector,
  });

  EditReportState copyWith({
    Diary? detailDiary,
    FormSubmissionStatus? formStatus,
    bool? isShowProgress,
    List<Report>? listReport,
    List<List<Select>>? listSelected,
    List<List<Visible>>? listVisible,
    List<List<Controller>>? listController,
    List<TableQuestion>? listTable,
    List<TableQuestion>? listTableField,
    List<List<Controller>>? listControllerTable,
    List<List<Controller>>? listControllerTableField,
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
    List<GlobalExpand>? expansionTileKeys,
    AutoScrollController? scrollController,
    String? nameInspector,
  }) {
    return EditReportState(
        detailDiary: detailDiary ?? this.detailDiary,
        formStatus: formStatus ?? this.formStatus,
        isShowProgress: isShowProgress ?? this.isShowProgress,
        listReport: listReport ?? this.listReport,
        listSelected: listSelected ?? this.listSelected,
        listController: listController ?? this.listController,
        listVisible: listVisible ?? this.listVisible,
        listTable: listTable ?? this.listTable,
        listTableField: listTableField ?? this.listTableField,
        listControllerTable: listControllerTable ?? this.listControllerTable,
        listControllerTableField: listControllerTableField ?? this.listControllerTableField,
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
        expansionTileKeys: expansionTileKeys ?? this.expansionTileKeys,
        scrollController: scrollController ?? this.scrollController,
        nameInspector: nameInspector ?? this.nameInspector);
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
