import 'dart:async';

import 'package:cm_mobile/model/client.dart';
import 'package:cm_mobile/model/stage.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:rxdart/rxdart.dart';

import 'base_bloc.dart';

class StageBloc extends BlocBase {
  StreamController<Stage> _stageController = StreamController<Stage>();
  Stream<Stage> get outStage => _stageController.stream;
  Sink<Stage> get inStage => _stageController.sink;

  final ApiService _apiService;

  StageBloc(this._apiService);
  @override
  void dispose() {
    _stageController.close();
  }

  void getStage(int id) {
    _apiService.getStage(id).then((user) {
      inStage.add(user);
    });
  }
}

class StagesBloc implements BlocBase {
  Stream<List<Stage>> _queryResults = Stream.empty();

  Stream<List<Stage>> get results => _queryResults;
  StreamController<Stage> _addedClientController = StreamController<Stage>();

  Stream<Stage> get outAddedClient => _addedClientController.stream;
  Sink<Stage> get inAddedClient => _addedClientController.sink;

  final ApiService _apiService;

  ReplaySubject<String> _query = ReplaySubject<String>();

  Sink<String> get query => _query;

  StagesBloc(this._apiService) {
    _queryResults = _query
        .distinct()
        .asyncMap(_apiService.queryStages)
        .asBroadcastStream();
  }

  @override
  void dispose() {
    _query.close();
    _addedClientController.close();
  }

  void addStage(Stage stage) {
    _apiService
        .addStage(stage).then((user) {
        inAddedClient.add(stage);
      });
  }
}
