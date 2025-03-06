class DetailBookingModel {
  int? id;
  String? codeBooking;
  String? roomNumber;
  String? typeName;
  String? checkInDate;
  String? checkOutDate;
  String? subtotal;

  DetailBookingModel({
    required this.id,
    required this.codeBooking,
    required this.roomNumber,
    required this.typeName,
    required this.checkInDate,
    required this.checkOutDate,
    required this.subtotal
  });

  factory DetailBookingModel.fromJson(Map<String, dynamic> json) {
    return DetailBookingModel(
        id: json['id'],
        codeBooking: json['booking'],
        roomNumber: json['room'],
        typeName: json['type'],
        checkInDate: json['checkin_date'],
        checkOutDate: json['checkout_date'],
        subtotal: json['subtotal']
    );
  }

}