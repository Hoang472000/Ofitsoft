import 'dart:convert';
import 'package:diary_mobile/data/entity/report/answer.dart';

class Question {
  int? id;
  int? pageId;
  String? title;
  String? questionsSelection;
  String? questionType;
  int? triggeringQuestionId;
  int? triggeringAnswerId;
  List<Answer> suggestedAnswerIds;
  List<Question> questionAndPageIds;
  String? stringSuggestedAnswerIds;

  Question({
    this.id,
    this.pageId,
    this.title,
    this.triggeringQuestionId,
    this.triggeringAnswerId,
    this.questionsSelection,
    this.questionType,
    this.suggestedAnswerIds = const [],
    this.questionAndPageIds = const [],
    this.stringSuggestedAnswerIds,
  });

  Question.copy(Question other)
      : id = other.id,
        pageId = other.pageId,
        title = other.title,
        triggeringQuestionId = other.triggeringQuestionId,
        triggeringAnswerId = other.triggeringAnswerId,
        questionsSelection = other.questionsSelection,
        questionType = other.questionType,
        suggestedAnswerIds = other.suggestedAnswerIds.map((answer) => Answer.copy(answer)).toList(),
        questionAndPageIds = List.of(other.questionAndPageIds??[]),
        stringSuggestedAnswerIds = other.stringSuggestedAnswerIds;

  factory Question.fromJson(Map<String, dynamic> json,
      {List<Question> questionAndPageIds = const []}) {
    return Question(
      id: json['id'] ?? -1,
      pageId: json['page_id'] ?? -1,
      title: json['title'] ?? '',
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
    data['triggering_question_id'] = triggeringQuestionId;
    data['triggering_answer_id'] = triggeringAnswerId;
    data['questions_selection'] = questionsSelection;
    data['question_type'] = questionType;
    data['suggested_answer_ids'] = suggestedAnswerIds;
    data['questionAndPageIds'] = questionAndPageIds;
    return data;
  }
}
