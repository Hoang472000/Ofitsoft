import 'dart:convert';

import 'package:diary_mobile/data/entity/item_default/item_basic.dart';
import 'package:diary_mobile/data/entity/report/question.dart';
import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:diary_mobile/utils/extenstion/input_register_model.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

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
  String? stringListFarmers;
  String? stringListInternalInspector;
  String? stringListMonitoringVisitType;

  Report({
    this.id,
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
    //
    this.stringListFarmers,
    this.stringListInternalInspector,
    this.stringListMonitoringVisitType,
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
      stringListFarmers: jsonEncode(json['list_farmers']) ?? '[]',
    );
  }

  String convertQuestionsListToJson() {
    final List<Map<String, dynamic>> questionListJson =
        questionAndPageIds.map((question) => question.toJson()).toList();
    return jsonEncode(questionListJson);
  }

  String convertListFarmersListToJson() {
    final List<Map<String, dynamic>> listFarmersListJson =
        listFarmers.map((listFarmer) => listFarmer.toJson()).toList();
    return jsonEncode(listFarmersListJson);
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
    //data['list_farmers'] = stringListFarmers;
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
        listFarmers =
            other.listFarmers.map((answer) => People.copy(answer)).toList(),
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
            isPage: Value(isPage),
            pageId: Value(pageId),
            surveyId: Value(surveyId),
            title: Value(title),
            userId: Value(userId),
            active: Value(active),
            hasConditionalQuestions: Value(hasConditionalQuestions),
            questionsSelection: Value(questionsSelection),
            timeLimit: Value(timeLimit),
            stringQuestionAndPageIds: Value(stringQuestionAndPageIds),
            stringListFarmers: Value(stringListFarmers))
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
    return MonitoringVisitType(type: json['type'], value: json['value']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    return data;
  }

  MonitoringVisitType.copy(MonitoringVisitType other)
      : type = other.type,
        value = other.value;
}

class People {
  final int id;
  final String name;
  final String? userCode;
  final String? code;
  final String? image;
  final List<People> farmIds;
  final int? areaId;
  final String? areaName;
  final List<ItemBasic> linkkinkField;

  People(
      {required this.id,
      required this.name,
      this.code,
      this.image,
      this.areaId,
      this.areaName,
      this.linkkinkField = const [],
      this.userCode,
      this.farmIds = const []});

  factory People.fromJson(Map<String, dynamic> json) {
    return People(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
      code: json['code'] == false ? null : json['code'],
      userCode: json['user_code'] == false ? null : json['user_code'],
      areaId: json['area_id'] ?? -1,
      areaName: json['area_name'] ?? '',
      farmIds: json['farm_ids'] != null
          ? (json['farm_ids'] as List<dynamic>)
              .map((itemJson) => People.fromJson(itemJson))
              .toList()
          : [],
      linkkinkField: json['linkkink_field'] != null
          ? (json['linkkink_field'] as List<dynamic>)
          .map((itemJson) => ItemBasic.fromJson(itemJson))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    List<Map> listFarm = [];
    for (int i = 0; i < (farmIds ?? []).length; i++) {
      listFarm.add((farmIds ?? [])[i].toJson());
    }
    List<Map> listLinkkinkField = [];
    for (int i = 0; i < (linkkinkField ?? []).length; i++) {
      listLinkkinkField.add((linkkinkField ?? [])[i].toJson());
    }
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['user_code'] = userCode;
    data['farm_ids'] = listFarm;
    data['area_id'] = areaId;
    data['area_name'] = areaName;
    data['linkkink_field'] = listLinkkinkField;
    return data;
  }

  People.copy(People other)
      : id = other.id,
        name = other.name,
        code = other.code,
        userCode = other.userCode,
        farmIds = other.farmIds.map((answer) => People.copy(answer)).toList(),
        areaId = other.areaId,
        areaName = other.areaName,
        linkkinkField = other.linkkinkField.map((answer) => ItemBasic.copy(answer)).toList(),
        image = other.image;
}

class Select {
  int id;
  bool value;
  String title;
  List<int> listId;
  List<int> listSubId;
  int parentId;
  String type;
  String typeSub;

  Select(this.id, this.value, this.title,
      {this.listId = const [],
      this.listSubId = const [],
      this.parentId = -1,
      this.type = '',
      this.typeSub = ''});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;
    data['title'] = title;
    return data;
  }
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
  InputRegisterModel? input;
  String type;
  String value;
  String? title;
  bool? constrMandatory;

  Controller(this.id, this.controller, this.type, this.value,
      {this.input,
      this.idRow,
      this.title,
      this.constrMandatory});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idRow'] = idRow;
    data['controller'] = controller;
    data['input'] = input;
    data['type'] = type;
    data['value'] = value;
    data['title'] = title;
    data['constrMandatory'] = constrMandatory;
    return data;
  }
}

class TableQuestion {
  int id;
  String title;
  List<Question> listQuestion;

  TableQuestion(this.id, this.title, this.listQuestion);

  TableQuestion.copy(TableQuestion other)
      : id = other.id,
        title = other.title,
        listQuestion = other.listQuestion
            .map((answer) => Question.copy(answer))
            .toList();
}
