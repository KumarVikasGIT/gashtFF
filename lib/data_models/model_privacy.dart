import 'package:json_annotation/json_annotation.dart';
part 'model_privacy.g.dart';

@JsonSerializable()
class Model_Privacy
{
  final String? status;
  final String? termsofuse;
  final String? privacypolicy;


  Model_Privacy({required this.status,required this.termsofuse,required this.privacypolicy});

  factory Model_Privacy.fromJson(Map<String, dynamic> json) =>
      _$Model_PrivacyFromJson(json);

  Map<String, dynamic> toJson() => _$Model_PrivacyToJson(this);




}