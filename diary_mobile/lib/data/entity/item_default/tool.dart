import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:diary_mobile/data/local_data/table/item_default/tool_table.dart';
import 'package:drift/drift.dart';

class Tool implements Insertable<Tool> {
  int? id;
  int? categoryId;
  String? toolName;
  String? name;
  String? description;
  bool? isOrganic;
  bool? notation;
  bool? isActive;
  String? image;
  int? diaryFarmerId;
  int? toolId;
  double? quantity;
  int? unitId;
  String? mediaContent;
  String? unitName;

  Tool(
      {this.id,
      this.toolName,
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
      toolName: json['tool_name'] ?? '',
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
      unitName: json['unit_name'] ?? '',
      mediaContent: json['media_content'] == false ? '' : json['media_content'] ?? "",
    );
  }

   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tool_name'] = toolName;
    data['name'] = name;
    data['category_id'] = categoryId;
    data['is_organic'] = isOrganic;
    data['notation'] = notation;
    data['description'] = description;
    //data['image'] = image;
    data['is_active'] = isActive;
    data['diary_farmer_id'] = diaryFarmerId;
    data['tool_id'] = toolId;
    data['quantity'] = quantity;
    data['unit_id'] = unitId;
    data['unit_name'] = unitName;
    data['media_content'] = mediaContent;
    return data;
  }


  Tool.copy(Tool other)
      : id = other.id,
        categoryId = other.categoryId,
        toolName = other.toolName,
        name = other.name,
        description = other.description,
        isOrganic = other.isOrganic,
        notation = other.notation,
        isActive = other.isActive,
        image = other.image,
        diaryFarmerId = other.diaryFarmerId,
        toolId = other.toolId,
        quantity = other.quantity,
        unitId = other.unitId,
        unitName = other.unitName,
        mediaContent = other.mediaContent;


  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return ToolTableCompanion(
            id: Value(id),
        toolName: Value(toolName),
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
