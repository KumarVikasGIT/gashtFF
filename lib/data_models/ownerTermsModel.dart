import 'package:json_annotation/json_annotation.dart';

part 'ownerTermsModel.g.dart';

@JsonSerializable()
class OwnerTermsModel {
  OwnerTermsModel({
    required this.status,
    required this.cancellationPolicy,
    required this.terms,
  });

  final String? status;
  static const String statusKey = "status";


  @JsonKey(name: 'cancellation_policy')
  final List<String>? cancellationPolicy;
  static const String cancellationPolicyKey = "cancellation_policy";

  final List<String>? terms;
  static const String termsKey = "terms";


  factory OwnerTermsModel.fromJson(Map<String, dynamic> json) => _$OwnerTermsModelFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerTermsModelToJson(this);

}
