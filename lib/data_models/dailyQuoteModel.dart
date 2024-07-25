import 'package:json_annotation/json_annotation.dart';

part 'dailyQuoteModel.g.dart';

@JsonSerializable()
class DailyQuoteModel {
  DailyQuoteModel({
    required this.status,
    required this.quote,
  });

  final String? status;
  static const String statusKey = "status";

  final String? quote;
  static const String quoteKey = "quote";


  factory DailyQuoteModel.fromJson(Map<String, dynamic> json) => _$DailyQuoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$DailyQuoteModelToJson(this);

}
