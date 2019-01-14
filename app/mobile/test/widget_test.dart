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
import 'package:dio/dio.dart';

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

  test('my first  test', () async {

    upload(File imageFile) async {
      // open a bytestream
      var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      // get file length
      var length = await imageFile.length();

      // string to uri
      var uri = Uri.parse(AppData.baseUrl);

      // create multipart request
      var request = new http.MultipartRequest("POST", uri);
      request.headers.putIfAbsent("token", () => AppData.authToken);
      request.headers.putIfAbsent("Content-Type", () => "application/json");


      // multipart that takes file
      var multipartFile = new http.MultipartFile('file', stream, length,
          filename: basename(imageFile.path));

      // add file to multipart
      request.files.add(multipartFile);

      // send
      var response = await request.send();
      print(response.statusCode);

      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    }
    upload(_image);

    var answer = 42;
    expect(answer, 42);
  });


}
