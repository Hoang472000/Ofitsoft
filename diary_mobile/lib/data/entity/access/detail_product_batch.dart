
class DetailProductBatch /*implements Insertable<DetailProductBatch>*/ {
  int? id;
  String? guid;
  String? name;
  int? productId;
  String? productName;
  String? batchCode;
  String? weightTree;
  String? description;
  int? parentId;
  String? parentName;
  int? companyId;
  String? companyName;
  double? weight;
  int? weightUnitId;
  String? weightUnitName;
  double? quantity;
  String? quantityUnitId;
  String? manufactureDate;
  String? expireDate;
  String? image;
  String? type;
  String? typeName;
  List<String>? diaryFarmerTransaction; // ko can de quet QR


  DetailProductBatch({this.id,
    this.guid,
    this.name,
    this.productId,
    this.productName,
    this.batchCode,
    this.weightTree,
    this.description,
    this.parentId,
    this.parentName,
    this.companyId,
    this.companyName,
    this.weight,
    this.weightUnitId,
    this.weightUnitName,
    this.quantity,
    this.quantityUnitId,
    this.manufactureDate,
    this.expireDate,
    this.image,
    this.type,
    this.typeName, 
    this.diaryFarmerTransaction});
  factory DetailProductBatch.fromJson(Map<String, dynamic> json) {
    return DetailProductBatch(
      id: json['id'] ?? -1,
      guid: json['guid'] ?? '',
      name: json['name'] ?? '',
      productId: json['product_id'] ?? -1,
      productName: json['product_name'] ?? '',
      batchCode: json['batch_code'] ?? '',
      weightTree: json['weight_tree'] ?? '',
      description: json['description'] ?? '',
      parentId: json['parent_id'] ?? -1,
      parentName: json['parent_name'] ?? '',
      companyId: json['company_id'] ?? -1,
      companyName: json['company_name'] ?? '',
      weight: json['weight'] ?? 0,
      weightUnitId: json['weight_unit_id'] ?? -1,
      weightUnitName: json['weight_unit_name'] ?? '',
      quantity: json['quantity'] ?? 0,
      quantityUnitId: json['quantity_unit_id'] ?? '',
      manufactureDate: json['manufacture_date'] ?? '',
      expireDate: json['expire_date'] ?? '',
      image: json['image'] ?? '',
      type: json['type'] ?? '',
      typeName: json['type_name'] ?? '',
//      diary_farmer_transaction: json['diary_farmer_transaction'] ?? '', // quet QR code
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['guid'] = guid;
    data['name'] = name;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['batch_code'] = batchCode;
    data['weight_tree'] = weightTree;
    data['description'] = description;
    data['parent_id'] = parentId;
    data['parent_name'] = parentName;
    data['company_id'] = companyId;
    data['company_name'] = companyName;
    data['weight'] = weight;
    data['weight_unit_id'] = weightUnitId;
    data['weight_unit_name'] = weightUnitName;
    data['quantity'] = quantity;
    data['quantity_unit_id'] = quantityUnitId;
    data['manufacture_date'] = manufactureDate;
    data['expire_date'] = expireDate;
    data['image'] = image;
    data['type'] = type;
    data['type_name'] = typeName;
    return data;
  }
/*
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return DetailProductBatchTableCompanion(
      id: Value(id),
      name: Value(name),
      login: Value(login),
      gender: Value(gender),
      dateOfBirth: Value(dateOfBirth),
      address: Value(address),
      active: Value(active),
      group: Value(group),
      language: Value(language),
      mediaContent: Value(mediaContent),
    ).toColumns(nullToAbsent);
  }*/
}
