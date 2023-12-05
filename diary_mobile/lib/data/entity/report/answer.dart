import 'package:diary_mobile/data/entity/report/question.dart';

import '../item_default/item_basic.dart';

class Answer {
  int? id;
  int? idSelected;
  int? questionId;
  int? parentColId;
  String? value;
  bool? commentAnswer;
  List<Question> questionAndPageIds;
  List<Answer> suggestedAnswerIds;
  int? rowId;

  // result;
  int? tableRowId;
  String? valueRowTable;
  int? suggestedAnswerId;

  bool? checkResult;
  String? valueResult;
  //check color
  bool? isError;
  bool? constrMandatory;
  String? linkingField;
  bool? isSelectionAnswer;
  List<ItemBasic> selectionAnswerIds;

  Answer({
    this.id,
    this.idSelected,
    this.questionId,
    this.parentColId,
    this.value,
    this.commentAnswer,
    this.questionAndPageIds = const [],
    this.suggestedAnswerIds = const [],
    this.rowId,

    this.tableRowId,
    this.valueRowTable,
    this.suggestedAnswerId,

    this.checkResult,
    this.valueResult,

    this.isError,
    this.constrMandatory,
    this.linkingField,
    this.isSelectionAnswer,
    this.selectionAnswerIds = const [],
  });

  Answer.copy(Answer other)
      : id = other.id,
        idSelected = other.idSelected,
        questionId = other.questionId,
        parentColId = other.parentColId,
        value = other.value,
        commentAnswer = other.commentAnswer,
        rowId = other.rowId,
        questionAndPageIds = other.questionAndPageIds.map((question) => Question.copy(question)).toList(),
        suggestedAnswerIds = other.suggestedAnswerIds.map((answer) => Answer.copy(answer)).toList(),

        tableRowId = other.tableRowId,
        valueRowTable = other.valueRowTable,
        suggestedAnswerId = other.suggestedAnswerId,

        checkResult = other.checkResult,
        valueResult = other.valueResult,

        constrMandatory = other.constrMandatory,
        isError = other.isError,
        linkingField = other.linkingField,
        isSelectionAnswer = other.isSelectionAnswer,
        selectionAnswerIds = other.selectionAnswerIds.map((item) => ItemBasic.copy(item)).toList();

  factory Answer.fromJson(Map<String, dynamic> json,
      {List<Question> questionAndPageIds = const [],
      List<Answer> suggestedAnswerIds = const [], int idSelected = -1, int rowId = -1}) {
    return Answer(
      id: json['id'] ?? -1,
      idSelected: idSelected,
      questionId: json['question_id'] ?? -1,
      parentColId: json['parent_col_id'] ?? -1,
      value: json['value'] ?? '',
      commentAnswer: json['comment_answer'] ?? false,
      questionAndPageIds: questionAndPageIds,
      suggestedAnswerIds: suggestedAnswerIds,
      rowId: rowId,

      tableRowId: json['table_row_id'] ?? -1,
      valueRowTable: json['value_row_table'] ?? '',
      suggestedAnswerId: json['suggested_answer_id'] ?? -1,

      checkResult: json['check_result'] ?? false,
      valueResult: json['value_result'] ?? '',

      constrMandatory: json['constr_mandatory'] ?? false,
      isError: json['isError'] ?? false,
        linkingField: json['linking_field'] ?? "",
        isSelectionAnswer: json['is_selection_answer'] ?? false,
        selectionAnswerIds: json['selection_answer_ids'] != null
            ? (json['selection_answer_ids'] as List<dynamic>)
            .map((itemJson) => ItemBasic.fromJson(itemJson))
            .toList()
            : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question_id'] = questionId;
    data['parent_col_id'] = parentColId;
    data['value'] = value;
    data['comment_answer'] = commentAnswer;
    data['questionAndPageIds'] = questionAndPageIds;
    data['suggestedAnswerIds'] = suggestedAnswerIds;

    data['table_row_id'] = tableRowId;
    data['value_row_table'] = valueRowTable;
    data['suggested_answer_id'] = suggestedAnswerId;

    data['check_result'] = checkResult;
    data['value_result'] = valueResult;

    data['constr_mandatory'] = constrMandatory;
    data['isError'] = isError;

    data['linking_field'] = linkingField;
    data['is_selection_answer'] = isSelectionAnswer;
    data['selection_answer_ids'] = selectionAnswerIds;
    return data;
  }
}
