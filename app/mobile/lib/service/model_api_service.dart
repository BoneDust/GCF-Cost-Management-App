import 'dart:async';
import 'dart:io';
import 'package:async/async.dart';
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
import 'package:path/path.dart';

class ApiService<T> {
  var client = new http.Client();

  String url = AppData.baseUrl + endPointMap[T];

  Map<String, String> headers = {
    'token': AppData.authToken,
    'Content-Type': 'application/json'
  };

  Future<List<T>> getAll([String filter]) async {
    String filteredUrl = filter == null ? url : url + "?" + filter;
    List<T> result;
    try {
      await client
          .get(Uri.parse(filteredUrl), headers: headers)
          .then((response) {
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);
        if (response.statusCode == 200) {
          JsonFileUtil.writeJsonText(
              response.body, AppData.user.name, endPointMap[T]);

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
      await client
          .get(Uri.parse(url + "/" + id.toString()), headers: headers)
          .then((response) {
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
      await client
          .get(
              Uri.parse(url +
                  "/" +
                  endPointMap[T] +
                  "ByProject" +
                  "/" +
                  projectId.toString()),
              headers: headers)
          .then((response) {
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

  Future<List<T>> getByUser(int projectId) async {
    List<T> result;

    try {
      await client
          .get(
              Uri.parse(url +
                  "/" +
                  endPointMap[T] +
                  "ByUser" +
                  "/" +
                  projectId.toString()),
              headers: headers)
          .then((response) {
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
          .put(Uri.parse(url + "/" + id.toString()),
              headers: headers, body: body)
          .then((response) {
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);
        if (response.statusCode == 200) {
          result = CustomJsonTools.createObject<T>(jsonResponse[mapTypes[T]]);
          return result;
        }
        throw ("could not update " + mapTypes[T]);
      });
    } on SocketException {
      throw ("no internet connection");
    } catch (e) {
      throw ("could not update " + mapTypes[T]);
    }
    return result;
  }

  Future<bool> delete(int id) async {
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

  Future<T> createWithPicture(T item, File image) async {
    try {

      var stream =
          new http.ByteStream(DelegatingStream.typed(image.openRead()));
      var length = await image.length();

      var uri = Uri.parse(
          "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/pictures");

      var request = new http.MultipartRequest("POST", uri);

      var multipartFile = new http.MultipartFile('somefile', stream, length,
          filename: basename(image.path));

      Map<String, String> headersCopy = Map();
      headersCopy.putIfAbsent("token" , () =>  mapTypes[T]);

      request.headers.addAll(headers);
      request.files.add(multipartFile);
      var response = await request.send();

      if (response.statusCode == 200) {
        response.stream.transform(utf8.decoder).listen((value) {
          print(value);
        });
        return create(item);
      }
      throw("could not create");
    } catch (e) {
      throw ("no internet connection");
    }
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
