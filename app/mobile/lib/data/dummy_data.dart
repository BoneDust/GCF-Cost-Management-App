import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/model/stage.dart';
import 'package:cm_mobile/model/user.dart';


class DummyData{
  static Project projectList = Project(
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
      receipts: [
        Receipt(
            supplier: "Builder's warehouse",
            description: "Bought pliers and cement",
            id: 1,
            picture: "/receipts/12345.jpg",
            projectId: 2,
            purchaseDate: DateTime.now(),
            totalCost: 2000.00),
        Receipt(
            supplier: "Timber",
            description: "Bought pliers and cement",
            id: 1,
            picture: "/receipts/12346.jpg",
            projectId: 2,
            purchaseDate: DateTime.now(),
            totalCost: 3000.00),
        Receipt(
            supplier: "Builder's warehouse",
            description: "Bought pliers and cement",
            id: 1,
            picture: "/receipts/12345.jpg",
            projectId: 2,
            purchaseDate: DateTime.now(),
            totalCost: 2000.00),
        Receipt(
            supplier: "Timber",
            description: "Bought pliers and cement",
            id: 1,
            picture: "/receipts/12346.jpg",
            projectId: 2,
            purchaseDate: DateTime.now(),
            totalCost: 3000.00),
        Receipt(
            supplier: "Builder's warehouse",
            description: "Bought pliers and cement",
            id: 1,
            picture: "/receipts/12345.jpg",
            projectId: 2,
            purchaseDate: DateTime.now(),
            totalCost: 2000.00),
        Receipt(
            supplier: "Timber",
            description: "Bought pliers and cement",
            id: 1,
            picture: "/receipts/12346.jpg",
            projectId: 2,
            purchaseDate: DateTime.now(),
            totalCost: 3000.00),
      ],
      endDate: DateTime.now(),
      description: "Standard bank roof damping",
      name: "Standard Bank E2",
      status: "in progress",
      clientId: 2,
      estimatedCost: 1000000,
      expenditure: 24555,
      foreman: User(),
      startDate: DateTime.now(),
      teamSize: 6);

  Future<User> getUser(String id) async {
    User result = User(privileges: Privilege.ADMIN);
    await Future.delayed(Duration(seconds: 2));

//     await _client.get(Uri.parse(_url))
//         .then((response) => response.body)
//         .then(json.decode)
//         .then((json) => json["results"])
//         .then((list) => list.forEach((item) => resultList.add(Project.fromJson(item))));

    return result;
  }
}