class ItemExpansion {
  int? id;
  String? name;
  String? amount;

  ItemExpansion({
    this.id,
    this.name,
    this.amount,
  });

  factory ItemExpansion.fromJson(Map<String, dynamic> json) {
    return ItemExpansion(
      id: json['id'] ?? -1,
      name: json['name'] == false ? "" : json['name'] ?? "",
      amount: json['amount'] == false ? "" : json['amount'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['amount'] = amount;
    return data;
  }

  ItemExpansion.copy(ItemExpansion other)
      : id = other.id,
        amount = other.amount,
        name = other.name;
}