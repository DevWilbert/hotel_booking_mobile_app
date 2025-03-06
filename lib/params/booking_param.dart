import 'package:hotel_app/params/detail_booking_param.dart';

class BookingParam {
  int? idHotel;
  int? idUser;
  String? totalPayment;
  String? numOfRooms;
  List<DetailBookingParam> detailBooking;

  BookingParam({
    required this.idHotel,
    required this.idUser,
    required this.totalPayment,
    required this.numOfRooms,
    required this.detailBooking,
  });

  Map<String, dynamic> toJson() {
    return {
      'hotel' : idHotel,
      'user' : idUser,
      'total_payment' : totalPayment,
      'num_of_rooms' : numOfRooms,
      'detail_booking' : detailBooking.map((detail) => detail.toJson()).toList(),
    };
  }
}