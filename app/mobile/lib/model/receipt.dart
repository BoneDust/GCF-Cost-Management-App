import 'package:json_annotation/json_annotation.dart';

part 'receipt.g.dart';

@JsonSerializable()
class Receipt {
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
  factory Receipt.fromJson(Map<String, dynamic> json) => _$ReceiptFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptToJson(this);
}
