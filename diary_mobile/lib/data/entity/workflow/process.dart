import 'dart:convert';

import 'package:diary_mobile/data/entity/workflow/activity_process.dart';

class ProcessStage{
  String? name;
  String? description;
  String? stringProcessStageTaskIds;
  List<ActivityProcess> processStageTaskIds;//process_stage_task_ids

  ProcessStage({
    this.name,
    this.description,
    this.stringProcessStageTaskIds,
    this.processStageTaskIds = const [],
  });

  factory ProcessStage.fromJson(Map<String, dynamic> json) {
    return ProcessStage(
      name: json['name'] ?? '',
      description: (json['description'] ?? '').replaceAll('<p>', '').replaceAll('</p>', ''),
      processStageTaskIds: json['process_stage_task_ids'] != null
          ? (json['process_stage_task_ids'] as List<dynamic>)
              .map((itemJson) => ActivityProcess.fromJson(itemJson))
              .toList()
          : [],
      stringProcessStageTaskIds: jsonEncode(json['process_stage_task_ids']) ?? '[]',

    );
  }

  String convertProcessStageTaskIdsToJson() {
    final List<Map<String, dynamic>> toolListJson =
    processStageTaskIds.map((tool) => tool.toJson()).toList();
    return jsonEncode(toolListJson);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['process_stage_task_ids'] = processStageTaskIds;
    return data;
  }
}
