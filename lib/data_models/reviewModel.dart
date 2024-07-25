import 'package:json_annotation/json_annotation.dart';
part 'reviewModel.g.dart';

@JsonSerializable()
class ReviewModel {
  ReviewModel({
    required this.id,
    required this.userId,
    required this.propertyId,
    required this.userName,
    required this.rating,
    required this.comment,
  });

  final int? id;
  static const String idKey = "id";


  @JsonKey(name: 'user_id')
  final int? userId;
  static const String userIdKey = "user_id";


  @JsonKey(name: 'property_id')
  final int? propertyId;
  static const String propertyIdKey = "property_id";


  @JsonKey(name: 'user_name')
  final String? userName;
  static const String userNameKey = "user_name";

  final String? rating;
  static const String ratingKey = "rating";

  final String? comment;
  static const String commentKey = "comment";


  factory ReviewModel.fromJson(Map<String, dynamic> json) => _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);

}