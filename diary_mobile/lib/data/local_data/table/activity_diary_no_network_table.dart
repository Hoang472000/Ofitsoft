import 'package:drift/drift.dart';
import '../../entity/activity/activity_diary_no_network.dart';

@UseRowClass(ActDiaryNoNetwork)
class ActDiaryNoNetworkTable extends Table {
  @override
  String get tableName => 'activity_diary_no_network';

  TextColumn get api => text().nullable()();
  IntColumn get id => integer().nullable()();
  IntColumn get seasonFarmId => integer().nullable()();
  TextColumn get seasonFarm => text().nullable()();
  IntColumn get activityId => integer().nullable()();
  TextColumn get activityName => text().nullable()();
  TextColumn get actionTime => text().nullable()();
  RealColumn get actionArea => real().nullable()();
  IntColumn get actionAreaUnitId => integer().nullable()();
  TextColumn get actionAreaUnitName => text().nullable()();
  TextColumn get description => text().nullable()();
  BoolColumn get isShow => boolean().nullable()();

  TextColumn get name => text().nullable()();
  TextColumn get byName => text().nullable()();
  TextColumn get startTime => text().nullable()();
  TextColumn get endTime => text().nullable()();
  IntColumn get status => integer().nullable()();

  TextColumn get stringTool => text().nullable()();
  TextColumn get stringMaterial => text().nullable()();
  TextColumn get stringMedia => text().nullable()();

  @override
  Set<Column>? get primaryKey => {id};
}