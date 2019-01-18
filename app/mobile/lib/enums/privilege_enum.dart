enum Privilege { ADMIN, FOREMAN }

const Map<Privilege, String> PrivilegeType = {
  Privilege.ADMIN: "admin",
  Privilege.FOREMAN: "foreman",
};


const Map<String, Privilege> PrivilegeTypeString = {
  "admin" : Privilege.ADMIN,
  "foreman" : Privilege.FOREMAN
};