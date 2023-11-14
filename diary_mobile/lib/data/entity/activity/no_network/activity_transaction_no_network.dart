import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:drift/drift.dart';

import '../../../../utils/utils.dart';
import '../activity_transaction.dart';

class ActivityTransactionNoNetwork implements Insertable<ActivityTransactionNoNetwork>{
  String? api;
  int? id;
  String? uuid;
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

  ActivityTransactionNoNetwork({
    this.api,
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

  factory ActivityTransactionNoNetwork.fromJson(Map<String, dynamic> json, String api) {
    return ActivityTransactionNoNetwork(
      api: api,
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

  factory ActivityTransactionNoNetwork.fromJsonConvert(ActivityTransaction json, String api) {
    return ActivityTransactionNoNetwork(
      api: api,
      uuid: json.uuid,
      id: json.id,
      seasonFarmId: json.seasonFarmId,
      seasonFarmName: json.seasonFarmName,
      transactionDate: json.transactionDate,
      quantity: json.quantity,
      quantityUnitId: json.quantityUnitId,
      quantityUnitName: json.quantityUnitName,
      productId: json.productId,
      productName: json.productName,
      person: json.person,
      unitPrice: json.unitPrice,
      isPurchase: json.isPurchase,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api'] = api;
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

  ActivityTransactionNoNetwork.copy(ActivityTransactionNoNetwork other)
      : api = other.api,
        uuid = other.uuid,
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
    return ActivityTransactionNoNetworkTableCompanion(
      api: Value(api),
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
