import 'package:diary_mobile/data/local_data/table/item_default/unit_table.dart';
import 'package:diary_mobile/utils/utils.dart';
import 'package:drift/drift.dart';

import '../../local_data/diary_db.dart';

class UserInfo implements Insertable<UserInfo> {
  int? id;
  String? name;
  String? login;
  String? gender;
  String? dateOfBirth;
  String? address;
  bool? active;
  String? group;
  String? language;
  String? mediaContent;

  UserInfo(
      {this.id,
      this.name,
      this.login,
      this.gender,
      this.dateOfBirth,
      this.address,
      this.active,
      this.group,
      this.language,
      this.mediaContent});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    //print("HoangCV:1 media_content: ${json['media_content']}");
    String gen = json['gender'] ?? '';
    String gender = '';
    if(gen.isNotEmpty){
      switch (gen){
        case 'Male':
          gender = 'Nam';
        case 'Female':
          gender = 'Nữ';
          default :
          gender = 'Khác';
      }
    }
    return UserInfo(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
      login: json['login'] ?? '',
      gender: gender,
      dateOfBirth: json['date_of_birth'] ?? '',
      address: json['address'] ?? '',
      active: json['active'] ?? true,
      group: json['group'] ?? '',
      language: json['language'] ?? '',
      mediaContent: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    String gen = '';
    if(gender!.isNotEmpty){
      switch (gender){
        case 'Nam':
        case 'Male':
          gen = 'male';
        case 'Nữ':
        case 'FeMale':
          gen = 'female';
        default :
          gen = 'other';
      }
    }
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['login'] = login;
    data['gender'] = gen;
    data['date_of_birth'] = Utils.convertTimeUpSever(dateOfBirth ?? '');
    data['address'] = address;
    data['active'] = active;
    data['language'] = language;
    data['group'] = group;
    data['image'] = mediaContent;
    return data;
  }

  UserInfo.copy(UserInfo other)
      : id = other.id,
        name = other.name,
        login = other.login,
        gender = other.gender,
        dateOfBirth = other.dateOfBirth,
        address = other.address,
        active = other.active,
        language = other.language,
        mediaContent = other.mediaContent,
        group = other.group; // Tạo bản sao của danh sách media


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
      group: Value(group),
      language: Value(language),
      mediaContent: Value(mediaContent),
    ).toColumns(nullToAbsent);
  }
}
