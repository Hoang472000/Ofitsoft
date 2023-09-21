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

  //for farmer - inspector
  List<People> listFarmers;
  List<People> listInternalInspector;
  List<MonitoringVisitType> listMonitoringVisitType;

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
      this.stringQuestionAndPageIds,
      //
      this.listFarmers = const [],
      this.listInternalInspector = const [],
      this.listMonitoringVisitType = const [],
  });

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
      //
      listFarmers: json['list_farmers'] != null
          ? (json['list_farmers'] as List<dynamic>)
          .map((itemJson) => People.fromJson(itemJson))
          .toList()
          : [],

      listInternalInspector: json['list_internal_inspector'] != null
          ? (json['list_internal_inspector'] as List<dynamic>)
          .map((itemJson) => People.fromJson(itemJson))
          .toList()
          : [],

      listMonitoringVisitType: json['list_monitoring_visit_type'] != null
          ? (json['list_monitoring_visit_type'] as List<dynamic>)
          .map((itemJson) => MonitoringVisitType.fromJson(itemJson))
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

  Report.copy(Report other)
      : id = other.id,
        pageId = other.pageId,
        isPage = other.isPage,
        surveyId = other.surveyId,
        title = other.title,
        userId = other.userId,
        active = other.active,
        hasConditionalQuestions = other.hasConditionalQuestions,
        questionsSelection = other.questionsSelection,
        timeLimit = other.timeLimit,
        questionAndPageIds = other.questionAndPageIds
            .map((answer) => Question.copy(answer))
            .toList(),
        stringQuestionAndPageIds = other.stringQuestionAndPageIds,
        listFarmers = other.listFarmers
            .map((answer) => People.copy(answer))
            .toList(),
        listInternalInspector = other.listInternalInspector
            .map((answer) => People.copy(answer))
            .toList(),
        listMonitoringVisitType = other.listMonitoringVisitType
      .map((answer) => MonitoringVisitType.copy(answer))
      .toList();

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

class MonitoringVisitType {
  String type;
  String value;

  MonitoringVisitType({
    required this.type,
    required this.value,
  });

  factory MonitoringVisitType.fromJson(Map<String, dynamic> json) {
    return MonitoringVisitType(
        type: json['type'],
        value: json['value']
    );
  }

  MonitoringVisitType.copy(MonitoringVisitType other)
      : type = other.type,
        value = other.value;
}

class People {
  final int id;
  final String name;
  final String? image;

  People({required this.id, required this.name, this.image});

  factory People.fromJson(Map<String, dynamic> json) {
    return People(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
    );
  }

  People.copy(People other)
      : id = other.id,
        name = other.name,
        image = other.image;
}
