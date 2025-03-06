class DetailBookingParam {
  int? idRooom;
  int? idType;
  String? checkInDate;
  String? checkOutDate;
  String? subtotal;

  DetailBookingParam({
    required this.idRooom,
    required this.idType,
    required this.checkInDate,
    required this.checkOutDate,
    required this.subtotal,
  });

  Map<String, dynamic> toJson() {
    return {
      'room' : idRooom,
      'type' : idType,
      'checkin_date' : checkInDate,
      'checkout_date' : checkOutDate,
      'subtotal' : subtotal,
    };
  }
}
