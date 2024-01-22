import 'dart:convert';
import 'package:diary_mobile/data/entity/setting/reply_entity.dart';
import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:diary_mobile/data/local_data/table/task/task_table.dart';
import 'package:drift/drift.dart';

import '../image/image_entity.dart';
import '../item_default/item_basic.dart';

class TaskEntity implements Insertable<TaskEntityTable>{
  int? id;
  String? name;
  String? stringSeasonFarmIds;
  List<ItemBasic> seasonFarmIds;
  int? activityId;
  String? activityName;
  String? startDate;
  String? endDate;
  String? completeDate;
  String? status;
  String? statusName;
  String? result;
  String? description;

  TaskEntity({
    this.id,
    this.name,
    this.stringSeasonFarmIds,
    this.seasonFarmIds = const [],
    this.activityId,
    this.activityName,
    this.startDate,
    this.endDate,
    this.completeDate,
    this.status,
    this.statusName,
    this.result,
    this.description,
  });

  factory TaskEntity.fromJson(Map<String, dynamic> json) {
    return TaskEntity(
      id: json['id'] ?? -1,
      name: json['name'] ?? "",
      stringSeasonFarmIds: jsonEncode(json['season_farm_ids']) ?? '[]',
      seasonFarmIds: json['season_farm_ids'] != null ? (json['season_farm_ids']
      as List<dynamic>).map((itemJson) => ItemBasic.fromJson(itemJson)).toList() : [],
      activityId: json['activity_id'] ?? -1,
      activityName: json['activity_name'] ?? "",
      startDate: json['start_date'] ?? "",
      endDate: json['end_date'] ?? "",
      completeDate: json['complete_date'] ?? "",
      status: json['status'] ?? "",
      statusName: json['status_name'] ?? "",
      result: ((json['result'] ?? '') as String).replaceAll('<p>', '').replaceAll('</p>', ''),
      description: /*((*/json['description'] ?? ''/*) as String).replaceAll('<p>', '').replaceAll('</p>', '')*/,

    );
  }

  String convertSeasonFarmListToJson() {
    final List<Map<String, dynamic>> toolListJson =
    seasonFarmIds.map((tool) => tool.toJson()).toList();
    return jsonEncode(toolListJson);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['stringSeasonFarmIds'] = stringSeasonFarmIds;
    data['season_farm_ids'] = seasonFarmIds;
    data['activity_id'] = activityId;
    data['activity_name'] = activityName;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['complete_date'] = completeDate;
    data['status'] = status;
    data['status_name'] = statusName;
    data['result'] = result;
    data['description'] = description;
    return data;
  }

  TaskEntity.copy(TaskEntity other)
      : id = other.id,
        name = other.name,
        stringSeasonFarmIds = other.stringSeasonFarmIds,
        seasonFarmIds = List.of(other.seasonFarmIds??[]),
        activityId = other.activityId,
        activityName = other.activityName,
        startDate = other.startDate,
        endDate = other.endDate,
        completeDate = other.completeDate,
        status = other.status,
        statusName = other.statusName,
        result = other.result,
        description = other.description;

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return TaskEntityTableCompanion(
        id: Value(id),
        name: Value(name),
        stringSeasonFarmIds: Value(stringSeasonFarmIds),
        activityId: Value(activityId),
        activityName: Value(activityName),
        startDate: Value(startDate),
        endDate: Value(endDate),
        completeDate: Value(completeDate),
        status: Value(status),
        statusName: Value(statusName),
        result: Value(result),
        description: Value(description))
        .toColumns(nullToAbsent);
  }

}
