import 'dart:convert';
import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:drift/drift.dart';
import '../image/image_entity.dart';
import '../item_default/material_entity.dart';
import '../item_default/tool.dart';

class ActDiaryNoNetwork implements Insertable<ActDiaryNoNetwork>{
  String? api;
  int? id;
  int? seasonFarmId;
  String? seasonFarm;
  int? activityId;
  String? activityName;
  String? actionTime;
  double? actionArea;
  int? actionAreaUnitId;
  String? actionAreaUnitName;
  String? description;
  bool? isShow;
  // api chua co
  String? name;
  String? byName;
  String? startTime;
  String? endTime;
  int? status;
  //
  List<Tool> tool;
  List<MaterialEntity> material;
  List<ImageEntity> media;
  String? stringTool;
  String? stringMaterial;
  String? stringMedia;

  ActDiaryNoNetwork({
    this.api,
    this.id,
    this.seasonFarmId,
    this.activityId,
    this.actionTime,
    this.actionArea,
    this.actionAreaUnitId,
    this.actionAreaUnitName,
    this.description,
    this.activityName,
    this.seasonFarm,
    this.isShow,

    this.name,
    this.byName,
    this.startTime,
    this.endTime,
    this.status,

    this.tool = const [],
    this.material = const [],
    this.media = const [],
    this.stringTool,
    this.stringMedia,
    this.stringMaterial
  });

  factory ActDiaryNoNetwork.fromJson(Map<String, dynamic> json) {
    return ActDiaryNoNetwork(
      api: json['api'] ?? '',
      id: json['id'] ?? -1,
      seasonFarmId: json['season_farm_id'] ?? -1,
      seasonFarm: json['season_farm'] ?? "",
      activityId: json['activity_id'] ?? -1,
      actionTime: json['action_time'] ?? "",
      actionArea: json['action_area'],
      actionAreaUnitId: json['action_area_unit_id'] ?? -1,
      actionAreaUnitName: json['action_area_unit_name'] ?? '',
      description: (json['description']??'').toString().replaceAll(RegExp(r'<\/?p>'),'') ?? '',
      activityName: json['activity_name'] ?? '',
      name: json['name'] ?? "",
      byName: json['by_name'] ?? "",
      startTime: json['start_time'] ?? "",
      endTime: json['end_time'] ?? "",
      status: json['status'] ?? -1,
      isShow: json['is_Shown'],

      tool: json['diary_tool_ids'] != null ? (json['diary_tool_ids'] as List<dynamic>).map((itemJson) => Tool.fromJson(itemJson)).toList() : [],
      material: json['diary_material_ids'] != null ? (json['diary_material_ids'] as List<dynamic>).map((itemJson) => MaterialEntity.fromJson(itemJson)).toList() : [],
      media: json['diary_media_ids'] != null ? (json['diary_media_ids'] as List<dynamic>).map((itemJson) => ImageEntity.fromJson(itemJson)).toList() : [],
      stringTool: jsonEncode(json['diary_tool_ids']) ?? '[]',
      stringMedia: jsonEncode(json['diary_media_ids']) ?? '[]',
      stringMaterial: jsonEncode(json['diary_material_ids']) ?? '[]',
    );
  }

  factory ActDiaryNoNetwork.fromJsonConvert(ActivityDiary json, String api) {
    return ActDiaryNoNetwork(
      api: api,
      id: json.id,
      seasonFarmId: json.seasonFarmId,
      seasonFarm: json.seasonFarm,
      activityId: json.activityId,
      actionTime: json.actionTime,
      actionArea: json.actionArea,
      actionAreaUnitId: json.actionAreaUnitId,
      actionAreaUnitName: json.actionAreaUnitName,
      description: json.description,
      activityName: json.activityName,
      name: json.name,
      byName: json.byName,
      startTime: json.startTime,
      endTime: json.endTime,
      status: json.status,
      isShow: json.isShow,

      tool: json.tool,
      material: json.material,
      media: json.media,
      stringTool: json.stringTool,
      stringMedia: json.stringMaterial,
      stringMaterial: json.stringMedia,
    );
  }

  String convertToolsListToJson() {
    //print("HoangCV: tool: ${tool.length}");
    final List<Map<String, dynamic>> toolListJson =
    tool.map((tool) => tool.toJson()).toList();
    return jsonEncode(toolListJson);
  }
  String convertMaterialsListToJson() {
    final List<Map<String, dynamic>> toolListJson =
    material.map((tool) => tool.toJson()).toList();
    return jsonEncode(toolListJson);
  }
  String convertMediasListToJson() {
    final List<Map<String, dynamic>> toolListJson =
    media.map((tool) => tool.toJson()).toList();
    return jsonEncode(toolListJson);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['api'] = api;
    data['id'] = id;
    data['season_farm_id'] = seasonFarmId;
    data['season_farm'] = seasonFarm;
    data['activity_id'] = activityId;
    data['action_time'] = actionTime;
    data['action_area'] = actionArea;
    data['action_area_unit_id'] = actionAreaUnitId;
    data['action_area_unit_name'] = actionAreaUnitName;
    data['description'] = description;
    data['activity_name'] = activityName;
    data['is_shown'] = isShow;

    data['name'] = name;
    data['by_name'] = byName;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status;

    List<Map> listTool= [];
    for (int i = 0; i < (tool??[]).length; i++) {
      listTool.add((tool??[])[i].toJson());
    }
    List<Map> listMaterial= [];
    for (int i = 0; i < (material??[]).length; i++) {
      listMaterial.add((material??[])[i].toJson());
    }
    List<Map> listImage= [];
    for (int i = 0; i < (media??[]).length; i++) {
      listImage.add((media??[])[i].toJson());
    }
    data['diary_tool_ids'] = listTool;
    data['diary_material_ids'] = listMaterial;
    data['diary_media_ids'] = listImage;
    return data;
  }

  ActDiaryNoNetwork.copy(ActDiaryNoNetwork other)
      : id = other.id,
        api = other.api,
        seasonFarmId = other.seasonFarmId,
        seasonFarm = other.seasonFarm,
        activityId = other.activityId,
        actionTime = other.actionTime,
        actionArea = other.actionArea,
        actionAreaUnitId = other.actionAreaUnitId,
        actionAreaUnitName = other.actionAreaUnitName,
        description = other.description,
        activityName = other.activityName,
        isShow = other.isShow,
        name = other.name,
        byName = other.byName,
        startTime = other.startTime,
        endTime = other.endTime,
        status = other.status,
        tool = List.of(other.tool??[]), // Tạo bản sao của danh sách tool
        material = List.of(other.material??[]), // Tạo bản sao của danh sách material
        media = List.of(other.media??[]); // Tạo bản sao của danh sách media

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return ActDiaryNoNetworkTableCompanion(
        api: Value(api),
        id: Value(id),
        seasonFarmId: Value(seasonFarmId),
        activityId: Value(activityId),
        actionTime: Value(actionTime),
        actionArea: Value(actionArea),
        actionAreaUnitId: Value(actionAreaUnitId),
        actionAreaUnitName: Value(actionAreaUnitName),
        description: Value(description),
        activityName: Value(activityName),
        name: Value(name),
        byName: Value(byName),
        startTime: Value(startTime),
        endTime: Value(endTime),
        status: Value(status),
        stringTool: Value(stringTool),
        stringMaterial: Value(stringMaterial),
        stringMedia: Value(stringMedia))
        .toColumns(nullToAbsent);
  }
}
