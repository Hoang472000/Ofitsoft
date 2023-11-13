import 'dart:convert';
import '../image/image_entity.dart';

class FeedbackInfo{
  int? id;
  int? farmerId;
  String? title;
  String? description;
  List<ImageEntity> images;

  FeedbackInfo({
    this.id,
    this.farmerId,
    this.title,
    this.description,
    this.images = const [],
  });

  factory FeedbackInfo.fromJson(Map<String, dynamic> json) {
    return FeedbackInfo(
      id: json['id'] ?? -1,
      farmerId: json['farmer_id'] ?? -1,
      title: json['title'] ?? '',
      description: ((json['description'] ?? '') as String).replaceAll('<p>', '').replaceAll('</p>', ''),
      images: json['images'] != null ? (json['images'] as List<dynamic>).map((itemJson) => ImageEntity.fromJson(itemJson)).toList() : [],

    );
  }


  String convertMediasListToJson() {
    final List<Map<String, dynamic>> toolListJson =
    images.map((tool) => tool.toJson()).toList();
    return jsonEncode(toolListJson);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer_id'] = farmerId;
    data['title'] = title;
    data['description'] = description;
    List<Map> listImage = [];
    for (int i = 0; i < (images??[]).length; i++) {
      listImage.add({'media_content': (images??[])[i].contentView ?? ''});
    }
    data['farmer_feedback_media_ids'] = listImage;///[{'media_content':""}];
    data['farmer_feedback_attachment_ids'] = [];
    return data;
  }

  FeedbackInfo.copy(FeedbackInfo other)
      : id = other.id,
        farmerId = other.farmerId,
        title = other.title,
        description = other.description,
        images = List.of(other.images??[]); // Tạo bản sao của danh sách media;

}
