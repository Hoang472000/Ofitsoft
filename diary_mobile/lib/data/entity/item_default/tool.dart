import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:diary_mobile/data/local_data/table/item_default/tool_table.dart';
import 'package:drift/drift.dart';

class Tool implements Insertable<Tool> {
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
  double? quantity;
  int? unitId;
  String? mediaContent;
  String? unitName;

  Tool(
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
      this.unitName,
      this.mediaContent});

  factory Tool.fromJson(Map<String, dynamic> json) {
    return Tool(
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
      unitId: json['unit_id'] ?? -1,
      unitName: json['unit_name'] ?? '',
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
    data['unit_name'] = unitName;
    data['media_content'] = mediaContent;
    return data;
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return ToolTableCompanion(
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
            unitId: Value(unitId),
            unitName: Value(unitName))
        .toColumns(nullToAbsent);
  }
}
