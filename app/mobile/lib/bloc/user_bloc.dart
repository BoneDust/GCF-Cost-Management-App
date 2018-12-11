import 'dart:async';

import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/service/api_service.dart';

import 'base_bloc.dart';

class UserBloc extends BlocBase {

  User _user;
  final String _id;

  final ApiService _apiService;

  StreamController<User> _userController = StreamController<User>();

  Sink<User> get _inUser => _userController.sink;

  Stream<User> get outUser => _userController.stream;


  UserBloc(this._id, this._apiService);

  @override
  void dispose() {
    _inUser.close();
    _userController.close();
  }


  void  getUser() {
    _apiService.getUser(_id).then((user) {
      _user = user;
      _inUser.add(_user);
    });
  }
}
