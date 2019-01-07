import 'dart:async';
import 'dart:collection';

import 'package:cm_mobile/bloc/base_bloc.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:rxdart/rxdart.dart';

class ProjectsBloc implements BlocBase {
  Stream<List<Project>> _queryResults = Stream.empty();

  Stream<List<Project>> get results => _queryResults;
  StreamController<Project> _addedProjectController = StreamController<Project>();

  Stream<Project> get outAddedProject => _addedProjectController.stream;
  Sink<Project> get inAddedProject => _addedProjectController.sink;

  final ApiService _apiService;

  ReplaySubject<String> _query = ReplaySubject<String>();

  Sink<String> get query => _query;

  ProjectsBloc(this._apiService) {
    _queryResults =
        _query.distinct().asyncMap(_apiService.queryProjects).asBroadcastStream();
  }

  @override
  void dispose() {
    _query.close();
    _addedProjectController.close();

  }

  void addProject(Project project) {
    _apiService.addProject(project).then((project) {
      inAddedProject.add(project);
    });
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