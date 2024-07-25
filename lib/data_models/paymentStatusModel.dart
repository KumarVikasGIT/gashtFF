import 'package:json_annotation/json_annotation.dart';

part 'paymentStatusModel.g.dart';

@JsonSerializable()
class PaymentStatusModel {
  PaymentStatusModel({
    required this.status,
    required this.paymentStatus,
    required this.amount,
  });

  final String? status;
  static const String statusKey = "status";


  @JsonKey(name: 'payment_status')
  final String? paymentStatus;
  static const String paymentStatusKey = "payment_status";

  final String? amount;
  static const String amountKey = "amount";


  factory PaymentStatusModel.fromJson(Map<String, dynamic> json) => _$PaymentStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentStatusModelToJson(this);

}
