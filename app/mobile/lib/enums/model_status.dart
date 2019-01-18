class ModelStatus {
  ModelStatusType status;
  dynamic model;

  ModelStatus({this.status, this.model});

}

enum ModelStatusType {
  UNCHANGED,
  DELETED,
  UPDATED
}
