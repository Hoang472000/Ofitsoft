import 'dart:async';

import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:diary_mobile/data/entity/report/question_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/entity/activity/activity_diary.dart';
import '../../../data/entity/diary/diary.dart';
import '../../../data/entity/item_default/material_entity.dart';
import '../../../data/local_data/diary_db.dart';
import '../../../data/repository.dart';
import '../../data/entity/report/answer.dart';
import '../../data/entity/report/question.dart';
import '../../data/entity/report/report.dart';
import '../../data/remote_data/object_model/object_result.dart';
import '../../utils/constants/status_const.dart';
import '../../utils/status/form_submission_status.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class AddReportBloc extends Bloc<AddReportEvent, AddReportState> {
  final Repository repository;

  AddReportBloc(this.repository) : super(AddReportState()) {
    on<GetAddReportEvent>(_getAddReport);
    on<UpdateAddReportEvent>(updateAddReport);
  }

  void _getAddReport(
      GetAddReportEvent event, Emitter<AddReportState> emitter) async {
    emitter(state.copyWith(isShowProgress: true));
    final report = await repository.getListActivityReport();
    List<List<Select>> listSelected = [];
    List<List<Visible>> listVisible = [];
    List<List<Controller>> listController = [];
    List<Question> listTable = [];
    if (report.isNotEmpty) {
      listSelected = createSelectLists(report[1].questionAndPageIds);
      listVisible = createVisibleLists(report[1].questionAndPageIds);
      listController = createTextEditingControllerLists(report[1].questionAndPageIds);
      listSelected.forEach((element) {
        print("HoangCV:listSelected:  ${element.length} : ${element[0].id}");
      });
      listController.forEach((element) {
        print("HoangCV:listController:  ${element.length} : ${element[0].id}");
      });
      int i = 0;
      addTableRow(report[1].questionAndPageIds, listTable);
      listTable.forEach((element) {
        print("HoangCV:listTable:  ${element.title} : ${element.suggestedAnswerIds[0].value}");
      });
      List<List<Controller>> listCtrlTable = createTextEditingControllerLists(listTable);
      listController.addAll(listCtrlTable);
      listController.forEach((element) {
        print("HoangCV:listController:  ${element.length} : ${element[0].id}");
      });
    }
    emitter(state.copyWith(
      isShowProgress: false,
      detailDiary: event.diary,
      listReport: report,
      listSelected: listSelected,
        listVisible: listVisible,
        listController: listController,
      listTable: listTable,
    ));
  }
  void addTableRow(List<dynamic> items, List<Question> listTable) {
    //for(int i = 0 ; i< 2; i++) {
      for (dynamic item in items) {
        if (item is Question) {
          if (item.questionType == 'table') {
            List<Answer> listAs = [];
            for (Answer answer in item.suggestedAnswerIds) {
              //answer.value = '';
              listAs.add(answer);
            }
            Question qs = item;
            qs.suggestedAnswerIds = listAs;
            listTable.add(qs);
          }
          addTableRow(item.questionAndPageIds, listTable);
        }
      }
    //}
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
        print(
            "HoangCV: Question:1 ${item.title} : ${item.questionType} : ${answer.value} : ${answer.idSelected} : ${selectedIdsList.toString()}");
        selectList.add(Select(answer.idSelected!, false,
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
                .title!, /*listId: selectedIdsList*/)); // Thêm Select cho câu hỏi con của câu trả lời con
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
/*  void initVisibleValues(dynamic item, List<Visible> selectList) {
    if (item is Question) {
      // Gọi hàm đệ quy cho danh sách câu trả lời con
      for (Answer answer in item.suggestedAnswerIds) {
        print(
            "HoangCV: Visible: ${item.title} : ${answer.value} : ${answer.idSelected}");
        selectList.add(Visible(answer.idSelected!, false,
            answer.value!)); // Thêm Select cho câu trả lời con
        initVisibleValues(answer, selectList);
      }

      // Gọi hàm đệ quy cho danh sách câu hỏi con
      for (Question childQuestion in item.questionAndPageIds) {
        selectList.add(Visible(childQuestion.idSelected!, false,
            childQuestion.title!)); // Thêm Select cho câu hỏi con
        initVisibleValues(childQuestion, selectList);
      }
    } else if (item is Answer) {
      // Gọi hàm đệ quy cho danh sách câu hỏi con của câu trả lời con
      for (Question childQuestion in item.questionAndPageIds) {
        selectList.add(Visible(
            childQuestion.idSelected!,
            false,
            childQuestion
                .title!)); // Thêm Select cho câu hỏi con của câu trả lời con
        initVisibleValues(childQuestion, selectList);
      }

      // Gọi hàm đệ quy cho danh sách câu trả lời con của câu trả lời con
      for (Answer childAnswer in item.suggestedAnswerIds) {
        print(
            "HoangCV: childAnswer: ${item.value} : ${childAnswer.value} : ${childAnswer.idSelected}");
        selectList.add(Visible(
            childAnswer.idSelected!,
            false,
            childAnswer
                .value!)); // Thêm Select cho câu trả lời con của câu trả lời con
        initVisibleValues(childAnswer, selectList);
      }
    }
  }*/
  List<List<Controller>> createTextEditingControllerLists(
      List<Question> questions) {
    final List<List<Controller>> textEditingControllerLists = [];

    for (Question question in questions) {
      final List<Controller> textEditingControllerList = [];

      // Thêm TextEditingController cho câu hỏi cha
      textEditingControllerList.add(Controller(question.idSelected!, TextEditingController(), checkQuestionType(question.questionType ?? '')));

      // Gọi hàm đệ quy để thêm TextEditingController cho câu hỏi và câu trả lời con
      initTextControllers(question, textEditingControllerList);

      textEditingControllerLists.add(textEditingControllerList);
    }

    return textEditingControllerLists;
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

/*  void initTextControllers(
      dynamic item, List<Controller> textEditingControllerList) {
    if (item is Question) {
      // Gọi hàm đệ quy cho danh sách câu trả lời con
      for (Answer answer in item.suggestedAnswerIds) {
        print("HoangCV: initTextControllers: ${item.title} : ${answer.idSelected} : ${answer.value}");
        textEditingControllerList.add(
            Controller(answer.idSelected!, TextEditingController(), checkQuestionType(answer.commentAnswer == true ? '': ''))); // Thêm TextEditingController cho câu trả lời con
        initTextControllers(answer, textEditingControllerList);
      }

      // Gọi hàm đệ quy cho danh sách câu hỏi con
      for (Question childQuestion in item.questionAndPageIds) {
        textEditingControllerList.add(
            Controller(childQuestion.idSelected!, TextEditingController(), checkQuestionType(childQuestion.questionType ?? ''))); // Thêm TextEditingController cho câu hỏi con
        initTextControllers(childQuestion, textEditingControllerList);
      }
    } else if (item is Answer) {
      // Gọi hàm đệ quy cho danh sách câu hỏi con của câu trả lời con
      for (Question childQuestion in item.questionAndPageIds) {
        textEditingControllerList.add(
            Controller(childQuestion.idSelected!, TextEditingController(), checkQuestionType(childQuestion.questionType ?? ''))); // Thêm TextEditingController cho câu hỏi con của câu trả lời con
        initTextControllers(childQuestion, textEditingControllerList);
      }

      // Gọi hàm đệ quy cho danh sách câu trả lời con của câu trả lời con
      for (Answer childAnswer in item.suggestedAnswerIds) {
        textEditingControllerList.add(
            Controller(childAnswer.idSelected!, TextEditingController(), checkQuestionType(childAnswer.commentAnswer == true ? '' : ''))); // Thêm TextEditingController cho câu trả lời con của câu trả lời con
        initTextControllers(childAnswer, textEditingControllerList);
      }
    }
  }*/
  void initTextControllers(dynamic item, List<Controller> textEditingControllerList) {
    if (item is Question || item is Answer) {
      for (Question childQuestion in item.questionAndPageIds) {
        textEditingControllerList.add(
            Controller(childQuestion.idSelected!, TextEditingController(), checkQuestionType(childQuestion.questionType ?? '')));
        initTextControllers(childQuestion, textEditingControllerList);
      }

      for (Answer childAnswer in item.suggestedAnswerIds) {
        textEditingControllerList.add(
            Controller(childAnswer.idSelected!, TextEditingController(), checkQuestionType(childAnswer.commentAnswer == true ? '' : '')));
        initTextControllers(childAnswer, textEditingControllerList);
      }
    }
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
    List<Question> listQs = state.listReport[1].questionAndPageIds;
    for (int i = 0; i < listQs.length; i++) {
      for (int h = 0; h < listQs[i].questionAndPageIds.length; h++) {
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
              }
            }
            if (listQs[i].questionAndPageIds[h].suggestedAnswerIds[j].idSelected ==event.id) {
              question = Question.copy(listQs[i].questionAndPageIds[h]);
              answer = Answer.copy(
                  listQs[i].questionAndPageIds[h].suggestedAnswerIds[j]);
              answerType = question.questionType ?? "";
              if(answerType == 'simple_choice'){
                listIdSuggested = listQs[i].questionAndPageIds[h].suggestedAnswerIds.map((item) => item.id ?? -1).toList();
              }
            }
          }
          for (int l = 0;
              l < listQs[i].questionAndPageIds[h].questionAndPageIds.length;
              l++) {
            if (listQs[i].questionAndPageIds[h].questionAndPageIds[l].idSelected == event.id) {
              question = Question.copy(
                  listQs[i].questionAndPageIds[h].questionAndPageIds[l]);
              answerType = question.questionType ?? "";
            }
          }
        }
      }
    }

    int index = event.listSelect.indexWhere((element) => element.id == event.id);
    print("HoangCV: question: ${question.id} : ${question.idSelected} : ${question.title} : ${answer.id} : ${answerType} : ${listIdSuggested} : ${event.listSelect[index].value}");
    QuestionUpload questionUpload = QuestionUpload(
      user_input_id: state.reportId,
      survey_id: state.listReport[1].id,
      question_id: question.id,
      suggested_answer_id: answer.id,
      answer_type: answerType == '' ? null : answerType,
      value_text: event.value,
      test_entry: false, // value default ko ro Anh Dung de lam gi
      is_answer_exist: index != -1 ? event.listSelect[index].value : false,
        table_row_id: 1,
        list_id_suggested: listIdSuggested
    );
    ObjectResult result = await repository.uploadQuestion(questionUpload);
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

class Select {
  int id;
  bool value;
  String title;
  List<int> listId;
  List<int> listSubId;
  String type;
  String typeSub;

  Select(this.id, this.value, this.title,
      {this.listId = const [],
      this.listSubId = const [],
      this.type = '',
      this.typeSub = ''});
}

class Visible {
  int id;
  bool value;
  String title;

  Visible(this.id, this.value, this.title);
}

class Controller {
  int id;
  int? idRow;
  TextEditingController controller;
  String type;

  Controller(this.id, this.controller, this.type, {this.idRow});
}

class AddReportEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetAddReportEvent extends AddReportEvent {
  final Diary diary;

  GetAddReportEvent(this.diary);

  @override
  List<Object?> get props => [diary];
}

class UpdateAddReportEvent extends AddReportEvent {
  final int id;
  final String value;
  final List<Select> listSelect;

  UpdateAddReportEvent(this.id, this.value, this.listSelect);

  @override
  List<Object?> get props => [id, value, listSelect];
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
      ];
  final Diary? detailDiary;
  final List<Report> listReport;
  final List<List<Select>> listSelected;
  final List<List<Controller>> listController;
  final List<List<Visible>> listVisible;
  final List<Question> listTable;
  final FormSubmissionStatus formStatus;
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
    List<Question>? listTable,
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
        reportId: reportId ?? this.reportId);
  }
}
