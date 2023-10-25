import '../../../utils/utils.dart';

class SeasonFarm {
  int? id;
  String? name;
  int? productId;
  String? productName;
  String? image;


  SeasonFarm({
    this.id,
    this.name,
    this.productId,
    this.productName,
    this.image,
  });

  factory SeasonFarm.fromJson(Map<String, dynamic> json) {
    return SeasonFarm(
      id: json['id'] ?? -1,
      name: json['name'] ?? "",
      productId: json['product_id'] ?? -1,
      productName: json['product_name'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['image'] = image;
    return data;
  }
}
