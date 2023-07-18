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
  bool? image;
  int? diaryFarmerId;
  int? toolId;
  int? quantity;
  String? unitId;
  String? mediaContent;

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
      this.mediaContent});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      categoryId: json['category_id'] ?? -1,
      isOrganic: json['is_organic'] ?? false,
      notation: json['notation'] ?? false,
      image: json['image'] ?? false,
      isActive: json['is_active'] ?? false,
      diaryFarmerId: json['diary_farmer_id'] ?? -1,
      toolId: json['tool_id'] ?? -1,
      quantity: json['quantity'] ?? 0,
      unitId: json['unit_id'] ?? '',
      mediaContent: json['media_content'] ?? '',
    );
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
        unitId: Value(unitId))
        .toColumns(nullToAbsent);
  }
}
