import 'package:hotel_app/response/booking_response.dart';

import '../models/detail_booking_model.dart';
import 'detail_booking_response.dart';

class MyBookingResponse {
  int? idBooking;
  String? codeBooking;
  String? nameUser;
  String? nameHotel;
  String? totalPayment;
  int? numOfRooms;
  String? bookingDate;
  String? bookingStatus;
  List<DetailBookingModel>? detailBooking;

  MyBookingResponse({
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

  factory MyBookingResponse.fromJson(Map<String, dynamic> json) {
    return MyBookingResponse(
      idBooking: json['id'],
      codeBooking: json['code booking'],
      nameUser: json['user'],
      nameHotel: json['hotel'],
      totalPayment: json['total_payment'],
      numOfRooms: json['num_of_rooms'],
      bookingDate: json['booking_date'],
      bookingStatus: json['booking_status'],
      detailBooking: DetailBookingResponse
          .fromJson(json['detail_booking'])
          .listDetailBookingModel,
    );
  }
}

class MyBookingResponseList {
  List<MyBookingResponse> listMyBookingResponse = [];

  MyBookingResponseList.fromJson(json) {
    for(int i = 0; i < json.length; i++) {
      MyBookingResponse myBookingResponse = MyBookingResponse.fromJson(json[i]);
      listMyBookingResponse.add(myBookingResponse);
    }
  }
}
