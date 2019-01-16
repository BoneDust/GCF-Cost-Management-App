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



  test('my first unit test', () async {

    Map<String, String> headers = {
      'token': "fce594d0-182d-11e9-b6c1-3167d7297511",
    };
    File imageFile = File("/goinfre/mmayibo/Downloads/planets-preview.png");

    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse("https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/pictures");

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('somefile', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.headers.addAll(headers);
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });

  });
}
