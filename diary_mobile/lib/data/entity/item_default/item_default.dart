class Item {
  int id;
  int categoryId;
  String name;
  String description;
  bool isOrganic;
  bool notation;
  bool isActive;
  bool image;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.isOrganic,
    required this.notation,
    required this.image,
    required this.isActive,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      categoryId: json['category_id'] ?? -1,
      isOrganic: json['is_organic'] ?? false,
      notation: json['notation'] ?? false,
      image: json['image'] ?? false,
      isActive: json['is_active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['is_organic'] = this.isOrganic;
    data['notation'] = this.notation;
    data['description'] = this.description;
    data['image'] = this.image;
    data['is_active'] = this.isActive;
    return data;
  }
}
