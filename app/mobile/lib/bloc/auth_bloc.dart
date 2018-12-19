import 'dart:async';

import 'package:cm_mobile/model/user_login.dart';
import 'package:cm_mobile/model/auth_state.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:rxdart/rxdart.dart';

import 'base_bloc.dart';

class AuthBloc extends BlocBase {
  Stream<AuthenticationState> _results = Stream.empty();


  Stream<AuthenticationState> get results => _results;

  final ApiService _apiService;

  ReplaySubject<UserLogin> _query = ReplaySubject<UserLogin>();

  Sink<UserLogin> get query => _query;

  AuthBloc(this._apiService) {
    _results = _query
        .distinct()
        .asyncMap(_apiService.authenticateUser)
        .asBroadcastStream();
  }

  @override
  void dispose() {
    _query.close();
  }

  void authenticateUser(UserLogin userLogin) {
    query.add(userLogin);
  }

  void logout() {
    query.add(UserLogin());
  }
}