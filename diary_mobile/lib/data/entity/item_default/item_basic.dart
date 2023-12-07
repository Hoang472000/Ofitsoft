class ItemBasic {
  int? id;
  String? name;
  String? image;

  ItemBasic({
    this.id,
    this.name,
    this.image,
  });

  factory ItemBasic.fromJson(Map<String, dynamic> json) {
    return ItemBasic(
      id: json['id'] ?? -1,
      name: json['name'] == false ? "" : json['name'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  ItemBasic.copy(ItemBasic other)
      : id = other.id,
        name = other.name;
}