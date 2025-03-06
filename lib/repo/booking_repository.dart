import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_app/core/api_client.dart';
import 'package:hotel_app/params/booking_param.dart';
import 'package:hotel_app/params/detail_booking_param.dart';
import 'package:hotel_app/response/my_booking_response.dart';

import '../response/booking_response.dart';

class BookingRepository extends ApiClient {

  Future<BookingResponse> postBooking(BookingParam bookingParam) async {
    try {
      final response = await dio.post('booking', data: bookingParam.toJson());
      debugPrint('Booking Response : ${response.data}');
      return BookingResponse.fromJson(response.data);
    }on DioException catch(e) {
      throw Exception(e.toString());
    }
  }

  Future<MyBookingResponseList> getBookingUser(int? idUser) async {
    try {
      final response = await dio.get('booking-filter/?id_user=${idUser}');
      debugPrint('My Booking Response : ${response.data}');
      return MyBookingResponseList.fromJson(response.data);
    } on DioException catch(e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }

}