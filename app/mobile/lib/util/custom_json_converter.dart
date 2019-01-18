import 'package:cm_mobile/model/index.dart';

class CustomJsonTools{

  static double getDouble(var number) {
    if (number is double) return number;
    if (number is int) {
      return number.toDouble();
    }
    if (number is String) return double.parse(number);
    return 0.0;
  }

  static T createObject<T> (jsonObject) {
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
}