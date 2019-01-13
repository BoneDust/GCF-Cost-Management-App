import 'dart:async';
import 'dart:io';
import 'package:cm_mobile/data/app_data.dart';
import 'package:cm_mobile/model/activity.dart';
import 'package:cm_mobile/model/client.dart';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/model/stage.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/model/project.dart';
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
          print(jsonResponse[endPointMap[T]]);

          result = (jsonResponse[endPointMap[T]] as List)
              .map((i) => createObject(i))
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
          result = createObject(jsonResponse[mapTypes[T]]);
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
              .map((i) => createObject(i))
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
          result = createObject(jsonResponse[mapTypes[T]]);
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
          result = createObject(jsonResponse[mapTypes[T]]);
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

  T createObject(jsonObject) {
    switch (T) {
      case Project:
        return Project.fromJson(jsonObject) as T;
      case Stage:
        return Stage.fromJson(jsonObject) as T;
      case Activity:
        return Activity.fromJson(jsonObject) as T;
      case User:
        return User.fromJson(jsonObject) as T;
      case Client:
        return Client.fromJson(jsonObject) as T;
      case Receipt:
        return Receipt.fromJson(jsonObject) as T;
      default:
        return null;
    }
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
