  class CustomJsonConverter{
  static double getDouble(var number) {
    if (number is double) return number;
    if (number is int) {
      return number.toDouble();
    }
    if (number is String) return double.parse(number);
    return 0.0;
  }
}