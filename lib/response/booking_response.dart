import 'package:hotel_app/models/detail_booking_model.dart';
import 'package:hotel_app/response/detail_booking_response.dart';

class BookingResponse {
  String? message;
  int? idBooking;
  String? codeBooking;
  String? nameUser;
  String? nameHotel;
  String? totalPayment;
  int? numOfRooms;
  String? bookingDate;
  String? bookingStatus;
  List<DetailBookingModel>? detailBooking;

  BookingResponse({
   required this.message,
   required this.idBooking,
   required this.codeBooking,
   required this.nameUser,
   required this.nameHotel,
   required this.totalPayment,
   required this.numOfRooms,
   required this.bookingDate,
   required this.bookingStatus,
   required this.detailBooking,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
        message: json['message'],
        idBooking: json['data']['id'],
        codeBooking: json['data']['code_booking'],
        nameUser: json['data']['user'],
        nameHotel: json['data']['hotel'],
        totalPayment: json['data']['total_payment'],
        numOfRooms: json['data']['num_of_rooms'],
        bookingDate: json['data']['booking_date'],
        bookingStatus: json['data']['booking_status'],
        detailBooking: DetailBookingResponse.fromJson(json['data']['detail_booking']).listDetailBookingModel,
    );
  }
}