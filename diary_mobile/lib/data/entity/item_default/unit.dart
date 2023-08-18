import 'package:diary_mobile/data/local_data/table/item_default/unit_table.dart';
import 'package:drift/drift.dart';

import '../../local_data/diary_db.dart';

class Unit implements Insertable<Unit>{
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
  double? quantity;
  double? convert;
  int? unitId;
  String? mediaContent;

  Unit(
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
        this.convert,
        this.mediaContent});

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
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
      unitId: json['unit_id'] ?? -1,
      convert: json['convert'] ?? 0,
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
    data['convert'] = convert;
    data['media_content'] = mediaContent;
    return data;
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return UnitTableCompanion(
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
        convert: Value(convert),
        unitId: Value(unitId))
        .toColumns(nullToAbsent);
  }
}
