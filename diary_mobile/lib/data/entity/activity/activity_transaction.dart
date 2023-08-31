class ActivityTransaction {
  int? id;
  int? seasonFarmId;
  String? transactionDate;
  double? quantity;
  int? quantityUnitId;
  String? quantityUnitName;
  int? productId;
  String? productName;
  double? unitPrice;
  bool? isPurchase;
  String? person;

  ActivityTransaction({
    this.id,
    this.seasonFarmId,
    this.transactionDate,
    this.quantity,
    this.quantityUnitId,
    this.quantityUnitName,
    this.productId,
    this.unitPrice,
    this.person,
    this.productName,
    this.isPurchase,
  });

  factory ActivityTransaction.fromJson(Map<String, dynamic> json) {
    return ActivityTransaction(
      id: json['id'] ?? -1,
      seasonFarmId: json['season_farm_id'] ?? -1,
      transactionDate: json['transaction_date'] ?? '',
      quantity: json['quantity'] ?? 0,
      quantityUnitId: json['quantity_unit_id'] ?? -1,
      quantityUnitName: json['quantity_unit_name'] ?? '',
      productId: json['product_id'] ?? -1,
      productName: json['product_name'] ?? '',
      person: json['person'] ?? '',
      unitPrice: json['unit_price'] ?? '',
      isPurchase: json['is_purchase'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['season_farm_id'] = seasonFarmId;
    data['transaction_date'] = transactionDate;
    data['quantity'] = quantity;
    data['quantity_unit_id'] = quantityUnitId;
    data['quantity_unit_name'] = quantityUnitName;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['person'] = person;
    data['unit_price'] = unitPrice;
    data['is_purchase'] = isPurchase;
    return data;
  }


  ActivityTransaction.copy(ActivityTransaction other)
      : id = other.id,
        seasonFarmId = other.seasonFarmId,
        transactionDate = other.transactionDate,
        quantity = other.quantity,
        quantityUnitId = other.quantityUnitId,
        quantityUnitName = other.quantityUnitName,
        productId = other.productId,
        productName = other.productName,
        person = other.person,
        unitPrice = other.unitPrice,
        isPurchase = other.isPurchase;
}
