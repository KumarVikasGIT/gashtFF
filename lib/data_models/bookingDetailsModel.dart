import 'dashboardModel.dart';
import 'model_propertyList.dart';

class BookingDetailsModel {
  BookingDetailsModel({
    required this.status,
    required this.bookingDetails,
    required this.properties,
  });

  final String? status;
  static const String statusKey = "status";

  final List<BookingDetail> bookingDetails;
  static const String bookingDetailsKey = "Booking_details";

  final List<Property> properties;
  static const String propertiesKey = "properties";


  factory BookingDetailsModel.fromJson(Map<String, dynamic> json){
    return BookingDetailsModel(
      status: json["status"],
      bookingDetails: json["Booking_details"] == null ? [] : List<BookingDetail>.from(json["Booking_details"]!.map((x) => BookingDetail.fromJson(x))),
      properties: json["properties"] == null ? [] : List<Property>.from(json["properties"]!.map((x) => Property.fromJson(x))),
    );
  }

}

 class BookingDetail {
  BookingDetail({
    required this.id,
    required this.bookingId,
    required this.properties,
    required this.propertyName,
    required this.startDate,
    required this.endDate,
    required this.amountPaid,
    required this.bookingDate,
  });

  final int? id;
  static const String idKey = "id";

  final String? bookingId;
  static const String bookingIdKey = "booking_id";

  final int? properties;
  static const String propertiesKey = "properties";

  final String? propertyName;
  static const String propertyNameKey = "property_name";

  final String? startDate;
  static const String startDateKey = "start_date";

  final String? endDate;
  static const String endDateKey = "end_date";

  final int? amountPaid;
  static const String amountPaidKey = "amount_paid";

  final DateTime? bookingDate;
  static const String bookingDateKey = "booking_date";


  factory BookingDetail.fromJson(Map<String, dynamic> json){
    return BookingDetail(
      id: json["id"],
      bookingId: json["booking_id"],
      properties: json["properties"],
      propertyName: json["property_name"],
      startDate: json["start_date"],
      endDate: json["end_date"],
      amountPaid: json["amount_paid"],
      bookingDate: DateTime.tryParse(json["booking_date"] ?? ""),
    );
  }

}

