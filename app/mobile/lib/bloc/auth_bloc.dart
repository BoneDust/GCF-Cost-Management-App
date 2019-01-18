import 'dart:async';

import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/model/user_login.dart';
import 'package:cm_mobile/model/auth_state.dart';
import 'package:cm_mobile/service/api_auth_service.dart';

import 'base_bloc.dart';

class AuthBloc extends BlocBase {
  final _loginController = StreamController<User>.broadcast();
  Sink<User> get inLogin => _loginController.sink;
  Stream<User> get outLogin => _loginController.stream;

  StreamController<AuthenticationState> _logoutController =
      StreamController<AuthenticationState>();
  Stream<AuthenticationState> get outLogout =>
      _logoutController.stream.asBroadcastStream();
  Sink<AuthenticationState> get _inLogout => _logoutController.sink;

  AuthApiService _authApiService;

  AuthBloc(this._authApiService);

  @override
  void dispose() {
    _logoutController.close();
    _loginController.close();
  }

  void authenticateUser(UserLogin userLogin) {
    _authApiService
        .authenticateUser(userLogin)
        .then((user) => inLogin.add(user))
        .catchError(_loginController.addError);
  }

  void logout(User user) {
    _authApiService
        .logout(user)
        .then((authStatus) => _inLogout.add(authStatus))
        .catchError(_logoutController.addError);
  }
}
