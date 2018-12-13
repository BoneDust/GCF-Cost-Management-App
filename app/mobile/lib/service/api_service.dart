import 'dart:async';
import 'package:cm_mobile/data/dummy_data.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/model/stage.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:cm_mobile/model/project.dart';
import 'dart:convert';

class ApiService {
  http.Client _client = new http.Client();
  String _url = "";

  Future<List<Project>> getAll() async {
    List<Project> resultList = List.generate(10, (index) => DummyData.projectList);

    await Future.delayed(Duration(seconds: 2));

//     await _client.get(Uri.parse(_url))
//         .then((response) => response.body)
//         .then(json.decode)
//         .then((json) => json["results"])
//         .then((list) => list.forEach((item) => resultList.add(Project.fromJson(item))));

    return resultList;
  }

  Future<Project> get(String id) async {
    Project result = DummyData.projectList;
    await Future.delayed(Duration(seconds: 2));

//     await _client.get(Uri.parse(_url))
//         .then((response) => response.body)
//         .then(json.decode)
//         .then((json) => json["results"])
//         .then((list) => list.forEach((item) => resultList.add(Project.fromJson(item))));

    return result;
  }

  Future<User> getUser(String id) async {
    User result = User(privileges: Privilege.ADMIN);
    await Future.delayed(Duration(seconds: 2));

//     await _client.get(Uri.parse(_url))
//         .then((response) => response.body)
//         .then(json.decode)
//         .then((json) => json["results"])
//         .then((list) => list.forEach((item) => resultList.add(Project.fromJson(item))));

    return result;
  }
}
