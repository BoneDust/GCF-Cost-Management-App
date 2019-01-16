import 'dart:io';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:cm_mobile/data/app_data.dart';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/service/model_api_service.dart';
import 'package:cm_mobile/util/StringUtil.dart';
import 'package:cm_mobile/util/save_json_file.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() {



  test('my first unit test', () async {
    JsonFileUtil.addReceiptToOfflineCache(Receipt(description: "sdfsdf"), "mushagi");
  });
}
