import 'dart:async';

import 'package:cm_mobile/model/client.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:rxdart/rxdart.dart';

import 'base_bloc.dart';

class ClientBloc extends BlocBase {
  StreamController<Client> _getClientController = StreamController<Client>();
  Stream<Client> get outClient => _getClientController.stream;
  Sink<Client> get inClient => _getClientController.sink;

  final ApiService _apiService;

  ClientBloc(this._apiService);
  @override
  void dispose() {
    _getClientController.close();
  }

  void getClient(int id) {
    _apiService.getClient(id).then((user) {
      inClient.add(user);
    });
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
    _queryResults = _query
        .distinct()
        .asyncMap(_apiService.queryClients)
        .asBroadcastStream();
  }

  @override
  void dispose() {
    _query.close();
    _addedClientController.close();
  }

  void addClient(Client client) {
    _apiService
      ..addClient(client).then((user) {
        inAddedClient.add(client);
      });
  }
}
