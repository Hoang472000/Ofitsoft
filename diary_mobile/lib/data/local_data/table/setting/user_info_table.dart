import 'package:diary_mobile/data/entity/setting/user_info.dart';
import 'package:drift/drift.dart';

@UseRowClass(UserInfo)
class UserInfoTable extends Table {
  @override
  String get tableName => 'user_info';

  IntColumn get id => integer().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get login => text().nullable()();
  TextColumn get gender => text().nullable()();
  TextColumn get dateOfBirth => text().nullable()();
  TextColumn get address => text().nullable()();
  BoolColumn get active => boolean().nullable()();
  TextColumn get group => text().nullable()();
  TextColumn get language => text().nullable()();
  TextColumn get mediaContent => text().nullable()();

  @override
  Set<Column>? get primaryKey => {id};
}