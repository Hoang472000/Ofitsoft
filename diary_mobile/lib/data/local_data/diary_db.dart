import 'dart:convert';
import 'dart:io';

import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/diary/diary.dart';
import 'package:diary_mobile/data/entity/item_default/material_entity.dart';
import 'package:diary_mobile/data/entity/setting/user_info.dart';
import 'package:diary_mobile/data/local_data/table/activity_diary_no_network_table.dart';
import 'package:diary_mobile/data/local_data/table/activity_diary_table.dart';
import 'package:diary_mobile/data/local_data/table/diary_table.dart';
import 'package:diary_mobile/data/local_data/table/item_default/activity_monitor_table.dart';
import 'package:diary_mobile/data/local_data/table/item_default/activity_table.dart';
import 'package:diary_mobile/data/local_data/table/item_default/material_table.dart';
import 'package:diary_mobile/data/local_data/table/item_default/tool_table.dart';
import 'package:diary_mobile/data/local_data/table/item_default/unit_table.dart';
import 'package:diary_mobile/data/local_data/table/monitor_diary_table.dart';
import 'package:diary_mobile/data/local_data/table/report/report_table.dart';
import 'package:diary_mobile/data/local_data/table/setting/user_info_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../entity/activity/activity_diary_no_network.dart';
import '../entity/item_default/activity.dart';
import '../entity/item_default/activity_monitor.dart';
import '../entity/item_default/tool.dart';
import '../entity/item_default/unit.dart';
import '../entity/monitor/monitor_diary.dart';
import '../entity/report/report.dart';
part 'diary_db.g.dart';

@DriftDatabase(tables: [DiaryTable, ActivityTable, ToolTable, MaterialTable, UnitTable, ActivityDiaryTable, UserInfoTable, ActivityMonitorTable, MonitorDiaryTable, ActDiaryNoNetworkTable, ReportTable ])
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
  Future<List<Diary>> getListDiary(int userId, String action) async {
    return (select(diaryTable)..where((tbl) => tbl.userId.equals(userId) & tbl.action.equals(action)))
        .get();
  }
  Future<List<Diary>> getInfoDiary(int id) async {
    return (select(diaryTable)..where((tbl) => tbl.id.equals(id)))
        .get();
  }

  ///Thêm, sửa, xóa, lấy Activity Diary
  Future<void> insertListActivityDiary(List<ActivityDiary> values) async {
 /*   await batch((batch) {
      batch.insertAllOnConflictUpdate(activityDiaryTable, values);
    });*/
    await batch((batch) {
      for (final entry in values) {
        print("HoangCV: entry: ${entry.convertToolsListToJson()}");
        final ActivityDiaryTableCompanion entryCompanion = ActivityDiaryTableCompanion(
          id: Value(entry.id),
          seasonFarmId: Value(entry.seasonFarmId),
          seasonFarm: Value(entry.seasonFarm),
          activityId: Value(entry.activityId),
          actionTime: Value(entry.actionTime),
          actionArea: Value(entry.actionArea),
          actionAreaUnitId: Value(entry.actionAreaUnitId),
          actionAreaUnitName: Value(entry.actionAreaUnitName),
          description: Value(entry.description),
          activityName: Value(entry.activityName),
          harvesting: Value(entry.harvesting),
          amount: Value(entry.amount),
          amountUnitId: Value(entry.amountUnitId),
          amountUnitName: Value(entry.amountUnitName),
          stringTool: Value(entry.convertToolsListToJson()),
          stringMaterial: Value(entry.convertMaterialsListToJson()),
          stringMedia: Value(entry.convertMediasListToJson()),
          productId: Value(entry.productId),
          productName: Value(entry.productName),
          companyId: Value(entry.companyId),
          companyName: Value(entry.companyName),
          quantity: Value(entry.quantity),
          quantityUnitId: Value(entry.quantityUnitId),
          quantityUnitName: Value(entry.quantityUnitName),
          unitPrice: Value(entry.unitPrice),
          total: Value(entry.total),
          buyer: Value(entry.buyer),// Chuyển đổi thành chuỗi JSON
        );
        print("HoangCV: stringTool: ${entryCompanion.stringTool}");
        batch.insertAllOnConflictUpdate(activityDiaryTable, [entryCompanion]);
      }
    });
  }

  Future<List<ActivityDiary>> getListActivityDiary(int id) async {
    final query = await (select(activityDiaryTable)..where((tbl) => tbl.seasonFarmId.equals(id)))
        .get();
    final List<ActivityDiary> diaryEntriesList = [];

    for (final queriedEntry in query) {
      print('Diary Entry Tools String: ${queriedEntry.tool.length} : ${query}');
      final diaryEntry = ActivityDiary.fromJson({
        'id': queriedEntry.id,
        'season_farm_id': queriedEntry.seasonFarmId,
        'season_farm': queriedEntry.seasonFarm,
        'activity_id': queriedEntry.activityId,
        'action_time': queriedEntry.actionTime,
        'action_area': queriedEntry.actionArea,
        'action_area_unit_id': queriedEntry.actionAreaUnitId,
        'action_area_unit_name': queriedEntry.actionAreaUnitName,
        'description': queriedEntry.description,
        'activity_name': queriedEntry.activityName,
        'harvesting': queriedEntry.harvesting,
        'amount': queriedEntry.amount,
        'amount_unit_id': queriedEntry.amountUnitId,
        'amount_unit_name': queriedEntry.amountUnitName,
        'is_Shown': queriedEntry.isShow,
        'diary_tool_ids': jsonDecode(queriedEntry.stringTool??'[]'),
        'diary_material_ids': jsonDecode(queriedEntry.stringMaterial??'[]'),
        'diary_media_ids': jsonDecode(queriedEntry.stringMedia??'[]'),
        'product_id': queriedEntry.productId,
        'product_name': queriedEntry.productName,
        'company_id': queriedEntry.companyId,
        'company_name': queriedEntry.companyName,
        'quantity': queriedEntry.quantity,
        'quantity_unit_id': queriedEntry.quantityUnitId,
        'quantity_unit_name': queriedEntry.quantityUnitName,
        'unit_price': queriedEntry.unitPrice,
        'total': queriedEntry.total,
        'buyer': queriedEntry.buyer,
      });
      diaryEntriesList.add(diaryEntry);
    }
     return diaryEntriesList;
  }

  Future<void> removeActivityDiary(int id) async {
    await (delete(activityDiaryTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  ///Thêm, sửa, xóa, lấy Activity Diary no network
  Future<void> insertListActDiaryNoNetWork(List<ActDiaryNoNetwork> values) async {
    /*   await batch((batch) {
      batch.insertAllOnConflictUpdate(activityDiaryTable, values);
    });*/
    await batch((batch) {
      for (final entry in values) {
        print("HoangCV: entry: ${entry.convertToolsListToJson()}");
        final ActDiaryNoNetworkTableCompanion entryCompanion = ActDiaryNoNetworkTableCompanion(
          api: Value(entry.api),
          id: Value(entry.id),
          seasonFarmId: Value(entry.seasonFarmId),
          stringSeasonFarmIds: Value(entry.stringSeasonFarmIds),
          seasonFarm: Value(entry.seasonFarm),
          activityId: Value(entry.activityId),
          actionTime: Value(entry.actionTime),
          actionArea: Value(entry.actionArea),
          actionAreaUnitId: Value(entry.actionAreaUnitId),
          actionAreaUnitName: Value(entry.actionAreaUnitName),
          description: Value(entry.description),
          activityName: Value(entry.activityName),
          harvesting: Value(entry.harvesting),
          amount: Value(entry.amount),
          amountUnitId: Value(entry.amountUnitId),
          amountUnitName: Value(entry.amountUnitName),
          stringTool: Value(entry.convertToolsListToJson()),
          stringMaterial: Value(entry.convertMaterialsListToJson()),
          stringMedia: Value(entry.convertMediasListToJson()),
          productId: Value(entry.productId),
          productName: Value(entry.productName),
          companyId: Value(entry.companyId),
          companyName: Value(entry.companyName),
          quantity: Value(entry.quantity),
          quantityUnitId: Value(entry.quantityUnitId),
          quantityUnitName: Value(entry.quantityUnitName),
          unitPrice: Value(entry.unitPrice),
          total: Value(entry.total),
          buyer: Value(entry.buyer),/// Chuyển đổi thành chuỗi JSON
        );
        print("HoangCV: stringTool: ${entryCompanion.stringTool}");
        batch.insertAllOnConflictUpdate(actDiaryNoNetworkTable, [entryCompanion]);
      }
    });
  }

  Future<List<ActDiaryNoNetwork>> getListActDiaryNoNetWork() async {
    final query = await (select(actDiaryNoNetworkTable))
        .get();
    final List<ActDiaryNoNetwork> diaryEntriesList = [];

    for (final queriedEntry in query) {
      print('Diary Entry Tools String: ${queriedEntry.tool.length} : ${query}');
      final diaryEntry = ActDiaryNoNetwork.fromJson({
        'api': queriedEntry.api,
        'id': queriedEntry.id,
        'season_farm_id': queriedEntry.seasonFarmId,
        'season_farm_ids': jsonDecode(queriedEntry.stringSeasonFarmIds ?? '[]'),
        'season_farm': queriedEntry.seasonFarm,
        'activity_id': queriedEntry.activityId,
        'action_time': queriedEntry.actionTime,
        'action_area': queriedEntry.actionArea,
        'action_area_unit_id': queriedEntry.actionAreaUnitId,
        'action_area_unit_name': queriedEntry.actionAreaUnitName,
        'description': queriedEntry.description,
        'activity_name': queriedEntry.activityName,
        'harvesting': queriedEntry.harvesting,
        'amount': queriedEntry.amount,
        'amount_unit_id': queriedEntry.amountUnitId,
        'amount_unit_name': queriedEntry.amountUnitName,
        'is_Shown': queriedEntry.isShow,
        'diary_tool_ids': jsonDecode(queriedEntry.stringTool??'[]'),
        'diary_material_ids': jsonDecode(queriedEntry.stringMaterial??'[]'),
        'diary_media_ids': jsonDecode(queriedEntry.stringMedia??'[]'),
        'product_id': queriedEntry.productId,
        'product_name': queriedEntry.productName,
        'company_id': queriedEntry.companyId,
        'company_name': queriedEntry.companyName,
        'quantity': queriedEntry.quantity,
        'quantity_unit_id': queriedEntry.quantityUnitId,
        'quantity_unit_name': queriedEntry.quantityUnitName,
        'unit_price': queriedEntry.unitPrice,
        'total': queriedEntry.total,
        'buyer': queriedEntry.buyer,
      });
      diaryEntriesList.add(diaryEntry);
    }
    return diaryEntriesList;
  }
  
  Future<void> removeActDiaryNoNetWork(int id) async {
     await (delete(actDiaryNoNetworkTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  ///Thêm, sửa, xóa, lấy Monitor Diary
  Future<void> insertListMonitorDiary(List<MonitorDiary> values) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(monitorDiaryTable, values);
    });
  }
  Future<List<MonitorDiary>> getListMonitorDiary() async {
    return await select(monitorDiaryTable).get();
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
  Future<void> insertListActivity(List<Activity> values) async {
    await batch((batch) {
      for (final entry in values) {
        final ActivityTableCompanion entryCompanion = ActivityTableCompanion(
          id: Value(entry.id),
          name: Value(entry.name),
          description: Value(entry.description),
          categoryId: Value(entry.categoryId),
          isOrganic: Value(entry.isOrganic),
          notation: Value(entry.notation),
          image: Value(entry.image),
          isActive: Value(entry.isActive),
          diaryFarmerId: Value(entry.diaryFarmerId),
          toolId: Value(entry.toolId),
          quantity: Value(entry.quantity),
          mediaContent: Value(entry.mediaContent),
          harvesting: Value(entry.harvesting),
          stringToolIds: Value(entry.stringToolIds),
          stringMaterialIds: Value(entry.stringMaterialIds),
          unitId: Value(entry.unitId),
        );
        batch.insertAllOnConflictUpdate(activityTable, [entryCompanion]);
      }
    });
  }

  Future<List<Activity>> getListActivity() async {
    final query = await select(activityTable).get();
    final List<Activity> activitiesList = [];

    for (final queriedEntry in query) {
      final activity = Activity.fromJson({
        'id': queriedEntry.id,
        'name': queriedEntry.name,
        'description': queriedEntry.description,
        'category_id': queriedEntry.categoryId,
        'is_organic': queriedEntry.isOrganic,
        'notation': queriedEntry.notation,
        'image': queriedEntry.image,
        'is_active': queriedEntry.isActive,
        'diary_farmer_id': queriedEntry.diaryFarmerId,
        'tool_id': queriedEntry.toolId,
        'quantity': queriedEntry.quantity,
        'unit_id': queriedEntry.unitId,
        'media_content': queriedEntry.mediaContent,
        'harvesting': queriedEntry.harvesting,
        'tool_ids': jsonDecode(queriedEntry.stringToolIds ?? '[]'),
        'material_ids': jsonDecode(queriedEntry.stringMaterialIds ?? '[]'),
      });
      activitiesList.add(activity);
    }

    return activitiesList;
  }
/*  Future<void> insertListActivity(List<Activity> values) async{
    //final insertables = values.map((activity) => activityTable.map(activity.toMap())).toList();
    await batch((batch) {
      batch.insertAllOnConflictUpdate(activityTable, values );
    });
  }
  Future<List<Activity>> getListActivity() async {
    return await select(activityTable).get();
  }*/

  /// Unit
  Future<void> insertListUnit(List<Unit> values) async{
    await batch((batch) {
      batch.insertAllOnConflictUpdate(unitTable, values);
    });
  }
  Future<List<Unit>> getListUnit(int categoryIdUnitAmount) async {
    return await (select(unitTable)..where((tbl) => tbl.categoryId.equals(categoryIdUnitAmount)))
        .get();
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