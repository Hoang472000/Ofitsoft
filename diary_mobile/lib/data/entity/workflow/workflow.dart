import 'dart:convert';
import 'package:diary_mobile/data/entity/workflow/process.dart';
import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:drift/drift.dart';

class Workflow implements Insertable<Workflow> {
  int? id;
  String? name;
  String? cropName;
  String? description;
  String? productName;
  String? standard;
  String? status;
  String? statusName;
  List<ProcessStage> processStageIds;
  String? stringProcessStageIds;

  Workflow(
      {this.id,
        this.name,
        this.cropName,
        this.productName,
        this.description,
        this.status,
        this.statusName,
        this.standard,
        this.processStageIds = const [],
        this.stringProcessStageIds});

  factory Workflow.fromJson(Map<String, dynamic> json) {
    return Workflow(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
      description: (json['description'] ?? '').replaceAll('<p>', '').replaceAll('</p>', ''),
      cropName: json['crop_name'] ?? '',
      productName: json['product_name'] ?? '',
      status: json['status'] ?? '',
      standard: json['standard'] ?? '',
      statusName: json['status_name'] ?? '',
      processStageIds: json['process_stage_ids'] != null
          ? (json['process_stage_ids'] as List<dynamic>)
          .map((itemJson) => ProcessStage.fromJson(itemJson))
          .toList()
          : [],
      stringProcessStageIds: jsonEncode(json['process_stage_ids']) ?? '[]',
    );
  }

  String convertProcessListToJson() {
    final List<Map<String, dynamic>> questionListJson =
    processStageIds.map((question) => question.toJson()).toList();
    return jsonEncode(questionListJson);
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['crop_name'] = cropName;
    data['product_name'] = productName;
    data['status'] = status;
    data['status_name'] = statusName;
    data['process_stage_ids'] = processStageIds;
    data['standard'] = standard;
    return data;
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return WorkflowTableCompanion(
        id: Value(id),
        name: Value(name),
        description: Value(description),
        cropName: Value(cropName),
        productName: Value(productName),
        status: Value(status),
        statusName: Value(statusName),
        standard: Value(standard),
        stringProcessStageIds: Value(stringProcessStageIds))
        .toColumns(nullToAbsent);
  }
}
