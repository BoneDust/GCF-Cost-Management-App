class ProjectFilter{

  bool foreman = false;
  bool admin = false;
  int length;
  bool active = false;
  bool done = false;

  ProjectFilter.none();

  ProjectFilter.byForeMan(){
    foreman = true;
  }

  ProjectFilter.byActive(){
    active = true;
  }

  ProjectFilter.byDone(){
    done = true;
  }

}