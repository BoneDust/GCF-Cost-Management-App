import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/profile/profile.dart';
import 'package:flutter/material.dart';

class ManagerUserScreen extends StatelessWidget {
  final User user;

  const ManagerUserScreen({@required this.user});
  @override
  Widget build(BuildContext context) {
    return ProfileScreen();
  }
}
