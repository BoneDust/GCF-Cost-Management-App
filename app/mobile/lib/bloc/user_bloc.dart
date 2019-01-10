import 'dart:async';

import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:rxdart/rxdart.dart';

import 'base_bloc.dart';

class UserBloc extends BlocBase {
  Stream<User> _results = Stream.empty();

  StreamController<User> _userController = StreamController<User>();
  get outUser => _userController.stream.asBroadcastStream();
  Sink<User> get inUser => _userController.sink;


  Stream<User> get results => _results;

  final ApiService _apiService;

  ReplaySubject<int> _query = ReplaySubject<int>();

  Sink<int> get query => _query;

  UserBloc(this._apiService) {
    _results = _query
        .distinct()
        .asyncMap(_apiService.getUser)
        .asBroadcastStream();
  }

  @override
  void dispose() {
    _query.close();
    _userController.close();
  }

  void getUser(int userName) {
    query.add(userName);
  }
}

class UsersBloc implements BlocBase {
  Stream<List<User>> _queryResults = Stream.empty();

  Stream<List<User>> get results => _queryResults;
  StreamController<User> _addedProjectController = StreamController<User>();

  Stream<User> get outAddedProject => _addedProjectController.stream;
  Sink<User> get inAddedUser => _addedProjectController.sink;

  final ApiService _apiService;

  ReplaySubject<String> _query = ReplaySubject<String>();

  Sink<String> get query => _query;

  UsersBloc(this._apiService) {
    _queryResults =
        _query.distinct().asyncMap(_apiService.queryUsers).asBroadcastStream();
  }

  @override
  void dispose() {
    _query.close();
    _addedProjectController.close();

  }

  void addUser(User user) {
    _apiService.addUser(user).then((user) {
      inAddedUser.add(user);
    });
  }
}