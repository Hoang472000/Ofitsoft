import 'package:diary_mobile/data/entity/report/question_upload.dart';
import 'package:drift/drift.dart';


@UseRowClass(FarmerInspectorUpload)
class FarmerInspectorUploadNoNetworkTable extends Table {
  @override
  String get tableName => 'farmer_inspector_upload_no_network';

  IntColumn get id => integer().nullable()();
  TextColumn get api => text().nullable()();
  TextColumn get idOffline => text().nullable()();
  TextColumn get state => text().nullable()();
  IntColumn get farmerId => integer().nullable()();
  TextColumn get farmerCode => text().nullable()();
  IntColumn get farmId => integer().nullable()();
  TextColumn get farmCode => text().nullable()();
  IntColumn get internalInspectorId => integer().nullable()();
  TextColumn get monitoringVisitType => text().nullable()();
  TextColumn get visitDate => text().nullable()();

  @override
  Set<Column>? get primaryKey => {idOffline};
}