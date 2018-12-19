import 'dart:async';

import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:rxdart/rxdart.dart';

import 'base_bloc.dart';

class UserBloc extends BlocBase {
  Stream<User> _results = Stream.empty();


  Stream<User> get results => _results;

  final ApiService _apiService;

  ReplaySubject<String> _query = ReplaySubject<String>();

  Sink<String> get query => _query;

  UserBloc(this._apiService) {
    _results = _query
        .distinct()
        .asyncMap(_apiService.getUser)
        .asBroadcastStream();
  }

  @override
  void dispose() {
    _query.close();
  }

  void getUser(String userName) {
    query.add(userName);
  }
}
