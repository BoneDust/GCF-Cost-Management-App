import 'dart:async';
import 'dart:io';
import 'package:cm_mobile/data/app_data.dart';
import 'package:cm_mobile/model/activity.dart';
import 'package:cm_mobile/model/client.dart';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/model/stage.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/util/custom_json_converter.dart';
import 'package:cm_mobile/util/save_json_file.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService<T> {
  var client = new http.Client();

  String url = AppData.baseUrl + endPointMap[T];

  Map<String, String> headers = {
    'token': AppData.authToken,
    'Content-Type': 'application/json'
  };

  Future<List<T>> getAll() async {
    List<T> result;
    try {
      await client.get(Uri.parse(url), headers: headers).then((response) {
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);
        if (response.statusCode == 200) {
          JsonFileUtil.writeJsonText(response.body, endPointMap[T] );

          print(jsonResponse[endPointMap[T]]);

          result = (jsonResponse[endPointMap[T]] as List)
              .map((i) => CustomJsonTools.createObject<T>(i))
              .toList();


          return result;
        }
        throw ("could not get " + endPointMap[T]);

      });
    } catch (e) {
      print(e);
      throw ("no internet connection");
    }

    return result;
  }

  Future<T> getById(int id) async {
    T result;

    try {
      await client.get(Uri.parse(url + "/" + id.toString()), headers: headers).then((response) {
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);
        if (response.statusCode == 200) {
          result = CustomJsonTools.createObject<T>(jsonResponse[mapTypes[T]]);
          return result;
        }
        throw ("could not get " + mapTypes[T]);
      });
    } catch (e) {
      throw ("no internet connection");
    }

    return result;
  }

  Future<List<T>> getByProject(int projectId) async {
    List<T> result;

    try {
      await client.get(Uri.parse(url +"/"+ endPointMap[T] +"ByProject"+ "/" + projectId.toString()), headers: headers).then((response) {
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);
        if (response.statusCode == 200) {
          print(jsonResponse[endPointMap[T]]);
          result = (jsonResponse[endPointMap[T]] as List)
              .map((i) => CustomJsonTools.createObject<T>(i))
              .toList();
          return result;
        }
        throw ("could not get " + endPointMap[T]);
      });
    } catch (e) {
      print(e);
      throw ("no internet connection");
    }

    return result;
  }

  Future<T> create(T item) async {
    T result;

    String body = json.encode(item);

    print(body);
    try {
      await client
          .post(Uri.parse(url), headers: headers, body: body)
          .then((response) {
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);
        if (response.statusCode == 201) {
          result = CustomJsonTools.createObject<T>(jsonResponse[mapTypes[T]]);
          return result;
        }
        throw ("could create " + mapTypes[T]);

      });
    } catch (e) {
      throw ("no internet connection");
    }
    return result;
  }

  Future<T> update(T item, int id) async {
    T result;

    String body = json.encode(item);
    print(body);
    try {
      await client
          .put(Uri.parse(url + "/" + id.toString()), headers: headers, body: body)
          .then((response) {
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);
        if (response.statusCode == 200) {
          result = CustomJsonTools.createObject<T>(jsonResponse[mapTypes[T]]);
          return result;
        }
        throw ("could not update " + mapTypes[T]);

      });
    }
    on SocketException{
      throw ("no internet connection");
    }
    catch (e) {
      throw ("could not update " + mapTypes[T]);
    }
    return result;
  }



  Future<bool> delete( int id) async {
    bool deletedStatus = false;
    try {
      await client
          .delete(Uri.parse(url + "/" + id.toString()), headers: headers)
          .then((response) {
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);
        if (response.statusCode == 200) {
          deletedStatus = true;
        }
      });
    } catch (e) {
      throw ("no internet connection");
    }
    return deletedStatus;
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

const Map<Type, String> mapTypes = {
  Project: "project",
  Stage: "stage",
  Activity: "activity",
  User: "user",
  Client: "client",
  Receipt: "receipt",
};
