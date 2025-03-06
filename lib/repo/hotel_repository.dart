import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_app/core/api_client.dart';
import 'package:hotel_app/response/hotel_response.dart';

class HotelRepository extends ApiClient {

  Future<HotelResponse> getHotelPagination(int _limit, int _offset) async {
    try {
      final response = await dio.get('hotel-pagination/?limit=${_limit}&offset=${_offset}');
      debugPrint('Hotel Response : ${response.data}');
      return HotelResponse.fromJson(response.data['results']);
    } on DioException catch(e) {
      throw Exception(e.toString());
    }
  }
}