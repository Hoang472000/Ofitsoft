import '../item_default/item_default.dart';

class DiaryDetail {
  int id;
  int seasonFarmId;
  int activityId;
  String actionTime;
  String actionArea;
  String actionAreaUnitId;
  String description;
  // api chua co
  String name;
  String byName;
  String startTime;
  String endTime;
  int status;
  //
  List<Item> tool;
  List<Item> material;
  List<Item> media;

  DiaryDetail({
    required this.id,
    required this.seasonFarmId,
    required this.activityId,
    required this.actionTime,
    required this.actionArea,
    required this.actionAreaUnitId,
    required this.description,

    required this.name,
    required this.byName,
    required this.startTime,
    required this.endTime,
    required this.status,

    required this.tool,
    required this.material,
    required this.media,
  });

  factory DiaryDetail.fromJson(Map<String, dynamic> json) {
    return DiaryDetail(
        id: json['id'] ?? -1,
        seasonFarmId: json['season_farm_id'] ?? -1,
        activityId: json['activity_id'] ?? -1,
        actionTime: json['action_time'] ?? "",
        actionArea: json['action_area'] ?? "",
        actionAreaUnitId: json['action_area_unit_id'] ?? '',
        description: json['description'] ?? '',

        name: json['name'] ?? "",
        byName: json['by_name'] ?? "",
        startTime: json['start_time'] ?? "",
        endTime: json['end_time'] ?? "",
        status: json['status'] ?? -1,

        tool: json['tool'] ?? [],
        material: json['material'] ?? [],
        media: json['media'] ?? []
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['season_farm_id'] = seasonFarmId;
    data['activity_id'] = activityId;
    data['action_time'] = actionTime;
    data['action_area'] = actionArea;
    data['action_area_unit_id'] = actionAreaUnitId;
    data['description'] = description;

    data['name'] = name;
    data['by_name'] = byName;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status;

    data['tool'] = tool;
    data['material'] = material;
    data['media'] = media;
    return data;
  }
}
