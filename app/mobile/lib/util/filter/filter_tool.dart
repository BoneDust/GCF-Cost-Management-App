import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/filter/ProjectFilter.dart';
import 'package:cm_mobile/model/filter/UserFilter.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/user.dart';

class FilterTool{
  static List<Project> filterProjects(List<Project> projects, ProjectFilter projectFilter){
    if (projectFilter.active)
      projects = projects.where((project) => project.status == "Incomplete").toList();
    if (projectFilter.done)
      projects = projects.where((project) => project.status == "done").toList();
    return projects;
  }

  static List<User> filterUsers(List<User> users, UserFilter userFilter){
    if (userFilter.admin)
      users = users.where((user) => user.privilege == Privilege.ADMIN).toList();
    if (userFilter.foreman)
      users = users.where((user) => user.privilege == Privilege.FOREMAN).toList();
    return users;
  }
}