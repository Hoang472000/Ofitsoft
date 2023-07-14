import 'dart:async';

import 'package:diary_mobile/data/remote_data/object_model/object_result.dart';

import '../entity/item_default/item_default.dart';
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
  Future<bool> getListActivities() {
    // TODO: implement getListActivities
    throw UnimplementedError();
  }

  @override
  Future<bool> getListMaterials() {
    // TODO: implement getListMaterials
    throw UnimplementedError();
  }

  @override
  Future<bool> getListTools() {
    // TODO: implement getListTools
    throw UnimplementedError();
  }

  @override
  Future<bool> getListUnits() {
    // TODO: implement getListUnits
    throw UnimplementedError();
  }

  
}