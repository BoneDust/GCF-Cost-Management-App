import 'package:cm_mobile/model/model_base.dart';
import 'package:cm_mobile/util/custom_json_converter.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Receipt extends ModelBase {
  int id;
  int projectId;
  String supplier;
  String description;
  double totalCost;
  String picture;
  DateTime purchaseDate;

  Receipt(
      {this.id = 0,
      this.projectId = 0,
      this.supplier,
      this.description = "",
      this.totalCost = 0,
      this.picture = "",
      this.purchaseDate});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Receipt && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Receipt.fromJson(Map<String, dynamic> json)
      : id = json['receiptId'],
        projectId = json['project_id'],
        description = json['description'],
        supplier = json['supplier'],
        totalCost = CustomJsonConverter.getDouble(json['total_cost']),
        picture = json['pic_url'],
        purchaseDate =
            DateTime.fromMillisecondsSinceEpoch(json['purchase_date']);

  Map<String, dynamic> toJson() => {
        'receiptId': id,
        'description': description,
        'project_id': projectId,
        'supplier': supplier,
        'total_cost': totalCost,
        'pic_url': picture,
        'purchase_date': purchaseDate.millisecondsSinceEpoch
      };
}
