// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_db.dart';

// ignore_for_file: type=lint
class $DiaryTableTable extends DiaryTable
    with TableInfo<$DiaryTableTable, Diary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiaryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _seasonIdMeta =
      const VerificationMeta('seasonId');
  @override
  late final GeneratedColumn<int> seasonId = GeneratedColumn<int>(
      'season_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _seasonFarmIdMeta =
      const VerificationMeta('seasonFarmId');
  @override
  late final GeneratedColumn<int> seasonFarmId = GeneratedColumn<int>(
      'season_farm_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _activityMeta =
      const VerificationMeta('activity');
  @override
  late final GeneratedColumn<String> activity = GeneratedColumn<String>(
      'activity', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _farmIdMeta = const VerificationMeta('farmId');
  @override
  late final GeneratedColumn<int> farmId = GeneratedColumn<int>(
      'farm_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _farmMeta = const VerificationMeta('farm');
  @override
  late final GeneratedColumn<String> farm = GeneratedColumn<String>(
      'farm', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _activityIdMeta =
      const VerificationMeta('activityId');
  @override
  late final GeneratedColumn<int> activityId = GeneratedColumn<int>(
      'activity_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _productNameMeta =
      const VerificationMeta('productName');
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
      'product_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cropNameMeta =
      const VerificationMeta('cropName');
  @override
  late final GeneratedColumn<String> cropName = GeneratedColumn<String>(
      'crop_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _userMeta = const VerificationMeta('user');
  @override
  late final GeneratedColumn<String> user = GeneratedColumn<String>(
      'user', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _actionTimeMeta =
      const VerificationMeta('actionTime');
  @override
  late final GeneratedColumn<String> actionTime = GeneratedColumn<String>(
      'action_time', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _actionAreaMeta =
      const VerificationMeta('actionArea');
  @override
  late final GeneratedColumn<double> actionArea = GeneratedColumn<double>(
      'action_area', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _actionAreaUnitIdMeta =
      const VerificationMeta('actionAreaUnitId');
  @override
  late final GeneratedColumn<int> actionAreaUnitId = GeneratedColumn<int>(
      'action_area_unit_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cropMeta = const VerificationMeta('crop');
  @override
  late final GeneratedColumn<String> crop = GeneratedColumn<String>(
      'crop', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
      'start_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
      'end_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _amountUnitIdMeta =
      const VerificationMeta('amountUnitId');
  @override
  late final GeneratedColumn<int> amountUnitId = GeneratedColumn<int>(
      'amount_unit_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _amountUnitMeta =
      const VerificationMeta('amountUnit');
  @override
  late final GeneratedColumn<String> amountUnit = GeneratedColumn<String>(
      'amount_unit', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _areaMeta = const VerificationMeta('area');
  @override
  late final GeneratedColumn<double> area = GeneratedColumn<double>(
      'area', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _areaUnitIdMeta =
      const VerificationMeta('areaUnitId');
  @override
  late final GeneratedColumn<int> areaUnitId = GeneratedColumn<int>(
      'area_unit_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _areaUnitMeta =
      const VerificationMeta('areaUnit');
  @override
  late final GeneratedColumn<String> areaUnit = GeneratedColumn<String>(
      'area_unit', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _yieldEstimateMeta =
      const VerificationMeta('yieldEstimate');
  @override
  late final GeneratedColumn<double> yieldEstimate = GeneratedColumn<double>(
      'yield_estimate', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _yieldEstimateUnitIdMeta =
      const VerificationMeta('yieldEstimateUnitId');
  @override
  late final GeneratedColumn<int> yieldEstimateUnitId = GeneratedColumn<int>(
      'yield_estimate_unit_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _yieldEstimateUnitMeta =
      const VerificationMeta('yieldEstimateUnit');
  @override
  late final GeneratedColumn<String> yieldEstimateUnit =
      GeneratedColumn<String>('yield_estimate_unit', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _farmerNameMeta =
      const VerificationMeta('farmerName');
  @override
  late final GeneratedColumn<String> farmerName = GeneratedColumn<String>(
      'farmer_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        seasonId,
        seasonFarmId,
        activity,
        farmId,
        farm,
        activityId,
        productName,
        cropName,
        productId,
        user,
        actionTime,
        actionArea,
        actionAreaUnitId,
        description,
        name,
        crop,
        startDate,
        endDate,
        status,
        amount,
        amountUnitId,
        amountUnit,
        area,
        areaUnitId,
        areaUnit,
        yieldEstimate,
        yieldEstimateUnitId,
        yieldEstimateUnit,
        farmerName
      ];
  @override
  String get aliasedName => _alias ?? 'diary';
  @override
  String get actualTableName => 'diary';
  @override
  VerificationContext validateIntegrity(Insertable<Diary> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('season_id')) {
      context.handle(_seasonIdMeta,
          seasonId.isAcceptableOrUnknown(data['season_id']!, _seasonIdMeta));
    }
    if (data.containsKey('season_farm_id')) {
      context.handle(
          _seasonFarmIdMeta,
          seasonFarmId.isAcceptableOrUnknown(
              data['season_farm_id']!, _seasonFarmIdMeta));
    }
    if (data.containsKey('activity')) {
      context.handle(_activityMeta,
          activity.isAcceptableOrUnknown(data['activity']!, _activityMeta));
    }
    if (data.containsKey('farm_id')) {
      context.handle(_farmIdMeta,
          farmId.isAcceptableOrUnknown(data['farm_id']!, _farmIdMeta));
    }
    if (data.containsKey('farm')) {
      context.handle(
          _farmMeta, farm.isAcceptableOrUnknown(data['farm']!, _farmMeta));
    }
    if (data.containsKey('activity_id')) {
      context.handle(
          _activityIdMeta,
          activityId.isAcceptableOrUnknown(
              data['activity_id']!, _activityIdMeta));
    }
    if (data.containsKey('product_name')) {
      context.handle(
          _productNameMeta,
          productName.isAcceptableOrUnknown(
              data['product_name']!, _productNameMeta));
    }
    if (data.containsKey('crop_name')) {
      context.handle(_cropNameMeta,
          cropName.isAcceptableOrUnknown(data['crop_name']!, _cropNameMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    }
    if (data.containsKey('user')) {
      context.handle(
          _userMeta, user.isAcceptableOrUnknown(data['user']!, _userMeta));
    }
    if (data.containsKey('action_time')) {
      context.handle(
          _actionTimeMeta,
          actionTime.isAcceptableOrUnknown(
              data['action_time']!, _actionTimeMeta));
    }
    if (data.containsKey('action_area')) {
      context.handle(
          _actionAreaMeta,
          actionArea.isAcceptableOrUnknown(
              data['action_area']!, _actionAreaMeta));
    }
    if (data.containsKey('action_area_unit_id')) {
      context.handle(
          _actionAreaUnitIdMeta,
          actionAreaUnitId.isAcceptableOrUnknown(
              data['action_area_unit_id']!, _actionAreaUnitIdMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('crop')) {
      context.handle(
          _cropMeta, crop.isAcceptableOrUnknown(data['crop']!, _cropMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    }
    if (data.containsKey('amount_unit_id')) {
      context.handle(
          _amountUnitIdMeta,
          amountUnitId.isAcceptableOrUnknown(
              data['amount_unit_id']!, _amountUnitIdMeta));
    }
    if (data.containsKey('amount_unit')) {
      context.handle(
          _amountUnitMeta,
          amountUnit.isAcceptableOrUnknown(
              data['amount_unit']!, _amountUnitMeta));
    }
    if (data.containsKey('area')) {
      context.handle(
          _areaMeta, area.isAcceptableOrUnknown(data['area']!, _areaMeta));
    }
    if (data.containsKey('area_unit_id')) {
      context.handle(
          _areaUnitIdMeta,
          areaUnitId.isAcceptableOrUnknown(
              data['area_unit_id']!, _areaUnitIdMeta));
    }
    if (data.containsKey('area_unit')) {
      context.handle(_areaUnitMeta,
          areaUnit.isAcceptableOrUnknown(data['area_unit']!, _areaUnitMeta));
    }
    if (data.containsKey('yield_estimate')) {
      context.handle(
          _yieldEstimateMeta,
          yieldEstimate.isAcceptableOrUnknown(
              data['yield_estimate']!, _yieldEstimateMeta));
    }
    if (data.containsKey('yield_estimate_unit_id')) {
      context.handle(
          _yieldEstimateUnitIdMeta,
          yieldEstimateUnitId.isAcceptableOrUnknown(
              data['yield_estimate_unit_id']!, _yieldEstimateUnitIdMeta));
    }
    if (data.containsKey('yield_estimate_unit')) {
      context.handle(
          _yieldEstimateUnitMeta,
          yieldEstimateUnit.isAcceptableOrUnknown(
              data['yield_estimate_unit']!, _yieldEstimateUnitMeta));
    }
    if (data.containsKey('farmer_name')) {
      context.handle(
          _farmerNameMeta,
          farmerName.isAcceptableOrUnknown(
              data['farmer_name']!, _farmerNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Diary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Diary(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      seasonId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}season_id']),
      seasonFarmId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}season_farm_id']),
      activity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}activity']),
      activityId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}activity_id']),
      actionTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action_time']),
      actionArea: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}action_area']),
      actionAreaUnitId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}action_area_unit_id']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      farmId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}farm_id']),
      crop: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}crop']),
      productName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_name']),
      cropName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}crop_name']),
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id']),
      area: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}area']),
      areaUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}area_unit']),
      areaUnitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}area_unit_id']),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount']),
      amountUnitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_unit_id']),
      amountUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}amount_unit']),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_date']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_date']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status']),
      yieldEstimate: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}yield_estimate']),
      yieldEstimateUnitId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}yield_estimate_unit_id']),
      yieldEstimateUnit: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}yield_estimate_unit']),
      farm: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}farm']),
      farmerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}farmer_name']),
    );
  }

  @override
  $DiaryTableTable createAlias(String alias) {
    return $DiaryTableTable(attachedDatabase, alias);
  }
}

class DiaryTableCompanion extends UpdateCompanion<Diary> {
  final Value<int?> id;
  final Value<int?> seasonId;
  final Value<int?> seasonFarmId;
  final Value<String?> activity;
  final Value<int?> farmId;
  final Value<String?> farm;
  final Value<int?> activityId;
  final Value<String?> productName;
  final Value<String?> cropName;
  final Value<int?> productId;
  final Value<String?> user;
  final Value<String?> actionTime;
  final Value<double?> actionArea;
  final Value<int?> actionAreaUnitId;
  final Value<String?> description;
  final Value<String?> name;
  final Value<String?> crop;
  final Value<String?> startDate;
  final Value<String?> endDate;
  final Value<String?> status;
  final Value<double?> amount;
  final Value<int?> amountUnitId;
  final Value<String?> amountUnit;
  final Value<double?> area;
  final Value<int?> areaUnitId;
  final Value<String?> areaUnit;
  final Value<double?> yieldEstimate;
  final Value<int?> yieldEstimateUnitId;
  final Value<String?> yieldEstimateUnit;
  final Value<String?> farmerName;
  const DiaryTableCompanion({
    this.id = const Value.absent(),
    this.seasonId = const Value.absent(),
    this.seasonFarmId = const Value.absent(),
    this.activity = const Value.absent(),
    this.farmId = const Value.absent(),
    this.farm = const Value.absent(),
    this.activityId = const Value.absent(),
    this.productName = const Value.absent(),
    this.cropName = const Value.absent(),
    this.productId = const Value.absent(),
    this.user = const Value.absent(),
    this.actionTime = const Value.absent(),
    this.actionArea = const Value.absent(),
    this.actionAreaUnitId = const Value.absent(),
    this.description = const Value.absent(),
    this.name = const Value.absent(),
    this.crop = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.status = const Value.absent(),
    this.amount = const Value.absent(),
    this.amountUnitId = const Value.absent(),
    this.amountUnit = const Value.absent(),
    this.area = const Value.absent(),
    this.areaUnitId = const Value.absent(),
    this.areaUnit = const Value.absent(),
    this.yieldEstimate = const Value.absent(),
    this.yieldEstimateUnitId = const Value.absent(),
    this.yieldEstimateUnit = const Value.absent(),
    this.farmerName = const Value.absent(),
  });
  DiaryTableCompanion.insert({
    this.id = const Value.absent(),
    this.seasonId = const Value.absent(),
    this.seasonFarmId = const Value.absent(),
    this.activity = const Value.absent(),
    this.farmId = const Value.absent(),
    this.farm = const Value.absent(),
    this.activityId = const Value.absent(),
    this.productName = const Value.absent(),
    this.cropName = const Value.absent(),
    this.productId = const Value.absent(),
    this.user = const Value.absent(),
    this.actionTime = const Value.absent(),
    this.actionArea = const Value.absent(),
    this.actionAreaUnitId = const Value.absent(),
    this.description = const Value.absent(),
    this.name = const Value.absent(),
    this.crop = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.status = const Value.absent(),
    this.amount = const Value.absent(),
    this.amountUnitId = const Value.absent(),
    this.amountUnit = const Value.absent(),
    this.area = const Value.absent(),
    this.areaUnitId = const Value.absent(),
    this.areaUnit = const Value.absent(),
    this.yieldEstimate = const Value.absent(),
    this.yieldEstimateUnitId = const Value.absent(),
    this.yieldEstimateUnit = const Value.absent(),
    this.farmerName = const Value.absent(),
  });
  static Insertable<Diary> custom({
    Expression<int>? id,
    Expression<int>? seasonId,
    Expression<int>? seasonFarmId,
    Expression<String>? activity,
    Expression<int>? farmId,
    Expression<String>? farm,
    Expression<int>? activityId,
    Expression<String>? productName,
    Expression<String>? cropName,
    Expression<int>? productId,
    Expression<String>? user,
    Expression<String>? actionTime,
    Expression<double>? actionArea,
    Expression<int>? actionAreaUnitId,
    Expression<String>? description,
    Expression<String>? name,
    Expression<String>? crop,
    Expression<String>? startDate,
    Expression<String>? endDate,
    Expression<String>? status,
    Expression<double>? amount,
    Expression<int>? amountUnitId,
    Expression<String>? amountUnit,
    Expression<double>? area,
    Expression<int>? areaUnitId,
    Expression<String>? areaUnit,
    Expression<double>? yieldEstimate,
    Expression<int>? yieldEstimateUnitId,
    Expression<String>? yieldEstimateUnit,
    Expression<String>? farmerName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (seasonId != null) 'season_id': seasonId,
      if (seasonFarmId != null) 'season_farm_id': seasonFarmId,
      if (activity != null) 'activity': activity,
      if (farmId != null) 'farm_id': farmId,
      if (farm != null) 'farm': farm,
      if (activityId != null) 'activity_id': activityId,
      if (productName != null) 'product_name': productName,
      if (cropName != null) 'crop_name': cropName,
      if (productId != null) 'product_id': productId,
      if (user != null) 'user': user,
      if (actionTime != null) 'action_time': actionTime,
      if (actionArea != null) 'action_area': actionArea,
      if (actionAreaUnitId != null) 'action_area_unit_id': actionAreaUnitId,
      if (description != null) 'description': description,
      if (name != null) 'name': name,
      if (crop != null) 'crop': crop,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (status != null) 'status': status,
      if (amount != null) 'amount': amount,
      if (amountUnitId != null) 'amount_unit_id': amountUnitId,
      if (amountUnit != null) 'amount_unit': amountUnit,
      if (area != null) 'area': area,
      if (areaUnitId != null) 'area_unit_id': areaUnitId,
      if (areaUnit != null) 'area_unit': areaUnit,
      if (yieldEstimate != null) 'yield_estimate': yieldEstimate,
      if (yieldEstimateUnitId != null)
        'yield_estimate_unit_id': yieldEstimateUnitId,
      if (yieldEstimateUnit != null) 'yield_estimate_unit': yieldEstimateUnit,
      if (farmerName != null) 'farmer_name': farmerName,
    });
  }

  DiaryTableCompanion copyWith(
      {Value<int?>? id,
      Value<int?>? seasonId,
      Value<int?>? seasonFarmId,
      Value<String?>? activity,
      Value<int?>? farmId,
      Value<String?>? farm,
      Value<int?>? activityId,
      Value<String?>? productName,
      Value<String?>? cropName,
      Value<int?>? productId,
      Value<String?>? user,
      Value<String?>? actionTime,
      Value<double?>? actionArea,
      Value<int?>? actionAreaUnitId,
      Value<String?>? description,
      Value<String?>? name,
      Value<String?>? crop,
      Value<String?>? startDate,
      Value<String?>? endDate,
      Value<String?>? status,
      Value<double?>? amount,
      Value<int?>? amountUnitId,
      Value<String?>? amountUnit,
      Value<double?>? area,
      Value<int?>? areaUnitId,
      Value<String?>? areaUnit,
      Value<double?>? yieldEstimate,
      Value<int?>? yieldEstimateUnitId,
      Value<String?>? yieldEstimateUnit,
      Value<String?>? farmerName}) {
    return DiaryTableCompanion(
      id: id ?? this.id,
      seasonId: seasonId ?? this.seasonId,
      seasonFarmId: seasonFarmId ?? this.seasonFarmId,
      activity: activity ?? this.activity,
      farmId: farmId ?? this.farmId,
      farm: farm ?? this.farm,
      activityId: activityId ?? this.activityId,
      productName: productName ?? this.productName,
      cropName: cropName ?? this.cropName,
      productId: productId ?? this.productId,
      user: user ?? this.user,
      actionTime: actionTime ?? this.actionTime,
      actionArea: actionArea ?? this.actionArea,
      actionAreaUnitId: actionAreaUnitId ?? this.actionAreaUnitId,
      description: description ?? this.description,
      name: name ?? this.name,
      crop: crop ?? this.crop,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      amountUnitId: amountUnitId ?? this.amountUnitId,
      amountUnit: amountUnit ?? this.amountUnit,
      area: area ?? this.area,
      areaUnitId: areaUnitId ?? this.areaUnitId,
      areaUnit: areaUnit ?? this.areaUnit,
      yieldEstimate: yieldEstimate ?? this.yieldEstimate,
      yieldEstimateUnitId: yieldEstimateUnitId ?? this.yieldEstimateUnitId,
      yieldEstimateUnit: yieldEstimateUnit ?? this.yieldEstimateUnit,
      farmerName: farmerName ?? this.farmerName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (seasonId.present) {
      map['season_id'] = Variable<int>(seasonId.value);
    }
    if (seasonFarmId.present) {
      map['season_farm_id'] = Variable<int>(seasonFarmId.value);
    }
    if (activity.present) {
      map['activity'] = Variable<String>(activity.value);
    }
    if (farmId.present) {
      map['farm_id'] = Variable<int>(farmId.value);
    }
    if (farm.present) {
      map['farm'] = Variable<String>(farm.value);
    }
    if (activityId.present) {
      map['activity_id'] = Variable<int>(activityId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (cropName.present) {
      map['crop_name'] = Variable<String>(cropName.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (user.present) {
      map['user'] = Variable<String>(user.value);
    }
    if (actionTime.present) {
      map['action_time'] = Variable<String>(actionTime.value);
    }
    if (actionArea.present) {
      map['action_area'] = Variable<double>(actionArea.value);
    }
    if (actionAreaUnitId.present) {
      map['action_area_unit_id'] = Variable<int>(actionAreaUnitId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (crop.present) {
      map['crop'] = Variable<String>(crop.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (amountUnitId.present) {
      map['amount_unit_id'] = Variable<int>(amountUnitId.value);
    }
    if (amountUnit.present) {
      map['amount_unit'] = Variable<String>(amountUnit.value);
    }
    if (area.present) {
      map['area'] = Variable<double>(area.value);
    }
    if (areaUnitId.present) {
      map['area_unit_id'] = Variable<int>(areaUnitId.value);
    }
    if (areaUnit.present) {
      map['area_unit'] = Variable<String>(areaUnit.value);
    }
    if (yieldEstimate.present) {
      map['yield_estimate'] = Variable<double>(yieldEstimate.value);
    }
    if (yieldEstimateUnitId.present) {
      map['yield_estimate_unit_id'] = Variable<int>(yieldEstimateUnitId.value);
    }
    if (yieldEstimateUnit.present) {
      map['yield_estimate_unit'] = Variable<String>(yieldEstimateUnit.value);
    }
    if (farmerName.present) {
      map['farmer_name'] = Variable<String>(farmerName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiaryTableCompanion(')
          ..write('id: $id, ')
          ..write('seasonId: $seasonId, ')
          ..write('seasonFarmId: $seasonFarmId, ')
          ..write('activity: $activity, ')
          ..write('farmId: $farmId, ')
          ..write('farm: $farm, ')
          ..write('activityId: $activityId, ')
          ..write('productName: $productName, ')
          ..write('cropName: $cropName, ')
          ..write('productId: $productId, ')
          ..write('user: $user, ')
          ..write('actionTime: $actionTime, ')
          ..write('actionArea: $actionArea, ')
          ..write('actionAreaUnitId: $actionAreaUnitId, ')
          ..write('description: $description, ')
          ..write('name: $name, ')
          ..write('crop: $crop, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('status: $status, ')
          ..write('amount: $amount, ')
          ..write('amountUnitId: $amountUnitId, ')
          ..write('amountUnit: $amountUnit, ')
          ..write('area: $area, ')
          ..write('areaUnitId: $areaUnitId, ')
          ..write('areaUnit: $areaUnit, ')
          ..write('yieldEstimate: $yieldEstimate, ')
          ..write('yieldEstimateUnitId: $yieldEstimateUnitId, ')
          ..write('yieldEstimateUnit: $yieldEstimateUnit, ')
          ..write('farmerName: $farmerName')
          ..write(')'))
        .toString();
  }
}

class $ActivityTableTable extends ActivityTable
    with TableInfo<$ActivityTableTable, Activity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isOrganicMeta =
      const VerificationMeta('isOrganic');
  @override
  late final GeneratedColumn<bool> isOrganic =
      GeneratedColumn<bool>('is_organic', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_organic" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _notationMeta =
      const VerificationMeta('notation');
  @override
  late final GeneratedColumn<bool> notation =
      GeneratedColumn<bool>('notation', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("notation" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive =
      GeneratedColumn<bool>('is_active', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_active" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _diaryFarmerIdMeta =
      const VerificationMeta('diaryFarmerId');
  @override
  late final GeneratedColumn<int> diaryFarmerId = GeneratedColumn<int>(
      'diary_farmer_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _toolIdMeta = const VerificationMeta('toolId');
  @override
  late final GeneratedColumn<int> toolId = GeneratedColumn<int>(
      'tool_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<String> unitId = GeneratedColumn<String>(
      'unit_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _mediaContentMeta =
      const VerificationMeta('mediaContent');
  @override
  late final GeneratedColumn<String> mediaContent = GeneratedColumn<String>(
      'media_content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        categoryId,
        name,
        description,
        isOrganic,
        notation,
        isActive,
        image,
        diaryFarmerId,
        toolId,
        quantity,
        unitId,
        mediaContent
      ];
  @override
  String get aliasedName => _alias ?? 'activity';
  @override
  String get actualTableName => 'activity';
  @override
  VerificationContext validateIntegrity(Insertable<Activity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('is_organic')) {
      context.handle(_isOrganicMeta,
          isOrganic.isAcceptableOrUnknown(data['is_organic']!, _isOrganicMeta));
    }
    if (data.containsKey('notation')) {
      context.handle(_notationMeta,
          notation.isAcceptableOrUnknown(data['notation']!, _notationMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    if (data.containsKey('diary_farmer_id')) {
      context.handle(
          _diaryFarmerIdMeta,
          diaryFarmerId.isAcceptableOrUnknown(
              data['diary_farmer_id']!, _diaryFarmerIdMeta));
    }
    if (data.containsKey('tool_id')) {
      context.handle(_toolIdMeta,
          toolId.isAcceptableOrUnknown(data['tool_id']!, _toolIdMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('unit_id')) {
      context.handle(_unitIdMeta,
          unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta));
    }
    if (data.containsKey('media_content')) {
      context.handle(
          _mediaContentMeta,
          mediaContent.isAcceptableOrUnknown(
              data['media_content']!, _mediaContentMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Activity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Activity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id']),
      isOrganic: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_organic']),
      notation: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}notation']),
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active']),
      diaryFarmerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}diary_farmer_id']),
      toolId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tool_id']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity']),
      unitId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit_id']),
      mediaContent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}media_content']),
    );
  }

  @override
  $ActivityTableTable createAlias(String alias) {
    return $ActivityTableTable(attachedDatabase, alias);
  }
}

class ActivityTableCompanion extends UpdateCompanion<Activity> {
  final Value<int?> id;
  final Value<int?> categoryId;
  final Value<String?> name;
  final Value<String?> description;
  final Value<bool?> isOrganic;
  final Value<bool?> notation;
  final Value<bool?> isActive;
  final Value<String?> image;
  final Value<int?> diaryFarmerId;
  final Value<int?> toolId;
  final Value<int?> quantity;
  final Value<String?> unitId;
  final Value<String?> mediaContent;
  const ActivityTableCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isOrganic = const Value.absent(),
    this.notation = const Value.absent(),
    this.isActive = const Value.absent(),
    this.image = const Value.absent(),
    this.diaryFarmerId = const Value.absent(),
    this.toolId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitId = const Value.absent(),
    this.mediaContent = const Value.absent(),
  });
  ActivityTableCompanion.insert({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isOrganic = const Value.absent(),
    this.notation = const Value.absent(),
    this.isActive = const Value.absent(),
    this.image = const Value.absent(),
    this.diaryFarmerId = const Value.absent(),
    this.toolId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitId = const Value.absent(),
    this.mediaContent = const Value.absent(),
  });
  static Insertable<Activity> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isOrganic,
    Expression<bool>? notation,
    Expression<bool>? isActive,
    Expression<String>? image,
    Expression<int>? diaryFarmerId,
    Expression<int>? toolId,
    Expression<int>? quantity,
    Expression<String>? unitId,
    Expression<String>? mediaContent,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (isOrganic != null) 'is_organic': isOrganic,
      if (notation != null) 'notation': notation,
      if (isActive != null) 'is_active': isActive,
      if (image != null) 'image': image,
      if (diaryFarmerId != null) 'diary_farmer_id': diaryFarmerId,
      if (toolId != null) 'tool_id': toolId,
      if (quantity != null) 'quantity': quantity,
      if (unitId != null) 'unit_id': unitId,
      if (mediaContent != null) 'media_content': mediaContent,
    });
  }

  ActivityTableCompanion copyWith(
      {Value<int?>? id,
      Value<int?>? categoryId,
      Value<String?>? name,
      Value<String?>? description,
      Value<bool?>? isOrganic,
      Value<bool?>? notation,
      Value<bool?>? isActive,
      Value<String?>? image,
      Value<int?>? diaryFarmerId,
      Value<int?>? toolId,
      Value<int?>? quantity,
      Value<String?>? unitId,
      Value<String?>? mediaContent}) {
    return ActivityTableCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      isOrganic: isOrganic ?? this.isOrganic,
      notation: notation ?? this.notation,
      isActive: isActive ?? this.isActive,
      image: image ?? this.image,
      diaryFarmerId: diaryFarmerId ?? this.diaryFarmerId,
      toolId: toolId ?? this.toolId,
      quantity: quantity ?? this.quantity,
      unitId: unitId ?? this.unitId,
      mediaContent: mediaContent ?? this.mediaContent,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isOrganic.present) {
      map['is_organic'] = Variable<bool>(isOrganic.value);
    }
    if (notation.present) {
      map['notation'] = Variable<bool>(notation.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (diaryFarmerId.present) {
      map['diary_farmer_id'] = Variable<int>(diaryFarmerId.value);
    }
    if (toolId.present) {
      map['tool_id'] = Variable<int>(toolId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    if (mediaContent.present) {
      map['media_content'] = Variable<String>(mediaContent.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityTableCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isOrganic: $isOrganic, ')
          ..write('notation: $notation, ')
          ..write('isActive: $isActive, ')
          ..write('image: $image, ')
          ..write('diaryFarmerId: $diaryFarmerId, ')
          ..write('toolId: $toolId, ')
          ..write('quantity: $quantity, ')
          ..write('unitId: $unitId, ')
          ..write('mediaContent: $mediaContent')
          ..write(')'))
        .toString();
  }
}

class $ToolTableTable extends ToolTable with TableInfo<$ToolTableTable, Tool> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ToolTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _toolNameMeta =
      const VerificationMeta('toolName');
  @override
  late final GeneratedColumn<String> toolName = GeneratedColumn<String>(
      'tool_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isOrganicMeta =
      const VerificationMeta('isOrganic');
  @override
  late final GeneratedColumn<bool> isOrganic =
      GeneratedColumn<bool>('is_organic', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_organic" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _notationMeta =
      const VerificationMeta('notation');
  @override
  late final GeneratedColumn<bool> notation =
      GeneratedColumn<bool>('notation', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("notation" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive =
      GeneratedColumn<bool>('is_active', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_active" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _diaryFarmerIdMeta =
      const VerificationMeta('diaryFarmerId');
  @override
  late final GeneratedColumn<int> diaryFarmerId = GeneratedColumn<int>(
      'diary_farmer_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _toolIdMeta = const VerificationMeta('toolId');
  @override
  late final GeneratedColumn<int> toolId = GeneratedColumn<int>(
      'tool_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<int> unitId = GeneratedColumn<int>(
      'unit_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _unitNameMeta =
      const VerificationMeta('unitName');
  @override
  late final GeneratedColumn<String> unitName = GeneratedColumn<String>(
      'unit_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _mediaContentMeta =
      const VerificationMeta('mediaContent');
  @override
  late final GeneratedColumn<String> mediaContent = GeneratedColumn<String>(
      'media_content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        categoryId,
        toolName,
        name,
        description,
        isOrganic,
        notation,
        isActive,
        image,
        diaryFarmerId,
        toolId,
        quantity,
        unitId,
        unitName,
        mediaContent
      ];
  @override
  String get aliasedName => _alias ?? 'tool';
  @override
  String get actualTableName => 'tool';
  @override
  VerificationContext validateIntegrity(Insertable<Tool> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('tool_name')) {
      context.handle(_toolNameMeta,
          toolName.isAcceptableOrUnknown(data['tool_name']!, _toolNameMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('is_organic')) {
      context.handle(_isOrganicMeta,
          isOrganic.isAcceptableOrUnknown(data['is_organic']!, _isOrganicMeta));
    }
    if (data.containsKey('notation')) {
      context.handle(_notationMeta,
          notation.isAcceptableOrUnknown(data['notation']!, _notationMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    if (data.containsKey('diary_farmer_id')) {
      context.handle(
          _diaryFarmerIdMeta,
          diaryFarmerId.isAcceptableOrUnknown(
              data['diary_farmer_id']!, _diaryFarmerIdMeta));
    }
    if (data.containsKey('tool_id')) {
      context.handle(_toolIdMeta,
          toolId.isAcceptableOrUnknown(data['tool_id']!, _toolIdMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('unit_id')) {
      context.handle(_unitIdMeta,
          unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta));
    }
    if (data.containsKey('unit_name')) {
      context.handle(_unitNameMeta,
          unitName.isAcceptableOrUnknown(data['unit_name']!, _unitNameMeta));
    }
    if (data.containsKey('media_content')) {
      context.handle(
          _mediaContentMeta,
          mediaContent.isAcceptableOrUnknown(
              data['media_content']!, _mediaContentMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tool map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tool(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      toolName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tool_name']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id']),
      isOrganic: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_organic']),
      notation: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}notation']),
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active']),
      diaryFarmerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}diary_farmer_id']),
      toolId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tool_id']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity']),
      unitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unit_id']),
      unitName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit_name']),
      mediaContent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}media_content']),
    );
  }

  @override
  $ToolTableTable createAlias(String alias) {
    return $ToolTableTable(attachedDatabase, alias);
  }
}

class ToolTableCompanion extends UpdateCompanion<Tool> {
  final Value<int?> id;
  final Value<int?> categoryId;
  final Value<String?> toolName;
  final Value<String?> name;
  final Value<String?> description;
  final Value<bool?> isOrganic;
  final Value<bool?> notation;
  final Value<bool?> isActive;
  final Value<String?> image;
  final Value<int?> diaryFarmerId;
  final Value<int?> toolId;
  final Value<double?> quantity;
  final Value<int?> unitId;
  final Value<String?> unitName;
  final Value<String?> mediaContent;
  const ToolTableCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.toolName = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isOrganic = const Value.absent(),
    this.notation = const Value.absent(),
    this.isActive = const Value.absent(),
    this.image = const Value.absent(),
    this.diaryFarmerId = const Value.absent(),
    this.toolId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitId = const Value.absent(),
    this.unitName = const Value.absent(),
    this.mediaContent = const Value.absent(),
  });
  ToolTableCompanion.insert({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.toolName = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isOrganic = const Value.absent(),
    this.notation = const Value.absent(),
    this.isActive = const Value.absent(),
    this.image = const Value.absent(),
    this.diaryFarmerId = const Value.absent(),
    this.toolId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitId = const Value.absent(),
    this.unitName = const Value.absent(),
    this.mediaContent = const Value.absent(),
  });
  static Insertable<Tool> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<String>? toolName,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isOrganic,
    Expression<bool>? notation,
    Expression<bool>? isActive,
    Expression<String>? image,
    Expression<int>? diaryFarmerId,
    Expression<int>? toolId,
    Expression<double>? quantity,
    Expression<int>? unitId,
    Expression<String>? unitName,
    Expression<String>? mediaContent,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (toolName != null) 'tool_name': toolName,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (isOrganic != null) 'is_organic': isOrganic,
      if (notation != null) 'notation': notation,
      if (isActive != null) 'is_active': isActive,
      if (image != null) 'image': image,
      if (diaryFarmerId != null) 'diary_farmer_id': diaryFarmerId,
      if (toolId != null) 'tool_id': toolId,
      if (quantity != null) 'quantity': quantity,
      if (unitId != null) 'unit_id': unitId,
      if (unitName != null) 'unit_name': unitName,
      if (mediaContent != null) 'media_content': mediaContent,
    });
  }

  ToolTableCompanion copyWith(
      {Value<int?>? id,
      Value<int?>? categoryId,
      Value<String?>? toolName,
      Value<String?>? name,
      Value<String?>? description,
      Value<bool?>? isOrganic,
      Value<bool?>? notation,
      Value<bool?>? isActive,
      Value<String?>? image,
      Value<int?>? diaryFarmerId,
      Value<int?>? toolId,
      Value<double?>? quantity,
      Value<int?>? unitId,
      Value<String?>? unitName,
      Value<String?>? mediaContent}) {
    return ToolTableCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      toolName: toolName ?? this.toolName,
      name: name ?? this.name,
      description: description ?? this.description,
      isOrganic: isOrganic ?? this.isOrganic,
      notation: notation ?? this.notation,
      isActive: isActive ?? this.isActive,
      image: image ?? this.image,
      diaryFarmerId: diaryFarmerId ?? this.diaryFarmerId,
      toolId: toolId ?? this.toolId,
      quantity: quantity ?? this.quantity,
      unitId: unitId ?? this.unitId,
      unitName: unitName ?? this.unitName,
      mediaContent: mediaContent ?? this.mediaContent,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (toolName.present) {
      map['tool_name'] = Variable<String>(toolName.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isOrganic.present) {
      map['is_organic'] = Variable<bool>(isOrganic.value);
    }
    if (notation.present) {
      map['notation'] = Variable<bool>(notation.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (diaryFarmerId.present) {
      map['diary_farmer_id'] = Variable<int>(diaryFarmerId.value);
    }
    if (toolId.present) {
      map['tool_id'] = Variable<int>(toolId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<int>(unitId.value);
    }
    if (unitName.present) {
      map['unit_name'] = Variable<String>(unitName.value);
    }
    if (mediaContent.present) {
      map['media_content'] = Variable<String>(mediaContent.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ToolTableCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('toolName: $toolName, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isOrganic: $isOrganic, ')
          ..write('notation: $notation, ')
          ..write('isActive: $isActive, ')
          ..write('image: $image, ')
          ..write('diaryFarmerId: $diaryFarmerId, ')
          ..write('toolId: $toolId, ')
          ..write('quantity: $quantity, ')
          ..write('unitId: $unitId, ')
          ..write('unitName: $unitName, ')
          ..write('mediaContent: $mediaContent')
          ..write(')'))
        .toString();
  }
}

class $MaterialTableTable extends MaterialTable
    with TableInfo<$MaterialTableTable, MaterialEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaterialTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _materialNameMeta =
      const VerificationMeta('materialName');
  @override
  late final GeneratedColumn<String> materialName = GeneratedColumn<String>(
      'material_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isOrganicMeta =
      const VerificationMeta('isOrganic');
  @override
  late final GeneratedColumn<bool> isOrganic =
      GeneratedColumn<bool>('is_organic', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_organic" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _notationMeta =
      const VerificationMeta('notation');
  @override
  late final GeneratedColumn<bool> notation =
      GeneratedColumn<bool>('notation', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("notation" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive =
      GeneratedColumn<bool>('is_active', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_active" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _diaryFarmerIdMeta =
      const VerificationMeta('diaryFarmerId');
  @override
  late final GeneratedColumn<int> diaryFarmerId = GeneratedColumn<int>(
      'diary_farmer_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _toolIdMeta = const VerificationMeta('toolId');
  @override
  late final GeneratedColumn<int> toolId = GeneratedColumn<int>(
      'tool_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _materialIdMeta =
      const VerificationMeta('materialId');
  @override
  late final GeneratedColumn<int> materialId = GeneratedColumn<int>(
      'material_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _unitNameMeta =
      const VerificationMeta('unitName');
  @override
  late final GeneratedColumn<String> unitName = GeneratedColumn<String>(
      'unit_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _mediaContentMeta =
      const VerificationMeta('mediaContent');
  @override
  late final GeneratedColumn<String> mediaContent = GeneratedColumn<String>(
      'media_content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        categoryId,
        materialName,
        name,
        description,
        isOrganic,
        notation,
        isActive,
        image,
        diaryFarmerId,
        toolId,
        quantity,
        materialId,
        unitName,
        mediaContent
      ];
  @override
  String get aliasedName => _alias ?? 'material';
  @override
  String get actualTableName => 'material';
  @override
  VerificationContext validateIntegrity(Insertable<MaterialEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('material_name')) {
      context.handle(
          _materialNameMeta,
          materialName.isAcceptableOrUnknown(
              data['material_name']!, _materialNameMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('is_organic')) {
      context.handle(_isOrganicMeta,
          isOrganic.isAcceptableOrUnknown(data['is_organic']!, _isOrganicMeta));
    }
    if (data.containsKey('notation')) {
      context.handle(_notationMeta,
          notation.isAcceptableOrUnknown(data['notation']!, _notationMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    if (data.containsKey('diary_farmer_id')) {
      context.handle(
          _diaryFarmerIdMeta,
          diaryFarmerId.isAcceptableOrUnknown(
              data['diary_farmer_id']!, _diaryFarmerIdMeta));
    }
    if (data.containsKey('tool_id')) {
      context.handle(_toolIdMeta,
          toolId.isAcceptableOrUnknown(data['tool_id']!, _toolIdMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('material_id')) {
      context.handle(
          _materialIdMeta,
          materialId.isAcceptableOrUnknown(
              data['material_id']!, _materialIdMeta));
    }
    if (data.containsKey('unit_name')) {
      context.handle(_unitNameMeta,
          unitName.isAcceptableOrUnknown(data['unit_name']!, _unitNameMeta));
    }
    if (data.containsKey('media_content')) {
      context.handle(
          _mediaContentMeta,
          mediaContent.isAcceptableOrUnknown(
              data['media_content']!, _mediaContentMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MaterialEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaterialEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      materialName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}material_name']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id']),
      isOrganic: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_organic']),
      notation: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}notation']),
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active']),
      diaryFarmerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}diary_farmer_id']),
      materialId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}material_id']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity']),
      unitName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit_name']),
      mediaContent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}media_content']),
    );
  }

  @override
  $MaterialTableTable createAlias(String alias) {
    return $MaterialTableTable(attachedDatabase, alias);
  }
}

class MaterialTableCompanion extends UpdateCompanion<MaterialEntity> {
  final Value<int?> id;
  final Value<int?> categoryId;
  final Value<String?> materialName;
  final Value<String?> name;
  final Value<String?> description;
  final Value<bool?> isOrganic;
  final Value<bool?> notation;
  final Value<bool?> isActive;
  final Value<String?> image;
  final Value<int?> diaryFarmerId;
  final Value<int?> toolId;
  final Value<double?> quantity;
  final Value<int?> materialId;
  final Value<String?> unitName;
  final Value<String?> mediaContent;
  const MaterialTableCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.materialName = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isOrganic = const Value.absent(),
    this.notation = const Value.absent(),
    this.isActive = const Value.absent(),
    this.image = const Value.absent(),
    this.diaryFarmerId = const Value.absent(),
    this.toolId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.materialId = const Value.absent(),
    this.unitName = const Value.absent(),
    this.mediaContent = const Value.absent(),
  });
  MaterialTableCompanion.insert({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.materialName = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isOrganic = const Value.absent(),
    this.notation = const Value.absent(),
    this.isActive = const Value.absent(),
    this.image = const Value.absent(),
    this.diaryFarmerId = const Value.absent(),
    this.toolId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.materialId = const Value.absent(),
    this.unitName = const Value.absent(),
    this.mediaContent = const Value.absent(),
  });
  static Insertable<MaterialEntity> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<String>? materialName,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isOrganic,
    Expression<bool>? notation,
    Expression<bool>? isActive,
    Expression<String>? image,
    Expression<int>? diaryFarmerId,
    Expression<int>? toolId,
    Expression<double>? quantity,
    Expression<int>? materialId,
    Expression<String>? unitName,
    Expression<String>? mediaContent,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (materialName != null) 'material_name': materialName,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (isOrganic != null) 'is_organic': isOrganic,
      if (notation != null) 'notation': notation,
      if (isActive != null) 'is_active': isActive,
      if (image != null) 'image': image,
      if (diaryFarmerId != null) 'diary_farmer_id': diaryFarmerId,
      if (toolId != null) 'tool_id': toolId,
      if (quantity != null) 'quantity': quantity,
      if (materialId != null) 'material_id': materialId,
      if (unitName != null) 'unit_name': unitName,
      if (mediaContent != null) 'media_content': mediaContent,
    });
  }

  MaterialTableCompanion copyWith(
      {Value<int?>? id,
      Value<int?>? categoryId,
      Value<String?>? materialName,
      Value<String?>? name,
      Value<String?>? description,
      Value<bool?>? isOrganic,
      Value<bool?>? notation,
      Value<bool?>? isActive,
      Value<String?>? image,
      Value<int?>? diaryFarmerId,
      Value<int?>? toolId,
      Value<double?>? quantity,
      Value<int?>? materialId,
      Value<String?>? unitName,
      Value<String?>? mediaContent}) {
    return MaterialTableCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      materialName: materialName ?? this.materialName,
      name: name ?? this.name,
      description: description ?? this.description,
      isOrganic: isOrganic ?? this.isOrganic,
      notation: notation ?? this.notation,
      isActive: isActive ?? this.isActive,
      image: image ?? this.image,
      diaryFarmerId: diaryFarmerId ?? this.diaryFarmerId,
      toolId: toolId ?? this.toolId,
      quantity: quantity ?? this.quantity,
      materialId: materialId ?? this.materialId,
      unitName: unitName ?? this.unitName,
      mediaContent: mediaContent ?? this.mediaContent,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (materialName.present) {
      map['material_name'] = Variable<String>(materialName.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isOrganic.present) {
      map['is_organic'] = Variable<bool>(isOrganic.value);
    }
    if (notation.present) {
      map['notation'] = Variable<bool>(notation.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (diaryFarmerId.present) {
      map['diary_farmer_id'] = Variable<int>(diaryFarmerId.value);
    }
    if (toolId.present) {
      map['tool_id'] = Variable<int>(toolId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (materialId.present) {
      map['material_id'] = Variable<int>(materialId.value);
    }
    if (unitName.present) {
      map['unit_name'] = Variable<String>(unitName.value);
    }
    if (mediaContent.present) {
      map['media_content'] = Variable<String>(mediaContent.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaterialTableCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('materialName: $materialName, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isOrganic: $isOrganic, ')
          ..write('notation: $notation, ')
          ..write('isActive: $isActive, ')
          ..write('image: $image, ')
          ..write('diaryFarmerId: $diaryFarmerId, ')
          ..write('toolId: $toolId, ')
          ..write('quantity: $quantity, ')
          ..write('materialId: $materialId, ')
          ..write('unitName: $unitName, ')
          ..write('mediaContent: $mediaContent')
          ..write(')'))
        .toString();
  }
}

class $UnitTableTable extends UnitTable with TableInfo<$UnitTableTable, Unit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UnitTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isOrganicMeta =
      const VerificationMeta('isOrganic');
  @override
  late final GeneratedColumn<bool> isOrganic =
      GeneratedColumn<bool>('is_organic', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_organic" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _notationMeta =
      const VerificationMeta('notation');
  @override
  late final GeneratedColumn<bool> notation =
      GeneratedColumn<bool>('notation', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("notation" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive =
      GeneratedColumn<bool>('is_active', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_active" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _diaryFarmerIdMeta =
      const VerificationMeta('diaryFarmerId');
  @override
  late final GeneratedColumn<int> diaryFarmerId = GeneratedColumn<int>(
      'diary_farmer_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _toolIdMeta = const VerificationMeta('toolId');
  @override
  late final GeneratedColumn<int> toolId = GeneratedColumn<int>(
      'tool_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<int> unitId = GeneratedColumn<int>(
      'unit_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _mediaContentMeta =
      const VerificationMeta('mediaContent');
  @override
  late final GeneratedColumn<String> mediaContent = GeneratedColumn<String>(
      'media_content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        categoryId,
        name,
        description,
        isOrganic,
        notation,
        isActive,
        image,
        diaryFarmerId,
        toolId,
        quantity,
        unitId,
        mediaContent
      ];
  @override
  String get aliasedName => _alias ?? 'unit';
  @override
  String get actualTableName => 'unit';
  @override
  VerificationContext validateIntegrity(Insertable<Unit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('is_organic')) {
      context.handle(_isOrganicMeta,
          isOrganic.isAcceptableOrUnknown(data['is_organic']!, _isOrganicMeta));
    }
    if (data.containsKey('notation')) {
      context.handle(_notationMeta,
          notation.isAcceptableOrUnknown(data['notation']!, _notationMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    if (data.containsKey('diary_farmer_id')) {
      context.handle(
          _diaryFarmerIdMeta,
          diaryFarmerId.isAcceptableOrUnknown(
              data['diary_farmer_id']!, _diaryFarmerIdMeta));
    }
    if (data.containsKey('tool_id')) {
      context.handle(_toolIdMeta,
          toolId.isAcceptableOrUnknown(data['tool_id']!, _toolIdMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('unit_id')) {
      context.handle(_unitIdMeta,
          unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta));
    }
    if (data.containsKey('media_content')) {
      context.handle(
          _mediaContentMeta,
          mediaContent.isAcceptableOrUnknown(
              data['media_content']!, _mediaContentMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Unit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Unit(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id']),
      isOrganic: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_organic']),
      notation: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}notation']),
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active']),
      diaryFarmerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}diary_farmer_id']),
      toolId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tool_id']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity']),
      unitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unit_id']),
      mediaContent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}media_content']),
    );
  }

  @override
  $UnitTableTable createAlias(String alias) {
    return $UnitTableTable(attachedDatabase, alias);
  }
}

class UnitTableCompanion extends UpdateCompanion<Unit> {
  final Value<int?> id;
  final Value<int?> categoryId;
  final Value<String?> name;
  final Value<String?> description;
  final Value<bool?> isOrganic;
  final Value<bool?> notation;
  final Value<bool?> isActive;
  final Value<String?> image;
  final Value<int?> diaryFarmerId;
  final Value<int?> toolId;
  final Value<double?> quantity;
  final Value<int?> unitId;
  final Value<String?> mediaContent;
  const UnitTableCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isOrganic = const Value.absent(),
    this.notation = const Value.absent(),
    this.isActive = const Value.absent(),
    this.image = const Value.absent(),
    this.diaryFarmerId = const Value.absent(),
    this.toolId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitId = const Value.absent(),
    this.mediaContent = const Value.absent(),
  });
  UnitTableCompanion.insert({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isOrganic = const Value.absent(),
    this.notation = const Value.absent(),
    this.isActive = const Value.absent(),
    this.image = const Value.absent(),
    this.diaryFarmerId = const Value.absent(),
    this.toolId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitId = const Value.absent(),
    this.mediaContent = const Value.absent(),
  });
  static Insertable<Unit> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isOrganic,
    Expression<bool>? notation,
    Expression<bool>? isActive,
    Expression<String>? image,
    Expression<int>? diaryFarmerId,
    Expression<int>? toolId,
    Expression<double>? quantity,
    Expression<int>? unitId,
    Expression<String>? mediaContent,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (isOrganic != null) 'is_organic': isOrganic,
      if (notation != null) 'notation': notation,
      if (isActive != null) 'is_active': isActive,
      if (image != null) 'image': image,
      if (diaryFarmerId != null) 'diary_farmer_id': diaryFarmerId,
      if (toolId != null) 'tool_id': toolId,
      if (quantity != null) 'quantity': quantity,
      if (unitId != null) 'unit_id': unitId,
      if (mediaContent != null) 'media_content': mediaContent,
    });
  }

  UnitTableCompanion copyWith(
      {Value<int?>? id,
      Value<int?>? categoryId,
      Value<String?>? name,
      Value<String?>? description,
      Value<bool?>? isOrganic,
      Value<bool?>? notation,
      Value<bool?>? isActive,
      Value<String?>? image,
      Value<int?>? diaryFarmerId,
      Value<int?>? toolId,
      Value<double?>? quantity,
      Value<int?>? unitId,
      Value<String?>? mediaContent}) {
    return UnitTableCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      isOrganic: isOrganic ?? this.isOrganic,
      notation: notation ?? this.notation,
      isActive: isActive ?? this.isActive,
      image: image ?? this.image,
      diaryFarmerId: diaryFarmerId ?? this.diaryFarmerId,
      toolId: toolId ?? this.toolId,
      quantity: quantity ?? this.quantity,
      unitId: unitId ?? this.unitId,
      mediaContent: mediaContent ?? this.mediaContent,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isOrganic.present) {
      map['is_organic'] = Variable<bool>(isOrganic.value);
    }
    if (notation.present) {
      map['notation'] = Variable<bool>(notation.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (diaryFarmerId.present) {
      map['diary_farmer_id'] = Variable<int>(diaryFarmerId.value);
    }
    if (toolId.present) {
      map['tool_id'] = Variable<int>(toolId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<int>(unitId.value);
    }
    if (mediaContent.present) {
      map['media_content'] = Variable<String>(mediaContent.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UnitTableCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isOrganic: $isOrganic, ')
          ..write('notation: $notation, ')
          ..write('isActive: $isActive, ')
          ..write('image: $image, ')
          ..write('diaryFarmerId: $diaryFarmerId, ')
          ..write('toolId: $toolId, ')
          ..write('quantity: $quantity, ')
          ..write('unitId: $unitId, ')
          ..write('mediaContent: $mediaContent')
          ..write(')'))
        .toString();
  }
}

class $ActivityDiaryTableTable extends ActivityDiaryTable
    with TableInfo<$ActivityDiaryTableTable, ActivityDiary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityDiaryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _seasonFarmIdMeta =
      const VerificationMeta('seasonFarmId');
  @override
  late final GeneratedColumn<int> seasonFarmId = GeneratedColumn<int>(
      'season_farm_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _seasonFarmMeta =
      const VerificationMeta('seasonFarm');
  @override
  late final GeneratedColumn<String> seasonFarm = GeneratedColumn<String>(
      'season_farm', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _activityIdMeta =
      const VerificationMeta('activityId');
  @override
  late final GeneratedColumn<int> activityId = GeneratedColumn<int>(
      'activity_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _activityNameMeta =
      const VerificationMeta('activityName');
  @override
  late final GeneratedColumn<String> activityName = GeneratedColumn<String>(
      'activity_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _actionTimeMeta =
      const VerificationMeta('actionTime');
  @override
  late final GeneratedColumn<String> actionTime = GeneratedColumn<String>(
      'action_time', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _actionAreaMeta =
      const VerificationMeta('actionArea');
  @override
  late final GeneratedColumn<double> actionArea = GeneratedColumn<double>(
      'action_area', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _actionAreaUnitIdMeta =
      const VerificationMeta('actionAreaUnitId');
  @override
  late final GeneratedColumn<int> actionAreaUnitId = GeneratedColumn<int>(
      'action_area_unit_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _actionAreaUnitNameMeta =
      const VerificationMeta('actionAreaUnitName');
  @override
  late final GeneratedColumn<String> actionAreaUnitName =
      GeneratedColumn<String>('action_area_unit_name', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isShowMeta = const VerificationMeta('isShow');
  @override
  late final GeneratedColumn<bool> isShow =
      GeneratedColumn<bool>('is_show', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_show" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _byNameMeta = const VerificationMeta('byName');
  @override
  late final GeneratedColumn<String> byName = GeneratedColumn<String>(
      'by_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<String> startTime = GeneratedColumn<String>(
      'start_time', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<String> endTime = GeneratedColumn<String>(
      'end_time', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        seasonFarmId,
        seasonFarm,
        activityId,
        activityName,
        actionTime,
        actionArea,
        actionAreaUnitId,
        actionAreaUnitName,
        description,
        isShow,
        name,
        byName,
        startTime,
        endTime,
        status
      ];
  @override
  String get aliasedName => _alias ?? 'activity_diary';
  @override
  String get actualTableName => 'activity_diary';
  @override
  VerificationContext validateIntegrity(Insertable<ActivityDiary> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('season_farm_id')) {
      context.handle(
          _seasonFarmIdMeta,
          seasonFarmId.isAcceptableOrUnknown(
              data['season_farm_id']!, _seasonFarmIdMeta));
    }
    if (data.containsKey('season_farm')) {
      context.handle(
          _seasonFarmMeta,
          seasonFarm.isAcceptableOrUnknown(
              data['season_farm']!, _seasonFarmMeta));
    }
    if (data.containsKey('activity_id')) {
      context.handle(
          _activityIdMeta,
          activityId.isAcceptableOrUnknown(
              data['activity_id']!, _activityIdMeta));
    }
    if (data.containsKey('activity_name')) {
      context.handle(
          _activityNameMeta,
          activityName.isAcceptableOrUnknown(
              data['activity_name']!, _activityNameMeta));
    }
    if (data.containsKey('action_time')) {
      context.handle(
          _actionTimeMeta,
          actionTime.isAcceptableOrUnknown(
              data['action_time']!, _actionTimeMeta));
    }
    if (data.containsKey('action_area')) {
      context.handle(
          _actionAreaMeta,
          actionArea.isAcceptableOrUnknown(
              data['action_area']!, _actionAreaMeta));
    }
    if (data.containsKey('action_area_unit_id')) {
      context.handle(
          _actionAreaUnitIdMeta,
          actionAreaUnitId.isAcceptableOrUnknown(
              data['action_area_unit_id']!, _actionAreaUnitIdMeta));
    }
    if (data.containsKey('action_area_unit_name')) {
      context.handle(
          _actionAreaUnitNameMeta,
          actionAreaUnitName.isAcceptableOrUnknown(
              data['action_area_unit_name']!, _actionAreaUnitNameMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('is_show')) {
      context.handle(_isShowMeta,
          isShow.isAcceptableOrUnknown(data['is_show']!, _isShowMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('by_name')) {
      context.handle(_byNameMeta,
          byName.isAcceptableOrUnknown(data['by_name']!, _byNameMeta));
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivityDiary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityDiary(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      seasonFarmId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}season_farm_id']),
      activityId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}activity_id']),
      actionTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action_time']),
      actionArea: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}action_area']),
      actionAreaUnitId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}action_area_unit_id']),
      actionAreaUnitName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}action_area_unit_name']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      activityName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}activity_name']),
      seasonFarm: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}season_farm']),
      isShow: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_show']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      byName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}by_name']),
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_time']),
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_time']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status']),
    );
  }

  @override
  $ActivityDiaryTableTable createAlias(String alias) {
    return $ActivityDiaryTableTable(attachedDatabase, alias);
  }
}

class ActivityDiaryTableCompanion extends UpdateCompanion<ActivityDiary> {
  final Value<int?> id;
  final Value<int?> seasonFarmId;
  final Value<String?> seasonFarm;
  final Value<int?> activityId;
  final Value<String?> activityName;
  final Value<String?> actionTime;
  final Value<double?> actionArea;
  final Value<int?> actionAreaUnitId;
  final Value<String?> actionAreaUnitName;
  final Value<String?> description;
  final Value<bool?> isShow;
  final Value<String?> name;
  final Value<String?> byName;
  final Value<String?> startTime;
  final Value<String?> endTime;
  final Value<int?> status;
  const ActivityDiaryTableCompanion({
    this.id = const Value.absent(),
    this.seasonFarmId = const Value.absent(),
    this.seasonFarm = const Value.absent(),
    this.activityId = const Value.absent(),
    this.activityName = const Value.absent(),
    this.actionTime = const Value.absent(),
    this.actionArea = const Value.absent(),
    this.actionAreaUnitId = const Value.absent(),
    this.actionAreaUnitName = const Value.absent(),
    this.description = const Value.absent(),
    this.isShow = const Value.absent(),
    this.name = const Value.absent(),
    this.byName = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.status = const Value.absent(),
  });
  ActivityDiaryTableCompanion.insert({
    this.id = const Value.absent(),
    this.seasonFarmId = const Value.absent(),
    this.seasonFarm = const Value.absent(),
    this.activityId = const Value.absent(),
    this.activityName = const Value.absent(),
    this.actionTime = const Value.absent(),
    this.actionArea = const Value.absent(),
    this.actionAreaUnitId = const Value.absent(),
    this.actionAreaUnitName = const Value.absent(),
    this.description = const Value.absent(),
    this.isShow = const Value.absent(),
    this.name = const Value.absent(),
    this.byName = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.status = const Value.absent(),
  });
  static Insertable<ActivityDiary> custom({
    Expression<int>? id,
    Expression<int>? seasonFarmId,
    Expression<String>? seasonFarm,
    Expression<int>? activityId,
    Expression<String>? activityName,
    Expression<String>? actionTime,
    Expression<double>? actionArea,
    Expression<int>? actionAreaUnitId,
    Expression<String>? actionAreaUnitName,
    Expression<String>? description,
    Expression<bool>? isShow,
    Expression<String>? name,
    Expression<String>? byName,
    Expression<String>? startTime,
    Expression<String>? endTime,
    Expression<int>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (seasonFarmId != null) 'season_farm_id': seasonFarmId,
      if (seasonFarm != null) 'season_farm': seasonFarm,
      if (activityId != null) 'activity_id': activityId,
      if (activityName != null) 'activity_name': activityName,
      if (actionTime != null) 'action_time': actionTime,
      if (actionArea != null) 'action_area': actionArea,
      if (actionAreaUnitId != null) 'action_area_unit_id': actionAreaUnitId,
      if (actionAreaUnitName != null)
        'action_area_unit_name': actionAreaUnitName,
      if (description != null) 'description': description,
      if (isShow != null) 'is_show': isShow,
      if (name != null) 'name': name,
      if (byName != null) 'by_name': byName,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (status != null) 'status': status,
    });
  }

  ActivityDiaryTableCompanion copyWith(
      {Value<int?>? id,
      Value<int?>? seasonFarmId,
      Value<String?>? seasonFarm,
      Value<int?>? activityId,
      Value<String?>? activityName,
      Value<String?>? actionTime,
      Value<double?>? actionArea,
      Value<int?>? actionAreaUnitId,
      Value<String?>? actionAreaUnitName,
      Value<String?>? description,
      Value<bool?>? isShow,
      Value<String?>? name,
      Value<String?>? byName,
      Value<String?>? startTime,
      Value<String?>? endTime,
      Value<int?>? status}) {
    return ActivityDiaryTableCompanion(
      id: id ?? this.id,
      seasonFarmId: seasonFarmId ?? this.seasonFarmId,
      seasonFarm: seasonFarm ?? this.seasonFarm,
      activityId: activityId ?? this.activityId,
      activityName: activityName ?? this.activityName,
      actionTime: actionTime ?? this.actionTime,
      actionArea: actionArea ?? this.actionArea,
      actionAreaUnitId: actionAreaUnitId ?? this.actionAreaUnitId,
      actionAreaUnitName: actionAreaUnitName ?? this.actionAreaUnitName,
      description: description ?? this.description,
      isShow: isShow ?? this.isShow,
      name: name ?? this.name,
      byName: byName ?? this.byName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (seasonFarmId.present) {
      map['season_farm_id'] = Variable<int>(seasonFarmId.value);
    }
    if (seasonFarm.present) {
      map['season_farm'] = Variable<String>(seasonFarm.value);
    }
    if (activityId.present) {
      map['activity_id'] = Variable<int>(activityId.value);
    }
    if (activityName.present) {
      map['activity_name'] = Variable<String>(activityName.value);
    }
    if (actionTime.present) {
      map['action_time'] = Variable<String>(actionTime.value);
    }
    if (actionArea.present) {
      map['action_area'] = Variable<double>(actionArea.value);
    }
    if (actionAreaUnitId.present) {
      map['action_area_unit_id'] = Variable<int>(actionAreaUnitId.value);
    }
    if (actionAreaUnitName.present) {
      map['action_area_unit_name'] = Variable<String>(actionAreaUnitName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isShow.present) {
      map['is_show'] = Variable<bool>(isShow.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (byName.present) {
      map['by_name'] = Variable<String>(byName.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<String>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<String>(endTime.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityDiaryTableCompanion(')
          ..write('id: $id, ')
          ..write('seasonFarmId: $seasonFarmId, ')
          ..write('seasonFarm: $seasonFarm, ')
          ..write('activityId: $activityId, ')
          ..write('activityName: $activityName, ')
          ..write('actionTime: $actionTime, ')
          ..write('actionArea: $actionArea, ')
          ..write('actionAreaUnitId: $actionAreaUnitId, ')
          ..write('actionAreaUnitName: $actionAreaUnitName, ')
          ..write('description: $description, ')
          ..write('isShow: $isShow, ')
          ..write('name: $name, ')
          ..write('byName: $byName, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $UserInfoTableTable extends UserInfoTable
    with TableInfo<$UserInfoTableTable, UserInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserInfoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _loginMeta = const VerificationMeta('login');
  @override
  late final GeneratedColumn<String> login = GeneratedColumn<String>(
      'login', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateOfBirthMeta =
      const VerificationMeta('dateOfBirth');
  @override
  late final GeneratedColumn<String> dateOfBirth = GeneratedColumn<String>(
      'date_of_birth', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active =
      GeneratedColumn<bool>('active', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("active" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _groupMeta = const VerificationMeta('group');
  @override
  late final GeneratedColumn<String> group = GeneratedColumn<String>(
      'group', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
      'language', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _mediaContentMeta =
      const VerificationMeta('mediaContent');
  @override
  late final GeneratedColumn<String> mediaContent = GeneratedColumn<String>(
      'media_content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        login,
        gender,
        dateOfBirth,
        address,
        active,
        group,
        language,
        mediaContent
      ];
  @override
  String get aliasedName => _alias ?? 'user_info';
  @override
  String get actualTableName => 'user_info';
  @override
  VerificationContext validateIntegrity(Insertable<UserInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('login')) {
      context.handle(
          _loginMeta, login.isAcceptableOrUnknown(data['login']!, _loginMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
          _dateOfBirthMeta,
          dateOfBirth.isAcceptableOrUnknown(
              data['date_of_birth']!, _dateOfBirthMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    if (data.containsKey('group')) {
      context.handle(
          _groupMeta, group.isAcceptableOrUnknown(data['group']!, _groupMeta));
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    }
    if (data.containsKey('media_content')) {
      context.handle(
          _mediaContentMeta,
          mediaContent.isAcceptableOrUnknown(
              data['media_content']!, _mediaContentMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserInfo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      login: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}login']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      dateOfBirth: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date_of_birth']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active']),
      group: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group']),
      language: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language']),
      mediaContent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}media_content']),
    );
  }

  @override
  $UserInfoTableTable createAlias(String alias) {
    return $UserInfoTableTable(attachedDatabase, alias);
  }
}

class UserInfoTableCompanion extends UpdateCompanion<UserInfo> {
  final Value<int?> id;
  final Value<String?> name;
  final Value<String?> login;
  final Value<String?> gender;
  final Value<String?> dateOfBirth;
  final Value<String?> address;
  final Value<bool?> active;
  final Value<String?> group;
  final Value<String?> language;
  final Value<String?> mediaContent;
  const UserInfoTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.login = const Value.absent(),
    this.gender = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.address = const Value.absent(),
    this.active = const Value.absent(),
    this.group = const Value.absent(),
    this.language = const Value.absent(),
    this.mediaContent = const Value.absent(),
  });
  UserInfoTableCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.login = const Value.absent(),
    this.gender = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.address = const Value.absent(),
    this.active = const Value.absent(),
    this.group = const Value.absent(),
    this.language = const Value.absent(),
    this.mediaContent = const Value.absent(),
  });
  static Insertable<UserInfo> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? login,
    Expression<String>? gender,
    Expression<String>? dateOfBirth,
    Expression<String>? address,
    Expression<bool>? active,
    Expression<String>? group,
    Expression<String>? language,
    Expression<String>? mediaContent,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (login != null) 'login': login,
      if (gender != null) 'gender': gender,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (address != null) 'address': address,
      if (active != null) 'active': active,
      if (group != null) 'group': group,
      if (language != null) 'language': language,
      if (mediaContent != null) 'media_content': mediaContent,
    });
  }

  UserInfoTableCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? name,
      Value<String?>? login,
      Value<String?>? gender,
      Value<String?>? dateOfBirth,
      Value<String?>? address,
      Value<bool?>? active,
      Value<String?>? group,
      Value<String?>? language,
      Value<String?>? mediaContent}) {
    return UserInfoTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      login: login ?? this.login,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
      active: active ?? this.active,
      group: group ?? this.group,
      language: language ?? this.language,
      mediaContent: mediaContent ?? this.mediaContent,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (login.present) {
      map['login'] = Variable<String>(login.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<String>(dateOfBirth.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (group.present) {
      map['group'] = Variable<String>(group.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (mediaContent.present) {
      map['media_content'] = Variable<String>(mediaContent.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserInfoTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('login: $login, ')
          ..write('gender: $gender, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('address: $address, ')
          ..write('active: $active, ')
          ..write('group: $group, ')
          ..write('language: $language, ')
          ..write('mediaContent: $mediaContent')
          ..write(')'))
        .toString();
  }
}

class $ActivityMonitorTableTable extends ActivityMonitorTable
    with TableInfo<$ActivityMonitorTableTable, ActivityMonitor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityMonitorTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _diaryMonitorIdMeta =
      const VerificationMeta('diaryMonitorId');
  @override
  late final GeneratedColumn<int> diaryMonitorId = GeneratedColumn<int>(
      'diary_monitor_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _activityIdMeta =
      const VerificationMeta('activityId');
  @override
  late final GeneratedColumn<int> activityId = GeneratedColumn<int>(
      'activity_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _activityMeta =
      const VerificationMeta('activity');
  @override
  late final GeneratedColumn<String> activity = GeneratedColumn<String>(
      'activity', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _checkYesMeta =
      const VerificationMeta('checkYes');
  @override
  late final GeneratedColumn<bool> checkYes =
      GeneratedColumn<bool>('check_yes', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("check_yes" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _checkNoMeta =
      const VerificationMeta('checkNo');
  @override
  late final GeneratedColumn<bool> checkNo =
      GeneratedColumn<bool>('check_no', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("check_no" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  @override
  List<GeneratedColumn> get $columns =>
      [id, diaryMonitorId, activityId, activity, checkYes, checkNo];
  @override
  String get aliasedName => _alias ?? 'activity';
  @override
  String get actualTableName => 'activity';
  @override
  VerificationContext validateIntegrity(Insertable<ActivityMonitor> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('diary_monitor_id')) {
      context.handle(
          _diaryMonitorIdMeta,
          diaryMonitorId.isAcceptableOrUnknown(
              data['diary_monitor_id']!, _diaryMonitorIdMeta));
    }
    if (data.containsKey('activity_id')) {
      context.handle(
          _activityIdMeta,
          activityId.isAcceptableOrUnknown(
              data['activity_id']!, _activityIdMeta));
    }
    if (data.containsKey('activity')) {
      context.handle(_activityMeta,
          activity.isAcceptableOrUnknown(data['activity']!, _activityMeta));
    }
    if (data.containsKey('check_yes')) {
      context.handle(_checkYesMeta,
          checkYes.isAcceptableOrUnknown(data['check_yes']!, _checkYesMeta));
    }
    if (data.containsKey('check_no')) {
      context.handle(_checkNoMeta,
          checkNo.isAcceptableOrUnknown(data['check_no']!, _checkNoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivityMonitor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityMonitor(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      diaryMonitorId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}diary_monitor_id']),
      activityId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}activity_id']),
      activity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}activity']),
      checkYes: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}check_yes']),
      checkNo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}check_no']),
    );
  }

  @override
  $ActivityMonitorTableTable createAlias(String alias) {
    return $ActivityMonitorTableTable(attachedDatabase, alias);
  }
}

class ActivityMonitorTableCompanion extends UpdateCompanion<ActivityMonitor> {
  final Value<int?> id;
  final Value<int?> diaryMonitorId;
  final Value<int?> activityId;
  final Value<String?> activity;
  final Value<bool?> checkYes;
  final Value<bool?> checkNo;
  const ActivityMonitorTableCompanion({
    this.id = const Value.absent(),
    this.diaryMonitorId = const Value.absent(),
    this.activityId = const Value.absent(),
    this.activity = const Value.absent(),
    this.checkYes = const Value.absent(),
    this.checkNo = const Value.absent(),
  });
  ActivityMonitorTableCompanion.insert({
    this.id = const Value.absent(),
    this.diaryMonitorId = const Value.absent(),
    this.activityId = const Value.absent(),
    this.activity = const Value.absent(),
    this.checkYes = const Value.absent(),
    this.checkNo = const Value.absent(),
  });
  static Insertable<ActivityMonitor> custom({
    Expression<int>? id,
    Expression<int>? diaryMonitorId,
    Expression<int>? activityId,
    Expression<String>? activity,
    Expression<bool>? checkYes,
    Expression<bool>? checkNo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (diaryMonitorId != null) 'diary_monitor_id': diaryMonitorId,
      if (activityId != null) 'activity_id': activityId,
      if (activity != null) 'activity': activity,
      if (checkYes != null) 'check_yes': checkYes,
      if (checkNo != null) 'check_no': checkNo,
    });
  }

  ActivityMonitorTableCompanion copyWith(
      {Value<int?>? id,
      Value<int?>? diaryMonitorId,
      Value<int?>? activityId,
      Value<String?>? activity,
      Value<bool?>? checkYes,
      Value<bool?>? checkNo}) {
    return ActivityMonitorTableCompanion(
      id: id ?? this.id,
      diaryMonitorId: diaryMonitorId ?? this.diaryMonitorId,
      activityId: activityId ?? this.activityId,
      activity: activity ?? this.activity,
      checkYes: checkYes ?? this.checkYes,
      checkNo: checkNo ?? this.checkNo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (diaryMonitorId.present) {
      map['diary_monitor_id'] = Variable<int>(diaryMonitorId.value);
    }
    if (activityId.present) {
      map['activity_id'] = Variable<int>(activityId.value);
    }
    if (activity.present) {
      map['activity'] = Variable<String>(activity.value);
    }
    if (checkYes.present) {
      map['check_yes'] = Variable<bool>(checkYes.value);
    }
    if (checkNo.present) {
      map['check_no'] = Variable<bool>(checkNo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityMonitorTableCompanion(')
          ..write('id: $id, ')
          ..write('diaryMonitorId: $diaryMonitorId, ')
          ..write('activityId: $activityId, ')
          ..write('activity: $activity, ')
          ..write('checkYes: $checkYes, ')
          ..write('checkNo: $checkNo')
          ..write(')'))
        .toString();
  }
}

class $MonitorDiaryTableTable extends MonitorDiaryTable
    with TableInfo<$MonitorDiaryTableTable, MonitorDiary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonitorDiaryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _seasonFarmIdMeta =
      const VerificationMeta('seasonFarmId');
  @override
  late final GeneratedColumn<int> seasonFarmId = GeneratedColumn<int>(
      'season_farm_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _seasonFarmMeta =
      const VerificationMeta('seasonFarm');
  @override
  late final GeneratedColumn<String> seasonFarm = GeneratedColumn<String>(
      'season_farm', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _actionTimeMeta =
      const VerificationMeta('actionTime');
  @override
  late final GeneratedColumn<String> actionTime = GeneratedColumn<String>(
      'action_time', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<String> latitude = GeneratedColumn<String>(
      'latitude', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<String> longitude = GeneratedColumn<String>(
      'longitude', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _monitorIdMeta =
      const VerificationMeta('monitorId');
  @override
  late final GeneratedColumn<int> monitorId = GeneratedColumn<int>(
      'monitor_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _monitorMeta =
      const VerificationMeta('monitor');
  @override
  late final GeneratedColumn<String> monitor = GeneratedColumn<String>(
      'monitor', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        seasonFarmId,
        seasonFarm,
        actionTime,
        latitude,
        longitude,
        monitorId,
        monitor,
        description
      ];
  @override
  String get aliasedName => _alias ?? 'monitor_diary';
  @override
  String get actualTableName => 'monitor_diary';
  @override
  VerificationContext validateIntegrity(Insertable<MonitorDiary> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('season_farm_id')) {
      context.handle(
          _seasonFarmIdMeta,
          seasonFarmId.isAcceptableOrUnknown(
              data['season_farm_id']!, _seasonFarmIdMeta));
    }
    if (data.containsKey('season_farm')) {
      context.handle(
          _seasonFarmMeta,
          seasonFarm.isAcceptableOrUnknown(
              data['season_farm']!, _seasonFarmMeta));
    }
    if (data.containsKey('action_time')) {
      context.handle(
          _actionTimeMeta,
          actionTime.isAcceptableOrUnknown(
              data['action_time']!, _actionTimeMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    }
    if (data.containsKey('monitor_id')) {
      context.handle(_monitorIdMeta,
          monitorId.isAcceptableOrUnknown(data['monitor_id']!, _monitorIdMeta));
    }
    if (data.containsKey('monitor')) {
      context.handle(_monitorMeta,
          monitor.isAcceptableOrUnknown(data['monitor']!, _monitorMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MonitorDiary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonitorDiary(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      seasonFarmId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}season_farm_id']),
      seasonFarm: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}season_farm']),
      actionTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action_time']),
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}latitude']),
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}longitude']),
      monitorId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}monitor_id']),
      monitor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}monitor']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  $MonitorDiaryTableTable createAlias(String alias) {
    return $MonitorDiaryTableTable(attachedDatabase, alias);
  }
}

class MonitorDiaryTableCompanion extends UpdateCompanion<MonitorDiary> {
  final Value<int?> id;
  final Value<int?> seasonFarmId;
  final Value<String?> seasonFarm;
  final Value<String?> actionTime;
  final Value<String?> latitude;
  final Value<String?> longitude;
  final Value<int?> monitorId;
  final Value<String?> monitor;
  final Value<String?> description;
  const MonitorDiaryTableCompanion({
    this.id = const Value.absent(),
    this.seasonFarmId = const Value.absent(),
    this.seasonFarm = const Value.absent(),
    this.actionTime = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.monitorId = const Value.absent(),
    this.monitor = const Value.absent(),
    this.description = const Value.absent(),
  });
  MonitorDiaryTableCompanion.insert({
    this.id = const Value.absent(),
    this.seasonFarmId = const Value.absent(),
    this.seasonFarm = const Value.absent(),
    this.actionTime = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.monitorId = const Value.absent(),
    this.monitor = const Value.absent(),
    this.description = const Value.absent(),
  });
  static Insertable<MonitorDiary> custom({
    Expression<int>? id,
    Expression<int>? seasonFarmId,
    Expression<String>? seasonFarm,
    Expression<String>? actionTime,
    Expression<String>? latitude,
    Expression<String>? longitude,
    Expression<int>? monitorId,
    Expression<String>? monitor,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (seasonFarmId != null) 'season_farm_id': seasonFarmId,
      if (seasonFarm != null) 'season_farm': seasonFarm,
      if (actionTime != null) 'action_time': actionTime,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (monitorId != null) 'monitor_id': monitorId,
      if (monitor != null) 'monitor': monitor,
      if (description != null) 'description': description,
    });
  }

  MonitorDiaryTableCompanion copyWith(
      {Value<int?>? id,
      Value<int?>? seasonFarmId,
      Value<String?>? seasonFarm,
      Value<String?>? actionTime,
      Value<String?>? latitude,
      Value<String?>? longitude,
      Value<int?>? monitorId,
      Value<String?>? monitor,
      Value<String?>? description}) {
    return MonitorDiaryTableCompanion(
      id: id ?? this.id,
      seasonFarmId: seasonFarmId ?? this.seasonFarmId,
      seasonFarm: seasonFarm ?? this.seasonFarm,
      actionTime: actionTime ?? this.actionTime,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      monitorId: monitorId ?? this.monitorId,
      monitor: monitor ?? this.monitor,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (seasonFarmId.present) {
      map['season_farm_id'] = Variable<int>(seasonFarmId.value);
    }
    if (seasonFarm.present) {
      map['season_farm'] = Variable<String>(seasonFarm.value);
    }
    if (actionTime.present) {
      map['action_time'] = Variable<String>(actionTime.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<String>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<String>(longitude.value);
    }
    if (monitorId.present) {
      map['monitor_id'] = Variable<int>(monitorId.value);
    }
    if (monitor.present) {
      map['monitor'] = Variable<String>(monitor.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonitorDiaryTableCompanion(')
          ..write('id: $id, ')
          ..write('seasonFarmId: $seasonFarmId, ')
          ..write('seasonFarm: $seasonFarm, ')
          ..write('actionTime: $actionTime, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('monitorId: $monitorId, ')
          ..write('monitor: $monitor, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

abstract class _$DiaryDB extends GeneratedDatabase {
  _$DiaryDB(QueryExecutor e) : super(e);
  late final $DiaryTableTable diaryTable = $DiaryTableTable(this);
  late final $ActivityTableTable activityTable = $ActivityTableTable(this);
  late final $ToolTableTable toolTable = $ToolTableTable(this);
  late final $MaterialTableTable materialTable = $MaterialTableTable(this);
  late final $UnitTableTable unitTable = $UnitTableTable(this);
  late final $ActivityDiaryTableTable activityDiaryTable =
      $ActivityDiaryTableTable(this);
  late final $UserInfoTableTable userInfoTable = $UserInfoTableTable(this);
  late final $ActivityMonitorTableTable activityMonitorTable =
      $ActivityMonitorTableTable(this);
  late final $MonitorDiaryTableTable monitorDiaryTable =
      $MonitorDiaryTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        diaryTable,
        activityTable,
        toolTable,
        materialTable,
        unitTable,
        activityDiaryTable,
        userInfoTable,
        activityMonitorTable,
        monitorDiaryTable
      ];
}
