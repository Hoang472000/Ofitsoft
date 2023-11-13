import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:drift/drift.dart';

class SeasonFarm implements Insertable<SeasonFarm>{
  int? id;
  int? userId;
  String? name;
  int? productId;
  String? productName;
  String? image;


  SeasonFarm({
    this.userId,
    this.id,
    this.name,
    this.productId,
    this.productName,
    this.image,
  });

  factory SeasonFarm.fromJson(Map<String, dynamic> json, int userId) {
    return SeasonFarm(
      userId: userId,
      id: json['id'] ?? -1,
      name: json['name'] ?? "",
      productId: json['product_id'] ?? -1,
      productName: json['product_name'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = userId;
    data['id'] = id;
    data['name'] = name;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['image'] = image;
    return data;
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return SeasonFarmTableCompanion(
      id: Value(id),
      name: Value(name),
      productId: Value(productId),
      productName: Value(productName),
      image: Value(image),
      userId: Value(userId))
        .toColumns(nullToAbsent);
  }
}
