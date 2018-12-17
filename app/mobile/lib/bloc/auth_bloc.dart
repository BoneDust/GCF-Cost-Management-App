import 'dart:async';

import 'package:cm_mobile/model/user_login.dart';
import 'package:cm_mobile/model/auth_state.dart';
import 'package:cm_mobile/service/api_service.dart';

import 'base_bloc.dart';

class AuthBloc extends BlocBase {
  final ApiService _apiService;

  StreamController<AuthenticationState> _loginController = StreamController<AuthenticationState>();

  Sink<AuthenticationState> get _inAuthState => _loginController.sink;

  Stream<AuthenticationState> get outAuthState => _loginController.stream;

  AuthBloc(this._apiService);

  @override
  void dispose() {
    _loginController.close();
  }

  void authenticateUser(UserLogin userLogin) {
    _apiService.authenticateUser(userLogin).then((authState) {
      _inAuthState.add(authState);
    });
  }
}
