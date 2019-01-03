import 'dart:async';

import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/model/user_login.dart';
import 'package:cm_mobile/model/auth_state.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:rxdart/rxdart.dart';

import 'base_bloc.dart';

class AuthBloc extends BlocBase {
  final _authStatus = StreamController<AuthenticationState>.broadcast();

  ApiService _apiService;

  AuthBloc(this._apiService);

  Sink<AuthenticationState> get inAuth => _authStatus.sink;

  Stream<AuthenticationState> get results => _authStatus.stream;


  @override
  void dispose() {
    _authStatus.close();
  }

  void authenticateUser(UserLogin userLogin) {
    _apiService.authenticateUser(userLogin).then((authStatus) => inAuth.add(authStatus));
  }

  void logout(User user){
    _apiService.logout(user).then((authStatus) => inAuth.add(authStatus));

  }
}