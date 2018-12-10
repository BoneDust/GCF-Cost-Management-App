class User {
  int id;
  String name;
  String surname;
  String username;
  String password;
  String pictureUrl;
  String contactNo;
  String privileges;


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
