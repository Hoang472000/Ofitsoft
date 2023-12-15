import 'dart:convert';

import 'package:diary_mobile/data/entity/report/question.dart';
import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

class ReportSelect implements Insertable<ReportSelect> {
  int? id;
  String? title;
  bool? isInitialAssessment;

  ReportSelect({
    this.id,
    this.title,
    this.isInitialAssessment
  });

  factory ReportSelect.fromJson(Map<String, dynamic> json) {
    return ReportSelect(
      id: json['id'] ?? -1,
      title: json['title'] ?? '',
      isInitialAssessment: json['is_initial_assessment'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['is_initial_assessment'] = isInitialAssessment;
    return data;
  }

  ReportSelect.copy(ReportSelect other)
      : id = other.id,
        title = other.title,
  isInitialAssessment = other.isInitialAssessment;


  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return ReportSelectTableCompanion(
        id: Value(id),
        title: Value(title),
    isInitialAssessment: Value(isInitialAssessment))
        .toColumns(nullToAbsent);
  }

}





