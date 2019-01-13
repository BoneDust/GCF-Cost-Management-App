class UserFilter{

  bool foreman = false;
  bool admin = false;

  UserFilter.none();

  UserFilter.byForeMan(){
    foreman = true;
  }

  UserFilter.byAdmin(){
    admin = true;
  }

}