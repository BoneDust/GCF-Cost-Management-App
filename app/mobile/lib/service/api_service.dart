import 'dart:async';
import 'package:cm_mobile/data/app_data.dart';
import 'package:cm_mobile/data/dummy_data.dart';
import 'package:cm_mobile/model/api_response.dart';
import 'package:cm_mobile/model/activity.dart';
import 'package:cm_mobile/model/auth_state.dart';
import 'package:cm_mobile/model/client.dart';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/model/stage.dart';
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

  Future<User> getUser(int id) async {
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

    String _url =
        "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/projects";
    List<Project> projects = [];

    Map<String, String> headers = Map();
    headers.putIfAbsent("token", () => AppData.authToken);
    headers.putIfAbsent("Content-Type", () => "application/json");

    await client.get(Uri.parse(_url), headers: headers).then((response) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      projects = (jsonResponse["projects"] as List)
          .map((i) => Project.fromJson(i))
          .toList();
    });
    return projects;
  }

  Future<List<Activity>> queryActivities(String value) async {
    String _url =
        "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/activities";
    List<Activity> activities = [];

    Map<String, String> headers = Map();
    headers.putIfAbsent("token", () => AppData.authToken);
    headers.putIfAbsent("Content-Type", () => "application/json");

    await client.get(Uri.parse(_url), headers: headers).then((response) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      activities = (jsonResponse["activities"] as List)
          .map((i) => new Activity.fromJson(i))
          .toList();
    });

    return activities;
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

    await client.post(Uri.parse(_url), headers: headers).then((response) {
      var jsonResponse = json.decode(response.body);
      AppData.authToken = jsonResponse["access_token"];
      print(jsonResponse);
    });

    return authenticationState;
  }

  Future<AuthenticationState> logout(User user) async {
    String _url =
        "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/users/logout";

    Map<String, String> headers = Map();
    headers.putIfAbsent("token", () => AppData.authToken);

    await client.post(Uri.parse(_url), headers: headers).then((response) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
    });

    return AuthenticationState(
        isInitializing: false, isAuthenticated: false, isLoading: false);
  }

  Future<ApiResponse> addProject(Project project) async {
    ApiResponse apiResponse =
        ApiResponse.withError("failed to create project", 1);
    String _url =
        "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/projects";

    Map<String, String> headers = Map();
    headers.putIfAbsent("token", () => AppData.authToken);
    headers.putIfAbsent("Content-Type", () => "application/json");

    String body = json.encode(project);
    print(body);
    try {
      await client
          .post(Uri.parse(_url), headers: headers, body: body)
          .then((response) {
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);
        if (response.statusCode == 201)
          apiResponse = ApiResponse.isSuccess(
              "project created successfully", response.statusCode, object: Project.fromJson(jsonResponse["project"]));
        else
          apiResponse =
              ApiResponse.withError(jsonResponse['error'], response.statusCode);
      }).timeout(Duration(seconds: 120));
    } catch (e) {
      apiResponse = ApiResponse.withError("no internet connection", 1);
    }

    return apiResponse;
  }

  Future<Receipt> addReceipt(Receipt receipt) async {
    String _url =
        "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/project";

    Map<String, String> headers = Map();
    headers.putIfAbsent("token", () => AppData.authToken);

    await client.post(Uri.parse(_url), headers: headers).then((response) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
    });

    return Receipt();
  }

  Future<User> addUser(User user) async {
    String _url =
        "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/project";

    Map<String, String> headers = Map();
    headers.putIfAbsent("token", () => AppData.authToken);

    await client.post(Uri.parse(_url), headers: headers).then((response) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
    }).timeout(Duration(seconds: 20));

    return User();
  }

  Future<List<User>> queryUsers(String value) async {
    String _url =
        "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/activites";

    Map<String, String> headers = Map();
    headers.putIfAbsent("access_token", () => AppData.authToken);

    await client.post(Uri.parse(_url), headers: headers).then((response) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
    });

    var resultList = DummyData.getUsers;
    var filteredList = resultList;

    return filteredList;
  }

  Future<Client> addClient(Client user) async {
    String _url =
        "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/project";

    Map<String, String> headers = Map();
    headers.putIfAbsent("token", () => AppData.authToken);
    await client.post(Uri.parse(_url), headers: headers).then((response) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
    });

    return Client();
  }

  Future<List<Client>> queryClients(String value) async {
    String _url =
        "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/activites";

    Map<String, String> headers = Map();
    headers.putIfAbsent("access_token", () => AppData.authToken);

    await client.post(Uri.parse(_url), headers: headers).then((response) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
    });

    var resultList = DummyData.getClients;
    var filteredList = resultList;

    return filteredList;
  }

  Future<Client> getClient(int id) async {
    await Future.delayed(Duration(seconds: 2));

//     await _client.get(Uri.parse(_url))
//         .then((response) => response.body)
//         .then(json.decode)
//         .then((json) => json["results"])
//         .then((list) => list.forEach((item) => resultList.add(Project.fromJson(item))));

    return DummyData.getClient;
  }

  Future<ApiResponse> updateProject(Project project) async {
    ApiResponse apiResponse =
        ApiResponse.withError("failed to update project", 1);
    String _url =
        "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/projects/" + project.id.toString();

    Map<String, String> headers = Map();
    headers.putIfAbsent("token", () => AppData.authToken);
    headers.putIfAbsent("Content-Type", () => "application/json");

    String body = json.encode(project);
    print(body);
    try {
      await client
          .put(Uri.parse(_url), headers: headers, body: body)
          .then((response) {
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);
        if (response.statusCode == 200)
          apiResponse = ApiResponse.isSuccess(
              "project update successfully", response.statusCode);
        else
          apiResponse =
              ApiResponse.withError(jsonResponse['error'], response.statusCode);
      }).timeout(Duration(seconds: 120));
    } catch (e) {
      apiResponse = ApiResponse.withError("no internet connection", 1);
    }

    return apiResponse;
  }

  getStage(int id) {}

  Future<List<Stage>> queryStages(String value) async {
    String _url =
        "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/activities";
    List<Stage> stages = DummyData.stages;

//    Map<String, String> headers = Map();
//    headers.putIfAbsent("token", () => AppData.authToken);
//    headers.putIfAbsent("Content-Type", () => "application/json");
//
//    await client.get(Uri.parse(_url), headers: headers).then((response) {
//      var jsonResponse = json.decode(response.body);
//      print(jsonResponse);
//      stages = (jsonResponse["stages"] as List)
//          .map((i) => new Stage.fromJson(i))
//          .toList();
//    });

    return stages;
  }

  Future<ApiResponse> addStage(Stage stage) async {
    ApiResponse apiResponse =
    ApiResponse.withError("failed to create stage", 1);
    String _url =
        "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/projects";

    Map<String, String> headers = Map();
    headers.putIfAbsent("token", () => AppData.authToken);
    headers.putIfAbsent("Content-Type", () => "application/json");

    String body = json.encode(stage);
    print(body);
    try {
      await client
          .post(Uri.parse(_url), headers: headers, body: body)
          .then((response) {
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);
        if (response.statusCode == 201)
          apiResponse = ApiResponse.isSuccess(
              "stage created successfully", response.statusCode, object: Project.fromJson(jsonResponse["stage"]));
        else
          apiResponse =
              ApiResponse.withError(jsonResponse['error'], response.statusCode);
      }).timeout(Duration(seconds: 120));
    } catch (e) {
      apiResponse = ApiResponse.withError("no internet connection", 1);
    }

    return apiResponse;
  }
}
