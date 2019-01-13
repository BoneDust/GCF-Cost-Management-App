import 'package:cm_mobile/model/activity.dart';
import 'package:cm_mobile/model/auth_state.dart';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:flutter/material.dart';

class AppDataContainer extends StatefulWidget {
  final Widget child;
  AppDataContainer({@required this.child});

  static AppDataContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }

  @override
  AppDataContainerState createState() => AppDataContainerState();
}

class AppDataContainerState extends State<AppDataContainer> {
  User user;
  String token;
  AuthenticationState authState = AuthenticationState(
      isInitializing: true, isLoading: false, isAuthenticated: false);

  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }

  setUser(User user) {
    setState(() {
      this.user = user;
    });
  }

  setAuthState(AuthenticationState authState) {
    setState(() {
      this.authState = authState;
    });
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final AppDataContainerState data;

  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}
