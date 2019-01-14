import 'dart:io';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:cm_mobile/data/app_data.dart';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/service/model_api_service.dart';
import 'package:cm_mobile/util/StringUtil.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

void main() {
  Map<String, String> headers = {
    'token': AppData.authToken,
    'Content-Type': 'application/json'
  };


  test('my first unit test', () async {
    ApiService<User> apiService = ApiService<User>();
    var list = await apiService.getAll();
    print(list);

    var answer = 42;
    expect(answer, 42);
  });
}
