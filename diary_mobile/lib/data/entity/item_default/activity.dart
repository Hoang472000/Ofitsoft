import 'dart:convert';

import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:drift/drift.dart';

class Activity implements Insertable<Activity> {
  int? id;
  int? categoryId;
  String? name;
  String? description;
  bool? isOrganic;
  bool? notation;
  bool? isActive;
  String? image;
  int? diaryFarmerId;
  int? toolId;
  int? quantity;
  String? unitId;
  String? mediaContent;
  bool? harvesting;
  String? stringToolIds;
  String? stringMaterialIds;
  List<int>? toolIds;
  List<int>? materialIds;

  Activity(
      {this.id,
      this.name,
      this.description,
      this.categoryId,
      this.isOrganic,
      this.notation,
      this.image,
      this.isActive,
      this.diaryFarmerId,
      this.toolId,
      this.quantity,
      this.unitId,
      this.mediaContent,
      this.toolIds,
      this.materialIds,
      this.stringToolIds,
      this.stringMaterialIds,
      this.harvesting});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      categoryId: json['category_id'] ?? -1,
      isOrganic: json['is_organic'] ?? false,
      notation: json['notation'] ?? false,
      image: json['image'] ?? '',
      isActive: json['is_active'] ?? false,
      diaryFarmerId: json['diary_farmer_id'] ?? -1,
      toolId: json['tool_id'] ?? -1,
      quantity: json['quantity'] ?? 0,
      unitId: json['unit_id'] ?? '',
      mediaContent: json['media_content'] ?? '',
      harvesting: json['harvesting'] ?? false,
      toolIds:
          json['tool_ids'] != null ? List<int>.from(json['tool_ids']) : <int>[],
      materialIds: json['material_ids'] != null
          ? List<int>.from(json['material_ids'])
          : <int>[],
      stringToolIds: jsonEncode(json['tool_ids']) ?? '[]',
      stringMaterialIds: jsonEncode(json['material_ids']) ?? '[]',
    );
  }

  String convertIntListToJson(List<int> intList) {
    final List<int> copyIntList = List.from(intList);
    return jsonEncode(copyIntList);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['category_id'] = categoryId;
    data['is_organic'] = isOrganic;
    data['notation'] = notation;
    data['description'] = description;
    data['image'] = image;
    data['is_active'] = isActive;
    data['diary_farmer_id'] = diaryFarmerId;
    data['tool_id'] = toolId;
    data['quantity'] = quantity;
    data['unit_id'] = unitId;
    data['media_content'] = mediaContent;
    data['tool_ids'] = toolIds;
    data['material_ids'] = materialIds;
    data['harvesting'] = harvesting;
    return data;
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return ActivityTableCompanion(
            id: Value(id),
            name: Value(name),
            categoryId: Value(categoryId),
            isOrganic: Value(isOrganic),
            notation: Value(notation),
            description: Value(description),
            image: Value(image),
            isActive: Value(isActive),
            diaryFarmerId: Value(diaryFarmerId),
            toolId: Value(toolId),
            quantity: Value(quantity),
            mediaContent: Value(mediaContent),
            harvesting: Value(harvesting),
            stringToolIds: Value(stringToolIds),
            stringMaterialIds: Value(stringMaterialIds),
            unitId: Value(unitId))
        .toColumns(nullToAbsent);
  }
}
