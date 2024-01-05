import 'dart:convert';
import 'dart:io';

import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/entity/activity/activity_transaction.dart';
import 'package:diary_mobile/data/entity/activity/no_network/activity_purchase_no_network.dart';
import 'package:diary_mobile/data/entity/activity/season_farm.dart';
import 'package:diary_mobile/data/entity/diary/area_entity.dart';
import 'package:diary_mobile/data/entity/diary/diary.dart';
import 'package:diary_mobile/data/entity/item_default/material_entity.dart';
import 'package:diary_mobile/data/entity/setting/user_info.dart';
import 'package:diary_mobile/data/entity/workflow/workflow.dart';
import 'package:diary_mobile/data/local_data/table/activity_diary_no_network_table.dart';
import 'package:diary_mobile/data/local_data/table/activity_diary_table.dart';
import 'package:diary_mobile/data/local_data/table/area_table.dart';
import 'package:diary_mobile/data/local_data/table/diary_table.dart';
import 'package:diary_mobile/data/local_data/table/item_default/activity_monitor_table.dart';
import 'package:diary_mobile/data/local_data/table/item_default/activity_table.dart';
import 'package:diary_mobile/data/local_data/table/item_default/material_table.dart';
import 'package:diary_mobile/data/local_data/table/item_default/tool_table.dart';
import 'package:diary_mobile/data/local_data/table/item_default/unit_table.dart';
import 'package:diary_mobile/data/local_data/table/monitor_diary_table.dart';
import 'package:diary_mobile/data/local_data/table/report/farmer_inspector_upload_no_network_table.dart';
import 'package:diary_mobile/data/local_data/table/report/question_upload_no_network_table.dart';
import 'package:diary_mobile/data/local_data/table/report/report_select_table.dart';
import 'package:diary_mobile/data/local_data/table/report/report_table.dart';
import 'package:diary_mobile/data/local_data/table/setting/user_info_table.dart';
import 'package:diary_mobile/data/local_data/table/transaction/activity_purchase_table.dart';
import 'package:diary_mobile/data/local_data/table/transaction/activity_transaction_table.dart';
import 'package:diary_mobile/data/local_data/table/transaction/season_farm_table.dart';
import 'package:diary_mobile/data/local_data/workflow_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../../view_model/filter/filter_bloc.dart';
import '../entity/activity/activity_diary_no_network.dart';
import '../entity/activity/activity_purchase.dart';
import '../entity/activity/no_network/activity_transaction_no_network.dart';
import '../entity/item_default/activity.dart';
import '../entity/item_default/activity_monitor.dart';
import '../entity/item_default/tool.dart';
import '../entity/item_default/unit.dart';
import '../entity/monitor/monitor_diary.dart';
import '../entity/report/question_upload.dart';
import '../entity/report/report.dart';
import '../entity/report/report_select.dart';
import 'table/transaction/activity_purchase_no_network_table.dart';
import 'table/transaction/activity_transaction_no_network_table.dart';
part 'diary_db.g.dart';

@DriftDatabase(tables: [DiaryTable, ActivityTable, ToolTable, MaterialTable, UnitTable,
  ActivityDiaryTable, UserInfoTable, ActivityMonitorTable, MonitorDiaryTable,
  ActDiaryNoNetworkTable, ReportTable, QuestionUploadNoNetworkTable, FarmerInspectorUploadNoNetworkTable,
  ReportSelectTable, ActivityPurchaseTable, ActivityTransactionTable, ActivityTransactionNoNetworkTable,
  ActivityPurchaseNoNetworkTable, SeasonFarmTable, WorkflowTable, AreaEntityTable])
class DiaryDB extends _$DiaryDB {
  // we tell the database where to store the data with this constructor
  DiaryDB._internal() : super(_openConnection());

  // khoi tao 1 singleton
  static final DiaryDB instance = DiaryDB._internal();

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 3;

  Future<void> deleteEverything() {
    return transaction(() async {
      // you only need this if you've manually enabled foreign keys
      // await customStatement('PRAGMA foreign_keys = OFF');
      //DateTime startTime = DateTime.now();
      try {
        await delete(diaryTable).go();//1
        await delete(activityTable).go();//2
        await delete(toolTable).go();//3
        await delete(materialTable).go();//4
        await delete(unitTable).go();//5
        await delete(activityDiaryTable).go();//6
        await delete(userInfoTable).go();//7
        await delete(activityMonitorTable).go();//8
        await delete(monitorDiaryTable).go();//9
        await delete(reportTable).go();//10
        await delete(reportSelectTable).go();//11
        await delete(activityPurchaseTable).go();//12
        await delete(activityTransactionTable).go();//13
        await delete(seasonFarmTable).go();//14
        await delete(workflowTable).go();//15
        await delete(areaEntityTable).go();//16
        for (final table in allTables) {
          await delete(table).go();
        }
       /* DateTime endTime = DateTime.now();
        Duration elapsedTime = endTime.difference(startTime);*/
        print('Dữ liệu trong bảng đã được xóa.');
      } catch (e) {
        print('Lỗi xóa dữ liệu: $e');
      }
    });
  }

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
  // loc theo vung trong - mua vu
  Future<List<Diary>> getListDiaryFilter(int userId, String action, int seasonId, int areaId) async {
    if(seasonId != -1 && areaId != -1){
      return (select(diaryTable)..where((tbl) => tbl.userId.equals(userId) & tbl.action.equals(action)
      & tbl.seasonId.equals(seasonId) & tbl.areaId.equals(areaId)))
          .get();
    } else if(seasonId == -1 && areaId != -1){
      return (select(diaryTable)..where((tbl) => tbl.userId.equals(userId) & tbl.action.equals(action)
      & tbl.areaId.equals(areaId)))
          .get();
    } else if(seasonId != -1 && areaId == -1){
      return (select(diaryTable)..where((tbl) => tbl.userId.equals(userId) & tbl.action.equals(action)
      & tbl.seasonId.equals(seasonId)))
          .get();
    } else {
      return (select(diaryTable)..where((tbl) => tbl.userId.equals(userId) & tbl.action.equals(action)))
          .get();
    }
  }

  ///Thêm, sửa, xóa, lấy Activity Diary
  Future<void> insertListActivityDiary(List<ActivityDiary> values) async {
    await batch((batch) {
      for (final entry in values) {
        //print("HoangCV: entry: ${entry.toJson()}");
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
        //print("HoangCV: stringTool: ${entryCompanion.stringTool}");
        batch.insertAllOnConflictUpdate(activityDiaryTable, [entryCompanion]);
      }
    });
  }

  Future<List<ActivityDiary>> getListActivityDiary(int id) async {
    final query = await (select(activityDiaryTable)..where((tbl) => tbl.seasonFarmId.equals(id)))
        .get();
    final List<ActivityDiary> diaryEntriesList = [];

    for (final queriedEntry in query) {
      print('Diary Entry Tools String: ${queriedEntry.tool.length} : ${queriedEntry.toJson()} : ${queriedEntry.activityId}');
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
        //print("HoangCV: entry: ${entry.convertToolsListToJson()}");
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

  ///report
  ///
  ///insert report no network
  Future<void> insertListReport(List<Report> values) async {
    await batch((batch) {
      for (final entry in values) {
        //print("HoangCV: entry: ${entry.toJson()}");
        final ReportTableCompanion entryCompanion = ReportTableCompanion(
            id: Value(entry.id),
            isPage: Value(entry.isPage),
            pageId: Value(entry.pageId),
            surveyId: Value(entry.surveyId),
            title: Value(entry.title),
            userId: Value(entry.userId),
            active: Value(entry.active),
            hasConditionalQuestions: Value(entry.hasConditionalQuestions),
            questionsSelection: Value(entry.questionsSelection),
            timeLimit: Value(entry.timeLimit),
            stringQuestionAndPageIds: Value(entry.convertQuestionsListToJson()),
            stringListFarmers: Value(entry.convertListFarmersListToJson()),
      );
      batch.insertAllOnConflictUpdate(reportTable, [entryCompanion]);
    }
    });
  }
  ///get report no network
  Future<List<Report>> getListReport(int id) async {
    final query = await (select(reportTable)..where((tbl) => tbl.id.equals(id)))
        .get();

    print('getListReport no network String: ${query.length}');
    final List<Report> diaryEntriesList = [];
    for (final queriedEntry in query) {
      print('getListReport no network String: ${queriedEntry.toJson()}');
      final diaryEntry = Report.fromJson({
        'id': queriedEntry.id,
        'is_page': queriedEntry.isPage,
        'page_id': queriedEntry.pageId,
        'survey_id': queriedEntry.surveyId,
        'title': queriedEntry.title,
        'user_id': queriedEntry.userId,
        'active': queriedEntry.active,
        'has_conditional_questions': queriedEntry.hasConditionalQuestions,
        'questions_selection': queriedEntry.questionsSelection,
        'time_limit': queriedEntry.timeLimit,
        'string_question_and_page_ids': queriedEntry.stringQuestionAndPageIds,
        'question_and_page_ids': jsonDecode(queriedEntry.stringQuestionAndPageIds??'[]'),
        'list_farmers': jsonDecode(queriedEntry.stringListFarmers??'[]'),
        'string_list_farmers': queriedEntry.stringListFarmers,
      });
      //print("HoangCV: líst QS: ${diaryEntry.questionAndPageIds}");
      diaryEntriesList.add(diaryEntry);
    }
    return diaryEntriesList;
  }
  ///Thêm, sửa, report no network
  Future<void> insertQuestionUploadNoNetWork(List<QuestionUpload> values) async {
    await batch((batch) {
      for (final entry in values) {
        //print("HoangCV: entry: insertQuestionUploadNoNetWork:  ${entry.toJson()}");
        final QuestionUploadNoNetworkTableCompanion entryCompanion = QuestionUploadNoNetworkTableCompanion(
          api: Value(entry.api),
          idOffline: Value(entry.idOffline),
          userInputId: Value(entry.userInputId),
          surveyId: Value(entry.surveyId),
          questionId: Value(entry.questionId),
          suggestedAnswerId: Value(entry.suggestedAnswerId),
          matrixRowId: Value(entry.matrixRowId),
          answerType: Value(entry.answerType),
          valueText: Value(entry.valueText),
          state: Value(entry.state),
          skipped: Value(entry.skipped),
          isAnswerExist: Value(entry.isAnswerExist),
          valueCheckBox: Value(entry.valueCheckBox),
          tableRowId: Value(entry.tableRowId),
          stringListIdSuggested: Value(entry.stringListIdSuggested),
          farmerId: Value(entry.farmerId),
          farmerCode: Value(entry.farmerCode),
          farmId: Value(entry.farmId),
          farmCode: Value(entry.farmCode),
          internalInspectorId: Value(entry.internalInspectorId),
          monitoringVisitType: Value(entry.monitoringVisitType),
          visitDate: Value(entry.visitDate),
        );
        batch.insertAllOnConflictUpdate(questionUploadNoNetworkTable, [entryCompanion]);
      }
    });
  }
  ///get
  Future<List<QuestionUpload>> getListQuestionUploadNoNetWork() async {
    final query = await (select(questionUploadNoNetworkTable))
        .get();
    final List<QuestionUpload> diaryEntriesList = [];

    print("HoangCV: query:list Question upload: ${query.length}");
    for (final queriedEntry in query) {
      final diaryEntry = QuestionUpload.fromJsonNoNetwork({
        'api': queriedEntry.api,
        'idOffline': queriedEntry.idOffline,
        'userInputId': queriedEntry.userInputId,
        'surveyId': queriedEntry.surveyId,
        'listIdSuggested': jsonDecode(queriedEntry.stringListIdSuggested??'[]'),
        'stringListIdSuggested': queriedEntry.stringListIdSuggested,
        'suggestedAnswerId': queriedEntry.suggestedAnswerId,
        'questionId': queriedEntry.questionId,
        'matrixRowId': queriedEntry.matrixRowId,
        'answerType': queriedEntry.answerType,
        'valueText': queriedEntry.valueText,
        'skipped': queriedEntry.skipped,
        'state': queriedEntry.state,
        'isAnswerExist': queriedEntry.isAnswerExist,
        'valueCheckBox': queriedEntry.valueCheckBox,
        'tableRowId': queriedEntry.tableRowId,
        'farmerId': queriedEntry.farmerId,
        'farmerCode': queriedEntry.farmerCode,
        'internalInspectorId': queriedEntry.internalInspectorId,
        'monitoringVisitType': queriedEntry.monitoringVisitType,
        'visitDate': queriedEntry.visitDate,
        'farmId': queriedEntry.farmId,
        'farmCode': queriedEntry.farmCode,
      });
      diaryEntriesList.add(diaryEntry);
    }
    return diaryEntriesList;
  }
  ///delete
  Future<void> removeQuestionUploadNoNetWork() async {
    await delete(questionUploadNoNetworkTable).go();
  }

  ///report
  ///Thêm, sửa, xóa, lấy report no network
  Future<void> insertFarmerInspectorUploaddNoNetWork(List<FarmerInspectorUpload> values) async {
    await batch((batch) {
      for (final entry in values) {
        //print("HoangCV: entry: insertFarmerInspectorUploaddNoNetWork : ${entry.toJson()}");
        final FarmerInspectorUploadNoNetworkTableCompanion entryCompanion = FarmerInspectorUploadNoNetworkTableCompanion(
          api: Value(entry.api),
          idOffline: Value(entry.idOffline),
          id: Value(entry.id),
          state: Value(entry.state),
          farmerId: Value(entry.farmerId),
          farmerCode: Value(entry.farmerCode),
          farmId: Value(entry.farmId),
          farmCode: Value(entry.farmCode),
          internalInspectorId: Value(entry.internalInspectorId),
          monitoringVisitType: Value(entry.monitoringVisitType),
          visitDate: Value(entry.visitDate),
        );
        batch.insertAllOnConflictUpdate(farmerInspectorUploadNoNetworkTable, [entryCompanion]);
      }
    });
  }
  ///get
  Future<List<FarmerInspectorUpload>> getListFarmerInspectorUploadNoNetWork() async {
    final query = await (select(farmerInspectorUploadNoNetworkTable))
        .get();
    final List<FarmerInspectorUpload> diaryEntriesList = [];

    for (final queriedEntry in query) {
      final diaryEntry = FarmerInspectorUpload.fromJsonNoNetwork({
        'api': queriedEntry.api,
        'idOffline': queriedEntry.idOffline,
        'state': queriedEntry.state,
        'farmerId': queriedEntry.farmerId,
        'farmerCode': queriedEntry.farmerCode,
        'internalInspectorId': queriedEntry.internalInspectorId,
        'monitoringVisitType': queriedEntry.monitoringVisitType,
        'visitDate': queriedEntry.visitDate,
        'farmId': queriedEntry.farmId,
        'farmCode': queriedEntry.farmCode,
      });
      diaryEntriesList.add(diaryEntry);
    }
    return diaryEntriesList;
  }
  ///delete
  Future<void> removeFarmerInspectorUploadNoNetWork(String idOffline) async {
    await (delete(farmerInspectorUploadNoNetworkTable)..where((tbl) => tbl.idOffline.equals(idOffline))).go();
  }

  ///Report Select
  ///
  ///insert, get, Report Select
  Future<void> insertListReportSelect(List<ReportSelect> values) async{
    await batch((batch) {
      batch.insertAllOnConflictUpdate(reportSelectTable, values);
    });
  }
  Future<List<ReportSelect>> getListReportSelect() async {
    return await select(reportSelectTable).get();
  }

  /// Transaction sell
  Future<void> insertListActivityTransaction(List<ActivityTransaction> values) async{
    await batch((batch) {
      batch.insertAllOnConflictUpdate(activityTransactionTable, values);
    });
  }
  Future<List<ActivityTransaction>> getListActivityTransaction() async {
    return await select(activityTransactionTable).get();
  }
  Future<void> removeActivityTransaction() async {
    await (delete(activityTransactionTable).go());
  }

  /// Transaction purchase
  Future<void> insertListActivityPurchase(List<ActivityPurchase> values) async{
    await batch((batch) {
      batch.insertAllOnConflictUpdate(activityPurchaseTable, values);
    });
  }
  Future<List<ActivityPurchase>> getListActivityPurchase(int userId) async {
    return await (select(activityPurchaseTable)..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }
  Future<void> removeActivityPurchase() async {
    await (delete(activityPurchaseTable).go());
  }

  /// Transaction sell no network
  Future<void> insertListActivityTransactionNoNetwork (List<ActivityTransactionNoNetwork> values) async{
    await batch((batch) {
      batch.insertAllOnConflictUpdate(activityTransactionNoNetworkTable, values);
    });
  }
  Future<List<ActivityTransactionNoNetwork>> getListActivityTransactionNoNetwork() async {
    return await select(activityTransactionNoNetworkTable).get();
  }
  Future<void> removeActivityTransactionNoNetWork(int id) async {
    await (delete(activityTransactionNoNetworkTable).go());
  }

  /// Transaction purchase no network
  Future<void> insertListActivityPurchaseNoNetwork(List<ActivityPurchaseNoNetWork> values) async{
    await batch((batch) {
      batch.insertAllOnConflictUpdate(activityPurchaseNoNetworkTable, values);
    });
  }
  Future<List<ActivityPurchaseNoNetWork>> getListActivityPurchaseNoNetwork() async {
    return await select(activityPurchaseNoNetworkTable).get();
  }
  Future<void> removeActivityPurchaseNoNetWork(int id) async {
    await (delete(activityPurchaseNoNetworkTable).go());
  }

  /// Season Farm
  Future<void> insertListSeasonFarm(List<SeasonFarm> values) async{
    await batch((batch) {
      batch.insertAllOnConflictUpdate(seasonFarmTable, values);
    });
  }
  Future<List<SeasonFarm>> getListSeasonFarm(int userId) async {
    return
      await (select(seasonFarmTable)..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }

  ///Thêm, sửa, xóa, lấy Activity Diary
  Future<void> insertListWorkflow(List<Workflow> values) async {
    await batch((batch) {
      for (final entry in values) {
        //print("HoangCV: entry: ${entry.toJson()}");
        final WorkflowTableCompanion entryCompanion = WorkflowTableCompanion(
          id: Value(entry.id),
          name: Value(entry.name),
          cropName: Value(entry.cropName),
          statusName: Value(entry.statusName),
          standard: Value(entry.standard),
          status: Value(entry.status),
          description: Value(entry.description),
          productName: Value(entry.productName),
          stringProcessStageIds: Value(entry.convertProcessListToJson()),// Chuyển đổi thành chuỗi JSON
        );
        //print("HoangCV: stringProcessStageIds: ${entryCompanion.stringProcessStageIds}");
        batch.insertAllOnConflictUpdate(workflowTable, [entryCompanion]);
      }
    });
  }

  Future<List<Workflow>> getListWorkflow(int id) async {
    final query = await (select(workflowTable)..where((tbl) => tbl.id.equals(id)))
        .get();
    final List<Workflow> workflow = [];

    for (final queriedEntry in query) {

      final diaryEntry = Workflow.fromJson({
        'id': queriedEntry.id,
        'name': queriedEntry.name,
        'crop_name': queriedEntry.cropName,
        'product_name': queriedEntry.productName,
        'standard': queriedEntry.standard,
        'status': queriedEntry.status,
        'status_name': queriedEntry.statusName,
        'description': queriedEntry.description,
        'process_stage_ids': jsonDecode(queriedEntry.stringProcessStageIds??'[]'),
      });
      workflow.add(diaryEntry);
    }
    return workflow;
  }

  ///Thêm, sửa, xóa, lấy Area_entity
  Future<void> insertListAreaEntity(List<AreaEntity> values) async {
    await batch((batch) {
      for (final entry in values) {
        //print("HoangCV: entry: ${entry.toJson()}");
        final AreaEntityTableCompanion entryCompanion = AreaEntityTableCompanion(
          id: Value(entry.id),
          name: Value(entry.name),
          userId: Value(entry.userId),
          stringSeasons: Value(entry.convertSeasonsListToJson()),// Chuyển đổi thành chuỗi JSON
        );
        batch.insertAllOnConflictUpdate(areaEntityTable, [entryCompanion]);
      }
    });
  }

  Future<List<AreaEntity>> getListAreaEntity(int userId) async {
    final query = await (select(areaEntityTable)..where((tbl) => tbl.userId.equals(userId)))
        .get();
    final List<AreaEntity> workflow = [];

    for (final queriedEntry in query) {

      final diaryEntry = AreaEntity.fromJson({
        'id': queriedEntry.id,
        'name': queriedEntry.name,
        'userId': queriedEntry.userId,
        'seasons': jsonDecode(queriedEntry.stringSeasons??'[]'),
      }, userId);
      workflow.add(diaryEntry);
    }
    return workflow;
  }

  Future<List<ItemFilter>> getListItemFilter(int userId) async {
    final query = await (select(areaEntityTable)..where((tbl) => tbl.userId.equals(userId)))
        .get();
    final List<ItemFilter> workflow = [];

    for (final queriedEntry in query) {

      final diaryEntry = ItemFilter.fromJson({
        'id': queriedEntry.id,
        'name': queriedEntry.name,
        'list': jsonDecode(queriedEntry.stringSeasons??'[]'),
      });
      workflow.add(diaryEntry);
    }
    return workflow;
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

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll(); // Important! This is what gets called if `onCreate` not provided
        //await m.createIndex(SomeIndexName());
      },
      onUpgrade: (Migrator m, int from, int to) async {
        print("HoangCV : m: ${m} : ${from} : ${to}" );
        if (from == 1) {
          //m.createTable(images);
          m.deleteTable("report_select_table");
          m.createTable(reportSelectTable);
        }
        else if (from == 2) {
          //m.createTable(images);
          m.deleteTable("report_select_table");
          m.createTable(reportSelectTable);
          m.addColumn(diaryTable, diaryTable.seasonName);
          //await m.addColumn(reportSelectTable, reportSelectTable.isInitialAssessment);
        }
        else if (from == 3) {
          m.addColumn(activityPurchaseTable, activityPurchaseTable.farmerName);
          m.addColumn(activityPurchaseTable, activityPurchaseTable.farmerCode);
          m.addColumn(activityPurchaseTable, activityPurchaseTable.areaName);
          //await m.addColumn(reportSelectTable, reportSelectTable.isInitialAssessment);
        }
      },
    );
  }

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