import 'dart:async';

import 'package:cm_mobile/model/auth_state.dart';

import 'base_bloc.dart';

class LoginBloc extends BaseBloc {
  StreamController<AuthenticationState> authController =
      StreamController<AuthenticationState>();

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
