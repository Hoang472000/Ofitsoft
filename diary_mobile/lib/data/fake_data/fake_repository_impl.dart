import 'dart:async';

import 'package:diary_mobile/data/remote_data/object_model/object_result.dart';

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

  
}