import 'dart:async';
import 'package:cm_mobile/data/app_data.dart';
import 'package:cm_mobile/model/auth_state.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/model/user_login.dart';
import 'package:cm_mobile/util/save_json_file.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class AuthApiService {
  var client =  http.Client();

  Future<User> authenticateUser(UserLogin userLogin) async {
    User user;

    String _url =
        "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/users/login";

    Map<String, String> headers = Map();
//    headers.putIfAbsent("email", () => "shheu");
//    headers.putIfAbsent("password", () => "dfgsdfsd");
    headers.putIfAbsent("email", () => "admin@user.com");
    headers.putIfAbsent("password", () => "asdfeqewf353539999**-");
    try {
      await client.post(Uri.parse(_url), headers: headers).then((response) async {
        var jsonResponse = json.decode(response.body);
        if (response.statusCode == 200) {
          AppData.authToken = jsonResponse["access_token"];
          await JsonFileUtil.writeJsonText(AppData.authToken, null, "auth_token");
          await JsonFileUtil.writeJsonText(response.body, null, "user");
          user = User.fromJson(jsonResponse['user']);
          AppData.user = user;


          return user;
        }
        throw ("username or password is incorrect");

      }).timeout(Duration(seconds: 60));

    }
    on SocketException{
      throw ("no internet connection");
    }
    return user;
  }

  Future<AuthenticationState> logout(User user) async {
    String _url =
        "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/users/logout";

    Map<String, String> headers = Map();
    headers.putIfAbsent("token", () => AppData.authToken);


    try {
      await client.post(Uri.parse(_url), headers: headers).then((response) {
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);
      });

    }
    on SocketException{
      throw ("no internet connection");
    }

    return AuthenticationState.unauthenticated();
  }
}
