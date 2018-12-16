import 'dart:async';
import 'dart:collection';

import 'package:cm_mobile/bloc/base_bloc.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:rxdart/rxdart.dart';

class ProjectsBloc implements BlocBase {
  Stream<List<Project>> _queryResults = Stream.empty();

  Stream<List<Project>> get results => _queryResults;

  final ApiService _apiService;

  ReplaySubject<String> _query = ReplaySubject<String>();

  Sink<String> get query => _query;

  ProjectsBloc(this._apiService) {
    _queryResults =
        _query.distinct().asyncMap(_apiService.queryData).asBroadcastStream();
  }

  @override
  void dispose() {
    _query.close();
  }
}

class ProjectBloc implements BlocBase {
  Project _project;
  final String _id;

  final ApiService _apiService;

  StreamController<Project> _projectController = StreamController<Project>();

  Sink<Project> get _inProject => _projectController.sink;

  Stream<Project> get outProject => _projectController.stream;

  ProjectBloc(this._id, this._apiService);

  @override
  void dispose() {
    _inProject.close();
    _projectController.close();
  }

  void getProject() {
    _apiService.get(_id).then((project) {
      _project = project;

      _inProject.add(_project);
    });
  }
}
