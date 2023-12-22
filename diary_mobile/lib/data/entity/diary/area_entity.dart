import 'dart:convert';

import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:drift/drift.dart';

import '../item_default/item_default.dart';

class AreaEntity implements Insertable<AreaEntity> {
  int? userId;
  int? id;
  String? name;
  List<SeasonEntity> seasons;
  String? stringSeasons;
  String? image;

  AreaEntity({this.userId, this.id, this.name, this.seasons = const [],
    this.stringSeasons, this.image,
  });

  factory AreaEntity.fromJson(Map<String, dynamic> json, int userId) {
    return AreaEntity(
      id: json['id'] ?? -1,
      userId: userId,
      name: json['name'] ?? "",
      stringSeasons: jsonEncode(json['seasons']) ?? '[]',
      seasons: json['seasons'] != null
          ? (json['seasons'] as List<dynamic>)
          .map((itemJson) => SeasonEntity.fromJson(itemJson))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['userId'] = userId;
    data['name'] = name;
    data['seasons'] = seasons;
    data['stringSeasons'] = stringSeasons;
    return data;
  }

  String convertSeasonsListToJson() {
    final List<Map<String, dynamic>> questionListJson =
    seasons.map((question) => question.toJson()).toList();
    return jsonEncode(questionListJson);
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return AreaEntityTableCompanion(
      id: Value(id),
      stringSeasons: Value(stringSeasons),
      userId: Value(userId),
      name: Value(name),
    ).toColumns(nullToAbsent);
  }
}

class SeasonEntity {
  int? id;
  String? name;
  String? image;

  SeasonEntity({
    this.id,
    this.name,
    this.image,
  });

  factory SeasonEntity.fromJson(Map<String, dynamic> json) {
    return SeasonEntity(
      id: json['id'] ?? -1,
      name: json['name'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}


