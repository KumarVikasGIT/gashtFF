import 'package:json_annotation/json_annotation.dart';

part 'model_login.g.dart';

@JsonSerializable()
class Model_Login {
  final String? status;
  final String? message;
  final String? name;
  final String? token;
  final String? user_id;



  Model_Login({required this.status,required this.message,required this.name,required this.token,required this.user_id});

  factory Model_Login.fromJson(Map<String, dynamic> json) =>
      _$Model_LoginFromJson(json);

  Map<String, dynamic> toJson() => _$Model_LoginToJson(this);



}
