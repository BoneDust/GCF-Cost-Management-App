import 'package:cm_mobile/model/user.dart';

class AppData{
  static String authToken = "";
    static String baseUrl = "https://iggpamghta.execute-api.us-east-1.amazonaws.com/dev/";
  static User user;

  static bool isInitializing = true;
  static bool isInitializingData = true;
}