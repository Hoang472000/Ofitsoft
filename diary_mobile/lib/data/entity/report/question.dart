import 'dart:convert';
import 'package:diary_mobile/data/entity/report/answer.dart';

class Question {
  int? id;
  int? idSelected;
  int? pageId;
  int? parentTitleId;
  String? title;
  String? questionsSelection;
  String? questionType;
  bool? commentAnswer;
  int? triggeringQuestionId;
  int? triggeringAnswerId;
  List<Answer> suggestedAnswerIds;
  List<Question> questionAndPageIds;
  List<Question> questionParentTitleId;
  String? stringSuggestedAnswerIds;
  //check color
  bool? isError;

  int? rowId;
  // result
  bool? checkResult;
  String? valueResult;
  List<RowLine> userInputLines;
  // validate
  bool? constrMandatory;

  Question({
    this.id,
    this.idSelected,
    this.pageId,
    this.parentTitleId,
    this.title,
    this.commentAnswer,
    this.triggeringQuestionId,
    this.triggeringAnswerId,
    this.questionsSelection,
    this.questionType,
    this.suggestedAnswerIds = const [],
    this.questionAndPageIds = const [],
    this.stringSuggestedAnswerIds,
    this.rowId,
    this.questionParentTitleId = const [],
    this.isError,

    this.checkResult,
    this.valueResult,
    this.userInputLines = const [],

    this.constrMandatory,
  });

  Question.copy(Question other)
      : id = other.id,
        pageId = other.pageId,
        parentTitleId = other.parentTitleId,
        title = other.title,
        idSelected = other.idSelected,
        commentAnswer = other.commentAnswer,
        triggeringQuestionId = other.triggeringQuestionId,
        triggeringAnswerId = other.triggeringAnswerId,
        questionsSelection = other.questionsSelection,
        questionType = other.questionType,
        suggestedAnswerIds = other.suggestedAnswerIds
            .map((answer) => Answer.copy(answer))
            .toList(),
        questionAndPageIds = other.questionAndPageIds
            .map((question) => Question.copy(question))
            .toList(),
        questionParentTitleId = other.questionParentTitleId
            .map((question) => Question.copy(question))
            .toList(),
        rowId = other.rowId,
        checkResult = other.checkResult,
        valueResult = other.valueResult,
        stringSuggestedAnswerIds = other.stringSuggestedAnswerIds,
        userInputLines = other.userInputLines
            .map((row) => RowLine.copy(row))
            .toList(),
        constrMandatory = other.constrMandatory,
        isError= other.isError;

  factory Question.fromJson(Map<String, dynamic> json,
      {List<Question> questionAndPageIds = const [],List<Question> questionParentTitleId = const [], int idSelected = -1, int rowId = -1}) {
    return Question(
      id: json['id'] ?? -1,
      idSelected: idSelected,
      pageId: json['page_id'] ?? -1,
      parentTitleId: json['parent_title_id'] ?? -1,
      title: json['title'] ?? '',
      commentAnswer: json['comment_answer'] ?? false,
      triggeringQuestionId: json['triggering_question_id'] ?? -1,
      triggeringAnswerId: json['triggering_answer_id'] ?? -1,
      questionsSelection: json['questions_selection'] ?? '',
      questionType: json['question_type'] ?? '',
      suggestedAnswerIds: json['suggested_answer_ids'] != null
          ? (json['suggested_answer_ids'] as List<dynamic>)
              .map((itemJson) => Answer.fromJson(itemJson))
              .toList()
          : [],
      stringSuggestedAnswerIds:
          jsonEncode(json['suggested_answer_ids']) ?? '[]',
      questionAndPageIds: questionAndPageIds,
      questionParentTitleId: questionParentTitleId,
      rowId: rowId,

      checkResult: json['check_result'] ?? false,
      valueResult: json['value_result'] ?? '',
      userInputLines: json['user_input_lines'] != null
          ? (json['user_input_lines'] as List<dynamic>)
          .map((itemJson) => RowLine.fromJson(itemJson))
          .toList()
          : [],
        constrMandatory: json['constr_mandatory'] ?? false,
        isError: json['isError'] ?? false,
    );
  }

  String convertAnswerListToJson() {
    final List<Map<String, dynamic>> answerListJson =
        suggestedAnswerIds.map((answer) => answer.toJson()).toList();
    return jsonEncode(answerListJson);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['parent_title_id'] = parentTitleId;
    data['comment_answer'] = commentAnswer;
    data['triggering_question_id'] = triggeringQuestionId;
    data['triggering_answer_id'] = triggeringAnswerId;
    data['questions_selection'] = questionsSelection;
    data['question_type'] = questionType;
    data['suggested_answer_ids'] = suggestedAnswerIds;
    data['questionAndPageIds'] = questionAndPageIds;
    data['questionParentTitleId'] = questionParentTitleId;
    data['check_result'] = checkResult;
    data['value_result'] = valueResult;
    data['userInputLines'] = userInputLines;
    data['constr_mandatory'] = constrMandatory;
    data['isError'] = isError;
    return data;
  }
}

class RowLine{
   int? rowId;
   List<Answer> userInputLineId;

  RowLine({
    this.rowId,
    this.userInputLineId = const [],
  }
  );

  factory RowLine.fromJson(Map<String, dynamic> json) {
    return RowLine(
        rowId: json['row_id'] ?? -1,
        userInputLineId: json['user_input_line_id'] != null
    ? (json['user_input_line_id'] as List<dynamic>)
        .map((itemJson) => Answer.fromJson(itemJson))
        .toList()
        : [],
    );
  }

  RowLine.copy(RowLine other)
      : rowId = other.rowId,
        userInputLineId = other.userInputLineId.map((answer) => Answer.copy(answer)).toList();
}
