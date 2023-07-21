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
  static const VerificationMeta _seasonFarmIdMeta =
      const VerificationMeta('seasonFarmId');
  @override
  late final GeneratedColumn<int> seasonFarmId = GeneratedColumn<int>(
      'season_farm_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _activityIdMeta =
      const VerificationMeta('activityId');
  @override
  late final GeneratedColumn<int> activityId = GeneratedColumn<int>(
      'activity_id', aliasedName, true,
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
  late final GeneratedColumn<String> actionAreaUnitId = GeneratedColumn<String>(
      'action_area_unit_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  late final GeneratedColumn<String> amountUnitId = GeneratedColumn<String>(
      'amount_unit_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _areaMeta = const VerificationMeta('area');
  @override
  late final GeneratedColumn<double> area = GeneratedColumn<double>(
      'area', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _areaUnitIdMeta =
      const VerificationMeta('areaUnitId');
  @override
  late final GeneratedColumn<String> areaUnitId = GeneratedColumn<String>(
      'area_unit_id', aliasedName, true,
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
  late final GeneratedColumn<String> yieldEstimateUnitId =
      GeneratedColumn<String>('yield_estimate_unit_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        seasonFarmId,
        activityId,
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
        area,
        areaUnitId,
        yieldEstimate,
        yieldEstimateUnitId
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
    if (data.containsKey('season_farm_id')) {
      context.handle(
          _seasonFarmIdMeta,
          seasonFarmId.isAcceptableOrUnknown(
              data['season_farm_id']!, _seasonFarmIdMeta));
    }
    if (data.containsKey('activity_id')) {
      context.handle(
          _activityIdMeta,
          activityId.isAcceptableOrUnknown(
              data['activity_id']!, _activityIdMeta));
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
      seasonFarmId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}season_farm_id']),
      activityId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}activity_id']),
      actionTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action_time']),
      actionArea: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}action_area']),
      actionAreaUnitId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}action_area_unit_id']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      user: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user']),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_date']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_date']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status']),
      crop: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}crop']),
      areaUnitId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}area_unit_id']),
      area: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}area']),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount']),
      amountUnitId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}amount_unit_id']),
      yieldEstimate: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}yield_estimate']),
      yieldEstimateUnitId: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}yield_estimate_unit_id']),
    );
  }

  @override
  $DiaryTableTable createAlias(String alias) {
    return $DiaryTableTable(attachedDatabase, alias);
  }
}

class DiaryTableCompanion extends UpdateCompanion<Diary> {
  final Value<int?> id;
  final Value<int?> seasonFarmId;
  final Value<int?> activityId;
  final Value<String?> user;
  final Value<String?> actionTime;
  final Value<double?> actionArea;
  final Value<String?> actionAreaUnitId;
  final Value<String?> description;
  final Value<String?> name;
  final Value<String?> crop;
  final Value<String?> startDate;
  final Value<String?> endDate;
  final Value<String?> status;
  final Value<double?> amount;
  final Value<String?> amountUnitId;
  final Value<double?> area;
  final Value<String?> areaUnitId;
  final Value<double?> yieldEstimate;
  final Value<String?> yieldEstimateUnitId;
  const DiaryTableCompanion({
    this.id = const Value.absent(),
    this.seasonFarmId = const Value.absent(),
    this.activityId = const Value.absent(),
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
    this.area = const Value.absent(),
    this.areaUnitId = const Value.absent(),
    this.yieldEstimate = const Value.absent(),
    this.yieldEstimateUnitId = const Value.absent(),
  });
  DiaryTableCompanion.insert({
    this.id = const Value.absent(),
    this.seasonFarmId = const Value.absent(),
    this.activityId = const Value.absent(),
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
    this.area = const Value.absent(),
    this.areaUnitId = const Value.absent(),
    this.yieldEstimate = const Value.absent(),
    this.yieldEstimateUnitId = const Value.absent(),
  });
  static Insertable<Diary> custom({
    Expression<int>? id,
    Expression<int>? seasonFarmId,
    Expression<int>? activityId,
    Expression<String>? user,
    Expression<String>? actionTime,
    Expression<double>? actionArea,
    Expression<String>? actionAreaUnitId,
    Expression<String>? description,
    Expression<String>? name,
    Expression<String>? crop,
    Expression<String>? startDate,
    Expression<String>? endDate,
    Expression<String>? status,
    Expression<double>? amount,
    Expression<String>? amountUnitId,
    Expression<double>? area,
    Expression<String>? areaUnitId,
    Expression<double>? yieldEstimate,
    Expression<String>? yieldEstimateUnitId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (seasonFarmId != null) 'season_farm_id': seasonFarmId,
      if (activityId != null) 'activity_id': activityId,
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
      if (area != null) 'area': area,
      if (areaUnitId != null) 'area_unit_id': areaUnitId,
      if (yieldEstimate != null) 'yield_estimate': yieldEstimate,
      if (yieldEstimateUnitId != null)
        'yield_estimate_unit_id': yieldEstimateUnitId,
    });
  }

  DiaryTableCompanion copyWith(
      {Value<int?>? id,
      Value<int?>? seasonFarmId,
      Value<int?>? activityId,
      Value<String?>? user,
      Value<String?>? actionTime,
      Value<double?>? actionArea,
      Value<String?>? actionAreaUnitId,
      Value<String?>? description,
      Value<String?>? name,
      Value<String?>? crop,
      Value<String?>? startDate,
      Value<String?>? endDate,
      Value<String?>? status,
      Value<double?>? amount,
      Value<String?>? amountUnitId,
      Value<double?>? area,
      Value<String?>? areaUnitId,
      Value<double?>? yieldEstimate,
      Value<String?>? yieldEstimateUnitId}) {
    return DiaryTableCompanion(
      id: id ?? this.id,
      seasonFarmId: seasonFarmId ?? this.seasonFarmId,
      activityId: activityId ?? this.activityId,
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
      area: area ?? this.area,
      areaUnitId: areaUnitId ?? this.areaUnitId,
      yieldEstimate: yieldEstimate ?? this.yieldEstimate,
      yieldEstimateUnitId: yieldEstimateUnitId ?? this.yieldEstimateUnitId,
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
    if (activityId.present) {
      map['activity_id'] = Variable<int>(activityId.value);
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
      map['action_area_unit_id'] = Variable<String>(actionAreaUnitId.value);
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
      map['amount_unit_id'] = Variable<String>(amountUnitId.value);
    }
    if (area.present) {
      map['area'] = Variable<double>(area.value);
    }
    if (areaUnitId.present) {
      map['area_unit_id'] = Variable<String>(areaUnitId.value);
    }
    if (yieldEstimate.present) {
      map['yield_estimate'] = Variable<double>(yieldEstimate.value);
    }
    if (yieldEstimateUnitId.present) {
      map['yield_estimate_unit_id'] =
          Variable<String>(yieldEstimateUnitId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiaryTableCompanion(')
          ..write('id: $id, ')
          ..write('seasonFarmId: $seasonFarmId, ')
          ..write('activityId: $activityId, ')
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
          ..write('area: $area, ')
          ..write('areaUnitId: $areaUnitId, ')
          ..write('yieldEstimate: $yieldEstimate, ')
          ..write('yieldEstimateUnitId: $yieldEstimateUnitId')
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
  late final GeneratedColumn<bool> image =
      GeneratedColumn<bool>('image', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("image" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
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
          .read(DriftSqlType.bool, data['${effectivePrefix}image']),
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
  final Value<bool?> image;
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
    Expression<bool>? image,
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
      Value<bool?>? image,
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
      map['image'] = Variable<bool>(image.value);
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
  late final GeneratedColumn<bool> image =
      GeneratedColumn<bool>('image', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("image" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
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
          .read(DriftSqlType.bool, data['${effectivePrefix}image']),
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
  final Value<String?> name;
  final Value<String?> description;
  final Value<bool?> isOrganic;
  final Value<bool?> notation;
  final Value<bool?> isActive;
  final Value<bool?> image;
  final Value<int?> diaryFarmerId;
  final Value<int?> toolId;
  final Value<double?> quantity;
  final Value<int?> unitId;
  final Value<String?> unitName;
  final Value<String?> mediaContent;
  const ToolTableCompanion({
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
    this.unitName = const Value.absent(),
    this.mediaContent = const Value.absent(),
  });
  ToolTableCompanion.insert({
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
    this.unitName = const Value.absent(),
    this.mediaContent = const Value.absent(),
  });
  static Insertable<Tool> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isOrganic,
    Expression<bool>? notation,
    Expression<bool>? isActive,
    Expression<bool>? image,
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
      Value<String?>? name,
      Value<String?>? description,
      Value<bool?>? isOrganic,
      Value<bool?>? notation,
      Value<bool?>? isActive,
      Value<bool?>? image,
      Value<int?>? diaryFarmerId,
      Value<int?>? toolId,
      Value<double?>? quantity,
      Value<int?>? unitId,
      Value<String?>? unitName,
      Value<String?>? mediaContent}) {
    return ToolTableCompanion(
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
      map['image'] = Variable<bool>(image.value);
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
  late final GeneratedColumn<bool> image =
      GeneratedColumn<bool>('image', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("image" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
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
  MaterialEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaterialEntity(
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
          .read(DriftSqlType.bool, data['${effectivePrefix}image']),
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
  $MaterialTableTable createAlias(String alias) {
    return $MaterialTableTable(attachedDatabase, alias);
  }
}

class MaterialTableCompanion extends UpdateCompanion<MaterialEntity> {
  final Value<int?> id;
  final Value<int?> categoryId;
  final Value<String?> name;
  final Value<String?> description;
  final Value<bool?> isOrganic;
  final Value<bool?> notation;
  final Value<bool?> isActive;
  final Value<bool?> image;
  final Value<int?> diaryFarmerId;
  final Value<int?> toolId;
  final Value<double?> quantity;
  final Value<int?> unitId;
  final Value<String?> unitName;
  final Value<String?> mediaContent;
  const MaterialTableCompanion({
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
    this.unitName = const Value.absent(),
    this.mediaContent = const Value.absent(),
  });
  MaterialTableCompanion.insert({
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
    this.unitName = const Value.absent(),
    this.mediaContent = const Value.absent(),
  });
  static Insertable<MaterialEntity> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isOrganic,
    Expression<bool>? notation,
    Expression<bool>? isActive,
    Expression<bool>? image,
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

  MaterialTableCompanion copyWith(
      {Value<int?>? id,
      Value<int?>? categoryId,
      Value<String?>? name,
      Value<String?>? description,
      Value<bool?>? isOrganic,
      Value<bool?>? notation,
      Value<bool?>? isActive,
      Value<bool?>? image,
      Value<int?>? diaryFarmerId,
      Value<int?>? toolId,
      Value<double?>? quantity,
      Value<int?>? unitId,
      Value<String?>? unitName,
      Value<String?>? mediaContent}) {
    return MaterialTableCompanion(
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
      map['image'] = Variable<bool>(image.value);
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
    return (StringBuffer('MaterialTableCompanion(')
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
  late final GeneratedColumn<bool> image =
      GeneratedColumn<bool>('image', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("image" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
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
          .read(DriftSqlType.bool, data['${effectivePrefix}image']),
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
  final Value<bool?> image;
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
    Expression<bool>? image,
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
      Value<bool?>? image,
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
      map['image'] = Variable<bool>(image.value);
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
  static const VerificationMeta _activityIdMeta =
      const VerificationMeta('activityId');
  @override
  late final GeneratedColumn<int> activityId = GeneratedColumn<int>(
      'activity_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameActivityMeta =
      const VerificationMeta('nameActivity');
  @override
  late final GeneratedColumn<String> nameActivity = GeneratedColumn<String>(
      'name_activity', aliasedName, true,
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
  late final GeneratedColumn<String> actionAreaUnitId = GeneratedColumn<String>(
      'action_area_unit_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
        activityId,
        nameActivity,
        actionTime,
        actionArea,
        actionAreaUnitId,
        description,
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
    if (data.containsKey('activity_id')) {
      context.handle(
          _activityIdMeta,
          activityId.isAcceptableOrUnknown(
              data['activity_id']!, _activityIdMeta));
    }
    if (data.containsKey('name_activity')) {
      context.handle(
          _nameActivityMeta,
          nameActivity.isAcceptableOrUnknown(
              data['name_activity']!, _nameActivityMeta));
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
          DriftSqlType.string, data['${effectivePrefix}action_area_unit_id']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      nameActivity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_activity']),
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
  final Value<int?> activityId;
  final Value<String?> nameActivity;
  final Value<String?> actionTime;
  final Value<double?> actionArea;
  final Value<String?> actionAreaUnitId;
  final Value<String?> description;
  final Value<String?> name;
  final Value<String?> byName;
  final Value<String?> startTime;
  final Value<String?> endTime;
  final Value<int?> status;
  const ActivityDiaryTableCompanion({
    this.id = const Value.absent(),
    this.seasonFarmId = const Value.absent(),
    this.activityId = const Value.absent(),
    this.nameActivity = const Value.absent(),
    this.actionTime = const Value.absent(),
    this.actionArea = const Value.absent(),
    this.actionAreaUnitId = const Value.absent(),
    this.description = const Value.absent(),
    this.name = const Value.absent(),
    this.byName = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.status = const Value.absent(),
  });
  ActivityDiaryTableCompanion.insert({
    this.id = const Value.absent(),
    this.seasonFarmId = const Value.absent(),
    this.activityId = const Value.absent(),
    this.nameActivity = const Value.absent(),
    this.actionTime = const Value.absent(),
    this.actionArea = const Value.absent(),
    this.actionAreaUnitId = const Value.absent(),
    this.description = const Value.absent(),
    this.name = const Value.absent(),
    this.byName = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.status = const Value.absent(),
  });
  static Insertable<ActivityDiary> custom({
    Expression<int>? id,
    Expression<int>? seasonFarmId,
    Expression<int>? activityId,
    Expression<String>? nameActivity,
    Expression<String>? actionTime,
    Expression<double>? actionArea,
    Expression<String>? actionAreaUnitId,
    Expression<String>? description,
    Expression<String>? name,
    Expression<String>? byName,
    Expression<String>? startTime,
    Expression<String>? endTime,
    Expression<int>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (seasonFarmId != null) 'season_farm_id': seasonFarmId,
      if (activityId != null) 'activity_id': activityId,
      if (nameActivity != null) 'name_activity': nameActivity,
      if (actionTime != null) 'action_time': actionTime,
      if (actionArea != null) 'action_area': actionArea,
      if (actionAreaUnitId != null) 'action_area_unit_id': actionAreaUnitId,
      if (description != null) 'description': description,
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
      Value<int?>? activityId,
      Value<String?>? nameActivity,
      Value<String?>? actionTime,
      Value<double?>? actionArea,
      Value<String?>? actionAreaUnitId,
      Value<String?>? description,
      Value<String?>? name,
      Value<String?>? byName,
      Value<String?>? startTime,
      Value<String?>? endTime,
      Value<int?>? status}) {
    return ActivityDiaryTableCompanion(
      id: id ?? this.id,
      seasonFarmId: seasonFarmId ?? this.seasonFarmId,
      activityId: activityId ?? this.activityId,
      nameActivity: nameActivity ?? this.nameActivity,
      actionTime: actionTime ?? this.actionTime,
      actionArea: actionArea ?? this.actionArea,
      actionAreaUnitId: actionAreaUnitId ?? this.actionAreaUnitId,
      description: description ?? this.description,
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
    if (activityId.present) {
      map['activity_id'] = Variable<int>(activityId.value);
    }
    if (nameActivity.present) {
      map['name_activity'] = Variable<String>(nameActivity.value);
    }
    if (actionTime.present) {
      map['action_time'] = Variable<String>(actionTime.value);
    }
    if (actionArea.present) {
      map['action_area'] = Variable<double>(actionArea.value);
    }
    if (actionAreaUnitId.present) {
      map['action_area_unit_id'] = Variable<String>(actionAreaUnitId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
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
          ..write('activityId: $activityId, ')
          ..write('nameActivity: $nameActivity, ')
          ..write('actionTime: $actionTime, ')
          ..write('actionArea: $actionArea, ')
          ..write('actionAreaUnitId: $actionAreaUnitId, ')
          ..write('description: $description, ')
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
  late final GeneratedColumn<String> active = GeneratedColumn<String>(
      'active', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
      'group_id', aliasedName, true,
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
        groupId,
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
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
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
          .read(DriftSqlType.string, data['${effectivePrefix}active']),
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_id']),
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
  final Value<String?> active;
  final Value<String?> groupId;
  final Value<String?> mediaContent;
  const UserInfoTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.login = const Value.absent(),
    this.gender = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.address = const Value.absent(),
    this.active = const Value.absent(),
    this.groupId = const Value.absent(),
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
    this.groupId = const Value.absent(),
    this.mediaContent = const Value.absent(),
  });
  static Insertable<UserInfo> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? login,
    Expression<String>? gender,
    Expression<String>? dateOfBirth,
    Expression<String>? address,
    Expression<String>? active,
    Expression<String>? groupId,
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
      if (groupId != null) 'group_id': groupId,
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
      Value<String?>? active,
      Value<String?>? groupId,
      Value<String?>? mediaContent}) {
    return UserInfoTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      login: login ?? this.login,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
      active: active ?? this.active,
      groupId: groupId ?? this.groupId,
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
      map['active'] = Variable<String>(active.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
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
          ..write('groupId: $groupId, ')
          ..write('mediaContent: $mediaContent')
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
        userInfoTable
      ];
}
