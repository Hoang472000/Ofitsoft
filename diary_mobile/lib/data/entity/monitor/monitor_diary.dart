import 'package:diary_mobile/data/entity/item_default/activity_monitor.dart';
import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:diary_mobile/data/local_data/table/diary_table.dart';
import 'package:drift/drift.dart';

import '../image/image_entity.dart';
import '../item_default/activity.dart';
import '../item_default/item_default.dart';
import '../item_default/material_entity.dart';
import '../item_default/tool.dart';

class MonitorDiary implements Insertable<MonitorDiary>{
  int? id;
  int? seasonFarmId;
  String? seasonFarm;
  String? actionTime;
  String? latitude;
  String? longitude;
  int? monitorId;
  String? monitor;
  String? description;

  List<ActivityMonitor> activityIds;
  List<ImageEntity> diaryMediaIds;

  MonitorDiary({
    this.id,
    this.seasonFarmId,
    this.seasonFarm,
    this.actionTime,
    this.latitude,
    this.longitude,
    this.monitorId,
    this.monitor,
    this.description,
    this.activityIds = const [],
    this.diaryMediaIds = const [],
  });

  factory MonitorDiary.fromJson(Map<String, dynamic> json) {
    return MonitorDiary(
      id: json['id'] ?? -1,
      seasonFarmId: json['season_farm_id'] ?? -1,
      seasonFarm: json['season_farm'] ?? "",
      actionTime: json['action_time'] ?? "",
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      monitorId: json['monitor_id'] ?? -1,
      monitor: json['monitor'] ?? '',
      description: json['description'] ?? '',

      activityIds: json['activity_ids'] != null ? (json['activity_ids'] as List<dynamic>).map((itemJson) => ActivityMonitor.fromJson(itemJson)).toList() : [],
      diaryMediaIds: json['diary_media_ids'] != null ? (json['diary_media_ids'] as List<dynamic>).map((itemJson) => ImageEntity.fromJson(itemJson)).toList() : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['season_farm_id'] = seasonFarmId;
    data['season_farm'] = seasonFarm;
    data['action_time'] = actionTime;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['description'] = description;
    data['monitor_id'] = monitorId;
    data['monitor'] = monitor;


    List<Map> listActivity= [];
    for (int i = 0; i < activityIds.length; i++) {
      listActivity.add(activityIds[i].toJson());
    }
    List<Map> listImage= [];
    for (int i = 0; i < diaryMediaIds.length; i++) {
      listImage.add(diaryMediaIds[i].toJson());
    }
    data['activity_ids'] = listActivity;
    data['diary_media_ids'] = listImage;
    return data;
  }

  MonitorDiary.copy(MonitorDiary other)
      : id = other.id,
        seasonFarmId = other.seasonFarmId,
        seasonFarm = other.seasonFarm,
        actionTime = other.actionTime,
        latitude = other.latitude,
        longitude = other.longitude,
        description = other.description,
        monitorId = other.monitorId,
        monitor =  other.monitor, // Tạo bản sao của danh sách tool
        activityIds = List.of(other.activityIds), // Tạo bản sao của danh sách material
        diaryMediaIds = List.of(other.diaryMediaIds); // Tạo bản sao của danh sách media

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return MonitorDiaryTableCompanion(
        id: Value(id),
        seasonFarmId: Value(seasonFarmId),
        seasonFarm: Value(seasonFarm),
        actionTime: Value(actionTime),
        latitude: Value(latitude),
        longitude: Value(longitude),
        description: Value(description),
        monitorId: Value(monitorId),
        monitor: Value(monitor))
        .toColumns(nullToAbsent);
  }
}
