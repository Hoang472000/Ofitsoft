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
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
      'action', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _seasonIdMeta =
      const VerificationMeta('seasonId');
  @override
  late final GeneratedColumn<int> seasonId = GeneratedColumn<int>(
      'season_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _seasonNameMeta =
      const VerificationMeta('seasonName');
  @override
  late final GeneratedColumn<String> seasonName = GeneratedColumn<String>(
      'season_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _farmIdMeta = const VerificationMeta('farmId');
  @override
  late final GeneratedColumn<int> farmId = GeneratedColumn<int>(
      'farm_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _farmNameMeta =
      const VerificationMeta('farmName');
  @override
  late final GeneratedColumn<String> farmName = GeneratedColumn<String>(
      'farm_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  static const VerificationMeta _cropIdMeta = const VerificationMeta('cropId');
  @override
  late final GeneratedColumn<int> cropId = GeneratedColumn<int>(
      'crop_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
  static const VerificationMeta _amountUnitNameMeta =
      const VerificationMeta('amountUnitName');
  @override
  late final GeneratedColumn<String> amountUnitName = GeneratedColumn<String>(
      'amount_unit_name', aliasedName, true,
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
  static const VerificationMeta _areaUnitNameMeta =
      const VerificationMeta('areaUnitName');
  @override
  late final GeneratedColumn<String> areaUnitName = GeneratedColumn<String>(
      'area_unit_name', aliasedName, true,
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
  static const VerificationMeta _yieldEstimateUnitNameMeta =
      const VerificationMeta('yieldEstimateUnitName');
  @override
  late final GeneratedColumn<String> yieldEstimateUnitName =
      GeneratedColumn<String>('yield_estimate_unit_name', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _yieldRealMeta =
      const VerificationMeta('yieldReal');
  @override
  late final GeneratedColumn<double> yieldReal = GeneratedColumn<double>(
      'yield_real', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _yieldRealUnitIdMeta =
      const VerificationMeta('yieldRealUnitId');
  @override
  late final GeneratedColumn<int> yieldRealUnitId = GeneratedColumn<int>(
      'yield_real_unit_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _yieldRealUnitNameMeta =
      const VerificationMeta('yieldRealUnitName');
  @override
  late final GeneratedColumn<String> yieldRealUnitName =
      GeneratedColumn<String>('yield_real_unit_name', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _harvestingMeta =
      const VerificationMeta('harvesting');
  @override
  late final GeneratedColumn<bool> harvesting = GeneratedColumn<bool>(
      'harvesting', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("harvesting" IN (0, 1))'));
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
  static const VerificationMeta _statusNameMeta =
      const VerificationMeta('statusName');
  @override
  late final GeneratedColumn<String> statusName = GeneratedColumn<String>(
      'status_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _farmerNameMeta =
      const VerificationMeta('farmerName');
  @override
  late final GeneratedColumn<String> farmerName = GeneratedColumn<String>(
      'farmer_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _farmerIdMeta =
      const VerificationMeta('farmerId');
  @override
  late final GeneratedColumn<int> farmerId = GeneratedColumn<int>(
      'farmer_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _areaNameMeta =
      const VerificationMeta('areaName');
  @override
  late final GeneratedColumn<String> areaName = GeneratedColumn<String>(
      'area_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _areaCodeMeta =
      const VerificationMeta('areaCode');
  @override
  late final GeneratedColumn<String> areaCode = GeneratedColumn<String>(
      'area_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _farmCodeMeta =
      const VerificationMeta('farmCode');
  @override
  late final GeneratedColumn<String> farmCode = GeneratedColumn<String>(
      'farm_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _googleMapMeta =
      const VerificationMeta('googleMap');
  @override
  late final GeneratedColumn<String> googleMap = GeneratedColumn<String>(
      'google_map', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _productProcessIdMeta =
      const VerificationMeta('productProcessId');
  @override
  late final GeneratedColumn<int> productProcessId = GeneratedColumn<int>(
      'product_process_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _productProcessNameMeta =
      const VerificationMeta('productProcessName');
  @override
  late final GeneratedColumn<String> productProcessName =
      GeneratedColumn<String>('product_process_name', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _areaIdMeta = const VerificationMeta('areaId');
  @override
  late final GeneratedColumn<int> areaId = GeneratedColumn<int>(
      'area_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        action,
        name,
        seasonId,
        seasonName,
        farmId,
        farmName,
        productName,
        cropName,
        productId,
        cropId,
        amount,
        amountUnitId,
        amountUnitName,
        area,
        areaUnitId,
        areaUnitName,
        yieldEstimate,
        yieldEstimateUnitId,
        yieldEstimateUnitName,
        yieldReal,
        yieldRealUnitId,
        yieldRealUnitName,
        harvesting,
        startDate,
        endDate,
        status,
        statusName,
        description,
        farmerName,
        farmerId,
        areaName,
        areaCode,
        farmCode,
        googleMap,
        productProcessId,
        productProcessName,
        areaId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'diary';
  @override
  VerificationContext validateIntegrity(Insertable<Diary> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('action')) {
      context.handle(_actionMeta,
          action.isAcceptableOrUnknown(data['action']!, _actionMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('season_id')) {
      context.handle(_seasonIdMeta,
          seasonId.isAcceptableOrUnknown(data['season_id']!, _seasonIdMeta));
    }
    if (data.containsKey('season_name')) {
      context.handle(
          _seasonNameMeta,
          seasonName.isAcceptableOrUnknown(
              data['season_name']!, _seasonNameMeta));
    }
    if (data.containsKey('farm_id')) {
      context.handle(_farmIdMeta,
          farmId.isAcceptableOrUnknown(data['farm_id']!, _farmIdMeta));
    }
    if (data.containsKey('farm_name')) {
      context.handle(_farmNameMeta,
          farmName.isAcceptableOrUnknown(data['farm_name']!, _farmNameMeta));
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
    if (data.containsKey('crop_id')) {
      context.handle(_cropIdMeta,
          cropId.isAcceptableOrUnknown(data['crop_id']!, _cropIdMeta));
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
    if (data.containsKey('amount_unit_name')) {
      context.handle(
          _amountUnitNameMeta,
          amountUnitName.isAcceptableOrUnknown(
              data['amount_unit_name']!, _amountUnitNameMeta));
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
    if (data.containsKey('area_unit_name')) {
      context.handle(
          _areaUnitNameMeta,
          areaUnitName.isAcceptableOrUnknown(
              data['area_unit_name']!, _areaUnitNameMeta));
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
    if (data.containsKey('yield_estimate_unit_name')) {
      context.handle(
          _yieldEstimateUnitNameMeta,
          yieldEstimateUnitName.isAcceptableOrUnknown(
              data['yield_estimate_unit_name']!, _yieldEstimateUnitNameMeta));
    }
    if (data.containsKey('yield_real')) {
      context.handle(_yieldRealMeta,
          yieldReal.isAcceptableOrUnknown(data['yield_real']!, _yieldRealMeta));
    }
    if (data.containsKey('yield_real_unit_id')) {
      context.handle(
          _yieldRealUnitIdMeta,
          yieldRealUnitId.isAcceptableOrUnknown(
              data['yield_real_unit_id']!, _yieldRealUnitIdMeta));
    }
    if (data.containsKey('yield_real_unit_name')) {
      context.handle(
          _yieldRealUnitNameMeta,
          yieldRealUnitName.isAcceptableOrUnknown(
              data['yield_real_unit_name']!, _yieldRealUnitNameMeta));
    }
    if (data.containsKey('harvesting')) {
      context.handle(
          _harvestingMeta,
          harvesting.isAcceptableOrUnknown(
              data['harvesting']!, _harvestingMeta));
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
    if (data.containsKey('status_name')) {
      context.handle(
          _statusNameMeta,
          statusName.isAcceptableOrUnknown(
              data['status_name']!, _statusNameMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('farmer_name')) {
      context.handle(
          _farmerNameMeta,
          farmerName.isAcceptableOrUnknown(
              data['farmer_name']!, _farmerNameMeta));
    }
    if (data.containsKey('farmer_id')) {
      context.handle(_farmerIdMeta,
          farmerId.isAcceptableOrUnknown(data['farmer_id']!, _farmerIdMeta));
    }
    if (data.containsKey('area_name')) {
      context.handle(_areaNameMeta,
          areaName.isAcceptableOrUnknown(data['area_name']!, _areaNameMeta));
    }
    if (data.containsKey('area_code')) {
      context.handle(_areaCodeMeta,
          areaCode.isAcceptableOrUnknown(data['area_code']!, _areaCodeMeta));
    }
    if (data.containsKey('farm_code')) {
      context.handle(_farmCodeMeta,
          farmCode.isAcceptableOrUnknown(data['farm_code']!, _farmCodeMeta));
    }
    if (data.containsKey('google_map')) {
      context.handle(_googleMapMeta,
          googleMap.isAcceptableOrUnknown(data['google_map']!, _googleMapMeta));
    }
    if (data.containsKey('product_process_id')) {
      context.handle(
          _productProcessIdMeta,
          productProcessId.isAcceptableOrUnknown(
              data['product_process_id']!, _productProcessIdMeta));
    }
    if (data.containsKey('product_process_name')) {
      context.handle(
          _productProcessNameMeta,
          productProcessName.isAcceptableOrUnknown(
              data['product_process_name']!, _productProcessNameMeta));
    }
    if (data.containsKey('area_id')) {
      context.handle(_areaIdMeta,
          areaId.isAcceptableOrUnknown(data['area_id']!, _areaIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, userId};
  @override
  Diary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Diary(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      action: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action']),
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      seasonId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}season_id']),
      seasonName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}season_name']),
      farmId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}farm_id']),
      farmName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}farm_name']),
      cropId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}crop_id']),
      productName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_name']),
      cropName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}crop_name']),
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id']),
      area: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}area']),
      areaUnitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}area_unit_id']),
      areaUnitName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}area_unit_name']),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount']),
      amountUnitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_unit_id']),
      amountUnitName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}amount_unit_name']),
      yieldEstimate: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}yield_estimate']),
      yieldEstimateUnitId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}yield_estimate_unit_id']),
      yieldEstimateUnitName: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}yield_estimate_unit_name']),
      yieldReal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}yield_real']),
      yieldRealUnitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}yield_real_unit_id']),
      yieldRealUnitName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}yield_real_unit_name']),
      harvesting: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}harvesting']),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_date']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_date']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status']),
      statusName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status_name']),
      farmerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}farmer_name']),
      farmerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}farmer_id']),
      areaName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}area_name']),
      areaCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}area_code']),
      farmCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}farm_code']),
      googleMap: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}google_map']),
      productProcessId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_process_id']),
      productProcessName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}product_process_name']),
      areaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}area_id']),
    );
  }

  @override
  $DiaryTableTable createAlias(String alias) {
    return $DiaryTableTable(attachedDatabase, alias);
  }
}

class DiaryTableCompanion extends UpdateCompanion<Diary> {
  final Value<int?> id;
  final Value<int?> userId;
  final Value<String?> action;
  final Value<String?> name;
  final Value<int?> seasonId;
  final Value<String?> seasonName;
  final Value<int?> farmId;
  final Value<String?> farmName;
  final Value<String?> productName;
  final Value<String?> cropName;
  final Value<int?> productId;
  final Value<int?> cropId;
  final Value<double?> amount;
  final Value<int?> amountUnitId;
  final Value<String?> amountUnitName;
  final Value<double?> area;
  final Value<int?> areaUnitId;
  final Value<String?> areaUnitName;
  final Value<double?> yieldEstimate;
  final Value<int?> yieldEstimateUnitId;
  final Value<String?> yieldEstimateUnitName;
  final Value<double?> yieldReal;
  final Value<int?> yieldRealUnitId;
  final Value<String?> yieldRealUnitName;
  final Value<bool?> harvesting;
  final Value<String?> startDate;
  final Value<String?> endDate;
  final Value<String?> status;
  final Value<String?> statusName;
  final Value<String?> description;
  final Value<String?> farmerName;
  final Value<int?> farmerId;
  final Value<String?> areaName;
  final Value<String?> areaCode;
  final Value<String?> farmCode;
  final Value<String?> googleMap;
  final Value<int?> productProcessId;
  final Value<String?> productProcessName;
  final Value<int?> areaId;
  final Value<int> rowid;
  const DiaryTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.action = const Value.absent(),
    this.name = const Value.absent(),
    this.seasonId = const Value.absent(),
    this.seasonName = const Value.absent(),
    this.farmId = const Value.absent(),
    this.farmName = const Value.absent(),
    this.productName = const Value.absent(),
    this.cropName = const Value.absent(),
    this.productId = const Value.absent(),
    this.cropId = const Value.absent(),
    this.amount = const Value.absent(),
    this.amountUnitId = const Value.absent(),
    this.amountUnitName = const Value.absent(),
    this.area = const Value.absent(),
    this.areaUnitId = const Value.absent(),
    this.areaUnitName = const Value.absent(),
    this.yieldEstimate = const Value.absent(),
    this.yieldEstimateUnitId = const Value.absent(),
    this.yieldEstimateUnitName = const Value.absent(),
    this.yieldReal = const Value.absent(),
    this.yieldRealUnitId = const Value.absent(),
    this.yieldRealUnitName = const Value.absent(),
    this.harvesting = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.status = const Value.absent(),
    this.statusName = const Value.absent(),
    this.description = const Value.absent(),
    this.farmerName = const Value.absent(),
    this.farmerId = const Value.absent(),
    this.areaName = const Value.absent(),
    this.areaCode = const Value.absent(),
    this.farmCode = const Value.absent(),
    this.googleMap = const Value.absent(),
    this.productProcessId = const Value.absent(),
    this.productProcessName = const Value.absent(),
    this.areaId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DiaryTableCompanion.insert({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.action = const Value.absent(),
    this.name = const Value.absent(),
    this.seasonId = const Value.absent(),
    this.seasonName = const Value.absent(),
    this.farmId = const Value.absent(),
    this.farmName = const Value.absent(),
    this.productName = const Value.absent(),
    this.cropName = const Value.absent(),
    this.productId = const Value.absent(),
    this.cropId = const Value.absent(),
    this.amount = const Value.absent(),
    this.amountUnitId = const Value.absent(),
    this.amountUnitName = const Value.absent(),
    this.area = const Value.absent(),
    this.areaUnitId = const Value.absent(),
    this.areaUnitName = const Value.absent(),
    this.yieldEstimate = const Value.absent(),
    this.yieldEstimateUnitId = const Value.absent(),
    this.yieldEstimateUnitName = const Value.absent(),
    this.yieldReal = const Value.absent(),
    this.yieldRealUnitId = const Value.absent(),
    this.yieldRealUnitName = const Value.absent(),
    this.harvesting = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.status = const Value.absent(),
    this.statusName = const Value.absent(),
    this.description = const Value.absent(),
    this.farmerName = const Value.absent(),
    this.farmerId = const Value.absent(),
    this.areaName = const Value.absent(),
    this.areaCode = const Value.absent(),
    this.farmCode = const Value.absent(),
    this.googleMap = const Value.absent(),
    this.productProcessId = const Value.absent(),
    this.productProcessName = const Value.absent(),
    this.areaId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<Diary> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? action,
    Expression<String>? name,
    Expression<int>? seasonId,
    Expression<String>? seasonName,
    Expression<int>? farmId,
    Expression<String>? farmName,
    Expression<String>? productName,
    Expression<String>? cropName,
    Expression<int>? productId,
    Expression<int>? cropId,
    Expression<double>? amount,
    Expression<int>? amountUnitId,
    Expression<String>? amountUnitName,
    Expression<double>? area,
    Expression<int>? areaUnitId,
    Expression<String>? areaUnitName,
    Expression<double>? yieldEstimate,
    Expression<int>? yieldEstimateUnitId,
    Expression<String>? yieldEstimateUnitName,
    Expression<double>? yieldReal,
    Expression<int>? yieldRealUnitId,
    Expression<String>? yieldRealUnitName,
    Expression<bool>? harvesting,
    Expression<String>? startDate,
    Expression<String>? endDate,
    Expression<String>? status,
    Expression<String>? statusName,
    Expression<String>? description,
    Expression<String>? farmerName,
    Expression<int>? farmerId,
    Expression<String>? areaName,
    Expression<String>? areaCode,
    Expression<String>? farmCode,
    Expression<String>? googleMap,
    Expression<int>? productProcessId,
    Expression<String>? productProcessName,
    Expression<int>? areaId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (action != null) 'action': action,
      if (name != null) 'name': name,
      if (seasonId != null) 'season_id': seasonId,
      if (seasonName != null) 'season_name': seasonName,
      if (farmId != null) 'farm_id': farmId,
      if (farmName != null) 'farm_name': farmName,
      if (productName != null) 'product_name': productName,
      if (cropName != null) 'crop_name': cropName,
      if (productId != null) 'product_id': productId,
      if (cropId != null) 'crop_id': cropId,
      if (amount != null) 'amount': amount,
      if (amountUnitId != null) 'amount_unit_id': amountUnitId,
      if (amountUnitName != null) 'amount_unit_name': amountUnitName,
      if (area != null) 'area': area,
      if (areaUnitId != null) 'area_unit_id': areaUnitId,
      if (areaUnitName != null) 'area_unit_name': areaUnitName,
      if (yieldEstimate != null) 'yield_estimate': yieldEstimate,
      if (yieldEstimateUnitId != null)
        'yield_estimate_unit_id': yieldEstimateUnitId,
      if (yieldEstimateUnitName != null)
        'yield_estimate_unit_name': yieldEstimateUnitName,
      if (yieldReal != null) 'yield_real': yieldReal,
      if (yieldRealUnitId != null) 'yield_real_unit_id': yieldRealUnitId,
      if (yieldRealUnitName != null) 'yield_real_unit_name': yieldRealUnitName,
      if (harvesting != null) 'harvesting': harvesting,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (status != null) 'status': status,
      if (statusName != null) 'status_name': statusName,
      if (description != null) 'description': description,
      if (farmerName != null) 'farmer_name': farmerName,
      if (farmerId != null) 'farmer_id': farmerId,
      if (areaName != null) 'area_name': areaName,
      if (areaCode != null) 'area_code': areaCode,
      if (farmCode != null) 'farm_code': farmCode,
      if (googleMap != null) 'google_map': googleMap,
      if (productProcessId != null) 'product_process_id': productProcessId,
      if (productProcessName != null)
        'product_process_name': productProcessName,
      if (areaId != null) 'area_id': areaId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DiaryTableCompanion copyWith(
      {Value<int?>? id,
      Value<int?>? userId,
      Value<String?>? action,
      Value<String?>? name,
      Value<int?>? seasonId,
      Value<String?>? seasonName,
      Value<int?>? farmId,
      Value<String?>? farmName,
      Value<String?>? productName,
      Value<String?>? cropName,
      Value<int?>? productId,
      Value<int?>? cropId,
      Value<double?>? amount,
      Value<int?>? amountUnitId,
      Value<String?>? amountUnitName,
      Value<double?>? area,
      Value<int?>? areaUnitId,
      Value<String?>? areaUnitName,
      Value<double?>? yieldEstimate,
      Value<int?>? yieldEstimateUnitId,
      Value<String?>? yieldEstimateUnitName,
      Value<double?>? yieldReal,
      Value<int?>? yieldRealUnitId,
      Value<String?>? yieldRealUnitName,
      Value<bool?>? harvesting,
      Value<String?>? startDate,
      Value<String?>? endDate,
      Value<String?>? status,
      Value<String?>? statusName,
      Value<String?>? description,
      Value<String?>? farmerName,
      Value<int?>? farmerId,
      Value<String?>? areaName,
      Value<String?>? areaCode,
      Value<String?>? farmCode,
      Value<String?>? googleMap,
      Value<int?>? productProcessId,
      Value<String?>? productProcessName,
      Value<int?>? areaId,
      Value<int>? rowid}) {
    return DiaryTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      action: action ?? this.action,
      name: name ?? this.name,
      seasonId: seasonId ?? this.seasonId,
      seasonName: seasonName ?? this.seasonName,
      farmId: farmId ?? this.farmId,
      farmName: farmName ?? this.farmName,
      productName: productName ?? this.productName,
      cropName: cropName ?? this.cropName,
      productId: productId ?? this.productId,
      cropId: cropId ?? this.cropId,
      amount: amount ?? this.amount,
      amountUnitId: amountUnitId ?? this.amountUnitId,
      amountUnitName: amountUnitName ?? this.amountUnitName,
      area: area ?? this.area,
      areaUnitId: areaUnitId ?? this.areaUnitId,
      areaUnitName: areaUnitName ?? this.areaUnitName,
      yieldEstimate: yieldEstimate ?? this.yieldEstimate,
      yieldEstimateUnitId: yieldEstimateUnitId ?? this.yieldEstimateUnitId,
      yieldEstimateUnitName:
          yieldEstimateUnitName ?? this.yieldEstimateUnitName,
      yieldReal: yieldReal ?? this.yieldReal,
      yieldRealUnitId: yieldRealUnitId ?? this.yieldRealUnitId,
      yieldRealUnitName: yieldRealUnitName ?? this.yieldRealUnitName,
      harvesting: harvesting ?? this.harvesting,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      statusName: statusName ?? this.statusName,
      description: description ?? this.description,
      farmerName: farmerName ?? this.farmerName,
      farmerId: farmerId ?? this.farmerId,
      areaName: areaName ?? this.areaName,
      areaCode: areaCode ?? this.areaCode,
      farmCode: farmCode ?? this.farmCode,
      googleMap: googleMap ?? this.googleMap,
      productProcessId: productProcessId ?? this.productProcessId,
      productProcessName: productProcessName ?? this.productProcessName,
      areaId: areaId ?? this.areaId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (seasonId.present) {
      map['season_id'] = Variable<int>(seasonId.value);
    }
    if (seasonName.present) {
      map['season_name'] = Variable<String>(seasonName.value);
    }
    if (farmId.present) {
      map['farm_id'] = Variable<int>(farmId.value);
    }
    if (farmName.present) {
      map['farm_name'] = Variable<String>(farmName.value);
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
    if (cropId.present) {
      map['crop_id'] = Variable<int>(cropId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (amountUnitId.present) {
      map['amount_unit_id'] = Variable<int>(amountUnitId.value);
    }
    if (amountUnitName.present) {
      map['amount_unit_name'] = Variable<String>(amountUnitName.value);
    }
    if (area.present) {
      map['area'] = Variable<double>(area.value);
    }
    if (areaUnitId.present) {
      map['area_unit_id'] = Variable<int>(areaUnitId.value);
    }
    if (areaUnitName.present) {
      map['area_unit_name'] = Variable<String>(areaUnitName.value);
    }
    if (yieldEstimate.present) {
      map['yield_estimate'] = Variable<double>(yieldEstimate.value);
    }
    if (yieldEstimateUnitId.present) {
      map['yield_estimate_unit_id'] = Variable<int>(yieldEstimateUnitId.value);
    }
    if (yieldEstimateUnitName.present) {
      map['yield_estimate_unit_name'] =
          Variable<String>(yieldEstimateUnitName.value);
    }
    if (yieldReal.present) {
      map['yield_real'] = Variable<double>(yieldReal.value);
    }
    if (yieldRealUnitId.present) {
      map['yield_real_unit_id'] = Variable<int>(yieldRealUnitId.value);
    }
    if (yieldRealUnitName.present) {
      map['yield_real_unit_name'] = Variable<String>(yieldRealUnitName.value);
    }
    if (harvesting.present) {
      map['harvesting'] = Variable<bool>(harvesting.value);
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
    if (statusName.present) {
      map['status_name'] = Variable<String>(statusName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (farmerName.present) {
      map['farmer_name'] = Variable<String>(farmerName.value);
    }
    if (farmerId.present) {
      map['farmer_id'] = Variable<int>(farmerId.value);
    }
    if (areaName.present) {
      map['area_name'] = Variable<String>(areaName.value);
    }
    if (areaCode.present) {
      map['area_code'] = Variable<String>(areaCode.value);
    }
    if (farmCode.present) {
      map['farm_code'] = Variable<String>(farmCode.value);
    }
    if (googleMap.present) {
      map['google_map'] = Variable<String>(googleMap.value);
    }
    if (productProcessId.present) {
      map['product_process_id'] = Variable<int>(productProcessId.value);
    }
    if (productProcessName.present) {
      map['product_process_name'] = Variable<String>(productProcessName.value);
    }
    if (areaId.present) {
      map['area_id'] = Variable<int>(areaId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiaryTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('action: $action, ')
          ..write('name: $name, ')
          ..write('seasonId: $seasonId, ')
          ..write('seasonName: $seasonName, ')
          ..write('farmId: $farmId, ')
          ..write('farmName: $farmName, ')
          ..write('productName: $productName, ')
          ..write('cropName: $cropName, ')
          ..write('productId: $productId, ')
          ..write('cropId: $cropId, ')
          ..write('amount: $amount, ')
          ..write('amountUnitId: $amountUnitId, ')
          ..write('amountUnitName: $amountUnitName, ')
          ..write('area: $area, ')
          ..write('areaUnitId: $areaUnitId, ')
          ..write('areaUnitName: $areaUnitName, ')
          ..write('yieldEstimate: $yieldEstimate, ')
          ..write('yieldEstimateUnitId: $yieldEstimateUnitId, ')
          ..write('yieldEstimateUnitName: $yieldEstimateUnitName, ')
          ..write('yieldReal: $yieldReal, ')
          ..write('yieldRealUnitId: $yieldRealUnitId, ')
          ..write('yieldRealUnitName: $yieldRealUnitName, ')
          ..write('harvesting: $harvesting, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('status: $status, ')
          ..write('statusName: $statusName, ')
          ..write('description: $description, ')
          ..write('farmerName: $farmerName, ')
          ..write('farmerId: $farmerId, ')
          ..write('areaName: $areaName, ')
          ..write('areaCode: $areaCode, ')
          ..write('farmCode: $farmCode, ')
          ..write('googleMap: $googleMap, ')
          ..write('productProcessId: $productProcessId, ')
          ..write('productProcessName: $productProcessName, ')
          ..write('areaId: $areaId, ')
          ..write('rowid: $rowid')
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
  late final GeneratedColumn<bool> isOrganic = GeneratedColumn<bool>(
      'is_organic', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_organic" IN (0, 1))'));
  static const VerificationMeta _notationMeta =
      const VerificationMeta('notation');
  @override
  late final GeneratedColumn<bool> notation = GeneratedColumn<bool>(
      'notation', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("notation" IN (0, 1))'));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'));
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
  static const VerificationMeta _harvestingMeta =
      const VerificationMeta('harvesting');
  @override
  late final GeneratedColumn<bool> harvesting = GeneratedColumn<bool>(
      'harvesting', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("harvesting" IN (0, 1))'));
  static const VerificationMeta _stringToolIdsMeta =
      const VerificationMeta('stringToolIds');
  @override
  late final GeneratedColumn<String> stringToolIds = GeneratedColumn<String>(
      'string_tool_ids', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stringMaterialIdsMeta =
      const VerificationMeta('stringMaterialIds');
  @override
  late final GeneratedColumn<String> stringMaterialIds =
      GeneratedColumn<String>('string_material_ids', aliasedName, true,
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
        mediaContent,
        harvesting,
        stringToolIds,
        stringMaterialIds
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity';
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
    if (data.containsKey('harvesting')) {
      context.handle(
          _harvestingMeta,
          harvesting.isAcceptableOrUnknown(
              data['harvesting']!, _harvestingMeta));
    }
    if (data.containsKey('string_tool_ids')) {
      context.handle(
          _stringToolIdsMeta,
          stringToolIds.isAcceptableOrUnknown(
              data['string_tool_ids']!, _stringToolIdsMeta));
    }
    if (data.containsKey('string_material_ids')) {
      context.handle(
          _stringMaterialIdsMeta,
          stringMaterialIds.isAcceptableOrUnknown(
              data['string_material_ids']!, _stringMaterialIdsMeta));
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
      stringToolIds: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}string_tool_ids']),
      stringMaterialIds: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}string_material_ids']),
      harvesting: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}harvesting']),
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
  final Value<bool?> harvesting;
  final Value<String?> stringToolIds;
  final Value<String?> stringMaterialIds;
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
    this.harvesting = const Value.absent(),
    this.stringToolIds = const Value.absent(),
    this.stringMaterialIds = const Value.absent(),
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
    this.harvesting = const Value.absent(),
    this.stringToolIds = const Value.absent(),
    this.stringMaterialIds = const Value.absent(),
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
    Expression<bool>? harvesting,
    Expression<String>? stringToolIds,
    Expression<String>? stringMaterialIds,
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
      if (harvesting != null) 'harvesting': harvesting,
      if (stringToolIds != null) 'string_tool_ids': stringToolIds,
      if (stringMaterialIds != null) 'string_material_ids': stringMaterialIds,
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
      Value<String?>? mediaContent,
      Value<bool?>? harvesting,
      Value<String?>? stringToolIds,
      Value<String?>? stringMaterialIds}) {
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
      harvesting: harvesting ?? this.harvesting,
      stringToolIds: stringToolIds ?? this.stringToolIds,
      stringMaterialIds: stringMaterialIds ?? this.stringMaterialIds,
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
    if (harvesting.present) {
      map['harvesting'] = Variable<bool>(harvesting.value);
    }
    if (stringToolIds.present) {
      map['string_tool_ids'] = Variable<String>(stringToolIds.value);
    }
    if (stringMaterialIds.present) {
      map['string_material_ids'] = Variable<String>(stringMaterialIds.value);
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
          ..write('mediaContent: $mediaContent, ')
          ..write('harvesting: $harvesting, ')
          ..write('stringToolIds: $stringToolIds, ')
          ..write('stringMaterialIds: $stringMaterialIds')
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
  late final GeneratedColumn<bool> isOrganic = GeneratedColumn<bool>(
      'is_organic', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_organic" IN (0, 1))'));
  static const VerificationMeta _notationMeta =
      const VerificationMeta('notation');
  @override
  late final GeneratedColumn<bool> notation = GeneratedColumn<bool>(
      'notation', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("notation" IN (0, 1))'));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'));
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
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tool';
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
  late final GeneratedColumn<bool> isOrganic = GeneratedColumn<bool>(
      'is_organic', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_organic" IN (0, 1))'));
  static const VerificationMeta _notationMeta =
      const VerificationMeta('notation');
  @override
  late final GeneratedColumn<bool> notation = GeneratedColumn<bool>(
      'notation', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("notation" IN (0, 1))'));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'));
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
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'material';
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
  late final GeneratedColumn<bool> isOrganic = GeneratedColumn<bool>(
      'is_organic', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_organic" IN (0, 1))'));
  static const VerificationMeta _notationMeta =
      const VerificationMeta('notation');
  @override
  late final GeneratedColumn<bool> notation = GeneratedColumn<bool>(
      'notation', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("notation" IN (0, 1))'));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'));
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
  static const VerificationMeta _convertMeta =
      const VerificationMeta('convert');
  @override
  late final GeneratedColumn<double> convert = GeneratedColumn<double>(
      'convert', aliasedName, true,
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
        convert,
        unitId,
        mediaContent
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'unit';
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
    if (data.containsKey('convert')) {
      context.handle(_convertMeta,
          convert.isAcceptableOrUnknown(data['convert']!, _convertMeta));
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
      convert: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}convert']),
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
  final Value<double?> convert;
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
    this.convert = const Value.absent(),
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
    this.convert = const Value.absent(),
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
    Expression<double>? convert,
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
      if (convert != null) 'convert': convert,
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
      Value<double?>? convert,
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
      convert: convert ?? this.convert,
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
    if (convert.present) {
      map['convert'] = Variable<double>(convert.value);
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
          ..write('convert: $convert, ')
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
  late final GeneratedColumn<bool> isShow = GeneratedColumn<bool>(
      'is_show', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_show" IN (0, 1))'));
  static const VerificationMeta _amountUnitIdMeta =
      const VerificationMeta('amountUnitId');
  @override
  late final GeneratedColumn<int> amountUnitId = GeneratedColumn<int>(
      'amount_unit_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _amountUnitNameMeta =
      const VerificationMeta('amountUnitName');
  @override
  late final GeneratedColumn<String> amountUnitName = GeneratedColumn<String>(
      'amount_unit_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _harvestingMeta =
      const VerificationMeta('harvesting');
  @override
  late final GeneratedColumn<bool> harvesting = GeneratedColumn<bool>(
      'harvesting', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("harvesting" IN (0, 1))'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _productNameMeta =
      const VerificationMeta('productName');
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
      'product_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _companyIdMeta =
      const VerificationMeta('companyId');
  @override
  late final GeneratedColumn<int> companyId = GeneratedColumn<int>(
      'company_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _companyNameMeta =
      const VerificationMeta('companyName');
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
      'company_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _quantityUnitIdMeta =
      const VerificationMeta('quantityUnitId');
  @override
  late final GeneratedColumn<int> quantityUnitId = GeneratedColumn<int>(
      'quantity_unit_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _quantityUnitNameMeta =
      const VerificationMeta('quantityUnitName');
  @override
  late final GeneratedColumn<String> quantityUnitName = GeneratedColumn<String>(
      'quantity_unit_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _unitPriceMeta =
      const VerificationMeta('unitPrice');
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
      'unit_price', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _buyerMeta = const VerificationMeta('buyer');
  @override
  late final GeneratedColumn<String> buyer = GeneratedColumn<String>(
      'buyer', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stringToolMeta =
      const VerificationMeta('stringTool');
  @override
  late final GeneratedColumn<String> stringTool = GeneratedColumn<String>(
      'string_tool', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stringMaterialMeta =
      const VerificationMeta('stringMaterial');
  @override
  late final GeneratedColumn<String> stringMaterial = GeneratedColumn<String>(
      'string_material', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stringMediaMeta =
      const VerificationMeta('stringMedia');
  @override
  late final GeneratedColumn<String> stringMedia = GeneratedColumn<String>(
      'string_media', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
        amountUnitId,
        amountUnitName,
        amount,
        harvesting,
        productId,
        productName,
        companyId,
        companyName,
        quantity,
        quantityUnitId,
        quantityUnitName,
        unitPrice,
        total,
        buyer,
        stringTool,
        stringMaterial,
        stringMedia
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_diary';
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
    if (data.containsKey('amount_unit_id')) {
      context.handle(
          _amountUnitIdMeta,
          amountUnitId.isAcceptableOrUnknown(
              data['amount_unit_id']!, _amountUnitIdMeta));
    }
    if (data.containsKey('amount_unit_name')) {
      context.handle(
          _amountUnitNameMeta,
          amountUnitName.isAcceptableOrUnknown(
              data['amount_unit_name']!, _amountUnitNameMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    }
    if (data.containsKey('harvesting')) {
      context.handle(
          _harvestingMeta,
          harvesting.isAcceptableOrUnknown(
              data['harvesting']!, _harvestingMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    }
    if (data.containsKey('product_name')) {
      context.handle(
          _productNameMeta,
          productName.isAcceptableOrUnknown(
              data['product_name']!, _productNameMeta));
    }
    if (data.containsKey('company_id')) {
      context.handle(_companyIdMeta,
          companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta));
    }
    if (data.containsKey('company_name')) {
      context.handle(
          _companyNameMeta,
          companyName.isAcceptableOrUnknown(
              data['company_name']!, _companyNameMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('quantity_unit_id')) {
      context.handle(
          _quantityUnitIdMeta,
          quantityUnitId.isAcceptableOrUnknown(
              data['quantity_unit_id']!, _quantityUnitIdMeta));
    }
    if (data.containsKey('quantity_unit_name')) {
      context.handle(
          _quantityUnitNameMeta,
          quantityUnitName.isAcceptableOrUnknown(
              data['quantity_unit_name']!, _quantityUnitNameMeta));
    }
    if (data.containsKey('unit_price')) {
      context.handle(_unitPriceMeta,
          unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta));
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    }
    if (data.containsKey('buyer')) {
      context.handle(
          _buyerMeta, buyer.isAcceptableOrUnknown(data['buyer']!, _buyerMeta));
    }
    if (data.containsKey('string_tool')) {
      context.handle(
          _stringToolMeta,
          stringTool.isAcceptableOrUnknown(
              data['string_tool']!, _stringToolMeta));
    }
    if (data.containsKey('string_material')) {
      context.handle(
          _stringMaterialMeta,
          stringMaterial.isAcceptableOrUnknown(
              data['string_material']!, _stringMaterialMeta));
    }
    if (data.containsKey('string_media')) {
      context.handle(
          _stringMediaMeta,
          stringMedia.isAcceptableOrUnknown(
              data['string_media']!, _stringMediaMeta));
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
      harvesting: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}harvesting']),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount']),
      amountUnitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_unit_id']),
      amountUnitName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}amount_unit_name']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      activityName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}activity_name']),
      seasonFarm: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}season_farm']),
      isShow: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_show']),
      stringTool: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}string_tool']),
      stringMedia: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}string_media']),
      stringMaterial: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}string_material']),
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id']),
      productName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_name']),
      companyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}company_id']),
      companyName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_name']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity']),
      quantityUnitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity_unit_id']),
      quantityUnitName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}quantity_unit_name']),
      unitPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}unit_price']),
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total']),
      buyer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}buyer']),
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
  final Value<int?> amountUnitId;
  final Value<String?> amountUnitName;
  final Value<double?> amount;
  final Value<bool?> harvesting;
  final Value<int?> productId;
  final Value<String?> productName;
  final Value<int?> companyId;
  final Value<String?> companyName;
  final Value<double?> quantity;
  final Value<int?> quantityUnitId;
  final Value<String?> quantityUnitName;
  final Value<double?> unitPrice;
  final Value<double?> total;
  final Value<String?> buyer;
  final Value<String?> stringTool;
  final Value<String?> stringMaterial;
  final Value<String?> stringMedia;
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
    this.amountUnitId = const Value.absent(),
    this.amountUnitName = const Value.absent(),
    this.amount = const Value.absent(),
    this.harvesting = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.companyId = const Value.absent(),
    this.companyName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.quantityUnitId = const Value.absent(),
    this.quantityUnitName = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.total = const Value.absent(),
    this.buyer = const Value.absent(),
    this.stringTool = const Value.absent(),
    this.stringMaterial = const Value.absent(),
    this.stringMedia = const Value.absent(),
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
    this.amountUnitId = const Value.absent(),
    this.amountUnitName = const Value.absent(),
    this.amount = const Value.absent(),
    this.harvesting = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.companyId = const Value.absent(),
    this.companyName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.quantityUnitId = const Value.absent(),
    this.quantityUnitName = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.total = const Value.absent(),
    this.buyer = const Value.absent(),
    this.stringTool = const Value.absent(),
    this.stringMaterial = const Value.absent(),
    this.stringMedia = const Value.absent(),
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
    Expression<int>? amountUnitId,
    Expression<String>? amountUnitName,
    Expression<double>? amount,
    Expression<bool>? harvesting,
    Expression<int>? productId,
    Expression<String>? productName,
    Expression<int>? companyId,
    Expression<String>? companyName,
    Expression<double>? quantity,
    Expression<int>? quantityUnitId,
    Expression<String>? quantityUnitName,
    Expression<double>? unitPrice,
    Expression<double>? total,
    Expression<String>? buyer,
    Expression<String>? stringTool,
    Expression<String>? stringMaterial,
    Expression<String>? stringMedia,
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
      if (amountUnitId != null) 'amount_unit_id': amountUnitId,
      if (amountUnitName != null) 'amount_unit_name': amountUnitName,
      if (amount != null) 'amount': amount,
      if (harvesting != null) 'harvesting': harvesting,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (companyId != null) 'company_id': companyId,
      if (companyName != null) 'company_name': companyName,
      if (quantity != null) 'quantity': quantity,
      if (quantityUnitId != null) 'quantity_unit_id': quantityUnitId,
      if (quantityUnitName != null) 'quantity_unit_name': quantityUnitName,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (total != null) 'total': total,
      if (buyer != null) 'buyer': buyer,
      if (stringTool != null) 'string_tool': stringTool,
      if (stringMaterial != null) 'string_material': stringMaterial,
      if (stringMedia != null) 'string_media': stringMedia,
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
      Value<int?>? amountUnitId,
      Value<String?>? amountUnitName,
      Value<double?>? amount,
      Value<bool?>? harvesting,
      Value<int?>? productId,
      Value<String?>? productName,
      Value<int?>? companyId,
      Value<String?>? companyName,
      Value<double?>? quantity,
      Value<int?>? quantityUnitId,
      Value<String?>? quantityUnitName,
      Value<double?>? unitPrice,
      Value<double?>? total,
      Value<String?>? buyer,
      Value<String?>? stringTool,
      Value<String?>? stringMaterial,
      Value<String?>? stringMedia}) {
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
      amountUnitId: amountUnitId ?? this.amountUnitId,
      amountUnitName: amountUnitName ?? this.amountUnitName,
      amount: amount ?? this.amount,
      harvesting: harvesting ?? this.harvesting,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      quantity: quantity ?? this.quantity,
      quantityUnitId: quantityUnitId ?? this.quantityUnitId,
      quantityUnitName: quantityUnitName ?? this.quantityUnitName,
      unitPrice: unitPrice ?? this.unitPrice,
      total: total ?? this.total,
      buyer: buyer ?? this.buyer,
      stringTool: stringTool ?? this.stringTool,
      stringMaterial: stringMaterial ?? this.stringMaterial,
      stringMedia: stringMedia ?? this.stringMedia,
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
    if (amountUnitId.present) {
      map['amount_unit_id'] = Variable<int>(amountUnitId.value);
    }
    if (amountUnitName.present) {
      map['amount_unit_name'] = Variable<String>(amountUnitName.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (harvesting.present) {
      map['harvesting'] = Variable<bool>(harvesting.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<int>(companyId.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (quantityUnitId.present) {
      map['quantity_unit_id'] = Variable<int>(quantityUnitId.value);
    }
    if (quantityUnitName.present) {
      map['quantity_unit_name'] = Variable<String>(quantityUnitName.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (buyer.present) {
      map['buyer'] = Variable<String>(buyer.value);
    }
    if (stringTool.present) {
      map['string_tool'] = Variable<String>(stringTool.value);
    }
    if (stringMaterial.present) {
      map['string_material'] = Variable<String>(stringMaterial.value);
    }
    if (stringMedia.present) {
      map['string_media'] = Variable<String>(stringMedia.value);
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
          ..write('amountUnitId: $amountUnitId, ')
          ..write('amountUnitName: $amountUnitName, ')
          ..write('amount: $amount, ')
          ..write('harvesting: $harvesting, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('companyId: $companyId, ')
          ..write('companyName: $companyName, ')
          ..write('quantity: $quantity, ')
          ..write('quantityUnitId: $quantityUnitId, ')
          ..write('quantityUnitName: $quantityUnitName, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('total: $total, ')
          ..write('buyer: $buyer, ')
          ..write('stringTool: $stringTool, ')
          ..write('stringMaterial: $stringMaterial, ')
          ..write('stringMedia: $stringMedia')
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
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
      'active', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'));
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
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_info';
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
  late final GeneratedColumn<bool> checkYes = GeneratedColumn<bool>(
      'check_yes', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("check_yes" IN (0, 1))'));
  static const VerificationMeta _checkNoMeta =
      const VerificationMeta('checkNo');
  @override
  late final GeneratedColumn<bool> checkNo = GeneratedColumn<bool>(
      'check_no', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("check_no" IN (0, 1))'));
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, diaryMonitorId, activityId, activity, checkYes, checkNo, image];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity';
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
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
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
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image']),
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
  final Value<String?> image;
  const ActivityMonitorTableCompanion({
    this.id = const Value.absent(),
    this.diaryMonitorId = const Value.absent(),
    this.activityId = const Value.absent(),
    this.activity = const Value.absent(),
    this.checkYes = const Value.absent(),
    this.checkNo = const Value.absent(),
    this.image = const Value.absent(),
  });
  ActivityMonitorTableCompanion.insert({
    this.id = const Value.absent(),
    this.diaryMonitorId = const Value.absent(),
    this.activityId = const Value.absent(),
    this.activity = const Value.absent(),
    this.checkYes = const Value.absent(),
    this.checkNo = const Value.absent(),
    this.image = const Value.absent(),
  });
  static Insertable<ActivityMonitor> custom({
    Expression<int>? id,
    Expression<int>? diaryMonitorId,
    Expression<int>? activityId,
    Expression<String>? activity,
    Expression<bool>? checkYes,
    Expression<bool>? checkNo,
    Expression<String>? image,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (diaryMonitorId != null) 'diary_monitor_id': diaryMonitorId,
      if (activityId != null) 'activity_id': activityId,
      if (activity != null) 'activity': activity,
      if (checkYes != null) 'check_yes': checkYes,
      if (checkNo != null) 'check_no': checkNo,
      if (image != null) 'image': image,
    });
  }

  ActivityMonitorTableCompanion copyWith(
      {Value<int?>? id,
      Value<int?>? diaryMonitorId,
      Value<int?>? activityId,
      Value<String?>? activity,
      Value<bool?>? checkYes,
      Value<bool?>? checkNo,
      Value<String?>? image}) {
    return ActivityMonitorTableCompanion(
      id: id ?? this.id,
      diaryMonitorId: diaryMonitorId ?? this.diaryMonitorId,
      activityId: activityId ?? this.activityId,
      activity: activity ?? this.activity,
      checkYes: checkYes ?? this.checkYes,
      checkNo: checkNo ?? this.checkNo,
      image: image ?? this.image,
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
    if (image.present) {
      map['image'] = Variable<String>(image.value);
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
          ..write('checkNo: $checkNo, ')
          ..write('image: $image')
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
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monitor_diary';
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

class $ActDiaryNoNetworkTableTable extends ActDiaryNoNetworkTable
    with TableInfo<$ActDiaryNoNetworkTableTable, ActDiaryNoNetwork> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActDiaryNoNetworkTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _apiMeta = const VerificationMeta('api');
  @override
  late final GeneratedColumn<String> api = GeneratedColumn<String>(
      'api', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  late final GeneratedColumn<bool> isShow = GeneratedColumn<bool>(
      'is_show', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_show" IN (0, 1))'));
  static const VerificationMeta _amountUnitIdMeta =
      const VerificationMeta('amountUnitId');
  @override
  late final GeneratedColumn<int> amountUnitId = GeneratedColumn<int>(
      'amount_unit_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _amountUnitNameMeta =
      const VerificationMeta('amountUnitName');
  @override
  late final GeneratedColumn<String> amountUnitName = GeneratedColumn<String>(
      'amount_unit_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _harvestingMeta =
      const VerificationMeta('harvesting');
  @override
  late final GeneratedColumn<bool> harvesting = GeneratedColumn<bool>(
      'harvesting', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("harvesting" IN (0, 1))'));
  static const VerificationMeta _stringToolMeta =
      const VerificationMeta('stringTool');
  @override
  late final GeneratedColumn<String> stringTool = GeneratedColumn<String>(
      'string_tool', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stringMaterialMeta =
      const VerificationMeta('stringMaterial');
  @override
  late final GeneratedColumn<String> stringMaterial = GeneratedColumn<String>(
      'string_material', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stringMediaMeta =
      const VerificationMeta('stringMedia');
  @override
  late final GeneratedColumn<String> stringMedia = GeneratedColumn<String>(
      'string_media', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _productNameMeta =
      const VerificationMeta('productName');
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
      'product_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _companyIdMeta =
      const VerificationMeta('companyId');
  @override
  late final GeneratedColumn<int> companyId = GeneratedColumn<int>(
      'company_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _companyNameMeta =
      const VerificationMeta('companyName');
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
      'company_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _quantityUnitIdMeta =
      const VerificationMeta('quantityUnitId');
  @override
  late final GeneratedColumn<int> quantityUnitId = GeneratedColumn<int>(
      'quantity_unit_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _quantityUnitNameMeta =
      const VerificationMeta('quantityUnitName');
  @override
  late final GeneratedColumn<String> quantityUnitName = GeneratedColumn<String>(
      'quantity_unit_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _unitPriceMeta =
      const VerificationMeta('unitPrice');
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
      'unit_price', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _buyerMeta = const VerificationMeta('buyer');
  @override
  late final GeneratedColumn<String> buyer = GeneratedColumn<String>(
      'buyer', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stringSeasonFarmIdsMeta =
      const VerificationMeta('stringSeasonFarmIds');
  @override
  late final GeneratedColumn<String> stringSeasonFarmIds =
      GeneratedColumn<String>('string_season_farm_ids', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        api,
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
        amountUnitId,
        amountUnitName,
        amount,
        harvesting,
        stringTool,
        stringMaterial,
        stringMedia,
        productId,
        productName,
        companyId,
        companyName,
        quantity,
        quantityUnitId,
        quantityUnitName,
        unitPrice,
        total,
        buyer,
        stringSeasonFarmIds
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_diary_no_network';
  @override
  VerificationContext validateIntegrity(Insertable<ActDiaryNoNetwork> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('api')) {
      context.handle(
          _apiMeta, api.isAcceptableOrUnknown(data['api']!, _apiMeta));
    }
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
    if (data.containsKey('amount_unit_id')) {
      context.handle(
          _amountUnitIdMeta,
          amountUnitId.isAcceptableOrUnknown(
              data['amount_unit_id']!, _amountUnitIdMeta));
    }
    if (data.containsKey('amount_unit_name')) {
      context.handle(
          _amountUnitNameMeta,
          amountUnitName.isAcceptableOrUnknown(
              data['amount_unit_name']!, _amountUnitNameMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    }
    if (data.containsKey('harvesting')) {
      context.handle(
          _harvestingMeta,
          harvesting.isAcceptableOrUnknown(
              data['harvesting']!, _harvestingMeta));
    }
    if (data.containsKey('string_tool')) {
      context.handle(
          _stringToolMeta,
          stringTool.isAcceptableOrUnknown(
              data['string_tool']!, _stringToolMeta));
    }
    if (data.containsKey('string_material')) {
      context.handle(
          _stringMaterialMeta,
          stringMaterial.isAcceptableOrUnknown(
              data['string_material']!, _stringMaterialMeta));
    }
    if (data.containsKey('string_media')) {
      context.handle(
          _stringMediaMeta,
          stringMedia.isAcceptableOrUnknown(
              data['string_media']!, _stringMediaMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    }
    if (data.containsKey('product_name')) {
      context.handle(
          _productNameMeta,
          productName.isAcceptableOrUnknown(
              data['product_name']!, _productNameMeta));
    }
    if (data.containsKey('company_id')) {
      context.handle(_companyIdMeta,
          companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta));
    }
    if (data.containsKey('company_name')) {
      context.handle(
          _companyNameMeta,
          companyName.isAcceptableOrUnknown(
              data['company_name']!, _companyNameMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('quantity_unit_id')) {
      context.handle(
          _quantityUnitIdMeta,
          quantityUnitId.isAcceptableOrUnknown(
              data['quantity_unit_id']!, _quantityUnitIdMeta));
    }
    if (data.containsKey('quantity_unit_name')) {
      context.handle(
          _quantityUnitNameMeta,
          quantityUnitName.isAcceptableOrUnknown(
              data['quantity_unit_name']!, _quantityUnitNameMeta));
    }
    if (data.containsKey('unit_price')) {
      context.handle(_unitPriceMeta,
          unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta));
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    }
    if (data.containsKey('buyer')) {
      context.handle(
          _buyerMeta, buyer.isAcceptableOrUnknown(data['buyer']!, _buyerMeta));
    }
    if (data.containsKey('string_season_farm_ids')) {
      context.handle(
          _stringSeasonFarmIdsMeta,
          stringSeasonFarmIds.isAcceptableOrUnknown(
              data['string_season_farm_ids']!, _stringSeasonFarmIdsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActDiaryNoNetwork map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActDiaryNoNetwork(
      api: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}api']),
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
      harvesting: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}harvesting']),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount']),
      amountUnitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_unit_id']),
      amountUnitName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}amount_unit_name']),
      stringTool: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}string_tool']),
      stringMedia: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}string_media']),
      stringMaterial: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}string_material']),
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id']),
      productName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_name']),
      companyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}company_id']),
      companyName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_name']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity']),
      quantityUnitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity_unit_id']),
      quantityUnitName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}quantity_unit_name']),
      unitPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}unit_price']),
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total']),
      buyer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}buyer']),
      stringSeasonFarmIds: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}string_season_farm_ids']),
    );
  }

  @override
  $ActDiaryNoNetworkTableTable createAlias(String alias) {
    return $ActDiaryNoNetworkTableTable(attachedDatabase, alias);
  }
}

class ActDiaryNoNetworkTableCompanion
    extends UpdateCompanion<ActDiaryNoNetwork> {
  final Value<String?> api;
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
  final Value<int?> amountUnitId;
  final Value<String?> amountUnitName;
  final Value<double?> amount;
  final Value<bool?> harvesting;
  final Value<String?> stringTool;
  final Value<String?> stringMaterial;
  final Value<String?> stringMedia;
  final Value<int?> productId;
  final Value<String?> productName;
  final Value<int?> companyId;
  final Value<String?> companyName;
  final Value<double?> quantity;
  final Value<int?> quantityUnitId;
  final Value<String?> quantityUnitName;
  final Value<double?> unitPrice;
  final Value<double?> total;
  final Value<String?> buyer;
  final Value<String?> stringSeasonFarmIds;
  const ActDiaryNoNetworkTableCompanion({
    this.api = const Value.absent(),
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
    this.amountUnitId = const Value.absent(),
    this.amountUnitName = const Value.absent(),
    this.amount = const Value.absent(),
    this.harvesting = const Value.absent(),
    this.stringTool = const Value.absent(),
    this.stringMaterial = const Value.absent(),
    this.stringMedia = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.companyId = const Value.absent(),
    this.companyName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.quantityUnitId = const Value.absent(),
    this.quantityUnitName = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.total = const Value.absent(),
    this.buyer = const Value.absent(),
    this.stringSeasonFarmIds = const Value.absent(),
  });
  ActDiaryNoNetworkTableCompanion.insert({
    this.api = const Value.absent(),
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
    this.amountUnitId = const Value.absent(),
    this.amountUnitName = const Value.absent(),
    this.amount = const Value.absent(),
    this.harvesting = const Value.absent(),
    this.stringTool = const Value.absent(),
    this.stringMaterial = const Value.absent(),
    this.stringMedia = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.companyId = const Value.absent(),
    this.companyName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.quantityUnitId = const Value.absent(),
    this.quantityUnitName = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.total = const Value.absent(),
    this.buyer = const Value.absent(),
    this.stringSeasonFarmIds = const Value.absent(),
  });
  static Insertable<ActDiaryNoNetwork> custom({
    Expression<String>? api,
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
    Expression<int>? amountUnitId,
    Expression<String>? amountUnitName,
    Expression<double>? amount,
    Expression<bool>? harvesting,
    Expression<String>? stringTool,
    Expression<String>? stringMaterial,
    Expression<String>? stringMedia,
    Expression<int>? productId,
    Expression<String>? productName,
    Expression<int>? companyId,
    Expression<String>? companyName,
    Expression<double>? quantity,
    Expression<int>? quantityUnitId,
    Expression<String>? quantityUnitName,
    Expression<double>? unitPrice,
    Expression<double>? total,
    Expression<String>? buyer,
    Expression<String>? stringSeasonFarmIds,
  }) {
    return RawValuesInsertable({
      if (api != null) 'api': api,
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
      if (amountUnitId != null) 'amount_unit_id': amountUnitId,
      if (amountUnitName != null) 'amount_unit_name': amountUnitName,
      if (amount != null) 'amount': amount,
      if (harvesting != null) 'harvesting': harvesting,
      if (stringTool != null) 'string_tool': stringTool,
      if (stringMaterial != null) 'string_material': stringMaterial,
      if (stringMedia != null) 'string_media': stringMedia,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (companyId != null) 'company_id': companyId,
      if (companyName != null) 'company_name': companyName,
      if (quantity != null) 'quantity': quantity,
      if (quantityUnitId != null) 'quantity_unit_id': quantityUnitId,
      if (quantityUnitName != null) 'quantity_unit_name': quantityUnitName,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (total != null) 'total': total,
      if (buyer != null) 'buyer': buyer,
      if (stringSeasonFarmIds != null)
        'string_season_farm_ids': stringSeasonFarmIds,
    });
  }

  ActDiaryNoNetworkTableCompanion copyWith(
      {Value<String?>? api,
      Value<int?>? id,
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
      Value<int?>? amountUnitId,
      Value<String?>? amountUnitName,
      Value<double?>? amount,
      Value<bool?>? harvesting,
      Value<String?>? stringTool,
      Value<String?>? stringMaterial,
      Value<String?>? stringMedia,
      Value<int?>? productId,
      Value<String?>? productName,
      Value<int?>? companyId,
      Value<String?>? companyName,
      Value<double?>? quantity,
      Value<int?>? quantityUnitId,
      Value<String?>? quantityUnitName,
      Value<double?>? unitPrice,
      Value<double?>? total,
      Value<String?>? buyer,
      Value<String?>? stringSeasonFarmIds}) {
    return ActDiaryNoNetworkTableCompanion(
      api: api ?? this.api,
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
      amountUnitId: amountUnitId ?? this.amountUnitId,
      amountUnitName: amountUnitName ?? this.amountUnitName,
      amount: amount ?? this.amount,
      harvesting: harvesting ?? this.harvesting,
      stringTool: stringTool ?? this.stringTool,
      stringMaterial: stringMaterial ?? this.stringMaterial,
      stringMedia: stringMedia ?? this.stringMedia,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      quantity: quantity ?? this.quantity,
      quantityUnitId: quantityUnitId ?? this.quantityUnitId,
      quantityUnitName: quantityUnitName ?? this.quantityUnitName,
      unitPrice: unitPrice ?? this.unitPrice,
      total: total ?? this.total,
      buyer: buyer ?? this.buyer,
      stringSeasonFarmIds: stringSeasonFarmIds ?? this.stringSeasonFarmIds,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (api.present) {
      map['api'] = Variable<String>(api.value);
    }
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
    if (amountUnitId.present) {
      map['amount_unit_id'] = Variable<int>(amountUnitId.value);
    }
    if (amountUnitName.present) {
      map['amount_unit_name'] = Variable<String>(amountUnitName.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (harvesting.present) {
      map['harvesting'] = Variable<bool>(harvesting.value);
    }
    if (stringTool.present) {
      map['string_tool'] = Variable<String>(stringTool.value);
    }
    if (stringMaterial.present) {
      map['string_material'] = Variable<String>(stringMaterial.value);
    }
    if (stringMedia.present) {
      map['string_media'] = Variable<String>(stringMedia.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<int>(companyId.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (quantityUnitId.present) {
      map['quantity_unit_id'] = Variable<int>(quantityUnitId.value);
    }
    if (quantityUnitName.present) {
      map['quantity_unit_name'] = Variable<String>(quantityUnitName.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (buyer.present) {
      map['buyer'] = Variable<String>(buyer.value);
    }
    if (stringSeasonFarmIds.present) {
      map['string_season_farm_ids'] =
          Variable<String>(stringSeasonFarmIds.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActDiaryNoNetworkTableCompanion(')
          ..write('api: $api, ')
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
          ..write('amountUnitId: $amountUnitId, ')
          ..write('amountUnitName: $amountUnitName, ')
          ..write('amount: $amount, ')
          ..write('harvesting: $harvesting, ')
          ..write('stringTool: $stringTool, ')
          ..write('stringMaterial: $stringMaterial, ')
          ..write('stringMedia: $stringMedia, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('companyId: $companyId, ')
          ..write('companyName: $companyName, ')
          ..write('quantity: $quantity, ')
          ..write('quantityUnitId: $quantityUnitId, ')
          ..write('quantityUnitName: $quantityUnitName, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('total: $total, ')
          ..write('buyer: $buyer, ')
          ..write('stringSeasonFarmIds: $stringSeasonFarmIds')
          ..write(')'))
        .toString();
  }
}

class $ReportTableTable extends ReportTable
    with TableInfo<$ReportTableTable, Report> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReportTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isPageMeta = const VerificationMeta('isPage');
  @override
  late final GeneratedColumn<bool> isPage = GeneratedColumn<bool>(
      'is_page', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_page" IN (0, 1))'));
  static const VerificationMeta _pageIdMeta = const VerificationMeta('pageId');
  @override
  late final GeneratedColumn<int> pageId = GeneratedColumn<int>(
      'page_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _surveyIdMeta =
      const VerificationMeta('surveyId');
  @override
  late final GeneratedColumn<int> surveyId = GeneratedColumn<int>(
      'survey_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
      'active', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'));
  static const VerificationMeta _hasConditionalQuestionsMeta =
      const VerificationMeta('hasConditionalQuestions');
  @override
  late final GeneratedColumn<bool> hasConditionalQuestions =
      GeneratedColumn<bool>('has_conditional_questions', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("has_conditional_questions" IN (0, 1))'));
  static const VerificationMeta _questionsSelectionMeta =
      const VerificationMeta('questionsSelection');
  @override
  late final GeneratedColumn<String> questionsSelection =
      GeneratedColumn<String>('questions_selection', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timeLimitMeta =
      const VerificationMeta('timeLimit');
  @override
  late final GeneratedColumn<double> timeLimit = GeneratedColumn<double>(
      'time_limit', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _stringQuestionAndPageIdsMeta =
      const VerificationMeta('stringQuestionAndPageIds');
  @override
  late final GeneratedColumn<String> stringQuestionAndPageIds =
      GeneratedColumn<String>('string_question_and_page_ids', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stringListFarmersMeta =
      const VerificationMeta('stringListFarmers');
  @override
  late final GeneratedColumn<String> stringListFarmers =
      GeneratedColumn<String>('string_list_farmers', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        isPage,
        pageId,
        surveyId,
        title,
        userId,
        active,
        hasConditionalQuestions,
        questionsSelection,
        timeLimit,
        stringQuestionAndPageIds,
        stringListFarmers
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'report';
  @override
  VerificationContext validateIntegrity(Insertable<Report> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_page')) {
      context.handle(_isPageMeta,
          isPage.isAcceptableOrUnknown(data['is_page']!, _isPageMeta));
    }
    if (data.containsKey('page_id')) {
      context.handle(_pageIdMeta,
          pageId.isAcceptableOrUnknown(data['page_id']!, _pageIdMeta));
    }
    if (data.containsKey('survey_id')) {
      context.handle(_surveyIdMeta,
          surveyId.isAcceptableOrUnknown(data['survey_id']!, _surveyIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    if (data.containsKey('has_conditional_questions')) {
      context.handle(
          _hasConditionalQuestionsMeta,
          hasConditionalQuestions.isAcceptableOrUnknown(
              data['has_conditional_questions']!,
              _hasConditionalQuestionsMeta));
    }
    if (data.containsKey('questions_selection')) {
      context.handle(
          _questionsSelectionMeta,
          questionsSelection.isAcceptableOrUnknown(
              data['questions_selection']!, _questionsSelectionMeta));
    }
    if (data.containsKey('time_limit')) {
      context.handle(_timeLimitMeta,
          timeLimit.isAcceptableOrUnknown(data['time_limit']!, _timeLimitMeta));
    }
    if (data.containsKey('string_question_and_page_ids')) {
      context.handle(
          _stringQuestionAndPageIdsMeta,
          stringQuestionAndPageIds.isAcceptableOrUnknown(
              data['string_question_and_page_ids']!,
              _stringQuestionAndPageIdsMeta));
    }
    if (data.containsKey('string_list_farmers')) {
      context.handle(
          _stringListFarmersMeta,
          stringListFarmers.isAcceptableOrUnknown(
              data['string_list_farmers']!, _stringListFarmersMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Report map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Report(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      isPage: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_page']),
      pageId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page_id']),
      surveyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}survey_id']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active']),
      hasConditionalQuestions: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}has_conditional_questions']),
      questionsSelection: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}questions_selection']),
      timeLimit: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}time_limit']),
      stringQuestionAndPageIds: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}string_question_and_page_ids']),
      stringListFarmers: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}string_list_farmers']),
    );
  }

  @override
  $ReportTableTable createAlias(String alias) {
    return $ReportTableTable(attachedDatabase, alias);
  }
}

class ReportTableCompanion extends UpdateCompanion<Report> {
  final Value<int?> id;
  final Value<bool?> isPage;
  final Value<int?> pageId;
  final Value<int?> surveyId;
  final Value<String?> title;
  final Value<int?> userId;
  final Value<bool?> active;
  final Value<bool?> hasConditionalQuestions;
  final Value<String?> questionsSelection;
  final Value<double?> timeLimit;
  final Value<String?> stringQuestionAndPageIds;
  final Value<String?> stringListFarmers;
  const ReportTableCompanion({
    this.id = const Value.absent(),
    this.isPage = const Value.absent(),
    this.pageId = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.title = const Value.absent(),
    this.userId = const Value.absent(),
    this.active = const Value.absent(),
    this.hasConditionalQuestions = const Value.absent(),
    this.questionsSelection = const Value.absent(),
    this.timeLimit = const Value.absent(),
    this.stringQuestionAndPageIds = const Value.absent(),
    this.stringListFarmers = const Value.absent(),
  });
  ReportTableCompanion.insert({
    this.id = const Value.absent(),
    this.isPage = const Value.absent(),
    this.pageId = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.title = const Value.absent(),
    this.userId = const Value.absent(),
    this.active = const Value.absent(),
    this.hasConditionalQuestions = const Value.absent(),
    this.questionsSelection = const Value.absent(),
    this.timeLimit = const Value.absent(),
    this.stringQuestionAndPageIds = const Value.absent(),
    this.stringListFarmers = const Value.absent(),
  });
  static Insertable<Report> custom({
    Expression<int>? id,
    Expression<bool>? isPage,
    Expression<int>? pageId,
    Expression<int>? surveyId,
    Expression<String>? title,
    Expression<int>? userId,
    Expression<bool>? active,
    Expression<bool>? hasConditionalQuestions,
    Expression<String>? questionsSelection,
    Expression<double>? timeLimit,
    Expression<String>? stringQuestionAndPageIds,
    Expression<String>? stringListFarmers,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isPage != null) 'is_page': isPage,
      if (pageId != null) 'page_id': pageId,
      if (surveyId != null) 'survey_id': surveyId,
      if (title != null) 'title': title,
      if (userId != null) 'user_id': userId,
      if (active != null) 'active': active,
      if (hasConditionalQuestions != null)
        'has_conditional_questions': hasConditionalQuestions,
      if (questionsSelection != null) 'questions_selection': questionsSelection,
      if (timeLimit != null) 'time_limit': timeLimit,
      if (stringQuestionAndPageIds != null)
        'string_question_and_page_ids': stringQuestionAndPageIds,
      if (stringListFarmers != null) 'string_list_farmers': stringListFarmers,
    });
  }

  ReportTableCompanion copyWith(
      {Value<int?>? id,
      Value<bool?>? isPage,
      Value<int?>? pageId,
      Value<int?>? surveyId,
      Value<String?>? title,
      Value<int?>? userId,
      Value<bool?>? active,
      Value<bool?>? hasConditionalQuestions,
      Value<String?>? questionsSelection,
      Value<double?>? timeLimit,
      Value<String?>? stringQuestionAndPageIds,
      Value<String?>? stringListFarmers}) {
    return ReportTableCompanion(
      id: id ?? this.id,
      isPage: isPage ?? this.isPage,
      pageId: pageId ?? this.pageId,
      surveyId: surveyId ?? this.surveyId,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      active: active ?? this.active,
      hasConditionalQuestions:
          hasConditionalQuestions ?? this.hasConditionalQuestions,
      questionsSelection: questionsSelection ?? this.questionsSelection,
      timeLimit: timeLimit ?? this.timeLimit,
      stringQuestionAndPageIds:
          stringQuestionAndPageIds ?? this.stringQuestionAndPageIds,
      stringListFarmers: stringListFarmers ?? this.stringListFarmers,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (isPage.present) {
      map['is_page'] = Variable<bool>(isPage.value);
    }
    if (pageId.present) {
      map['page_id'] = Variable<int>(pageId.value);
    }
    if (surveyId.present) {
      map['survey_id'] = Variable<int>(surveyId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (hasConditionalQuestions.present) {
      map['has_conditional_questions'] =
          Variable<bool>(hasConditionalQuestions.value);
    }
    if (questionsSelection.present) {
      map['questions_selection'] = Variable<String>(questionsSelection.value);
    }
    if (timeLimit.present) {
      map['time_limit'] = Variable<double>(timeLimit.value);
    }
    if (stringQuestionAndPageIds.present) {
      map['string_question_and_page_ids'] =
          Variable<String>(stringQuestionAndPageIds.value);
    }
    if (stringListFarmers.present) {
      map['string_list_farmers'] = Variable<String>(stringListFarmers.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReportTableCompanion(')
          ..write('id: $id, ')
          ..write('isPage: $isPage, ')
          ..write('pageId: $pageId, ')
          ..write('surveyId: $surveyId, ')
          ..write('title: $title, ')
          ..write('userId: $userId, ')
          ..write('active: $active, ')
          ..write('hasConditionalQuestions: $hasConditionalQuestions, ')
          ..write('questionsSelection: $questionsSelection, ')
          ..write('timeLimit: $timeLimit, ')
          ..write('stringQuestionAndPageIds: $stringQuestionAndPageIds, ')
          ..write('stringListFarmers: $stringListFarmers')
          ..write(')'))
        .toString();
  }
}

class $QuestionUploadNoNetworkTableTable extends QuestionUploadNoNetworkTable
    with TableInfo<$QuestionUploadNoNetworkTableTable, QuestionUpload> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionUploadNoNetworkTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _apiMeta = const VerificationMeta('api');
  @override
  late final GeneratedColumn<String> api = GeneratedColumn<String>(
      'api', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _idOfflineMeta =
      const VerificationMeta('idOffline');
  @override
  late final GeneratedColumn<String> idOffline = GeneratedColumn<String>(
      'id_offline', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _userInputIdMeta =
      const VerificationMeta('userInputId');
  @override
  late final GeneratedColumn<int> userInputId = GeneratedColumn<int>(
      'user_input_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _surveyIdMeta =
      const VerificationMeta('surveyId');
  @override
  late final GeneratedColumn<int> surveyId = GeneratedColumn<int>(
      'survey_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _questionIdMeta =
      const VerificationMeta('questionId');
  @override
  late final GeneratedColumn<int> questionId = GeneratedColumn<int>(
      'question_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _suggestedAnswerIdMeta =
      const VerificationMeta('suggestedAnswerId');
  @override
  late final GeneratedColumn<int> suggestedAnswerId = GeneratedColumn<int>(
      'suggested_answer_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _matrixRowIdMeta =
      const VerificationMeta('matrixRowId');
  @override
  late final GeneratedColumn<int> matrixRowId = GeneratedColumn<int>(
      'matrix_row_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _answerTypeMeta =
      const VerificationMeta('answerType');
  @override
  late final GeneratedColumn<String> answerType = GeneratedColumn<String>(
      'answer_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _valueTextMeta =
      const VerificationMeta('valueText');
  @override
  late final GeneratedColumn<String> valueText = GeneratedColumn<String>(
      'value_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
      'state', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _skippedMeta =
      const VerificationMeta('skipped');
  @override
  late final GeneratedColumn<bool> skipped = GeneratedColumn<bool>(
      'skipped', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("skipped" IN (0, 1))'));
  static const VerificationMeta _isAnswerExistMeta =
      const VerificationMeta('isAnswerExist');
  @override
  late final GeneratedColumn<bool> isAnswerExist = GeneratedColumn<bool>(
      'is_answer_exist', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_answer_exist" IN (0, 1))'));
  static const VerificationMeta _valueCheckBoxMeta =
      const VerificationMeta('valueCheckBox');
  @override
  late final GeneratedColumn<bool> valueCheckBox = GeneratedColumn<bool>(
      'value_check_box', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("value_check_box" IN (0, 1))'));
  static const VerificationMeta _tableRowIdMeta =
      const VerificationMeta('tableRowId');
  @override
  late final GeneratedColumn<int> tableRowId = GeneratedColumn<int>(
      'table_row_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _stringListIdSuggestedMeta =
      const VerificationMeta('stringListIdSuggested');
  @override
  late final GeneratedColumn<String> stringListIdSuggested =
      GeneratedColumn<String>('string_list_id_suggested', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _farmerIdMeta =
      const VerificationMeta('farmerId');
  @override
  late final GeneratedColumn<int> farmerId = GeneratedColumn<int>(
      'farmer_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _farmerCodeMeta =
      const VerificationMeta('farmerCode');
  @override
  late final GeneratedColumn<String> farmerCode = GeneratedColumn<String>(
      'farmer_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _farmIdMeta = const VerificationMeta('farmId');
  @override
  late final GeneratedColumn<int> farmId = GeneratedColumn<int>(
      'farm_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _farmCodeMeta =
      const VerificationMeta('farmCode');
  @override
  late final GeneratedColumn<String> farmCode = GeneratedColumn<String>(
      'farm_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _internalInspectorIdMeta =
      const VerificationMeta('internalInspectorId');
  @override
  late final GeneratedColumn<int> internalInspectorId = GeneratedColumn<int>(
      'internal_inspector_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _monitoringVisitTypeMeta =
      const VerificationMeta('monitoringVisitType');
  @override
  late final GeneratedColumn<String> monitoringVisitType =
      GeneratedColumn<String>('monitoring_visit_type', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _visitDateMeta =
      const VerificationMeta('visitDate');
  @override
  late final GeneratedColumn<String> visitDate = GeneratedColumn<String>(
      'visit_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        api,
        idOffline,
        userInputId,
        surveyId,
        questionId,
        suggestedAnswerId,
        matrixRowId,
        answerType,
        valueText,
        state,
        skipped,
        isAnswerExist,
        valueCheckBox,
        tableRowId,
        stringListIdSuggested,
        farmerId,
        farmerCode,
        farmId,
        farmCode,
        internalInspectorId,
        monitoringVisitType,
        visitDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_upload_no_network';
  @override
  VerificationContext validateIntegrity(Insertable<QuestionUpload> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('api')) {
      context.handle(
          _apiMeta, api.isAcceptableOrUnknown(data['api']!, _apiMeta));
    }
    if (data.containsKey('id_offline')) {
      context.handle(_idOfflineMeta,
          idOffline.isAcceptableOrUnknown(data['id_offline']!, _idOfflineMeta));
    }
    if (data.containsKey('user_input_id')) {
      context.handle(
          _userInputIdMeta,
          userInputId.isAcceptableOrUnknown(
              data['user_input_id']!, _userInputIdMeta));
    }
    if (data.containsKey('survey_id')) {
      context.handle(_surveyIdMeta,
          surveyId.isAcceptableOrUnknown(data['survey_id']!, _surveyIdMeta));
    }
    if (data.containsKey('question_id')) {
      context.handle(
          _questionIdMeta,
          questionId.isAcceptableOrUnknown(
              data['question_id']!, _questionIdMeta));
    }
    if (data.containsKey('suggested_answer_id')) {
      context.handle(
          _suggestedAnswerIdMeta,
          suggestedAnswerId.isAcceptableOrUnknown(
              data['suggested_answer_id']!, _suggestedAnswerIdMeta));
    }
    if (data.containsKey('matrix_row_id')) {
      context.handle(
          _matrixRowIdMeta,
          matrixRowId.isAcceptableOrUnknown(
              data['matrix_row_id']!, _matrixRowIdMeta));
    }
    if (data.containsKey('answer_type')) {
      context.handle(
          _answerTypeMeta,
          answerType.isAcceptableOrUnknown(
              data['answer_type']!, _answerTypeMeta));
    }
    if (data.containsKey('value_text')) {
      context.handle(_valueTextMeta,
          valueText.isAcceptableOrUnknown(data['value_text']!, _valueTextMeta));
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    }
    if (data.containsKey('skipped')) {
      context.handle(_skippedMeta,
          skipped.isAcceptableOrUnknown(data['skipped']!, _skippedMeta));
    }
    if (data.containsKey('is_answer_exist')) {
      context.handle(
          _isAnswerExistMeta,
          isAnswerExist.isAcceptableOrUnknown(
              data['is_answer_exist']!, _isAnswerExistMeta));
    }
    if (data.containsKey('value_check_box')) {
      context.handle(
          _valueCheckBoxMeta,
          valueCheckBox.isAcceptableOrUnknown(
              data['value_check_box']!, _valueCheckBoxMeta));
    }
    if (data.containsKey('table_row_id')) {
      context.handle(
          _tableRowIdMeta,
          tableRowId.isAcceptableOrUnknown(
              data['table_row_id']!, _tableRowIdMeta));
    }
    if (data.containsKey('string_list_id_suggested')) {
      context.handle(
          _stringListIdSuggestedMeta,
          stringListIdSuggested.isAcceptableOrUnknown(
              data['string_list_id_suggested']!, _stringListIdSuggestedMeta));
    }
    if (data.containsKey('farmer_id')) {
      context.handle(_farmerIdMeta,
          farmerId.isAcceptableOrUnknown(data['farmer_id']!, _farmerIdMeta));
    }
    if (data.containsKey('farmer_code')) {
      context.handle(
          _farmerCodeMeta,
          farmerCode.isAcceptableOrUnknown(
              data['farmer_code']!, _farmerCodeMeta));
    }
    if (data.containsKey('farm_id')) {
      context.handle(_farmIdMeta,
          farmId.isAcceptableOrUnknown(data['farm_id']!, _farmIdMeta));
    }
    if (data.containsKey('farm_code')) {
      context.handle(_farmCodeMeta,
          farmCode.isAcceptableOrUnknown(data['farm_code']!, _farmCodeMeta));
    }
    if (data.containsKey('internal_inspector_id')) {
      context.handle(
          _internalInspectorIdMeta,
          internalInspectorId.isAcceptableOrUnknown(
              data['internal_inspector_id']!, _internalInspectorIdMeta));
    }
    if (data.containsKey('monitoring_visit_type')) {
      context.handle(
          _monitoringVisitTypeMeta,
          monitoringVisitType.isAcceptableOrUnknown(
              data['monitoring_visit_type']!, _monitoringVisitTypeMeta));
    }
    if (data.containsKey('visit_date')) {
      context.handle(_visitDateMeta,
          visitDate.isAcceptableOrUnknown(data['visit_date']!, _visitDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey =>
      {idOffline, questionId, suggestedAnswerId, tableRowId};
  @override
  QuestionUpload map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionUpload(
      api: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}api']),
      idOffline: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id_offline']),
      userInputId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_input_id']),
      surveyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}survey_id']),
      questionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}question_id']),
      suggestedAnswerId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}suggested_answer_id']),
      matrixRowId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}matrix_row_id']),
      answerType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}answer_type']),
      valueText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value_text']),
      skipped: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}skipped']),
      state: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state']),
      isAnswerExist: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_answer_exist']),
      valueCheckBox: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}value_check_box']),
      tableRowId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}table_row_id']),
      stringListIdSuggested: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}string_list_id_suggested']),
      farmerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}farmer_id']),
      farmerCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}farmer_code']),
      internalInspectorId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}internal_inspector_id']),
      monitoringVisitType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}monitoring_visit_type']),
      visitDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}visit_date']),
      farmId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}farm_id']),
      farmCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}farm_code']),
    );
  }

  @override
  $QuestionUploadNoNetworkTableTable createAlias(String alias) {
    return $QuestionUploadNoNetworkTableTable(attachedDatabase, alias);
  }
}

class QuestionUploadNoNetworkTableCompanion
    extends UpdateCompanion<QuestionUpload> {
  final Value<String?> api;
  final Value<String?> idOffline;
  final Value<int?> userInputId;
  final Value<int?> surveyId;
  final Value<int?> questionId;
  final Value<int?> suggestedAnswerId;
  final Value<int?> matrixRowId;
  final Value<String?> answerType;
  final Value<String?> valueText;
  final Value<String?> state;
  final Value<bool?> skipped;
  final Value<bool?> isAnswerExist;
  final Value<bool?> valueCheckBox;
  final Value<int?> tableRowId;
  final Value<String?> stringListIdSuggested;
  final Value<int?> farmerId;
  final Value<String?> farmerCode;
  final Value<int?> farmId;
  final Value<String?> farmCode;
  final Value<int?> internalInspectorId;
  final Value<String?> monitoringVisitType;
  final Value<String?> visitDate;
  final Value<int> rowid;
  const QuestionUploadNoNetworkTableCompanion({
    this.api = const Value.absent(),
    this.idOffline = const Value.absent(),
    this.userInputId = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.questionId = const Value.absent(),
    this.suggestedAnswerId = const Value.absent(),
    this.matrixRowId = const Value.absent(),
    this.answerType = const Value.absent(),
    this.valueText = const Value.absent(),
    this.state = const Value.absent(),
    this.skipped = const Value.absent(),
    this.isAnswerExist = const Value.absent(),
    this.valueCheckBox = const Value.absent(),
    this.tableRowId = const Value.absent(),
    this.stringListIdSuggested = const Value.absent(),
    this.farmerId = const Value.absent(),
    this.farmerCode = const Value.absent(),
    this.farmId = const Value.absent(),
    this.farmCode = const Value.absent(),
    this.internalInspectorId = const Value.absent(),
    this.monitoringVisitType = const Value.absent(),
    this.visitDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionUploadNoNetworkTableCompanion.insert({
    this.api = const Value.absent(),
    this.idOffline = const Value.absent(),
    this.userInputId = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.questionId = const Value.absent(),
    this.suggestedAnswerId = const Value.absent(),
    this.matrixRowId = const Value.absent(),
    this.answerType = const Value.absent(),
    this.valueText = const Value.absent(),
    this.state = const Value.absent(),
    this.skipped = const Value.absent(),
    this.isAnswerExist = const Value.absent(),
    this.valueCheckBox = const Value.absent(),
    this.tableRowId = const Value.absent(),
    this.stringListIdSuggested = const Value.absent(),
    this.farmerId = const Value.absent(),
    this.farmerCode = const Value.absent(),
    this.farmId = const Value.absent(),
    this.farmCode = const Value.absent(),
    this.internalInspectorId = const Value.absent(),
    this.monitoringVisitType = const Value.absent(),
    this.visitDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<QuestionUpload> custom({
    Expression<String>? api,
    Expression<String>? idOffline,
    Expression<int>? userInputId,
    Expression<int>? surveyId,
    Expression<int>? questionId,
    Expression<int>? suggestedAnswerId,
    Expression<int>? matrixRowId,
    Expression<String>? answerType,
    Expression<String>? valueText,
    Expression<String>? state,
    Expression<bool>? skipped,
    Expression<bool>? isAnswerExist,
    Expression<bool>? valueCheckBox,
    Expression<int>? tableRowId,
    Expression<String>? stringListIdSuggested,
    Expression<int>? farmerId,
    Expression<String>? farmerCode,
    Expression<int>? farmId,
    Expression<String>? farmCode,
    Expression<int>? internalInspectorId,
    Expression<String>? monitoringVisitType,
    Expression<String>? visitDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (api != null) 'api': api,
      if (idOffline != null) 'id_offline': idOffline,
      if (userInputId != null) 'user_input_id': userInputId,
      if (surveyId != null) 'survey_id': surveyId,
      if (questionId != null) 'question_id': questionId,
      if (suggestedAnswerId != null) 'suggested_answer_id': suggestedAnswerId,
      if (matrixRowId != null) 'matrix_row_id': matrixRowId,
      if (answerType != null) 'answer_type': answerType,
      if (valueText != null) 'value_text': valueText,
      if (state != null) 'state': state,
      if (skipped != null) 'skipped': skipped,
      if (isAnswerExist != null) 'is_answer_exist': isAnswerExist,
      if (valueCheckBox != null) 'value_check_box': valueCheckBox,
      if (tableRowId != null) 'table_row_id': tableRowId,
      if (stringListIdSuggested != null)
        'string_list_id_suggested': stringListIdSuggested,
      if (farmerId != null) 'farmer_id': farmerId,
      if (farmerCode != null) 'farmer_code': farmerCode,
      if (farmId != null) 'farm_id': farmId,
      if (farmCode != null) 'farm_code': farmCode,
      if (internalInspectorId != null)
        'internal_inspector_id': internalInspectorId,
      if (monitoringVisitType != null)
        'monitoring_visit_type': monitoringVisitType,
      if (visitDate != null) 'visit_date': visitDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionUploadNoNetworkTableCompanion copyWith(
      {Value<String?>? api,
      Value<String?>? idOffline,
      Value<int?>? userInputId,
      Value<int?>? surveyId,
      Value<int?>? questionId,
      Value<int?>? suggestedAnswerId,
      Value<int?>? matrixRowId,
      Value<String?>? answerType,
      Value<String?>? valueText,
      Value<String?>? state,
      Value<bool?>? skipped,
      Value<bool?>? isAnswerExist,
      Value<bool?>? valueCheckBox,
      Value<int?>? tableRowId,
      Value<String?>? stringListIdSuggested,
      Value<int?>? farmerId,
      Value<String?>? farmerCode,
      Value<int?>? farmId,
      Value<String?>? farmCode,
      Value<int?>? internalInspectorId,
      Value<String?>? monitoringVisitType,
      Value<String?>? visitDate,
      Value<int>? rowid}) {
    return QuestionUploadNoNetworkTableCompanion(
      api: api ?? this.api,
      idOffline: idOffline ?? this.idOffline,
      userInputId: userInputId ?? this.userInputId,
      surveyId: surveyId ?? this.surveyId,
      questionId: questionId ?? this.questionId,
      suggestedAnswerId: suggestedAnswerId ?? this.suggestedAnswerId,
      matrixRowId: matrixRowId ?? this.matrixRowId,
      answerType: answerType ?? this.answerType,
      valueText: valueText ?? this.valueText,
      state: state ?? this.state,
      skipped: skipped ?? this.skipped,
      isAnswerExist: isAnswerExist ?? this.isAnswerExist,
      valueCheckBox: valueCheckBox ?? this.valueCheckBox,
      tableRowId: tableRowId ?? this.tableRowId,
      stringListIdSuggested:
          stringListIdSuggested ?? this.stringListIdSuggested,
      farmerId: farmerId ?? this.farmerId,
      farmerCode: farmerCode ?? this.farmerCode,
      farmId: farmId ?? this.farmId,
      farmCode: farmCode ?? this.farmCode,
      internalInspectorId: internalInspectorId ?? this.internalInspectorId,
      monitoringVisitType: monitoringVisitType ?? this.monitoringVisitType,
      visitDate: visitDate ?? this.visitDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (api.present) {
      map['api'] = Variable<String>(api.value);
    }
    if (idOffline.present) {
      map['id_offline'] = Variable<String>(idOffline.value);
    }
    if (userInputId.present) {
      map['user_input_id'] = Variable<int>(userInputId.value);
    }
    if (surveyId.present) {
      map['survey_id'] = Variable<int>(surveyId.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<int>(questionId.value);
    }
    if (suggestedAnswerId.present) {
      map['suggested_answer_id'] = Variable<int>(suggestedAnswerId.value);
    }
    if (matrixRowId.present) {
      map['matrix_row_id'] = Variable<int>(matrixRowId.value);
    }
    if (answerType.present) {
      map['answer_type'] = Variable<String>(answerType.value);
    }
    if (valueText.present) {
      map['value_text'] = Variable<String>(valueText.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (skipped.present) {
      map['skipped'] = Variable<bool>(skipped.value);
    }
    if (isAnswerExist.present) {
      map['is_answer_exist'] = Variable<bool>(isAnswerExist.value);
    }
    if (valueCheckBox.present) {
      map['value_check_box'] = Variable<bool>(valueCheckBox.value);
    }
    if (tableRowId.present) {
      map['table_row_id'] = Variable<int>(tableRowId.value);
    }
    if (stringListIdSuggested.present) {
      map['string_list_id_suggested'] =
          Variable<String>(stringListIdSuggested.value);
    }
    if (farmerId.present) {
      map['farmer_id'] = Variable<int>(farmerId.value);
    }
    if (farmerCode.present) {
      map['farmer_code'] = Variable<String>(farmerCode.value);
    }
    if (farmId.present) {
      map['farm_id'] = Variable<int>(farmId.value);
    }
    if (farmCode.present) {
      map['farm_code'] = Variable<String>(farmCode.value);
    }
    if (internalInspectorId.present) {
      map['internal_inspector_id'] = Variable<int>(internalInspectorId.value);
    }
    if (monitoringVisitType.present) {
      map['monitoring_visit_type'] =
          Variable<String>(monitoringVisitType.value);
    }
    if (visitDate.present) {
      map['visit_date'] = Variable<String>(visitDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionUploadNoNetworkTableCompanion(')
          ..write('api: $api, ')
          ..write('idOffline: $idOffline, ')
          ..write('userInputId: $userInputId, ')
          ..write('surveyId: $surveyId, ')
          ..write('questionId: $questionId, ')
          ..write('suggestedAnswerId: $suggestedAnswerId, ')
          ..write('matrixRowId: $matrixRowId, ')
          ..write('answerType: $answerType, ')
          ..write('valueText: $valueText, ')
          ..write('state: $state, ')
          ..write('skipped: $skipped, ')
          ..write('isAnswerExist: $isAnswerExist, ')
          ..write('valueCheckBox: $valueCheckBox, ')
          ..write('tableRowId: $tableRowId, ')
          ..write('stringListIdSuggested: $stringListIdSuggested, ')
          ..write('farmerId: $farmerId, ')
          ..write('farmerCode: $farmerCode, ')
          ..write('farmId: $farmId, ')
          ..write('farmCode: $farmCode, ')
          ..write('internalInspectorId: $internalInspectorId, ')
          ..write('monitoringVisitType: $monitoringVisitType, ')
          ..write('visitDate: $visitDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FarmerInspectorUploadNoNetworkTableTable
    extends FarmerInspectorUploadNoNetworkTable
    with
        TableInfo<$FarmerInspectorUploadNoNetworkTableTable,
            FarmerInspectorUpload> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FarmerInspectorUploadNoNetworkTableTable(this.attachedDatabase,
      [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _apiMeta = const VerificationMeta('api');
  @override
  late final GeneratedColumn<String> api = GeneratedColumn<String>(
      'api', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _idOfflineMeta =
      const VerificationMeta('idOffline');
  @override
  late final GeneratedColumn<String> idOffline = GeneratedColumn<String>(
      'id_offline', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
      'state', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _farmerIdMeta =
      const VerificationMeta('farmerId');
  @override
  late final GeneratedColumn<int> farmerId = GeneratedColumn<int>(
      'farmer_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _farmerCodeMeta =
      const VerificationMeta('farmerCode');
  @override
  late final GeneratedColumn<String> farmerCode = GeneratedColumn<String>(
      'farmer_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _farmIdMeta = const VerificationMeta('farmId');
  @override
  late final GeneratedColumn<int> farmId = GeneratedColumn<int>(
      'farm_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _farmCodeMeta =
      const VerificationMeta('farmCode');
  @override
  late final GeneratedColumn<String> farmCode = GeneratedColumn<String>(
      'farm_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _internalInspectorIdMeta =
      const VerificationMeta('internalInspectorId');
  @override
  late final GeneratedColumn<int> internalInspectorId = GeneratedColumn<int>(
      'internal_inspector_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _monitoringVisitTypeMeta =
      const VerificationMeta('monitoringVisitType');
  @override
  late final GeneratedColumn<String> monitoringVisitType =
      GeneratedColumn<String>('monitoring_visit_type', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _visitDateMeta =
      const VerificationMeta('visitDate');
  @override
  late final GeneratedColumn<String> visitDate = GeneratedColumn<String>(
      'visit_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        api,
        idOffline,
        state,
        farmerId,
        farmerCode,
        farmId,
        farmCode,
        internalInspectorId,
        monitoringVisitType,
        visitDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'farmer_inspector_upload_no_network';
  @override
  VerificationContext validateIntegrity(
      Insertable<FarmerInspectorUpload> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('api')) {
      context.handle(
          _apiMeta, api.isAcceptableOrUnknown(data['api']!, _apiMeta));
    }
    if (data.containsKey('id_offline')) {
      context.handle(_idOfflineMeta,
          idOffline.isAcceptableOrUnknown(data['id_offline']!, _idOfflineMeta));
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    }
    if (data.containsKey('farmer_id')) {
      context.handle(_farmerIdMeta,
          farmerId.isAcceptableOrUnknown(data['farmer_id']!, _farmerIdMeta));
    }
    if (data.containsKey('farmer_code')) {
      context.handle(
          _farmerCodeMeta,
          farmerCode.isAcceptableOrUnknown(
              data['farmer_code']!, _farmerCodeMeta));
    }
    if (data.containsKey('farm_id')) {
      context.handle(_farmIdMeta,
          farmId.isAcceptableOrUnknown(data['farm_id']!, _farmIdMeta));
    }
    if (data.containsKey('farm_code')) {
      context.handle(_farmCodeMeta,
          farmCode.isAcceptableOrUnknown(data['farm_code']!, _farmCodeMeta));
    }
    if (data.containsKey('internal_inspector_id')) {
      context.handle(
          _internalInspectorIdMeta,
          internalInspectorId.isAcceptableOrUnknown(
              data['internal_inspector_id']!, _internalInspectorIdMeta));
    }
    if (data.containsKey('monitoring_visit_type')) {
      context.handle(
          _monitoringVisitTypeMeta,
          monitoringVisitType.isAcceptableOrUnknown(
              data['monitoring_visit_type']!, _monitoringVisitTypeMeta));
    }
    if (data.containsKey('visit_date')) {
      context.handle(_visitDateMeta,
          visitDate.isAcceptableOrUnknown(data['visit_date']!, _visitDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idOffline};
  @override
  FarmerInspectorUpload map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FarmerInspectorUpload(
      api: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}api']),
      idOffline: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id_offline']),
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      farmerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}farmer_id']),
      farmerCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}farmer_code']),
      farmId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}farm_id']),
      farmCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}farm_code']),
      internalInspectorId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}internal_inspector_id']),
      monitoringVisitType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}monitoring_visit_type']),
      visitDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}visit_date']),
      state: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state']),
    );
  }

  @override
  $FarmerInspectorUploadNoNetworkTableTable createAlias(String alias) {
    return $FarmerInspectorUploadNoNetworkTableTable(attachedDatabase, alias);
  }
}

class FarmerInspectorUploadNoNetworkTableCompanion
    extends UpdateCompanion<FarmerInspectorUpload> {
  final Value<int?> id;
  final Value<String?> api;
  final Value<String?> idOffline;
  final Value<String?> state;
  final Value<int?> farmerId;
  final Value<String?> farmerCode;
  final Value<int?> farmId;
  final Value<String?> farmCode;
  final Value<int?> internalInspectorId;
  final Value<String?> monitoringVisitType;
  final Value<String?> visitDate;
  final Value<int> rowid;
  const FarmerInspectorUploadNoNetworkTableCompanion({
    this.id = const Value.absent(),
    this.api = const Value.absent(),
    this.idOffline = const Value.absent(),
    this.state = const Value.absent(),
    this.farmerId = const Value.absent(),
    this.farmerCode = const Value.absent(),
    this.farmId = const Value.absent(),
    this.farmCode = const Value.absent(),
    this.internalInspectorId = const Value.absent(),
    this.monitoringVisitType = const Value.absent(),
    this.visitDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FarmerInspectorUploadNoNetworkTableCompanion.insert({
    this.id = const Value.absent(),
    this.api = const Value.absent(),
    this.idOffline = const Value.absent(),
    this.state = const Value.absent(),
    this.farmerId = const Value.absent(),
    this.farmerCode = const Value.absent(),
    this.farmId = const Value.absent(),
    this.farmCode = const Value.absent(),
    this.internalInspectorId = const Value.absent(),
    this.monitoringVisitType = const Value.absent(),
    this.visitDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<FarmerInspectorUpload> custom({
    Expression<int>? id,
    Expression<String>? api,
    Expression<String>? idOffline,
    Expression<String>? state,
    Expression<int>? farmerId,
    Expression<String>? farmerCode,
    Expression<int>? farmId,
    Expression<String>? farmCode,
    Expression<int>? internalInspectorId,
    Expression<String>? monitoringVisitType,
    Expression<String>? visitDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (api != null) 'api': api,
      if (idOffline != null) 'id_offline': idOffline,
      if (state != null) 'state': state,
      if (farmerId != null) 'farmer_id': farmerId,
      if (farmerCode != null) 'farmer_code': farmerCode,
      if (farmId != null) 'farm_id': farmId,
      if (farmCode != null) 'farm_code': farmCode,
      if (internalInspectorId != null)
        'internal_inspector_id': internalInspectorId,
      if (monitoringVisitType != null)
        'monitoring_visit_type': monitoringVisitType,
      if (visitDate != null) 'visit_date': visitDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FarmerInspectorUploadNoNetworkTableCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? api,
      Value<String?>? idOffline,
      Value<String?>? state,
      Value<int?>? farmerId,
      Value<String?>? farmerCode,
      Value<int?>? farmId,
      Value<String?>? farmCode,
      Value<int?>? internalInspectorId,
      Value<String?>? monitoringVisitType,
      Value<String?>? visitDate,
      Value<int>? rowid}) {
    return FarmerInspectorUploadNoNetworkTableCompanion(
      id: id ?? this.id,
      api: api ?? this.api,
      idOffline: idOffline ?? this.idOffline,
      state: state ?? this.state,
      farmerId: farmerId ?? this.farmerId,
      farmerCode: farmerCode ?? this.farmerCode,
      farmId: farmId ?? this.farmId,
      farmCode: farmCode ?? this.farmCode,
      internalInspectorId: internalInspectorId ?? this.internalInspectorId,
      monitoringVisitType: monitoringVisitType ?? this.monitoringVisitType,
      visitDate: visitDate ?? this.visitDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (api.present) {
      map['api'] = Variable<String>(api.value);
    }
    if (idOffline.present) {
      map['id_offline'] = Variable<String>(idOffline.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (farmerId.present) {
      map['farmer_id'] = Variable<int>(farmerId.value);
    }
    if (farmerCode.present) {
      map['farmer_code'] = Variable<String>(farmerCode.value);
    }
    if (farmId.present) {
      map['farm_id'] = Variable<int>(farmId.value);
    }
    if (farmCode.present) {
      map['farm_code'] = Variable<String>(farmCode.value);
    }
    if (internalInspectorId.present) {
      map['internal_inspector_id'] = Variable<int>(internalInspectorId.value);
    }
    if (monitoringVisitType.present) {
      map['monitoring_visit_type'] =
          Variable<String>(monitoringVisitType.value);
    }
    if (visitDate.present) {
      map['visit_date'] = Variable<String>(visitDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FarmerInspectorUploadNoNetworkTableCompanion(')
          ..write('id: $id, ')
          ..write('api: $api, ')
          ..write('idOffline: $idOffline, ')
          ..write('state: $state, ')
          ..write('farmerId: $farmerId, ')
          ..write('farmerCode: $farmerCode, ')
          ..write('farmId: $farmId, ')
          ..write('farmCode: $farmCode, ')
          ..write('internalInspectorId: $internalInspectorId, ')
          ..write('monitoringVisitType: $monitoringVisitType, ')
          ..write('visitDate: $visitDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReportSelectTableTable extends ReportSelectTable
    with TableInfo<$ReportSelectTableTable, ReportSelect> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReportSelectTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isInitialAssessmentMeta =
      const VerificationMeta('isInitialAssessment');
  @override
  late final GeneratedColumn<bool> isInitialAssessment = GeneratedColumn<bool>(
      'is_initial_assessment', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_initial_assessment" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [id, title, isInitialAssessment];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'report_select_table';
  @override
  VerificationContext validateIntegrity(Insertable<ReportSelect> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('is_initial_assessment')) {
      context.handle(
          _isInitialAssessmentMeta,
          isInitialAssessment.isAcceptableOrUnknown(
              data['is_initial_assessment']!, _isInitialAssessmentMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReportSelect map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReportSelect(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      isInitialAssessment: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_initial_assessment']),
    );
  }

  @override
  $ReportSelectTableTable createAlias(String alias) {
    return $ReportSelectTableTable(attachedDatabase, alias);
  }
}

class ReportSelectTableCompanion extends UpdateCompanion<ReportSelect> {
  final Value<int?> id;
  final Value<String?> title;
  final Value<bool?> isInitialAssessment;
  const ReportSelectTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.isInitialAssessment = const Value.absent(),
  });
  ReportSelectTableCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.isInitialAssessment = const Value.absent(),
  });
  static Insertable<ReportSelect> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<bool>? isInitialAssessment,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (isInitialAssessment != null)
        'is_initial_assessment': isInitialAssessment,
    });
  }

  ReportSelectTableCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? title,
      Value<bool?>? isInitialAssessment}) {
    return ReportSelectTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      isInitialAssessment: isInitialAssessment ?? this.isInitialAssessment,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (isInitialAssessment.present) {
      map['is_initial_assessment'] = Variable<bool>(isInitialAssessment.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReportSelectTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('isInitialAssessment: $isInitialAssessment')
          ..write(')'))
        .toString();
  }
}

class $ActivityPurchaseTableTable extends ActivityPurchaseTable
    with TableInfo<$ActivityPurchaseTableTable, ActivityPurchase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityPurchaseTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _seasonFarmIdMeta =
      const VerificationMeta('seasonFarmId');
  @override
  late final GeneratedColumn<int> seasonFarmId = GeneratedColumn<int>(
      'season_farm_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _seasonFarmNameMeta =
      const VerificationMeta('seasonFarmName');
  @override
  late final GeneratedColumn<String> seasonFarmName = GeneratedColumn<String>(
      'season_farm_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _transactionDateMeta =
      const VerificationMeta('transactionDate');
  @override
  late final GeneratedColumn<String> transactionDate = GeneratedColumn<String>(
      'transaction_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _quantityUnitIdMeta =
      const VerificationMeta('quantityUnitId');
  @override
  late final GeneratedColumn<int> quantityUnitId = GeneratedColumn<int>(
      'quantity_unit_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _quantityUnitNameMeta =
      const VerificationMeta('quantityUnitName');
  @override
  late final GeneratedColumn<String> quantityUnitName = GeneratedColumn<String>(
      'quantity_unit_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _productNameMeta =
      const VerificationMeta('productName');
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
      'product_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _unitPriceMeta =
      const VerificationMeta('unitPrice');
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
      'unit_price', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _isPurchaseMeta =
      const VerificationMeta('isPurchase');
  @override
  late final GeneratedColumn<bool> isPurchase = GeneratedColumn<bool>(
      'is_purchase', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_purchase" IN (0, 1))'));
  static const VerificationMeta _personMeta = const VerificationMeta('person');
  @override
  late final GeneratedColumn<String> person = GeneratedColumn<String>(
      'person', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuid,
        userId,
        seasonFarmId,
        seasonFarmName,
        transactionDate,
        quantity,
        quantityUnitId,
        quantityUnitName,
        productId,
        productName,
        unitPrice,
        isPurchase,
        person
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_purchase';
  @override
  VerificationContext validateIntegrity(Insertable<ActivityPurchase> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('season_farm_id')) {
      context.handle(
          _seasonFarmIdMeta,
          seasonFarmId.isAcceptableOrUnknown(
              data['season_farm_id']!, _seasonFarmIdMeta));
    }
    if (data.containsKey('season_farm_name')) {
      context.handle(
          _seasonFarmNameMeta,
          seasonFarmName.isAcceptableOrUnknown(
              data['season_farm_name']!, _seasonFarmNameMeta));
    }
    if (data.containsKey('transaction_date')) {
      context.handle(
          _transactionDateMeta,
          transactionDate.isAcceptableOrUnknown(
              data['transaction_date']!, _transactionDateMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('quantity_unit_id')) {
      context.handle(
          _quantityUnitIdMeta,
          quantityUnitId.isAcceptableOrUnknown(
              data['quantity_unit_id']!, _quantityUnitIdMeta));
    }
    if (data.containsKey('quantity_unit_name')) {
      context.handle(
          _quantityUnitNameMeta,
          quantityUnitName.isAcceptableOrUnknown(
              data['quantity_unit_name']!, _quantityUnitNameMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    }
    if (data.containsKey('product_name')) {
      context.handle(
          _productNameMeta,
          productName.isAcceptableOrUnknown(
              data['product_name']!, _productNameMeta));
    }
    if (data.containsKey('unit_price')) {
      context.handle(_unitPriceMeta,
          unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta));
    }
    if (data.containsKey('is_purchase')) {
      context.handle(
          _isPurchaseMeta,
          isPurchase.isAcceptableOrUnknown(
              data['is_purchase']!, _isPurchaseMeta));
    }
    if (data.containsKey('person')) {
      context.handle(_personMeta,
          person.isAcceptableOrUnknown(data['person']!, _personMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, userId, uuid};
  @override
  ActivityPurchase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityPurchase(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid']),
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      seasonFarmId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}season_farm_id']),
      seasonFarmName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}season_farm_name']),
      transactionDate: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}transaction_date']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity']),
      quantityUnitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity_unit_id']),
      quantityUnitName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}quantity_unit_name']),
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id']),
      unitPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}unit_price']),
      person: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}person']),
      productName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_name']),
      isPurchase: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_purchase']),
    );
  }

  @override
  $ActivityPurchaseTableTable createAlias(String alias) {
    return $ActivityPurchaseTableTable(attachedDatabase, alias);
  }
}

class ActivityPurchaseTableCompanion extends UpdateCompanion<ActivityPurchase> {
  final Value<int?> id;
  final Value<String?> uuid;
  final Value<int?> userId;
  final Value<int?> seasonFarmId;
  final Value<String?> seasonFarmName;
  final Value<String?> transactionDate;
  final Value<double?> quantity;
  final Value<int?> quantityUnitId;
  final Value<String?> quantityUnitName;
  final Value<int?> productId;
  final Value<String?> productName;
  final Value<double?> unitPrice;
  final Value<bool?> isPurchase;
  final Value<String?> person;
  final Value<int> rowid;
  const ActivityPurchaseTableCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.userId = const Value.absent(),
    this.seasonFarmId = const Value.absent(),
    this.seasonFarmName = const Value.absent(),
    this.transactionDate = const Value.absent(),
    this.quantity = const Value.absent(),
    this.quantityUnitId = const Value.absent(),
    this.quantityUnitName = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.isPurchase = const Value.absent(),
    this.person = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivityPurchaseTableCompanion.insert({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.userId = const Value.absent(),
    this.seasonFarmId = const Value.absent(),
    this.seasonFarmName = const Value.absent(),
    this.transactionDate = const Value.absent(),
    this.quantity = const Value.absent(),
    this.quantityUnitId = const Value.absent(),
    this.quantityUnitName = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.isPurchase = const Value.absent(),
    this.person = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<ActivityPurchase> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<int>? userId,
    Expression<int>? seasonFarmId,
    Expression<String>? seasonFarmName,
    Expression<String>? transactionDate,
    Expression<double>? quantity,
    Expression<int>? quantityUnitId,
    Expression<String>? quantityUnitName,
    Expression<int>? productId,
    Expression<String>? productName,
    Expression<double>? unitPrice,
    Expression<bool>? isPurchase,
    Expression<String>? person,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (userId != null) 'user_id': userId,
      if (seasonFarmId != null) 'season_farm_id': seasonFarmId,
      if (seasonFarmName != null) 'season_farm_name': seasonFarmName,
      if (transactionDate != null) 'transaction_date': transactionDate,
      if (quantity != null) 'quantity': quantity,
      if (quantityUnitId != null) 'quantity_unit_id': quantityUnitId,
      if (quantityUnitName != null) 'quantity_unit_name': quantityUnitName,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (isPurchase != null) 'is_purchase': isPurchase,
      if (person != null) 'person': person,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivityPurchaseTableCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? uuid,
      Value<int?>? userId,
      Value<int?>? seasonFarmId,
      Value<String?>? seasonFarmName,
      Value<String?>? transactionDate,
      Value<double?>? quantity,
      Value<int?>? quantityUnitId,
      Value<String?>? quantityUnitName,
      Value<int?>? productId,
      Value<String?>? productName,
      Value<double?>? unitPrice,
      Value<bool?>? isPurchase,
      Value<String?>? person,
      Value<int>? rowid}) {
    return ActivityPurchaseTableCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      seasonFarmId: seasonFarmId ?? this.seasonFarmId,
      seasonFarmName: seasonFarmName ?? this.seasonFarmName,
      transactionDate: transactionDate ?? this.transactionDate,
      quantity: quantity ?? this.quantity,
      quantityUnitId: quantityUnitId ?? this.quantityUnitId,
      quantityUnitName: quantityUnitName ?? this.quantityUnitName,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      unitPrice: unitPrice ?? this.unitPrice,
      isPurchase: isPurchase ?? this.isPurchase,
      person: person ?? this.person,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (seasonFarmId.present) {
      map['season_farm_id'] = Variable<int>(seasonFarmId.value);
    }
    if (seasonFarmName.present) {
      map['season_farm_name'] = Variable<String>(seasonFarmName.value);
    }
    if (transactionDate.present) {
      map['transaction_date'] = Variable<String>(transactionDate.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (quantityUnitId.present) {
      map['quantity_unit_id'] = Variable<int>(quantityUnitId.value);
    }
    if (quantityUnitName.present) {
      map['quantity_unit_name'] = Variable<String>(quantityUnitName.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (isPurchase.present) {
      map['is_purchase'] = Variable<bool>(isPurchase.value);
    }
    if (person.present) {
      map['person'] = Variable<String>(person.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityPurchaseTableCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('userId: $userId, ')
          ..write('seasonFarmId: $seasonFarmId, ')
          ..write('seasonFarmName: $seasonFarmName, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('quantity: $quantity, ')
          ..write('quantityUnitId: $quantityUnitId, ')
          ..write('quantityUnitName: $quantityUnitName, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('isPurchase: $isPurchase, ')
          ..write('person: $person, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActivityTransactionTableTable extends ActivityTransactionTable
    with TableInfo<$ActivityTransactionTableTable, ActivityTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityTransactionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _seasonFarmIdMeta =
      const VerificationMeta('seasonFarmId');
  @override
  late final GeneratedColumn<int> seasonFarmId = GeneratedColumn<int>(
      'season_farm_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _seasonFarmNameMeta =
      const VerificationMeta('seasonFarmName');
  @override
  late final GeneratedColumn<String> seasonFarmName = GeneratedColumn<String>(
      'season_farm_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _transactionDateMeta =
      const VerificationMeta('transactionDate');
  @override
  late final GeneratedColumn<String> transactionDate = GeneratedColumn<String>(
      'transaction_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _quantityUnitIdMeta =
      const VerificationMeta('quantityUnitId');
  @override
  late final GeneratedColumn<int> quantityUnitId = GeneratedColumn<int>(
      'quantity_unit_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _quantityUnitNameMeta =
      const VerificationMeta('quantityUnitName');
  @override
  late final GeneratedColumn<String> quantityUnitName = GeneratedColumn<String>(
      'quantity_unit_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _productNameMeta =
      const VerificationMeta('productName');
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
      'product_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _unitPriceMeta =
      const VerificationMeta('unitPrice');
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
      'unit_price', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _isPurchaseMeta =
      const VerificationMeta('isPurchase');
  @override
  late final GeneratedColumn<bool> isPurchase = GeneratedColumn<bool>(
      'is_purchase', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_purchase" IN (0, 1))'));
  static const VerificationMeta _personMeta = const VerificationMeta('person');
  @override
  late final GeneratedColumn<String> person = GeneratedColumn<String>(
      'person', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuid,
        seasonFarmId,
        seasonFarmName,
        transactionDate,
        quantity,
        quantityUnitId,
        quantityUnitName,
        productId,
        productName,
        unitPrice,
        isPurchase,
        person
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_transaction';
  @override
  VerificationContext validateIntegrity(
      Insertable<ActivityTransaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    }
    if (data.containsKey('season_farm_id')) {
      context.handle(
          _seasonFarmIdMeta,
          seasonFarmId.isAcceptableOrUnknown(
              data['season_farm_id']!, _seasonFarmIdMeta));
    }
    if (data.containsKey('season_farm_name')) {
      context.handle(
          _seasonFarmNameMeta,
          seasonFarmName.isAcceptableOrUnknown(
              data['season_farm_name']!, _seasonFarmNameMeta));
    }
    if (data.containsKey('transaction_date')) {
      context.handle(
          _transactionDateMeta,
          transactionDate.isAcceptableOrUnknown(
              data['transaction_date']!, _transactionDateMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('quantity_unit_id')) {
      context.handle(
          _quantityUnitIdMeta,
          quantityUnitId.isAcceptableOrUnknown(
              data['quantity_unit_id']!, _quantityUnitIdMeta));
    }
    if (data.containsKey('quantity_unit_name')) {
      context.handle(
          _quantityUnitNameMeta,
          quantityUnitName.isAcceptableOrUnknown(
              data['quantity_unit_name']!, _quantityUnitNameMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    }
    if (data.containsKey('product_name')) {
      context.handle(
          _productNameMeta,
          productName.isAcceptableOrUnknown(
              data['product_name']!, _productNameMeta));
    }
    if (data.containsKey('unit_price')) {
      context.handle(_unitPriceMeta,
          unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta));
    }
    if (data.containsKey('is_purchase')) {
      context.handle(
          _isPurchaseMeta,
          isPurchase.isAcceptableOrUnknown(
              data['is_purchase']!, _isPurchaseMeta));
    }
    if (data.containsKey('person')) {
      context.handle(_personMeta,
          person.isAcceptableOrUnknown(data['person']!, _personMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, uuid};
  @override
  ActivityTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityTransaction(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid']),
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      seasonFarmId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}season_farm_id']),
      seasonFarmName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}season_farm_name']),
      transactionDate: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}transaction_date']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity']),
      quantityUnitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity_unit_id']),
      quantityUnitName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}quantity_unit_name']),
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id']),
      unitPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}unit_price']),
      person: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}person']),
      productName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_name']),
      isPurchase: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_purchase']),
    );
  }

  @override
  $ActivityTransactionTableTable createAlias(String alias) {
    return $ActivityTransactionTableTable(attachedDatabase, alias);
  }
}

class ActivityTransactionTableCompanion
    extends UpdateCompanion<ActivityTransaction> {
  final Value<int?> id;
  final Value<String?> uuid;
  final Value<int?> seasonFarmId;
  final Value<String?> seasonFarmName;
  final Value<String?> transactionDate;
  final Value<double?> quantity;
  final Value<int?> quantityUnitId;
  final Value<String?> quantityUnitName;
  final Value<int?> productId;
  final Value<String?> productName;
  final Value<double?> unitPrice;
  final Value<bool?> isPurchase;
  final Value<String?> person;
  final Value<int> rowid;
  const ActivityTransactionTableCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.seasonFarmId = const Value.absent(),
    this.seasonFarmName = const Value.absent(),
    this.transactionDate = const Value.absent(),
    this.quantity = const Value.absent(),
    this.quantityUnitId = const Value.absent(),
    this.quantityUnitName = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.isPurchase = const Value.absent(),
    this.person = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivityTransactionTableCompanion.insert({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.seasonFarmId = const Value.absent(),
    this.seasonFarmName = const Value.absent(),
    this.transactionDate = const Value.absent(),
    this.quantity = const Value.absent(),
    this.quantityUnitId = const Value.absent(),
    this.quantityUnitName = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.isPurchase = const Value.absent(),
    this.person = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<ActivityTransaction> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<int>? seasonFarmId,
    Expression<String>? seasonFarmName,
    Expression<String>? transactionDate,
    Expression<double>? quantity,
    Expression<int>? quantityUnitId,
    Expression<String>? quantityUnitName,
    Expression<int>? productId,
    Expression<String>? productName,
    Expression<double>? unitPrice,
    Expression<bool>? isPurchase,
    Expression<String>? person,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (seasonFarmId != null) 'season_farm_id': seasonFarmId,
      if (seasonFarmName != null) 'season_farm_name': seasonFarmName,
      if (transactionDate != null) 'transaction_date': transactionDate,
      if (quantity != null) 'quantity': quantity,
      if (quantityUnitId != null) 'quantity_unit_id': quantityUnitId,
      if (quantityUnitName != null) 'quantity_unit_name': quantityUnitName,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (isPurchase != null) 'is_purchase': isPurchase,
      if (person != null) 'person': person,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivityTransactionTableCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? uuid,
      Value<int?>? seasonFarmId,
      Value<String?>? seasonFarmName,
      Value<String?>? transactionDate,
      Value<double?>? quantity,
      Value<int?>? quantityUnitId,
      Value<String?>? quantityUnitName,
      Value<int?>? productId,
      Value<String?>? productName,
      Value<double?>? unitPrice,
      Value<bool?>? isPurchase,
      Value<String?>? person,
      Value<int>? rowid}) {
    return ActivityTransactionTableCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      seasonFarmId: seasonFarmId ?? this.seasonFarmId,
      seasonFarmName: seasonFarmName ?? this.seasonFarmName,
      transactionDate: transactionDate ?? this.transactionDate,
      quantity: quantity ?? this.quantity,
      quantityUnitId: quantityUnitId ?? this.quantityUnitId,
      quantityUnitName: quantityUnitName ?? this.quantityUnitName,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      unitPrice: unitPrice ?? this.unitPrice,
      isPurchase: isPurchase ?? this.isPurchase,
      person: person ?? this.person,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (seasonFarmId.present) {
      map['season_farm_id'] = Variable<int>(seasonFarmId.value);
    }
    if (seasonFarmName.present) {
      map['season_farm_name'] = Variable<String>(seasonFarmName.value);
    }
    if (transactionDate.present) {
      map['transaction_date'] = Variable<String>(transactionDate.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (quantityUnitId.present) {
      map['quantity_unit_id'] = Variable<int>(quantityUnitId.value);
    }
    if (quantityUnitName.present) {
      map['quantity_unit_name'] = Variable<String>(quantityUnitName.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (isPurchase.present) {
      map['is_purchase'] = Variable<bool>(isPurchase.value);
    }
    if (person.present) {
      map['person'] = Variable<String>(person.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityTransactionTableCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('seasonFarmId: $seasonFarmId, ')
          ..write('seasonFarmName: $seasonFarmName, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('quantity: $quantity, ')
          ..write('quantityUnitId: $quantityUnitId, ')
          ..write('quantityUnitName: $quantityUnitName, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('isPurchase: $isPurchase, ')
          ..write('person: $person, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActivityTransactionNoNetworkTableTable
    extends ActivityTransactionNoNetworkTable
    with
        TableInfo<$ActivityTransactionNoNetworkTableTable,
            ActivityTransactionNoNetwork> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityTransactionNoNetworkTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _apiMeta = const VerificationMeta('api');
  @override
  late final GeneratedColumn<String> api = GeneratedColumn<String>(
      'api', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  static const VerificationMeta _seasonFarmNameMeta =
      const VerificationMeta('seasonFarmName');
  @override
  late final GeneratedColumn<String> seasonFarmName = GeneratedColumn<String>(
      'season_farm_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _transactionDateMeta =
      const VerificationMeta('transactionDate');
  @override
  late final GeneratedColumn<String> transactionDate = GeneratedColumn<String>(
      'transaction_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _quantityUnitIdMeta =
      const VerificationMeta('quantityUnitId');
  @override
  late final GeneratedColumn<int> quantityUnitId = GeneratedColumn<int>(
      'quantity_unit_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _quantityUnitNameMeta =
      const VerificationMeta('quantityUnitName');
  @override
  late final GeneratedColumn<String> quantityUnitName = GeneratedColumn<String>(
      'quantity_unit_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _productNameMeta =
      const VerificationMeta('productName');
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
      'product_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _unitPriceMeta =
      const VerificationMeta('unitPrice');
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
      'unit_price', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _isPurchaseMeta =
      const VerificationMeta('isPurchase');
  @override
  late final GeneratedColumn<bool> isPurchase = GeneratedColumn<bool>(
      'is_purchase', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_purchase" IN (0, 1))'));
  static const VerificationMeta _personMeta = const VerificationMeta('person');
  @override
  late final GeneratedColumn<String> person = GeneratedColumn<String>(
      'person', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        api,
        uuid,
        id,
        seasonFarmId,
        seasonFarmName,
        transactionDate,
        quantity,
        quantityUnitId,
        quantityUnitName,
        productId,
        productName,
        unitPrice,
        isPurchase,
        person
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_transaction_no_network';
  @override
  VerificationContext validateIntegrity(
      Insertable<ActivityTransactionNoNetwork> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('api')) {
      context.handle(
          _apiMeta, api.isAcceptableOrUnknown(data['api']!, _apiMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('season_farm_id')) {
      context.handle(
          _seasonFarmIdMeta,
          seasonFarmId.isAcceptableOrUnknown(
              data['season_farm_id']!, _seasonFarmIdMeta));
    }
    if (data.containsKey('season_farm_name')) {
      context.handle(
          _seasonFarmNameMeta,
          seasonFarmName.isAcceptableOrUnknown(
              data['season_farm_name']!, _seasonFarmNameMeta));
    }
    if (data.containsKey('transaction_date')) {
      context.handle(
          _transactionDateMeta,
          transactionDate.isAcceptableOrUnknown(
              data['transaction_date']!, _transactionDateMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('quantity_unit_id')) {
      context.handle(
          _quantityUnitIdMeta,
          quantityUnitId.isAcceptableOrUnknown(
              data['quantity_unit_id']!, _quantityUnitIdMeta));
    }
    if (data.containsKey('quantity_unit_name')) {
      context.handle(
          _quantityUnitNameMeta,
          quantityUnitName.isAcceptableOrUnknown(
              data['quantity_unit_name']!, _quantityUnitNameMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    }
    if (data.containsKey('product_name')) {
      context.handle(
          _productNameMeta,
          productName.isAcceptableOrUnknown(
              data['product_name']!, _productNameMeta));
    }
    if (data.containsKey('unit_price')) {
      context.handle(_unitPriceMeta,
          unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta));
    }
    if (data.containsKey('is_purchase')) {
      context.handle(
          _isPurchaseMeta,
          isPurchase.isAcceptableOrUnknown(
              data['is_purchase']!, _isPurchaseMeta));
    }
    if (data.containsKey('person')) {
      context.handle(_personMeta,
          person.isAcceptableOrUnknown(data['person']!, _personMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, uuid};
  @override
  ActivityTransactionNoNetwork map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityTransactionNoNetwork(
      api: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}api']),
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid']),
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      seasonFarmId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}season_farm_id']),
      seasonFarmName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}season_farm_name']),
      transactionDate: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}transaction_date']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity']),
      quantityUnitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity_unit_id']),
      quantityUnitName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}quantity_unit_name']),
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id']),
      unitPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}unit_price']),
      person: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}person']),
      productName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_name']),
      isPurchase: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_purchase']),
    );
  }

  @override
  $ActivityTransactionNoNetworkTableTable createAlias(String alias) {
    return $ActivityTransactionNoNetworkTableTable(attachedDatabase, alias);
  }
}

class ActivityTransactionNoNetworkTableCompanion
    extends UpdateCompanion<ActivityTransactionNoNetwork> {
  final Value<String?> api;
  final Value<String?> uuid;
  final Value<int?> id;
  final Value<int?> seasonFarmId;
  final Value<String?> seasonFarmName;
  final Value<String?> transactionDate;
  final Value<double?> quantity;
  final Value<int?> quantityUnitId;
  final Value<String?> quantityUnitName;
  final Value<int?> productId;
  final Value<String?> productName;
  final Value<double?> unitPrice;
  final Value<bool?> isPurchase;
  final Value<String?> person;
  final Value<int> rowid;
  const ActivityTransactionNoNetworkTableCompanion({
    this.api = const Value.absent(),
    this.uuid = const Value.absent(),
    this.id = const Value.absent(),
    this.seasonFarmId = const Value.absent(),
    this.seasonFarmName = const Value.absent(),
    this.transactionDate = const Value.absent(),
    this.quantity = const Value.absent(),
    this.quantityUnitId = const Value.absent(),
    this.quantityUnitName = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.isPurchase = const Value.absent(),
    this.person = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivityTransactionNoNetworkTableCompanion.insert({
    this.api = const Value.absent(),
    this.uuid = const Value.absent(),
    this.id = const Value.absent(),
    this.seasonFarmId = const Value.absent(),
    this.seasonFarmName = const Value.absent(),
    this.transactionDate = const Value.absent(),
    this.quantity = const Value.absent(),
    this.quantityUnitId = const Value.absent(),
    this.quantityUnitName = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.isPurchase = const Value.absent(),
    this.person = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<ActivityTransactionNoNetwork> custom({
    Expression<String>? api,
    Expression<String>? uuid,
    Expression<int>? id,
    Expression<int>? seasonFarmId,
    Expression<String>? seasonFarmName,
    Expression<String>? transactionDate,
    Expression<double>? quantity,
    Expression<int>? quantityUnitId,
    Expression<String>? quantityUnitName,
    Expression<int>? productId,
    Expression<String>? productName,
    Expression<double>? unitPrice,
    Expression<bool>? isPurchase,
    Expression<String>? person,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (api != null) 'api': api,
      if (uuid != null) 'uuid': uuid,
      if (id != null) 'id': id,
      if (seasonFarmId != null) 'season_farm_id': seasonFarmId,
      if (seasonFarmName != null) 'season_farm_name': seasonFarmName,
      if (transactionDate != null) 'transaction_date': transactionDate,
      if (quantity != null) 'quantity': quantity,
      if (quantityUnitId != null) 'quantity_unit_id': quantityUnitId,
      if (quantityUnitName != null) 'quantity_unit_name': quantityUnitName,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (isPurchase != null) 'is_purchase': isPurchase,
      if (person != null) 'person': person,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivityTransactionNoNetworkTableCompanion copyWith(
      {Value<String?>? api,
      Value<String?>? uuid,
      Value<int?>? id,
      Value<int?>? seasonFarmId,
      Value<String?>? seasonFarmName,
      Value<String?>? transactionDate,
      Value<double?>? quantity,
      Value<int?>? quantityUnitId,
      Value<String?>? quantityUnitName,
      Value<int?>? productId,
      Value<String?>? productName,
      Value<double?>? unitPrice,
      Value<bool?>? isPurchase,
      Value<String?>? person,
      Value<int>? rowid}) {
    return ActivityTransactionNoNetworkTableCompanion(
      api: api ?? this.api,
      uuid: uuid ?? this.uuid,
      id: id ?? this.id,
      seasonFarmId: seasonFarmId ?? this.seasonFarmId,
      seasonFarmName: seasonFarmName ?? this.seasonFarmName,
      transactionDate: transactionDate ?? this.transactionDate,
      quantity: quantity ?? this.quantity,
      quantityUnitId: quantityUnitId ?? this.quantityUnitId,
      quantityUnitName: quantityUnitName ?? this.quantityUnitName,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      unitPrice: unitPrice ?? this.unitPrice,
      isPurchase: isPurchase ?? this.isPurchase,
      person: person ?? this.person,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (api.present) {
      map['api'] = Variable<String>(api.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (seasonFarmId.present) {
      map['season_farm_id'] = Variable<int>(seasonFarmId.value);
    }
    if (seasonFarmName.present) {
      map['season_farm_name'] = Variable<String>(seasonFarmName.value);
    }
    if (transactionDate.present) {
      map['transaction_date'] = Variable<String>(transactionDate.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (quantityUnitId.present) {
      map['quantity_unit_id'] = Variable<int>(quantityUnitId.value);
    }
    if (quantityUnitName.present) {
      map['quantity_unit_name'] = Variable<String>(quantityUnitName.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (isPurchase.present) {
      map['is_purchase'] = Variable<bool>(isPurchase.value);
    }
    if (person.present) {
      map['person'] = Variable<String>(person.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityTransactionNoNetworkTableCompanion(')
          ..write('api: $api, ')
          ..write('uuid: $uuid, ')
          ..write('id: $id, ')
          ..write('seasonFarmId: $seasonFarmId, ')
          ..write('seasonFarmName: $seasonFarmName, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('quantity: $quantity, ')
          ..write('quantityUnitId: $quantityUnitId, ')
          ..write('quantityUnitName: $quantityUnitName, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('isPurchase: $isPurchase, ')
          ..write('person: $person, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActivityPurchaseNoNetworkTableTable
    extends ActivityPurchaseNoNetworkTable
    with
        TableInfo<$ActivityPurchaseNoNetworkTableTable,
            ActivityPurchaseNoNetWork> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityPurchaseNoNetworkTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _apiMeta = const VerificationMeta('api');
  @override
  late final GeneratedColumn<String> api = GeneratedColumn<String>(
      'api', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  static const VerificationMeta _seasonFarmNameMeta =
      const VerificationMeta('seasonFarmName');
  @override
  late final GeneratedColumn<String> seasonFarmName = GeneratedColumn<String>(
      'season_farm_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _transactionDateMeta =
      const VerificationMeta('transactionDate');
  @override
  late final GeneratedColumn<String> transactionDate = GeneratedColumn<String>(
      'transaction_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _quantityUnitIdMeta =
      const VerificationMeta('quantityUnitId');
  @override
  late final GeneratedColumn<int> quantityUnitId = GeneratedColumn<int>(
      'quantity_unit_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _quantityUnitNameMeta =
      const VerificationMeta('quantityUnitName');
  @override
  late final GeneratedColumn<String> quantityUnitName = GeneratedColumn<String>(
      'quantity_unit_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _productNameMeta =
      const VerificationMeta('productName');
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
      'product_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _unitPriceMeta =
      const VerificationMeta('unitPrice');
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
      'unit_price', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _isPurchaseMeta =
      const VerificationMeta('isPurchase');
  @override
  late final GeneratedColumn<bool> isPurchase = GeneratedColumn<bool>(
      'is_purchase', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_purchase" IN (0, 1))'));
  static const VerificationMeta _personMeta = const VerificationMeta('person');
  @override
  late final GeneratedColumn<String> person = GeneratedColumn<String>(
      'person', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        api,
        uuid,
        id,
        seasonFarmId,
        seasonFarmName,
        transactionDate,
        quantity,
        quantityUnitId,
        quantityUnitName,
        productId,
        productName,
        unitPrice,
        isPurchase,
        person
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_purchase_no_network';
  @override
  VerificationContext validateIntegrity(
      Insertable<ActivityPurchaseNoNetWork> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('api')) {
      context.handle(
          _apiMeta, api.isAcceptableOrUnknown(data['api']!, _apiMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('season_farm_id')) {
      context.handle(
          _seasonFarmIdMeta,
          seasonFarmId.isAcceptableOrUnknown(
              data['season_farm_id']!, _seasonFarmIdMeta));
    }
    if (data.containsKey('season_farm_name')) {
      context.handle(
          _seasonFarmNameMeta,
          seasonFarmName.isAcceptableOrUnknown(
              data['season_farm_name']!, _seasonFarmNameMeta));
    }
    if (data.containsKey('transaction_date')) {
      context.handle(
          _transactionDateMeta,
          transactionDate.isAcceptableOrUnknown(
              data['transaction_date']!, _transactionDateMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('quantity_unit_id')) {
      context.handle(
          _quantityUnitIdMeta,
          quantityUnitId.isAcceptableOrUnknown(
              data['quantity_unit_id']!, _quantityUnitIdMeta));
    }
    if (data.containsKey('quantity_unit_name')) {
      context.handle(
          _quantityUnitNameMeta,
          quantityUnitName.isAcceptableOrUnknown(
              data['quantity_unit_name']!, _quantityUnitNameMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    }
    if (data.containsKey('product_name')) {
      context.handle(
          _productNameMeta,
          productName.isAcceptableOrUnknown(
              data['product_name']!, _productNameMeta));
    }
    if (data.containsKey('unit_price')) {
      context.handle(_unitPriceMeta,
          unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta));
    }
    if (data.containsKey('is_purchase')) {
      context.handle(
          _isPurchaseMeta,
          isPurchase.isAcceptableOrUnknown(
              data['is_purchase']!, _isPurchaseMeta));
    }
    if (data.containsKey('person')) {
      context.handle(_personMeta,
          person.isAcceptableOrUnknown(data['person']!, _personMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, uuid};
  @override
  ActivityPurchaseNoNetWork map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityPurchaseNoNetWork(
      api: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}api']),
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid']),
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      seasonFarmId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}season_farm_id']),
      seasonFarmName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}season_farm_name']),
      transactionDate: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}transaction_date']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity']),
      quantityUnitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity_unit_id']),
      quantityUnitName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}quantity_unit_name']),
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id']),
      unitPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}unit_price']),
      person: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}person']),
      productName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_name']),
      isPurchase: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_purchase']),
    );
  }

  @override
  $ActivityPurchaseNoNetworkTableTable createAlias(String alias) {
    return $ActivityPurchaseNoNetworkTableTable(attachedDatabase, alias);
  }
}

class ActivityPurchaseNoNetworkTableCompanion
    extends UpdateCompanion<ActivityPurchaseNoNetWork> {
  final Value<String?> api;
  final Value<String?> uuid;
  final Value<int?> id;
  final Value<int?> seasonFarmId;
  final Value<String?> seasonFarmName;
  final Value<String?> transactionDate;
  final Value<double?> quantity;
  final Value<int?> quantityUnitId;
  final Value<String?> quantityUnitName;
  final Value<int?> productId;
  final Value<String?> productName;
  final Value<double?> unitPrice;
  final Value<bool?> isPurchase;
  final Value<String?> person;
  final Value<int> rowid;
  const ActivityPurchaseNoNetworkTableCompanion({
    this.api = const Value.absent(),
    this.uuid = const Value.absent(),
    this.id = const Value.absent(),
    this.seasonFarmId = const Value.absent(),
    this.seasonFarmName = const Value.absent(),
    this.transactionDate = const Value.absent(),
    this.quantity = const Value.absent(),
    this.quantityUnitId = const Value.absent(),
    this.quantityUnitName = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.isPurchase = const Value.absent(),
    this.person = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivityPurchaseNoNetworkTableCompanion.insert({
    this.api = const Value.absent(),
    this.uuid = const Value.absent(),
    this.id = const Value.absent(),
    this.seasonFarmId = const Value.absent(),
    this.seasonFarmName = const Value.absent(),
    this.transactionDate = const Value.absent(),
    this.quantity = const Value.absent(),
    this.quantityUnitId = const Value.absent(),
    this.quantityUnitName = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.isPurchase = const Value.absent(),
    this.person = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<ActivityPurchaseNoNetWork> custom({
    Expression<String>? api,
    Expression<String>? uuid,
    Expression<int>? id,
    Expression<int>? seasonFarmId,
    Expression<String>? seasonFarmName,
    Expression<String>? transactionDate,
    Expression<double>? quantity,
    Expression<int>? quantityUnitId,
    Expression<String>? quantityUnitName,
    Expression<int>? productId,
    Expression<String>? productName,
    Expression<double>? unitPrice,
    Expression<bool>? isPurchase,
    Expression<String>? person,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (api != null) 'api': api,
      if (uuid != null) 'uuid': uuid,
      if (id != null) 'id': id,
      if (seasonFarmId != null) 'season_farm_id': seasonFarmId,
      if (seasonFarmName != null) 'season_farm_name': seasonFarmName,
      if (transactionDate != null) 'transaction_date': transactionDate,
      if (quantity != null) 'quantity': quantity,
      if (quantityUnitId != null) 'quantity_unit_id': quantityUnitId,
      if (quantityUnitName != null) 'quantity_unit_name': quantityUnitName,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (isPurchase != null) 'is_purchase': isPurchase,
      if (person != null) 'person': person,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivityPurchaseNoNetworkTableCompanion copyWith(
      {Value<String?>? api,
      Value<String?>? uuid,
      Value<int?>? id,
      Value<int?>? seasonFarmId,
      Value<String?>? seasonFarmName,
      Value<String?>? transactionDate,
      Value<double?>? quantity,
      Value<int?>? quantityUnitId,
      Value<String?>? quantityUnitName,
      Value<int?>? productId,
      Value<String?>? productName,
      Value<double?>? unitPrice,
      Value<bool?>? isPurchase,
      Value<String?>? person,
      Value<int>? rowid}) {
    return ActivityPurchaseNoNetworkTableCompanion(
      api: api ?? this.api,
      uuid: uuid ?? this.uuid,
      id: id ?? this.id,
      seasonFarmId: seasonFarmId ?? this.seasonFarmId,
      seasonFarmName: seasonFarmName ?? this.seasonFarmName,
      transactionDate: transactionDate ?? this.transactionDate,
      quantity: quantity ?? this.quantity,
      quantityUnitId: quantityUnitId ?? this.quantityUnitId,
      quantityUnitName: quantityUnitName ?? this.quantityUnitName,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      unitPrice: unitPrice ?? this.unitPrice,
      isPurchase: isPurchase ?? this.isPurchase,
      person: person ?? this.person,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (api.present) {
      map['api'] = Variable<String>(api.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (seasonFarmId.present) {
      map['season_farm_id'] = Variable<int>(seasonFarmId.value);
    }
    if (seasonFarmName.present) {
      map['season_farm_name'] = Variable<String>(seasonFarmName.value);
    }
    if (transactionDate.present) {
      map['transaction_date'] = Variable<String>(transactionDate.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (quantityUnitId.present) {
      map['quantity_unit_id'] = Variable<int>(quantityUnitId.value);
    }
    if (quantityUnitName.present) {
      map['quantity_unit_name'] = Variable<String>(quantityUnitName.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (isPurchase.present) {
      map['is_purchase'] = Variable<bool>(isPurchase.value);
    }
    if (person.present) {
      map['person'] = Variable<String>(person.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityPurchaseNoNetworkTableCompanion(')
          ..write('api: $api, ')
          ..write('uuid: $uuid, ')
          ..write('id: $id, ')
          ..write('seasonFarmId: $seasonFarmId, ')
          ..write('seasonFarmName: $seasonFarmName, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('quantity: $quantity, ')
          ..write('quantityUnitId: $quantityUnitId, ')
          ..write('quantityUnitName: $quantityUnitName, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('isPurchase: $isPurchase, ')
          ..write('person: $person, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SeasonFarmTableTable extends SeasonFarmTable
    with TableInfo<$SeasonFarmTableTable, SeasonFarm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SeasonFarmTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _productNameMeta =
      const VerificationMeta('productName');
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
      'product_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _availableQuantityMeta =
      const VerificationMeta('availableQuantity');
  @override
  late final GeneratedColumn<double> availableQuantity =
      GeneratedColumn<double>('available_quantity', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<int> unitId = GeneratedColumn<int>(
      'unit_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        name,
        productId,
        productName,
        availableQuantity,
        unitId,
        image
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'season_farm';
  @override
  VerificationContext validateIntegrity(Insertable<SeasonFarm> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    }
    if (data.containsKey('product_name')) {
      context.handle(
          _productNameMeta,
          productName.isAcceptableOrUnknown(
              data['product_name']!, _productNameMeta));
    }
    if (data.containsKey('available_quantity')) {
      context.handle(
          _availableQuantityMeta,
          availableQuantity.isAcceptableOrUnknown(
              data['available_quantity']!, _availableQuantityMeta));
    }
    if (data.containsKey('unit_id')) {
      context.handle(_unitIdMeta,
          unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SeasonFarm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SeasonFarm(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id']),
      productName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_name']),
      availableQuantity: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}available_quantity']),
      unitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unit_id']),
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image']),
    );
  }

  @override
  $SeasonFarmTableTable createAlias(String alias) {
    return $SeasonFarmTableTable(attachedDatabase, alias);
  }
}

class SeasonFarmTableCompanion extends UpdateCompanion<SeasonFarm> {
  final Value<int?> id;
  final Value<int?> userId;
  final Value<String?> name;
  final Value<int?> productId;
  final Value<String?> productName;
  final Value<double?> availableQuantity;
  final Value<int?> unitId;
  final Value<String?> image;
  const SeasonFarmTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.availableQuantity = const Value.absent(),
    this.unitId = const Value.absent(),
    this.image = const Value.absent(),
  });
  SeasonFarmTableCompanion.insert({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.availableQuantity = const Value.absent(),
    this.unitId = const Value.absent(),
    this.image = const Value.absent(),
  });
  static Insertable<SeasonFarm> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? name,
    Expression<int>? productId,
    Expression<String>? productName,
    Expression<double>? availableQuantity,
    Expression<int>? unitId,
    Expression<String>? image,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (availableQuantity != null) 'available_quantity': availableQuantity,
      if (unitId != null) 'unit_id': unitId,
      if (image != null) 'image': image,
    });
  }

  SeasonFarmTableCompanion copyWith(
      {Value<int?>? id,
      Value<int?>? userId,
      Value<String?>? name,
      Value<int?>? productId,
      Value<String?>? productName,
      Value<double?>? availableQuantity,
      Value<int?>? unitId,
      Value<String?>? image}) {
    return SeasonFarmTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      unitId: unitId ?? this.unitId,
      image: image ?? this.image,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (availableQuantity.present) {
      map['available_quantity'] = Variable<double>(availableQuantity.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<int>(unitId.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SeasonFarmTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('availableQuantity: $availableQuantity, ')
          ..write('unitId: $unitId, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }
}

class $WorkflowTableTable extends WorkflowTable
    with TableInfo<$WorkflowTableTable, Workflow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkflowTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _cropNameMeta =
      const VerificationMeta('cropName');
  @override
  late final GeneratedColumn<String> cropName = GeneratedColumn<String>(
      'crop_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _productNameMeta =
      const VerificationMeta('productName');
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
      'product_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _standardMeta =
      const VerificationMeta('standard');
  @override
  late final GeneratedColumn<String> standard = GeneratedColumn<String>(
      'standard', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusNameMeta =
      const VerificationMeta('statusName');
  @override
  late final GeneratedColumn<String> statusName = GeneratedColumn<String>(
      'status_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stringProcessStageIdsMeta =
      const VerificationMeta('stringProcessStageIds');
  @override
  late final GeneratedColumn<String> stringProcessStageIds =
      GeneratedColumn<String>('string_process_stage_ids', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        cropName,
        productName,
        description,
        standard,
        status,
        statusName,
        stringProcessStageIds
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workflow';
  @override
  VerificationContext validateIntegrity(Insertable<Workflow> instance,
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
    if (data.containsKey('crop_name')) {
      context.handle(_cropNameMeta,
          cropName.isAcceptableOrUnknown(data['crop_name']!, _cropNameMeta));
    }
    if (data.containsKey('product_name')) {
      context.handle(
          _productNameMeta,
          productName.isAcceptableOrUnknown(
              data['product_name']!, _productNameMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('standard')) {
      context.handle(_standardMeta,
          standard.isAcceptableOrUnknown(data['standard']!, _standardMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('status_name')) {
      context.handle(
          _statusNameMeta,
          statusName.isAcceptableOrUnknown(
              data['status_name']!, _statusNameMeta));
    }
    if (data.containsKey('string_process_stage_ids')) {
      context.handle(
          _stringProcessStageIdsMeta,
          stringProcessStageIds.isAcceptableOrUnknown(
              data['string_process_stage_ids']!, _stringProcessStageIdsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Workflow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Workflow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      cropName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}crop_name']),
      productName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_name']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status']),
      statusName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status_name']),
      standard: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}standard']),
      stringProcessStageIds: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}string_process_stage_ids']),
    );
  }

  @override
  $WorkflowTableTable createAlias(String alias) {
    return $WorkflowTableTable(attachedDatabase, alias);
  }
}

class WorkflowTableCompanion extends UpdateCompanion<Workflow> {
  final Value<int?> id;
  final Value<String?> name;
  final Value<String?> cropName;
  final Value<String?> productName;
  final Value<String?> description;
  final Value<String?> standard;
  final Value<String?> status;
  final Value<String?> statusName;
  final Value<String?> stringProcessStageIds;
  const WorkflowTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.cropName = const Value.absent(),
    this.productName = const Value.absent(),
    this.description = const Value.absent(),
    this.standard = const Value.absent(),
    this.status = const Value.absent(),
    this.statusName = const Value.absent(),
    this.stringProcessStageIds = const Value.absent(),
  });
  WorkflowTableCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.cropName = const Value.absent(),
    this.productName = const Value.absent(),
    this.description = const Value.absent(),
    this.standard = const Value.absent(),
    this.status = const Value.absent(),
    this.statusName = const Value.absent(),
    this.stringProcessStageIds = const Value.absent(),
  });
  static Insertable<Workflow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? cropName,
    Expression<String>? productName,
    Expression<String>? description,
    Expression<String>? standard,
    Expression<String>? status,
    Expression<String>? statusName,
    Expression<String>? stringProcessStageIds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (cropName != null) 'crop_name': cropName,
      if (productName != null) 'product_name': productName,
      if (description != null) 'description': description,
      if (standard != null) 'standard': standard,
      if (status != null) 'status': status,
      if (statusName != null) 'status_name': statusName,
      if (stringProcessStageIds != null)
        'string_process_stage_ids': stringProcessStageIds,
    });
  }

  WorkflowTableCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? name,
      Value<String?>? cropName,
      Value<String?>? productName,
      Value<String?>? description,
      Value<String?>? standard,
      Value<String?>? status,
      Value<String?>? statusName,
      Value<String?>? stringProcessStageIds}) {
    return WorkflowTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      cropName: cropName ?? this.cropName,
      productName: productName ?? this.productName,
      description: description ?? this.description,
      standard: standard ?? this.standard,
      status: status ?? this.status,
      statusName: statusName ?? this.statusName,
      stringProcessStageIds:
          stringProcessStageIds ?? this.stringProcessStageIds,
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
    if (cropName.present) {
      map['crop_name'] = Variable<String>(cropName.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (standard.present) {
      map['standard'] = Variable<String>(standard.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (statusName.present) {
      map['status_name'] = Variable<String>(statusName.value);
    }
    if (stringProcessStageIds.present) {
      map['string_process_stage_ids'] =
          Variable<String>(stringProcessStageIds.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkflowTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('cropName: $cropName, ')
          ..write('productName: $productName, ')
          ..write('description: $description, ')
          ..write('standard: $standard, ')
          ..write('status: $status, ')
          ..write('statusName: $statusName, ')
          ..write('stringProcessStageIds: $stringProcessStageIds')
          ..write(')'))
        .toString();
  }
}

class $AreaEntityTableTable extends AreaEntityTable
    with TableInfo<$AreaEntityTableTable, AreaEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AreaEntityTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
  static const VerificationMeta _stringSeasonsMeta =
      const VerificationMeta('stringSeasons');
  @override
  late final GeneratedColumn<String> stringSeasons = GeneratedColumn<String>(
      'string_seasons', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [userId, id, name, stringSeasons];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'area_entity';
  @override
  VerificationContext validateIntegrity(Insertable<AreaEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('string_seasons')) {
      context.handle(
          _stringSeasonsMeta,
          stringSeasons.isAcceptableOrUnknown(
              data['string_seasons']!, _stringSeasonsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, userId};
  @override
  AreaEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AreaEntity(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      stringSeasons: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}string_seasons']),
    );
  }

  @override
  $AreaEntityTableTable createAlias(String alias) {
    return $AreaEntityTableTable(attachedDatabase, alias);
  }
}

class AreaEntityTableCompanion extends UpdateCompanion<AreaEntity> {
  final Value<int?> userId;
  final Value<int?> id;
  final Value<String?> name;
  final Value<String?> stringSeasons;
  final Value<int> rowid;
  const AreaEntityTableCompanion({
    this.userId = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.stringSeasons = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AreaEntityTableCompanion.insert({
    this.userId = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.stringSeasons = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<AreaEntity> custom({
    Expression<int>? userId,
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? stringSeasons,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (stringSeasons != null) 'string_seasons': stringSeasons,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AreaEntityTableCompanion copyWith(
      {Value<int?>? userId,
      Value<int?>? id,
      Value<String?>? name,
      Value<String?>? stringSeasons,
      Value<int>? rowid}) {
    return AreaEntityTableCompanion(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      name: name ?? this.name,
      stringSeasons: stringSeasons ?? this.stringSeasons,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (stringSeasons.present) {
      map['string_seasons'] = Variable<String>(stringSeasons.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AreaEntityTableCompanion(')
          ..write('userId: $userId, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('stringSeasons: $stringSeasons, ')
          ..write('rowid: $rowid')
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
  late final $ActDiaryNoNetworkTableTable actDiaryNoNetworkTable =
      $ActDiaryNoNetworkTableTable(this);
  late final $ReportTableTable reportTable = $ReportTableTable(this);
  late final $QuestionUploadNoNetworkTableTable questionUploadNoNetworkTable =
      $QuestionUploadNoNetworkTableTable(this);
  late final $FarmerInspectorUploadNoNetworkTableTable
      farmerInspectorUploadNoNetworkTable =
      $FarmerInspectorUploadNoNetworkTableTable(this);
  late final $ReportSelectTableTable reportSelectTable =
      $ReportSelectTableTable(this);
  late final $ActivityPurchaseTableTable activityPurchaseTable =
      $ActivityPurchaseTableTable(this);
  late final $ActivityTransactionTableTable activityTransactionTable =
      $ActivityTransactionTableTable(this);
  late final $ActivityTransactionNoNetworkTableTable
      activityTransactionNoNetworkTable =
      $ActivityTransactionNoNetworkTableTable(this);
  late final $ActivityPurchaseNoNetworkTableTable
      activityPurchaseNoNetworkTable =
      $ActivityPurchaseNoNetworkTableTable(this);
  late final $SeasonFarmTableTable seasonFarmTable =
      $SeasonFarmTableTable(this);
  late final $WorkflowTableTable workflowTable = $WorkflowTableTable(this);
  late final $AreaEntityTableTable areaEntityTable =
      $AreaEntityTableTable(this);
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
        monitorDiaryTable,
        actDiaryNoNetworkTable,
        reportTable,
        questionUploadNoNetworkTable,
        farmerInspectorUploadNoNetworkTable,
        reportSelectTable,
        activityPurchaseTable,
        activityTransactionTable,
        activityTransactionNoNetworkTable,
        activityPurchaseNoNetworkTable,
        seasonFarmTable,
        workflowTable,
        areaEntityTable
      ];
}
