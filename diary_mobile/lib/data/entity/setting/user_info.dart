import 'package:diary_mobile/data/local_data/table/item_default/unit_table.dart';
import 'package:drift/drift.dart';

import '../../local_data/diary_db.dart';

class UserInfo implements Insertable<UserInfo> {
  int? id;
  String? name;
  String? login;
  String? gender;
  String? dateOfBirth;
  String? address;
  String? active;
  String? groupId;
  String? mediaContent;

  UserInfo(
      {this.id,
      this.name,
      this.login,
      this.gender,
      this.dateOfBirth,
      this.address,
      this.active,
      this.groupId,
      this.mediaContent});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    //print("HoangCV:1 media_content: ${json['media_content']}");
    return UserInfo(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
      login: json['login'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      address: json['address'] ?? '',
      active: json['active'] ?? '',
      groupId: json['group_id'] ?? '',
      mediaContent: json['media_content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['login'] = login;
    data['gender'] = gender;
    data['date_of_birth'] = dateOfBirth;
    data['address'] = address;
    data['active'] = active;
    data['group_id'] = groupId;
    data['media_content'] = mediaContent;
    return data;
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return UserInfoTableCompanion(
      id: Value(id),
      name: Value(name),
      login: Value(login),
      gender: Value(gender),
      dateOfBirth: Value(dateOfBirth),
      address: Value(address),
      active: Value(active),
      groupId: Value(groupId),
      mediaContent: Value(mediaContent),
    ).toColumns(nullToAbsent);
  }
}
