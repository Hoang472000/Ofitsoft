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
  TextColumn get active => text().nullable()();
  TextColumn get groupId => text().nullable()();
  TextColumn get mediaContent => text().nullable()();

  @override
  Set<Column>? get primaryKey => {id};
}