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

  static User currentUser = adminUser ;

  static var receipts =  List.generate(10, (index) => getReceipt());


  static User get getForemanUser => foremanUsers[random.nextInt(foremanUsers.length)];
  static Client get getClient => clients[random.nextInt(clients.length)];

  static List<User> get getUsers => List.generate(19, (index) => getForemanUser) + List.generate(19, (index) => adminUser);

  static List<Client> get getClients =>  List.generate(19, (index) => getClient) ;

  static Project getProject() {
    return Project(
        id: 1,
        stages: [
          Stage(
              projectId: 1,
              id: 1,
              description: "kitchen ",
              afterPicture: "",
              beforePicture: "",
              endDate: DateTime.now(),
              estimatedDaysDuration: 3,
              name: "Stage 1",
              status: "In progress"),
          Stage(
              projectId: 1,
              id: 2,
              description: "bathroon",
              afterPicture: "",
              beforePicture: "",
              endDate: DateTime.now(),
              estimatedDaysDuration: 3,
              name: "Stage 2",
              status: "In progress"),
          Stage(
              projectId: 1,
              id: 3,
              description: "Server room",
              afterPicture: "",
              beforePicture: "",
              endDate: DateTime.now(),
              estimatedDaysDuration: 3,
              name: "Stage 3",
              status: "In progress"),
          Stage(
              projectId: 1,
              id: 4,
              description: "Roof damping",
              afterPicture: "",
              beforePicture: "",
              endDate: DateTime.now(),
              estimatedDaysDuration: 3,
              name: "Stage 4",
              status: "In progress"),
        ],
        receipts: List.generate(10, (index) =>  getReceipt()),
        endDate: DateTime.now(),
        description:
            descriptions[random.nextInt(descriptions.length)],
        name: projectNames[random.nextInt(projectNames.length)],
        status: projectStatus[random.nextInt(projectStatus.length)],
        clientId: projectClient.length,
        estimatedCost: random.nextDouble(),
        expenditure: random.nextDouble(),
        foreman: foremanUsers[random.nextInt(foremanUsers.length)],
        startDate: DateTime.now(),
        teamSize: random.nextInt(10));
  }

  static User adminUser =
      User(name: "Dale", surname: "McLead", privilege: Privilege.ADMIN);
  static User foremanUser = getForemanUser;
  static List<Project> projectList = List.generate(10, (index) => getProject());

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
    User(name: "Khumo", surname: "Letlape", privilege: Privilege.FOREMAN, contactNo: "", username: ""),
    User(name: "Mushagi", surname: "Mayibo", privilege:  Privilege.FOREMAN, contactNo: "", username: ""),
    User(name: "Lonwabo", surname: "Rarane", privilege:  Privilege.FOREMAN, contactNo: "", username: ""),
    User(name: "Goodwill", surname: "Tshekele", privilege:  Privilege.FOREMAN, contactNo: "", username: ""),
    User(name: "Goodwill", surname: "Tshekele", privilege:  Privilege.FOREMAN, contactNo: "", username: ""),

  ];
  static var clients = [
    Client(name: "FNB"),
    Client(name: "We Think Code"),
    Client(name: "Lonwabo"),
    Client(name: "Themba High School"),
    Client(name: "Standard bank"),
  ];

  static List<String> suppliers = [
    "Builder's warehouse",
    "CTM",
    "Pefi Cash & Carry"
  ];

  static List<String> activityTitles = [
    "Receipt from supplier " + suppliers[random.nextInt(suppliers.length)] + "was added" ,
    "Stage "+ random.nextInt(10).toString()+", " + projectNames[random.nextInt(projectNames.length)] +", is done",
    "Project has , " + projectNames[random.nextInt(projectNames.length)] +", created",

  ];

  static Activity getActivity() {
    return Activity(getRandomActivity(),
        title: activityTitles[random.nextInt(activityTitles.length)],
        description:  descriptions[random.nextInt(descriptions.length)],
    );
  }

  static Receipt getReceipt() {
    return Receipt(
      supplier: suppliers[random.nextInt(suppliers.length)] ,
      description: descriptions[random.nextInt(descriptions.length)],
      totalCost: random.nextDouble(),
      purchaseDate: DateTime.now()
    );
  }

  static ActivityType getRandomActivity() {
    return ActivityType.values[random.nextInt(ActivityType.values.length)];
  }
}
