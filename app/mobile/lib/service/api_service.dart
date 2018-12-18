import 'dart:async';
import 'package:cm_mobile/data/dummy_data.dart';
import 'package:cm_mobile/model/activity.dart';
import 'package:cm_mobile/model/auth_state.dart';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/model/user_login.dart';
import 'package:cm_mobile/model/project.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  String _url = "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/users";
  var client = new http.Client();

  Future<List<Project>> getAll() async {
    List<Project> resultList = DummyData.projectList;
    await http.get(Uri.parse(_url))
         .then((response) => response.body)
         .then(json.decode)
         .then((json) => json["results"])
         .then((list) => list.forEach((item) => resultList.add(Project.fromJson(item))));

    return resultList;
  }

  Future<Project> get(String id) async {
    Project result = DummyData.getProject();
    await Future.delayed(Duration(seconds: 2));

//     await _client.get(Uri.parse(_url))
//         .then((response) => response.body)
//         .then(json.decode)
//         .then((json) => json["results"])
//         .then((list) => list.forEach((item) => resultList.add(Project.fromJson(item))));

    return result;
  }

  Future<User> getUser(String id) async {
    User result = DummyData.currentUser;
    await Future.delayed(Duration(seconds: 2));

//     await _client.get(Uri.parse(_url))
//         .then((response) => response.body)
//         .then(json.decode)
//         .then((json) => json["results"])
//         .then((list) => list.forEach((item) => resultList.add(Project.fromJson(item))));

    return result;
  }

  Future<List<Project>> queryData(String value) async {
    var resultList = DummyData.projectList;
    var filteredList = resultList
        .where((project) =>
            project.description.toLowerCase().contains(value) ||
            project.name.toLowerCase().contains(value))
        .toList();
    return filteredList;
  }

  Future<List<Activity>> queryActivities(String value) async {
    var resultList = DummyData.activities;
    var filteredList = resultList;

    return filteredList;
  }

  Future<List<Receipt>> queryReceipts(String value) async {
    List<Receipt> resultList = DummyData.receipts;
    List<Receipt> filteredList = resultList;

    return filteredList;
  }

  Future<AuthenticationState>  authenticateUser(UserLogin userLogin) async {
    Map<String, String> headers = Map();
    headers.putIfAbsent("token", () => "c4997600-fe15-11e8-8362-9ff8808b2a50");

    AuthenticationState authenticationState = AuthenticationState(
        isInitializing: false, isAuthenticated: false, isLoading: false);

    await client.get(Uri.parse(_url), headers: headers).then((response) =>
        print(response.body)
    );


    return authenticationState;
  }
}
