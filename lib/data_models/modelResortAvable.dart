import 'package:json_annotation/json_annotation.dart';

import 'bookingDetailsModel.dart';
import 'model_propertyList.dart';

part 'modelResortAvable.g.dart';

@JsonSerializable()
class ModelResortAvailable {
  ModelResortAvailable({
    required this.status,
    required this.propertyDetail,

    required this.message,
  });

  final String? status;
  static const String statusKey = "status";

  final String? message;
  static const String messageKey = "message";

  @JsonKey(name: 'property_detail')
  final Property? propertyDetail;
  static const String propertyDetailKey = "property_detail";



  /* @JsonKey(name: 'property_detail')
  final Property propertyDetail;
  static const String propertyDetailKey = "property_detail";
*/

  factory ModelResortAvailable.fromJson(Map<String, dynamic> json) => _$ModelResortAvailableFromJson(json);


}

