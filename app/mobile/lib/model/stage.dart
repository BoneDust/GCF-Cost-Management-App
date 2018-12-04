class Stage {
  int id;
  int projectId;
  String name;
  String description;
  String status;
  String beforePicture;
  String afterPicture;
  String startDate;
  String endDate;
  String estimatedDuration;

  Stage(
      {this.id = 0,
      this.projectId = 0,
      this.name = "",
      this.description = "",
      this.status = "",
      this.beforePicture = "",
      this.afterPicture = "",
      this.startDate = "",
      this.endDate = "",
      this.estimatedDuration = ""});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Stage && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
