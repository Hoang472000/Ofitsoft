import 'dart:io';

import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/diary/diary.dart';
import 'package:diary_mobile/data/entity/item_default/material_entity.dart';
import 'package:diary_mobile/data/entity/setting/user_info.dart';
import 'package:diary_mobile/data/local_data/table/activity_diary_table.dart';
import 'package:diary_mobile/data/local_data/table/diary_table.dart';
import 'package:diary_mobile/data/local_data/table/item_default/activity_table.dart';
import 'package:diary_mobile/data/local_data/table/item_default/material_table.dart';
import 'package:diary_mobile/data/local_data/table/item_default/tool_table.dart';
import 'package:diary_mobile/data/local_data/table/item_default/unit_table.dart';
import 'package:diary_mobile/data/local_data/table/setting/user_info_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../entity/item_default/activity.dart';
import '../entity/item_default/tool.dart';
import '../entity/item_default/unit.dart';
part 'diary_db.g.dart';

@DriftDatabase(tables: [DiaryTable, ActivityTable, ToolTable, MaterialTable, UnitTable, ActivityDiaryTable, UserInfoTable])
class DiaryDB extends _$DiaryDB {
  // we tell the database where to store the data with this constructor
  DiaryDB._internal() : super(_openConnection());

  // khoi tao 1 singleton
  static final DiaryDB instance = DiaryDB._internal();

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  ///Thêm, sửa, xóa, lấy Diary
  Future<void> insertListDiary(List<Diary> values) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(diaryTable, values);
    });
  }
  Future<List<Diary>> getListDiary() async {
    return await select(diaryTable).get();
  }

  ///Thêm, sửa, xóa, lấy Diary
  Future<void> insertListActivityDiary(List<ActivityDiary> values) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(activityDiaryTable, values);
    });
  }
  Future<List<ActivityDiary>> getListActivityDiary() async {
    return await select(activityDiaryTable).get();
  }

  ///Thêm, sửa, xóa, lấy tool
  Future<void> insertListTool(List<Tool> values) async{
    await batch((batch) {
      batch.insertAllOnConflictUpdate(toolTable, values);
    });
  }
  Future<List<Tool>> getListTool() async {
    return await select(toolTable).get();
  }

  /// material
  Future<void> insertListMaterial(List<MaterialEntity> values) async{
    await batch((batch) {
      batch.insertAllOnConflictUpdate(materialTable, values);
    });
  }
  Future<List<MaterialEntity>> getListMaterial() async {
    return await select(materialTable).get();
  }

  /// Activity
  Future<void> insertListActivity(List<Activity> values) async{
    //final insertables = values.map((activity) => activityTable.map(activity.toMap())).toList();
    await batch((batch) {
      batch.insertAllOnConflictUpdate(activityTable, values );
    });
  }
  Future<List<Activity>> getListActivity() async {
    return await select(activityTable).get();
  }

  /// Unit
  Future<void> insertListUnit(List<Unit> values) async{
    await batch((batch) {
      batch.insertAllOnConflictUpdate(unitTable, values);
    });
  }
  Future<List<Unit>> getListUnit() async {
    return await select(unitTable).get();
  }

  SingleSelectable<UserInfo> singleUser(int userId) {
    return select(userInfoTable)..where((tbl) => tbl.id.equals(userId));
  }

  ///Lay thong tin user
  Future<List<UserInfo>> getUserEntity(int userId) async {
    return (select(userInfoTable)..where((tbl) => tbl.id.equals(userId)))
        .get();
  }

  ///Thêm mới 1 [user] vào csdl
  ///Nếu đã có trong csdl, thì cập nhật
  Future<void> createOrUpdateUser(UserInfo user) {
    return into(userInfoTable).insertOnConflictUpdate(user);
  }

/*  ///Thêm user vào DB, nếu đã có trong DB thì update
  void insertUser(List<UserInfo> values) {
    batch((batch) {
      batch.insertAllOnConflictUpdate(userInfoTable, values);
    });
  }*/

}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}