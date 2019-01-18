enum ActivityType {
  USER,
  STAGE,
  RECEIPT,
  PROJECT,
  CLIENT
}

const Map<ActivityType, String> ActivityTypeStringMap = {
  ActivityType.USER: "User",
  ActivityType.STAGE: "Stage",
  ActivityType.RECEIPT: "Receipt",
  ActivityType.PROJECT: "Project",
  ActivityType.CLIENT: "Client",
};

const Map<String, ActivityType> ActivityTypeMap = {
  "User" : ActivityType.USER,
  "Stage" : ActivityType.STAGE,
  "Receipt" : ActivityType.RECEIPT,
  "Project" : ActivityType.PROJECT,
  "Client" : ActivityType.CLIENT,
};
