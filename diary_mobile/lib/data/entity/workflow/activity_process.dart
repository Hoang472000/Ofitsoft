import 'dart:convert';

class ActivityProcess{
  int? activityId;
  String? activityName;
  String? image;
  String? description;

  ActivityProcess({
    this.activityId,
    this.description,
    this.activityName,
    this.image,
  });

  factory ActivityProcess.fromJson(Map<String, dynamic> json) {
    return ActivityProcess(
      activityId: json['activity_id'] ?? -1,
      description: (json['description'] ?? '').replaceAll('<p>', '').replaceAll('</p>', ''),
      activityName: json['activity_name'] ?? '',
      image: json['image'] ?? '',

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activity_id'] = activityId;
    data['description'] = description;
    data['activity_name'] = activityName;
    data['image'] = image;
    return data;
  }
}
