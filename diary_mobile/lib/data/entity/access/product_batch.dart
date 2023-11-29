
class ProductBatch /*implements Insertable<ProductBatch>*/ {
  int? id;
  int? userId;
  String? name;
  String? guid;
  String? parentName;
  int? productId;
  String? productName;
  String? batchCode;
  String? weightTree;
  String? description;
  String? manufactureDate;
  String? expireDate;

  ProductBatch(
      {this.id,
        this.userId,
        this.guid,
        this.name,
        this.parentName,
        this.productId,
        this.productName,
        this.batchCode,
        this.weightTree,
        this.description,
        this.manufactureDate,
        this.expireDate});

  factory ProductBatch.fromJson(Map<String, dynamic> json, int userId) {
    return ProductBatch(
      id: json['id'] ?? -1,
      userId: userId,
      guid: json['guid'] ?? '',
      name: json['name'] ?? '',
      parentName: json['parent_name'] ?? '',
      productId: json['product_id'] ?? -1,
      productName: json['product_name'] ?? '',
      batchCode: json['batch_code'] ?? '',
      weightTree: json['weight_tree'] ?? '',
      description: json['description'] ?? '',
      manufactureDate: json['manufacture_date'] ?? '',
      expireDate: json['expire_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['guid'] = guid;
    data['name'] = name;
    data['parent_name'] = parentName;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['batch_code'] = batchCode;
    data['weight_tree'] = weightTree;
    data['description'] = description;
    data['manufacture_date'] = manufactureDate;
    data['expire_date'] = expireDate;
    return data;
  }
/*
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return ProductBatchTableCompanion(
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
