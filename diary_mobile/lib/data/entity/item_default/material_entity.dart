import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:diary_mobile/data/local_data/table/item_default/material_table.dart';
import 'package:drift/drift.dart';

class MaterialEntity implements Insertable<MaterialEntity> {
  int? id;
  int? categoryId;
  String? material;
  String? name;
  String? description;
  bool? isOrganic;
  bool? notation;
  bool? isActive;
  String? image;
  int? diaryFarmerId;
  int? materialId;
  double? quantity;
  int? unitId;
  String? unitName;
  String? mediaContent;

  MaterialEntity(
      {this.id,
      this.material,
      this.name,
      this.description,
      this.categoryId,
      this.isOrganic,
      this.notation,
      this.image,
      this.isActive,
      this.diaryFarmerId,
      this.materialId,
      this.quantity,
      this.unitId,
      this.unitName,
      this.mediaContent});

  factory MaterialEntity.fromJson(Map<String, dynamic> json) {
    return MaterialEntity(
      id: json['id'] ?? -1,
      material: json['material'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      categoryId: json['category_id'] ?? -1,
      isOrganic: json['is_organic'] ?? false,
      notation: json['notation'] ?? false,
      image: json['image'] ?? '',
      isActive: json['is_active'] ?? false,
      diaryFarmerId: json['diary_farmer_id'] ?? -1,
      materialId: json['material_id'] ?? -1,
      quantity: json['quantity'] ?? 0,
      unitId: json['unit_id'] ?? -1,
      unitName: json['unit_name'] ?? '',
      mediaContent: json['media_content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['material'] = material;
    data['material_id'] = materialId;
    data['name'] = name;
    data['category_id'] = categoryId;
    data['is_organic'] = isOrganic;
    data['notation'] = notation;
    data['description'] = description;
    //data['image'] = image;
    data['is_active'] = isActive;
    data['diary_farmer_id'] = diaryFarmerId;
    data['quantity'] = quantity;
    data['unit_id'] = unitId;
    data['unit_name'] = unitName;
    data['media_content'] = mediaContent;
    return data;
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return MaterialTableCompanion(
            id: Value(id),
            material: Value(material),
            name: Value(name),
            categoryId: Value(categoryId),
            isOrganic: Value(isOrganic),
            notation: Value(notation),
            description: Value(description),
            image: Value(image),
            isActive: Value(isActive),
            diaryFarmerId: Value(diaryFarmerId),
        materialId: Value(materialId),
            quantity: Value(quantity),
            mediaContent: Value(mediaContent),
            unitName: Value(unitName))
        .toColumns(nullToAbsent);
  }
}
