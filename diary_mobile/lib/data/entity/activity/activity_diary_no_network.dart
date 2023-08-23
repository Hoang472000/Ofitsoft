import 'dart:convert';
import 'package:diary_mobile/data/entity/activity/activity_diary.dart';
import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:drift/drift.dart';
import '../image/image_entity.dart';
import '../item_default/material_entity.dart';
import '../item_default/tool.dart';

class ActDiaryNoNetwork implements Insertable<ActDiaryNoNetwork>{
  String? api;
  int? id;
  int? seasonFarmId;
  String? seasonFarm;
  int? activityId;
  String? activityName;
  String? actionTime;
  double? actionArea;
  int? actionAreaUnitId;
  String? actionAreaUnitName;
  String? description;
  bool? isShow;
  double? amount;
  int? amountUnitId;
  String? amountUnitName;
  bool? harvesting;

  //mua ban
  int? productId;
  String? productName;
  int? companyId;
  String? companyName;
  double? quantity;
  int? quantityUnitId;
  String? quantityUnitName;
  double? unitPrice;
  double? total;
  String? buyer;
  //mua ban

  List<Tool> tool;
  List<MaterialEntity> material;
  List<ImageEntity> media;
  String? stringTool;
  String? stringMaterial;
  String? stringMedia;

  ActDiaryNoNetwork({
    this.api,
    this.id,
    this.seasonFarmId,
    this.activityId,
    this.actionTime,
    this.actionArea,
    this.actionAreaUnitId,
    this.actionAreaUnitName,
    this.description,
    this.activityName,
    this.seasonFarm,
    this.isShow,
    this.harvesting,
    this.amount,
    this.amountUnitId,
    this.amountUnitName,

    this.tool = const [],
    this.material = const [],
    this.media = const [],
    this.stringTool,
    this.stringMedia,
    this.stringMaterial,

    //mua ban
    this.productId,
    this.productName,
    this.companyId,
    this.companyName,
    this.quantity,
    this.quantityUnitId,
    this.quantityUnitName,
    this.unitPrice,
    this.total,
    this.buyer,
  });

  factory ActDiaryNoNetwork.fromJson(Map<String, dynamic> json) {
    return ActDiaryNoNetwork(
      api: json['api'] ?? '',
      id: json['id'] ?? -1,
      seasonFarmId: json['season_farm_id'] ?? -1,
      seasonFarm: json['season_farm'] ?? "",
      activityId: json['activity_id'],
      actionTime: json['action_time'] ?? "",
      actionArea: json['action_area'],
      actionAreaUnitId: json['action_area_unit_id'] ?? -1,
      actionAreaUnitName: json['action_area_unit_name'] ?? '',
      description: (json['description']??'').toString().replaceAll(RegExp(r'<\/?p>'),'') ?? '',
      activityName: json['activity_name'] ?? '',
      harvesting: json['harvesting'] ?? "",
      amount: json['amount'] ?? -1,
      amountUnitId: json['amount_unit_id'],
      amountUnitName: json['amount_unit_name'] ?? "",
      isShow: json['is_Shown'],

      tool: json['diary_tool_ids'] != null ? (json['diary_tool_ids'] as List<dynamic>).map((itemJson) => Tool.fromJson(itemJson)).toList() : [],
      material: json['diary_material_ids'] != null ? (json['diary_material_ids'] as List<dynamic>).map((itemJson) => MaterialEntity.fromJson(itemJson)).toList() : [],
      media: json['diary_media_ids'] != null ? (json['diary_media_ids'] as List<dynamic>).map((itemJson) => ImageEntity.fromJson(itemJson)).toList() : [],
      stringTool: jsonEncode(json['diary_tool_ids']) ?? '[]',
      stringMedia: jsonEncode(json['diary_media_ids']) ?? '[]',
      stringMaterial: jsonEncode(json['diary_material_ids']) ?? '[]',
      //mua ban
      productId: json['product_id'] ??  -1,
      productName: json['product_name'] ?? '',
      companyId: json['company_id'] ?? -1,
      companyName: json['company_name'] ?? '',
      quantity: json['quantity'],
      quantityUnitId: json['quantity_unit_id'],
      quantityUnitName: json['quantity_unit_name'],
      unitPrice: json['unitPrice'],
      total: json['total'],
      buyer: json['buyer'],

    );
  }

  factory ActDiaryNoNetwork.fromJsonConvert(ActivityDiary json, String api) {
    return ActDiaryNoNetwork(
      api: api,
      id: json.id,
      seasonFarmId: json.seasonFarmId,
      seasonFarm: json.seasonFarm,
      activityId: json.activityId,
      actionTime: json.actionTime,
      actionArea: json.actionArea,
      actionAreaUnitId: json.actionAreaUnitId,
      actionAreaUnitName: json.actionAreaUnitName,
      description: json.description,
      activityName: json.activityName,
      harvesting: json.harvesting,
      amount: json.amount,
      amountUnitId: json.amountUnitId,
      amountUnitName: json.amountUnitName,
      isShow: json.isShow,

      tool: json.tool,
      material: json.material,
      media: json.media,
      stringTool: json.stringTool,
      stringMedia: json.stringMaterial,
      stringMaterial: json.stringMedia,
      productId: json.productId,
      productName: json.productName,
      companyId: json.companyId,
      companyName: json.companyName,
      quantity: json.quantity,
      quantityUnitId: json.quantityUnitId,
      quantityUnitName: json.quantityUnitName,
      unitPrice: json.unitPrice,
      total: json.total,
      buyer: json.buyer,
    );
  }

  String convertToolsListToJson() {
    //print("HoangCV: tool: ${tool.length}");
    final List<Map<String, dynamic>> toolListJson =
    tool.map((tool) => tool.toJson()).toList();
    return jsonEncode(toolListJson);
  }
  String convertMaterialsListToJson() {
    final List<Map<String, dynamic>> toolListJson =
    material.map((tool) => tool.toJson()).toList();
    return jsonEncode(toolListJson);
  }
  String convertMediasListToJson() {
    final List<Map<String, dynamic>> toolListJson =
    media.map((tool) => tool.toJson()).toList();
    return jsonEncode(toolListJson);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['api'] = api;
    data['id'] = id;
    data['season_farm_id'] = seasonFarmId;
    data['season_farm'] = seasonFarm;
    data['activity_id'] = activityId;
    data['action_time'] = actionTime;
    data['action_area'] = actionArea;
    data['action_area_unit_id'] = actionAreaUnitId;
    data['action_area_unit_name'] = actionAreaUnitName;
    data['description'] = description;
    data['activity_name'] = activityName;
    data['is_shown'] = isShow;
    data['harvesting'] = harvesting;
    data['amount'] = amount;
    data['amount_unit_id'] = amountUnitId;
    data['amount_unit_name'] = amountUnitName;

    List<Map> listTool= [];
    for (int i = 0; i < (tool??[]).length; i++) {
      listTool.add((tool??[])[i].toJson());
    }
    List<Map> listMaterial= [];
    for (int i = 0; i < (material??[]).length; i++) {
      listMaterial.add((material??[])[i].toJson());
    }
    List<Map> listImage= [];
    for (int i = 0; i < (media??[]).length; i++) {
      listImage.add((media??[])[i].toJson());
    }
    data['diary_tool_ids'] = listTool;
    data['diary_material_ids'] = listMaterial;
    data['diary_media_ids'] = listImage;

    //mua ban
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['company_id'] = companyId;
    data['company_name'] = companyName;
    data['quantity'] = quantity;
    data['quantity_unit_id'] = quantityUnitId;
    data['quantity_unit_name'] = quantityUnitName;
    data['unitPrice'] = unitPrice;
    data['total'] = total;
    return data;
  }

  ActDiaryNoNetwork.copy(ActDiaryNoNetwork other)
      : id = other.id,
        api = other.api,
        seasonFarmId = other.seasonFarmId,
        seasonFarm = other.seasonFarm,
        activityId = other.activityId,
        actionTime = other.actionTime,
        actionArea = other.actionArea,
        actionAreaUnitId = other.actionAreaUnitId,
        actionAreaUnitName = other.actionAreaUnitName,
        description = other.description,
        activityName = other.activityName,
        isShow = other.isShow,
        harvesting = other.harvesting,
        amount = other.amount,
        amountUnitId = other.amountUnitId,
        amountUnitName = other.amountUnitName,
        tool = List.of(other.tool??[]), // Tạo bản sao của danh sách tool
        material = List.of(other.material??[]), // Tạo bản sao của danh sách material
        media = List.of(other.media??[]), // Tạo bản sao của danh sách media
        productId = other.productId,
        productName = other.productName,
        companyId = other.companyId,
        companyName = other.companyName,
        quantity = other.quantity,
        quantityUnitId = other.quantityUnitId,
        quantityUnitName = other.quantityUnitName,
        unitPrice = other.unitPrice,
        total = other.total,
        buyer = other.buyer;// Tạo bản sao của danh sách media

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return ActDiaryNoNetworkTableCompanion(
        api: Value(api),
        id: Value(id),
        seasonFarmId: Value(seasonFarmId),
        activityId: Value(activityId),
        actionTime: Value(actionTime),
        actionArea: Value(actionArea),
        actionAreaUnitId: Value(actionAreaUnitId),
        actionAreaUnitName: Value(actionAreaUnitName),
        description: Value(description),
        activityName: Value(activityName),
        harvesting: Value(harvesting),
        amount: Value(amount),
        amountUnitId: Value(amountUnitId),
        amountUnitName: Value(amountUnitName),
        stringTool: Value(stringTool),
        stringMaterial: Value(stringMaterial),
        stringMedia: Value(stringMedia),
            productId: Value(productId),
            productName: Value(productName),
            companyId: Value(companyId),
            companyName: Value(companyName),
            quantity: Value(quantity),
            quantityUnitId: Value(quantityUnitId),
            quantityUnitName: Value(quantityUnitName),
            unitPrice: Value(unitPrice),
            total: Value(total),
            buyer: Value(buyer))
        .toColumns(nullToAbsent);
  }
}
