import 'dart:async';

import 'package:cm_mobile/bloc/base_bloc.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/service/api_service.dart';

class ProjectsBloc implements BlocBase{
  List<Project> _projects;

  ApiService _apiService = ApiService();

  StreamController<List<Project>> _projectsController = StreamController<List<Project>>();

  Sink<List<Project>> get _inProjects => _projectsController. sink;
  Stream<List<Project>> get outProject => _projectsController.stream;

  @override
  void dispose() {
    _projectsController.close();
  }
  ProjectsBloc(){
    _getAllProjects();
  }

  void _getAllProjects() {
    _apiService.getAll().then((projects) {
      _projects = projects;
      _inProjects.add(_projects);
    });
  }
}

class ProjectBloc implements BlocBase{
  Project _project;
  String _projectId;

  ApiService _apiService = ApiService();

  StreamController<Project> _projectController = StreamController<Project>();

  ProjectBloc(this._projectId);

  Sink<Project> get _inProject => _projectController. sink;
  Stream<Project> get outProject => _projectController.stream;

  @override
  void dispose() {
    _projectController.close();
  }
  ProjectsBloc(){
    _getProject();
  }

  void _getProject() {
    _apiService.get(_projectId).then((project) {
      _project = project;
      _inProject.add(_project);
    });
  }
}