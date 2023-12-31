import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:drift/drift.dart';

import '../../../utils/utils.dart';

class ActivityTransaction implements Insertable<ActivityTransaction>{
  String? uuid;
  int? id;
  int? seasonFarmId;
  String? seasonFarmName;
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
    this.uuid,
    this.id,
    this.seasonFarmId,
    this.seasonFarmName,
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
      uuid: json['uuid'] ?? '',
      id: json['id'] ?? -1,
      seasonFarmId: json['season_farm_id'] ?? -1,
      seasonFarmName: json['season_farm_name'] ?? '',
      transactionDate: json['transaction_date'] ?? '',
      quantity: json['quantity'] ?? 0,
      quantityUnitId: json['quantity_unit_id'] ?? -1,
      quantityUnitName: json['quantity_unit_name'] ?? '',
      productId: json['product_id'] ?? -1,
      productName: json['product_name'] ?? '',
      person: json['person'] ?? '',
      unitPrice: json['unit_price'] ?? -1,
      isPurchase: json['is_purchase'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = uuid;
    data['id'] = id;
    data['season_farm_id'] = seasonFarmId;
    data['season_farm_name'] = seasonFarmName;
    data['transaction_date'] = Utils.stringToFormattedString(transactionDate ?? "");
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
      : uuid = other.uuid,
        id = other.id,
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

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return ActivityPurchaseTableCompanion(
      id: Value(id),
      uuid: Value(uuid),
      seasonFarmId: Value(seasonFarmId),
      transactionDate: Value(transactionDate),
      seasonFarmName: Value(seasonFarmName),
      quantity: Value(quantity),
      quantityUnitId: Value(quantityUnitId),
      quantityUnitName: Value(quantityUnitName),
      productId: Value(productId),
      productName: Value(productName),
      person: Value(person),
      unitPrice: Value(unitPrice),
      isPurchase: Value(isPurchase),)
        .toColumns(nullToAbsent);
  }
}
