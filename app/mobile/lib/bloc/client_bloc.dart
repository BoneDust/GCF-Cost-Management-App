import 'dart:async';

import 'package:cm_mobile/model/client.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:rxdart/rxdart.dart';

import 'base_bloc.dart';

class ClientBloc extends BlocBase {
  Stream<Client> _results = Stream.empty();


  Stream<Client> get results => _results;

  final ApiService _apiService;

  ReplaySubject<String> _query = ReplaySubject<String>();

  Sink<String> get query => _query;

  ClientBloc(this._apiService) {
    _results = _query
        .distinct()
        .asyncMap(_apiService.getClient)
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

class ClientsBloc implements BlocBase {
  Stream<List<Client>> _queryResults = Stream.empty();

  Stream<List<Client>> get results => _queryResults;
  StreamController<Client> _addedClientController = StreamController<Client>();

  Stream<Client> get outAddedClient => _addedClientController.stream;
  Sink<Client> get inAddedClient => _addedClientController.sink;

  final ApiService _apiService;

  ReplaySubject<String> _query = ReplaySubject<String>();

  Sink<String> get query => _query;

  ClientsBloc(this._apiService) {
    _queryResults =
        _query.distinct().asyncMap(_apiService.queryClients).asBroadcastStream();
  }

  @override
  void dispose() {
    _query.close();
    _addedClientController.close();

  }

  void addClient(Client client) {
    _apiService..addClient(client).then((user) {
      inAddedClient.add(client);
    });
  }
}