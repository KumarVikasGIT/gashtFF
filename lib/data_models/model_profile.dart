import 'package:json_annotation/json_annotation.dart';

part 'model_profile.g.dart';

@JsonSerializable()
class Model_Profile {
  final String? fullname;
  final String? email;
  final String? phone;
  final String? userType;
  final String ?id_proof;


  Model_Profile({required this.fullname, required this.email,required this.phone,required this.userType,required this.id_proof});

  factory Model_Profile.fromJson(Map<String, dynamic> json) =>
      _$Model_ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$Model_ProfileToJson(this);



}
