import 'dart:collection';
import 'dart:convert';

import 'package:cm_mobile/model/activity.dart';
import 'package:cm_mobile/model/client.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/model/stage.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/util/custom_json_converter.dart';
import 'package:cm_mobile/util/save_json_file.dart';

class ModelJsonFileUtil {
  static Future<List<T>> getAll<T>() async {
    String contents =  await JsonFileUtil.readFromFile(endPointMap[T]);
    List<T> result = [];

    try {
      var decoded = json.decode(contents);
      result = (decoded[endPointMap[T]] as List)
          .map((i) => CustomJsonTools.createObject<T>(i))
          .toList();

    }
    catch(error){
      print(error);
    }

    return result;
  }

}

const Map<Type, String> endPointMap = {
  Project: "projects",
  Stage: "stages",
  Activity: "activities",
  User: "users",
  Client: "clients",
  Receipt: "receipts",
};

const Map<Type, String> ModelsMap = {
  Project: "project",
  Stage: "stage",
  Activity: "activity",
  User: "user",
  Client: "client",
  Receipt: "receipt",
};
