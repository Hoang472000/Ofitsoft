import 'dart:convert';
import 'package:diary_mobile/data/entity/setting/reply_entity.dart';

import '../image/image_entity.dart';

class NotifyEntity {
  int? id;
  String? title;
  String? message;
  String? activeTime;
  bool? isRead;

  NotifyEntity({
    this.id,
    this.activeTime,
    this.title,
    this.message,
    this.isRead,
  });

  factory NotifyEntity.fromJson(Map<String, dynamic> json) {
    return NotifyEntity(
      id: json['id'] ?? -1,
      title: json['title'] ?? '',
      message: /*(*/(json['message'] ?? '')/* as String)
          .replaceAll('<p>', '')
          .replaceAll('</p>', '')*/,
      activeTime: json['active_time'] ?? '',
      isRead: json['is_read'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['active_time'] = activeTime;
    data['title'] = title;
    data['message'] = message;
    data['is_read'] = isRead;
    return data;
  }

  NotifyEntity.copy(NotifyEntity other)
      : id = other.id,
        activeTime = other.activeTime,
        title = other.title,
        message = other.message,
        isRead = other.isRead; // Tạo bản sao của danh sách media;
}
