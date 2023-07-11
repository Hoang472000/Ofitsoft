
import 'dart:async';
import 'dart:convert';

import 'package:diary_mobile/data/remote_data/object_model/object_result.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/widgets/dialog_manager.dart';
import 'fake_data/fake_repository_impl.dart';
import 'repository.dart';

import "package:http/http.dart" as http;

class RepositoryImpl extends Repository {
  final FakeRepositoryImpl _fakeData = FakeRepositoryImpl();
  //final bool isFakeData = FakeDataSource.isFake;


  // final ApiProvider _apiProvider = ApiProvider();

  //final NetworkExecutor networkExecutor = NetworkExecutor();

  BuildContext context;
  //late NetworkExecutor networkExecutor;

  RepositoryImpl({required this.context}) {
    //networkExecutor = NetworkExecutor(context: context);
  }
  @override
  Future<ObjectResult> login(String userName, String pass) async {
    final Map<String, Object> params = {
      'db': "visdiary",
      'login': userName,
      'password': pass,
      'context': {}
    };
    Map<String, String> _headers = {};
    _headers["Content-type"] = "application/json";
    //final response = await http.Client().post(Uri.parse('http://qlvsx.ofitsoft.com:8069/api/login'), body: jsonEncode(params), headers: _headers);
    //print("HoangCV: login response: ${response.body}");
    ObjectResult objectResult =  ObjectResult(1, "object", "1", true, false);
    if (objectResult.isOK) {
    }
    else {
      DiaLogManager.showDialogHTTPError(
        status: objectResult.status,
        resultStatus: objectResult.status,
        resultObject: objectResult.object,
      );
    }
    return objectResult;
  }

  @override
  Future<bool> checkExpToken() async{
    return true;
  }


}