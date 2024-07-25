class BookingModel {
  BookingModel({
    required this.status,
    required this.upcomingBookings,
    required this.bookingHistory,
  });

  final String? status;
  static const String statusKey = "status";

  final List<BookingHistory> upcomingBookings;
  static const String upcomingBookingsKey = "upcoming_bookings";

  final List<BookingHistory> bookingHistory;
  static const String bookingHistoryKey = "booking_history";


  factory BookingModel.fromJson(Map<String, dynamic> json){
    return BookingModel(
      status: json["status"],
      upcomingBookings: json["upcoming_bookings"] == null ? [] : List<BookingHistory>.from(json["upcoming_bookings"]!.map((x) => BookingHistory.fromJson(x))),
      bookingHistory: json["booking_history"] == null ? [] : List<BookingHistory>.from(json["booking_history"]!.map((x) => BookingHistory.fromJson(x))),
    );
  }

}

class BookingHistory {
  BookingHistory({
    required this.id,
    required this.bookingId,
    required this.propertyId,
    required this.propertyName,
    required this.startDate,
    required this.endDate,
    required this.amountPaid,
    required this.status,
    required this.bookingDate,
  });

  final int? id;
  static const String idKey = "id";

  final String? bookingId;
  static const String bookingIdKey = "booking_id";

  final int? propertyId;
  static const String propertyIdKey = "property_id";

  final String? propertyName;
  static const String propertyNameKey = "property_name";

  final String? startDate;
  static const String startDateKey = "start_date";

  final String? endDate;
  static const String endDateKey = "end_date";

  final int? amountPaid;
  static const String amountPaidKey = "amount_paid";

  final String? status;
  static const String statusKey = "status";

  final String? bookingDate;
  static const String bookingDateKey = "booking_date";


  factory BookingHistory.fromJson(Map<String, dynamic> json){
    return BookingHistory(
      id: json["id"],
      bookingId: json["booking_id"],
      propertyId: json["property_id"],
      propertyName: json["property_name"],
      startDate: json["start_date"],
      endDate: json["end_date"],
      amountPaid: json["amount_paid"],
      status: json["status"],
      bookingDate: json["booking_date"],
    );
  }

}
