import 'package:json_annotation/json_annotation.dart';

part 'notificationModel.g.dart';

@JsonSerializable()
class NotificationModel {
  NotificationModel({
    required this.status,
    required this.notifications,
  });

  final String? status;
  static const String statusKey = "status";

  final List<Notification>? notifications;
  static const String notificationsKey = "notifications";


  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

}

@JsonSerializable()
class Notification {
  Notification({
    required this.id,
    required this.title,
    required this.description,
  });

  final int? id;
  static const String idKey = "id";

  final String? title;
  static const String titleKey = "title";

  final String? description;
  static const String descriptionKey = "description";


  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);

}
