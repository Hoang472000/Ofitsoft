import 'dart:async';
import 'dart:convert';

import 'package:diary_mobile/data/entity/diary/detail_diary.dart';
import 'package:diary_mobile/data/entity/item_default/activity.dart';
import 'package:diary_mobile/data/entity/item_default/material_entity.dart';
import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:diary_mobile/data/remote_data/object_model/object_result.dart';

import '../entity/diary/diary.dart';
import '../entity/item_default/item_default.dart';
import '../entity/item_default/tool.dart';
import '../repository.dart';

class FakeRepositoryImpl  extends Repository{
  @override
  Future<bool> checkExpToken() {
    // TODO: implement checkExpToken
    throw UnimplementedError();
  }

  @override
  Future<ObjectResult> login(String userName, String pass) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<List<Activity>> getListActivities() async{
    var json = [
      {
        "id": 25,
        "name": "Garden Care",
        "category_id": 19,
        "description": "<p>Garden Care</p>"
      },
      {
        "id": 26,
        "name": "Garden Cleaning",
        "category_id": 19,
        "description": "<p>Garden Cleaning</p>"
      },
      {
        "id": 27,
        "name": "Garden Ventilation",
        "category_id": 19,
        "description": "<p>Garden Ventilation</p>"
      },
      {
        "id": 28,
        "name": "Pest and disease control",
        "category_id": 19,
        "description": "<p>Pest and disease control</p>"
      },
      {
        "id": 29,
        "name": "Gardening",
        "category_id": 19,
        "description": "<p>Gardening</p>"
      },
      {
        "id": 30,
        "name": "Pruning",
        "category_id": 19,
        "description": "<p>Pruning</p>"
      },
      {
        "id": 31,
        "name": "Weed control",
        "category_id": 19,
        "description": "<p>Weed control</p>"
      },
      {
        "id": 32,
        "name": "Harvesting",
        "category_id": 19,
        "description": "<p>Harvesting</p>"
      },
      {
        "id": 33,
        "name": "Do farmers store pesticides/herbicides in their house?",
        "category_id": 20,
        "description": "<p>Do farmers store pesticides/herbicides in their house?</p>"
      },
      {
        "id": 34,
        "name": "Do they have a pesticide sprayer at home?",
        "category_id": 20,
        "description": "<p>Do they have a pesticide sprayer at home?</p>"
      },
      {
        "id": 35,
        "name": "Do farmers have both organic and conventional product crops?",
        "category_id": 20,
        "description": "<p>Do farmers have both organic and conventional product crops?</p>"
      },
      {
        "id": 36,
        "name": "Is there any sign of using compost for the product?",
        "category_id": 20,
        "description": "<p>Is there any sign of using compost for the product?</p>"
      }
    ];
    List<Activity> list = List.from(json)
        .map((json) => Activity.fromJson(json))
        .toList();
    await DiaryDB.instance.insertListActivity(list);
    return list;
  }

  @override
  Future<List<MaterialEntity>> getListMaterials() async{
    var json = [
      {
        "id": 9,
        "category_id": 39,
        "name": "Garlic",
        "is_organic": false,
        "description": "<p>Using garlic to care for plants.</p>",
        "valid": true,
        "image": false
      },
      {
        "id": 10,
        "category_id": 39,
        "name": "Chili Pepper",
        "is_organic": false,
        "description": "<p>Using chili pepper to take care of plants.</p>",
        "valid": true,
        "image": false
      },
      {
        "id": 11,
        "category_id": 39,
        "name": "Ginger",
        "is_organic": false,
        "description": "<p>Using ginger to take care of plants.</p>",
        "valid": true,
        "image": false
      },
      {
        "id": 12,
        "category_id": 39,
        "name": "Lemongrass",
        "is_organic": false,
        "description": "<p>Using lemongrass to take care of plants.</p>",
        "valid": false,
        "image": false
      }
    ];
    List<MaterialEntity> list = List.from(json)
        .map((json) => MaterialEntity.fromJson(json))
        .toList();
    DiaryDB.instance.insertListMaterial(list);
    return list;
  }

  @override
  Future<List<Tool>> getListTools() async{
    var json = [
      {
        "id": 19,
        "name": "Specialized Grass Rake",
        "category_id": 42,
        "description": "<p>Specialized Grass Rake</p>",
        "valid": true
      },
      {
        "id": 20,
        "name": "Broom",
        "category_id": 42,
        "description": "<p>Broom</p>",
        "valid": true
      },
      {
        "id": 21,
        "name": "Saw",
        "category_id": 42,
        "description": "<p>Saw</p>",
        "valid": true
      },
      {
        "id": 22,
        "name": "Hoe",
        "category_id": 42,
        "description": "<p>Hoe</p>",
        "valid": true
      },
      {
        "id": 23,
        "name": "Knife",
        "category_id": 42,
        "description": "<p>Knife</p>",
        "valid": true
      },
      {
        "id": 24,
        "name": "Specialized Tools",
        "category_id": 42,
        "description": "<p>Specialized Tools</p>",
        "valid": true
      },
      {
        "id": 25,
        "name": "Remove Weeds Machine",
        "category_id": 42,
        "description": "<p>Remove Weeds Machine</p>",
        "valid": true
      },
      {
        "id": 26,
        "name": "Machete",
        "category_id": 42,
        "description": "<p>Machete</p>",
        "valid": true
      },
      {
        "id": 27,
        "name": "New Bag",
        "category_id": 42,
        "description": "<p>New Bag</p>",
        "valid": true
      }
    ];
    List<Tool> list = List.from(json)
        .map((json) => Tool.fromJson(json))
        .toList();
    DiaryDB.instance.insertListTool(list);
    return list;
  }

  @override
  Future<List<Unit>> getListUnits() async{
    var json = [
      {
        "id": 25,
        "category_id": 25,
        "name": "m2",
        "description": "<p>Used for unit of area measurement.</p>",
        "notation": false,
        "valid": true
      },
      {
        "id": 26,
        "category_id": 25,
        "name": "ha",
        "description": "<p>Used for unit of area measurement.</p>",
        "notation": false,
        "valid": true
      },
      {
        "id": 27,
        "category_id": 25,
        "name": "km2",
        "description": "<p>Used for unit of area measurement.</p>",
        "notation": false,
        "valid": true
      },
      {
        "id": 28,
        "category_id": 26,
        "name": "Kg",
        "description": "<p>Used for unit of weight/mass measurement.</p>",
        "notation": false,
        "valid": true
      },
      {
        "id": 29,
        "category_id": 26,
        "name": "Yến",
        "description": "<p>Used for unit of weight/mass measurement.</p>",
        "notation": false,
        "valid": true
      },
      {
        "id": 30,
        "category_id": 26,
        "name": "Tạ (100kg)",
        "description": "<p>Used for unit of weight/mass measurement.</p>",
        "notation": false,
        "valid": true
      },
      {
        "id": 31,
        "category_id": 26,
        "name": "Tấn (1000kg)",
        "description": "<p>Used for unit of weight/mass measurement.</p>",
        "notation": false,
        "valid": true
      },
      {
        "id": 32,
        "category_id": 27,
        "name": "Cây",
        "description": "<p>Used for unit of quantity measurement.</p>",
        "notation": false,
        "valid": true
      },
      {
        "id": 33,
        "category_id": 27,
        "name": "Con",
        "description": "<p>Used for unit of quantity measurement.</p>",
        "notation": false,
        "valid": false
      },
      {
        "id": 34,
        "category_id": 27,
        "name": "Cái",
        "description": "<p>Used for unit of quantity measurement.</p>",
        "notation": false,
        "valid": true
      },
      {
        "id": 35,
        "category_id": 29,
        "name": "m",
        "description": "<p>Used for unit of distance measurement.</p>",
        "notation": false,
        "valid": true
      },
      {
        "id": 36,
        "category_id": 29,
        "name": "km",
        "description": "<p>Used for unit of distance measurement.</p>",
        "notation": false,
        "valid": true
      }
    ];
    List<Unit> list = List.from(json)
        .map((json) => Unit.fromJson(json))
        .toList();
    DiaryDB.instance.insertListUnit(list);
    return list;
  }

  @override
  Future<List<Diary>> getListDiary() async{
    var json = [
      {
        "id": 1,
        "season_farm_id": 1,
        "activity_id": 1,
        "name": "Mùa lúa 2022 - Phạm văn đè",
        "by_name": "Phạm văn đè",
        "startTime": "10/11/2022",
        "endTime": "20/01/2023",
        "status": 0,
        "description": "Sản xuất lúa thu đông năm 2022 phục vụ xuất nhập khẩu trong và ngoài nước"
      },
      {
        "id": 1,
        "season_farm_id": 1,
        "activity_id": 1,
        "name": "Mùa lúa 2022 - Phạm văn đè",
        "by_name": "Phạm văn đè",
        "startTime": "10/11/2022",
        "endTime": "20/01/2023",
        "status": 1,
        "description": "Sản xuất lúa thu đông năm 2022 phục vụ xuất nhập khẩu trong và ngoài nước"
      },
      {
        "id": 2,
        "season_farm_id": 2,
        "activity_id": 2,
        "name": "Mùa điều 2022 - Phạm văn đè",
        "by_name": "Phạm văn đè",
        "startTime": "20/11/2022",
        "endTime": "20/01/2023",
        "status": 1,
        "description": "Sản xuất điều thu đông năm 2022 phục vụ xuất nhập khẩu trong và ngoài nước"
      },
      {
        "id": 3,
        "season_farm_id": 3,
        "activity_id": 3,
        "name": "Mùa bắp cải 2022 - Phạm văn đè",
        "by_name": "Phạm văn đè",
        "startTime": "5/11/2022",
        "endTime": "20/12/2022",
        "status": 2,
        "description": "Sản xuất bắp cải thu đông năm 2022 phục vụ xuất nhập khẩu trong và ngoài nước"
      },
      {
        "id": 4,
        "season_farm_id": 4,
        "activity_id": 4,
        "name": "Mùa điều 2022 - Phạm văn đè",
        "by_name": "Phạm văn đè",
        "startTime": "20/3/2022",
        "endTime": "20/12/2022",
        "status": 1,
        "description": "Sản xuất điều thu đông năm 2022 phục vụ xuất nhập khẩu trong và ngoài nước"
      },
      {
        "id": 5,
        "season_farm_id": 5,
        "activity_id": 5,
        "name": "Mùa điều 2022 - Phạm văn đè",
        "by_name": "Phạm văn đè",
        "startTime": "20/3/2022",
        "endTime": "20/12/2022",
        "status": 1,
        "description": "Sản xuất điều thu đông năm 2022 phục vụ xuất nhập khẩu trong và ngoài nước"
      },
    ];
    List<Diary> list = List.from(json)
        .map((json) => Diary.fromJson(json))
        .toList();
    DiaryDB.instance.insertListDiary(list);
    return list;
  }

  @override
  Future<Diary> getDetailDiary(int id) async{
    var json =
      {
        "id": 1,
        "season_farm_id": 1,
        "activity_id": 25,
        "action_time": "2022-05-11 08:08:10",
        "action_area": 1.0,
        "action_area_unit_id": "km",
        "description": "Sản xuất lúa thu đông năm 2022 phục vụ xuất nhập khẩu trong và ngoài nước",
        "name_activity": "Garden Care",
        "tool":[
          {
            "id": 1,
            "name": "Máy cào cỏ chuyên dụng",
            "diary_farmer_id": 4,
            "tool_id": 1,
            "description": "<p>Máy cào cỏ chuyên dụng</p>",
            "quantity": 5,
            "unit_id": "cái"
          },
          {
            "id": 2,
            "name": "Broom",
            "diary_farmer_id": 2,
            "tool_id": 2,
            "description": "<p>Broom</p>",
            "quantity": 5,
            "unit_id": "cái"
          },
          {
            "id": 3,
            "diary_farmer_id": 3,
            "tool_id": 3,
            "name": "Saw",
            "category_id": 4,
            "quantity": 5,
            "unit_id": "cái"
          },
        ],
        "material": [
          {
            "id": 1,
            "diary_farmer_id": 3,
            "tool_id": 3,
            "category_id": 3,
            "name": "Garlic",
            "is_organic": false,
            "description": "<p>Sử dụng tỏi chăm sóc cây trồng.</p>",
            "is_active": false,
            "quantity": 5,
            "unit_id": "cái"
          },
        ]
      };
    Diary list = Diary.fromJson(json);
    return list;
  }

  
}