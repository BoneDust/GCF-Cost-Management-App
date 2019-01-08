import 'dart:async';
import 'package:cm_mobile/data/app_data.dart';
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

  var client = new http.Client();

  Future<List<Project>> getAll() async {
    List<Project> resultList = DummyData.projectList;

//    await http
//        .get(Uri.parse(_url))
//        .then((response) => response.body)
//        .then(json.decode)
//        .then((json) => json["results"])
//        .then((list) =>
//            list.forEach((item) => resultList.add(Project.fromJson(item))));

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

  Future<List<Project>> queryProjects(String value) async {
    await Future.delayed(Duration(seconds: 2));

    var resultList = DummyData.projectList;
    var filteredList = resultList
        .where((project) =>
            project.description.toLowerCase().contains(value) ||
            project.name.toLowerCase().contains(value))
        .toList();
    return filteredList;
  }

  Future<List<Activity>> queryActivities(String value) async {

    String _url =
        "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/activites";

    Map<String, String> headers = Map();
    headers.putIfAbsent("access_token", () => AppData.authToken);

    await client.post(Uri.parse(_url), headers: headers).then((response){
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
    });

    var resultList = DummyData.activities;
    var filteredList = resultList;

    return filteredList;
  }

  Future<List<Receipt>> queryReceipts(String value) async {
    List<Receipt> resultList = DummyData.receipts;
    List<Receipt> filteredList = resultList;

    return filteredList;
  }

  Future<AuthenticationState> authenticateUser(UserLogin userLogin) async {

    String _url =
        "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/users/login";

    Map<String, String> headers = Map();
    headers.putIfAbsent("email", () => "MainAdmin@gcfprojects.co.za");
    headers.putIfAbsent("password", () => "Maintestering");
    AuthenticationState authenticationState = AuthenticationState(
        isInitializing: false, isAuthenticated: true, isLoading: false);

    await client.post(Uri.parse(_url), headers: headers).then((response){
      var jsonResponse = json.decode(response.body);
      AppData.authToken = jsonResponse["access_token"];
      print(jsonResponse);
    });

    return authenticationState;
  }

  Future<AuthenticationState>  logout(User user) async{

    String _url =
        "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/users/logout";

    Map<String, String> headers = Map();
    headers.putIfAbsent("token", () => AppData.authToken);

    await client.post(Uri.parse(_url), headers: headers).then((response){
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
    });

    return AuthenticationState(
        isInitializing: false, isAuthenticated: false, isLoading: false);
  }

  Future<Project> addProject(Project project) async{
    String _url =
        "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/projects";

    Map<String, String> headers = Map();
    headers.putIfAbsent("token", () => AppData.authToken);
    String body = json.encode(project);
    var encoded = json.encode(project);
    print(encoded);
    await client.post(Uri.parse(_url), headers: headers, body: body).then((response){
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
    });

    return Project();
  }

  Future<Receipt> addReceipt(Receipt receipt) async{
    String _url =
        "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/project";

    Map<String, String> headers = Map();
    headers.putIfAbsent("token", () => AppData.authToken);

    await client.post(Uri.parse(_url), headers: headers).then((response){
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
    });

    return Receipt();
  }

  Future<User> addUser(User user) async{
    String _url =
        "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/project";

    Map<String, String> headers = Map();
    headers.putIfAbsent("token", () => AppData.authToken);

    await client.post(Uri.parse(_url), headers: headers).then((response){
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
    });

    return User();
  }

  Future<List<User>> queryUsers(String value) async {

    String _url =
        "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/activites";

    Map<String, String> headers = Map();
    headers.putIfAbsent("access_token", () => AppData.authToken);

    await client.post(Uri.parse(_url), headers: headers).then((response){
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
    });

    var resultList = DummyData.getUsers;
    var filteredList = resultList;

    return filteredList;
  }

}
