import 'dart:async';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/model/stage.dart';
import 'package:http/http.dart' as http;
import 'package:cm_mobile/model/project.dart';
import 'dart:convert';

class ApiService {
  http.Client _client = new http.Client();
  String _url = "";

  Future<List<Project>> getAll() async {
    List<Project> resultList = [Project(id: 1), Project(id: 1), Project(id: 1), Project(id: 1), Project(id: 1), Project(id: 1), Project(id: 1)];
    await Future.delayed(Duration(seconds: 2));

//     await _client.get(Uri.parse(_url))
//         .then((response) => response.body)
//         .then(json.decode)
//         .then((json) => json["results"])
//         .then((list) => list.forEach((item) => resultList.add(Project.fromJson(item))));

    return resultList;
  }

  Future<Project> get(String id) async {
    Project result = Project(
        id: 1,
        stages: [Stage(), Stage(), Stage()]
        , receipts: [
          Receipt(supplier: "sdfsd", description: "sdfsdfds"),
          Receipt(supplier: "sdfsd", description: "sdfsdfds"),
          Receipt(supplier: "sdfsd", description: "sdfsdfds"),
          Receipt(supplier: "sdfsd", description: "sdfsdfds"),

    ]);
    await Future.delayed(Duration(seconds: 2));

//     await _client.get(Uri.parse(_url))
//         .then((response) => response.body)
//         .then(json.decode)
//         .then((json) => json["results"])
//         .then((list) => list.forEach((item) => resultList.add(Project.fromJson(item))));

    return result;
   }
}
