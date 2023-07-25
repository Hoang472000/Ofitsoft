class Item {
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

  Item(
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

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      categoryId: json['category_id'] ?? -1,
      isOrganic: json['is_organic'] ?? false,
      notation: json['notation'] ?? false,
      image: json['image'] ?? '',
      isActive: json['is_active'] ?? false,
      diaryFarmerId: json['diary_farmer_id'] ?? -1,
      toolId: json['tool_id'] ?? '',
      quantity: json['quantity'] ?? '',
      unitId: json['unit_id'] ?? -1,
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
}
