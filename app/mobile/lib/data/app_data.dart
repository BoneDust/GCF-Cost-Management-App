import 'package:cm_mobile/model/user.dart';

class AppData{
  static String authToken = "";
  static String baseUrl = "https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/";
  static User user;

  static bool isInitializing = true;
}