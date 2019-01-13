import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
abstract class ModelBase{
  int id;

  ModelBase();
  ModelBase.fromJson(Map<String, dynamic> json);
}