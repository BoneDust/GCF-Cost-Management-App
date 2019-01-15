import 'dart:math';

import 'package:cm_mobile/enums/activity_type.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/activity.dart';
import 'package:cm_mobile/model/client.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/model/stage.dart';
import 'package:cm_mobile/model/user.dart';

class DummyData {
  static Random random = Random();

  static List<Activity> activities =
      List.generate(10, (index) => getActivity());

  static User currentUser = adminUser;

  static var receipts = List.generate(10, (index) => getReceipt());

  static List<Stage> stages = [
    Stage(
        projectId: 1,
        id: 1,
        description: "kitchen ",
        afterPicture: "",
        beforePicture: "",
        estimatedDaysDuration: 3,
        name: "Stage 1",
        status: "In progress"),
    Stage(
        projectId: 1,
        id: 2,
        description: "bathroon",
        afterPicture: "",
        beforePicture: "",
        estimatedDaysDuration: 3,
        name: "Stage 2",
        status: "In progress"),
    Stage(
        projectId: 1,
        id: 3,
        description: "Server room",
        afterPicture: "",
        beforePicture: "",
        estimatedDaysDuration: 3,
        name: "Stage 3",
        status: "In progress"),
    Stage(
        projectId: 1,
        id: 4,
        description: "Roof damping",
        afterPicture: "",
        beforePicture: "",
        estimatedDaysDuration: 3,
        name: "Stage 4",
        status: "In progress"),
  ];

  static User get getForemanUser =>
      foremanUsers[random.nextInt(foremanUsers.length)];
  static Client get getClient => clients[random.nextInt(clients.length)];

  static List<User> get getUsers =>
      List.generate(19, (index) => getForemanUser) +
      List.generate(19, (index) => adminUser);

  static List<Client> get getClients => List.generate(19, (index) => getClient);

  static Project getProject() {
    return Project(
        id: 1,
        stages: stages,
        receipts: List.generate(10, (index) => getReceipt()),
        endDate: DateTime.now(),
        name: projectNames[random.nextInt(projectNames.length)],
        status: projectStatus[random.nextInt(projectStatus.length)],
        clientId: projectClient.length,
        estimatedCost: random.nextDouble(),
        expenditure: random.nextDouble(),
        userId: random.nextInt(4),
        foreman: foremanUsers[random.nextInt(foremanUsers.length)],
        startDate: DateTime.now(),
        teamSize: random.nextInt(10));
  }

  static User adminUser =
      User(name: "Dale", surname: "McLead", privilege: Privilege.ADMIN, id: 1, );
  static User foremanUser = getForemanUser;
  static List<Project> projectList = List.generate(100, (index) => getProject());

  static List<String> projectNames = [
    "Standard bank Johanessburg",
    "Germiston Someone's house",
    "FNB ",
    "WeThinkCode Capetown"
  ];

  static List<String> descriptions = [
    "Lorem ipsum dolors neque. Donec cursus ut ligula nec consectetur. Maecenas placerat id lacus et tristique. Donec justo mi, imperdiet a elit ac, eleifend tempor risus",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc.",
    "Nulla et lectus ligula. Duis tristique sapien auctor orci varius luctus. Vestibulum quis eros laoreet, molestie risus et, dapibus diam. Vivamus id justo sit amet nulla commodo scipit.",
    "Praesent mollis bibendum nisl ut tristique. Aliquam vitae ultrices tortor. Ut faucibus finibus nisl ornare ornare. Suspendisse faucibus suscipit nunc, lectus vulputate in.",
    "ivamus lacus nisl, malesuada eget mi in, hendrerit commodo augue. Maecenas suscipit mattis nunc ut fermentum. Donec egestas imperdiet arcu, ac tempus ex consectetur at",
    "Suspendisse tempus felis ut tortor convallis, vitae ultricies nibh tincidunt. In interdum, ligula tincidunt viverra consectetur, dolor lectus ultricies metus, eget feugiat neque libero id sem."
  ];

  static List<String> projectStatus = ["in progress", "finished"];

  static var projectClient = ["Standard Bank", "FNB"];

  static var foremanUsers = [
    User(
        name: "Khumo",
        surname: "Letlape",
        privilege: Privilege.FOREMAN,
        email: "",
        id: 1),
    User(
        name: "Mushagi",
        surname: "Mayibo",
        privilege: Privilege.FOREMAN,
        email: "",
        id: 2),
    User(
        name: "Lonwabo",
        surname: "Rarane",
        privilege: Privilege.FOREMAN,
        email: "",
        id: 3),
    User(
        name: "Goodwill",
        surname: "Tshekele",
        privilege: Privilege.FOREMAN,
        email: "",
        id: 4),
    User(
        name: "Goodwill",
        surname: "Tshekele",
        privilege: Privilege.FOREMAN,
        email: "",
        id: 5),
  ];
  static var clients = [
    Client(name: "FNB", id: 1),
    Client(name: "We Think Code", id: 2),
    Client(name: "Lonwabo", id: 3),
    Client(name: "Themba High School", id: 4),
    Client(name: "Standard bank", id: 5),
  ];

  static List<String> suppliers = [
    "Builder's warehouse",
    "CTM",
    "Pefi Cash & Carry"
  ];

  static List<String> activityTitles = [
    "Receipt from supplier " +
        suppliers[random.nextInt(suppliers.length)] +
        "was added",
    "Stage " +
        random.nextInt(10).toString() +
        ", " +
        projectNames[random.nextInt(projectNames.length)] +
        ", is done",
    "Project has , " +
        projectNames[random.nextInt(projectNames.length)] +
        ", created",
  ];

  static Activity getActivity() {
    return Activity(
      title: activityTitles[random.nextInt(activityTitles.length)],
      performer: "perfomer",
      type: getRandomActivity(),
      description: descriptions[random.nextInt(descriptions.length)],
      activityId: 1,
      creationDate: DateTime.now(),
      projectId: 3
    );
  }

  static Receipt getReceipt() {
    return Receipt(
        supplier: suppliers[random.nextInt(suppliers.length)],
        description: descriptions[random.nextInt(descriptions.length)],
        totalCost: random.nextDouble(),
        purchaseDate: DateTime.now());
  }

  static ActivityType getRandomActivity() {
    return ActivityType.values[random.nextInt(ActivityType.values.length)];
  }
}
