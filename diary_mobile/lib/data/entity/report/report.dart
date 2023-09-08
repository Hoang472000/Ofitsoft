import 'dart:convert';

import 'package:diary_mobile/data/entity/report/question.dart';
import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:drift/drift.dart';

class Report implements Insertable<Report> {
  int? id;
  bool? isPage;
  int? pageId;
  int? surveyId;
  String? title;
  int? userId;
  bool? active;
  bool? hasConditionalQuestions;
  String? questionsSelection;
  double? timeLimit;
  List<Question> questionAndPageIds;
  String? stringQuestionAndPageIds;

  Report(
      {this.id,
      this.isPage,
      this.pageId,
      this.surveyId,
      this.title,
      this.userId,
      this.active,
      this.hasConditionalQuestions,
      this.questionsSelection,
      this.timeLimit,
      this.questionAndPageIds = const [],
      this.stringQuestionAndPageIds});

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] ?? -1,
      isPage: json['is_page'] ?? false,
      pageId: json['page_id'] ?? -1,
      surveyId: json['survey_id'] ?? -1,
      title: json['title'] ?? '',
      userId: json['user_id'] ?? -1,
      active: json['active'] ?? false,
      hasConditionalQuestions: json['has_conditional_questions'] ?? false,
      questionsSelection: json['questions_selection'] ?? '',
      timeLimit: json['time_limit'] ?? 0,
      questionAndPageIds: json['question_and_page_ids'] != null
          ? (json['question_and_page_ids'] as List<dynamic>)
              .map((itemJson) => Question.fromJson(itemJson))
              .toList()
          : [],
      stringQuestionAndPageIds:
          jsonEncode(json['question_and_page_ids']) ?? '[]',
    );
  }

  String convertQuestionsListToJson() {
    final List<Map<String, dynamic>> questionListJson =
        questionAndPageIds.map((question) => question.toJson()).toList();
    return jsonEncode(questionListJson);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_page'] = isPage;
    data['page_id'] = pageId;
    data['survey_id'] = surveyId;
    data['title'] = title;
    data['user_id'] = userId;
    data['active'] = active;
    data['has_conditional_questions'] = hasConditionalQuestions;
    data['questions_selection'] = questionsSelection;
    data['time_limit'] = timeLimit;
    data['question_and_page_ids'] = questionAndPageIds;
    return data;
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return ReportTableCompanion(
            id: Value(id),
            title: Value(title),
            userId: Value(userId),
            active: Value(active),
            hasConditionalQuestions: Value(hasConditionalQuestions),
            questionsSelection: Value(questionsSelection),
            timeLimit: Value(timeLimit),
            stringQuestionAndPageIds: Value(stringQuestionAndPageIds))
        .toColumns(nullToAbsent);
  }
}
