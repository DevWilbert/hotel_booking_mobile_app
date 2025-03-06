import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_app/core/api_client.dart';
import 'package:hotel_app/response/room_type_response.dart';

class RoomTypeRepository extends ApiClient {

  Future<RoomTypeResponse> getRoomType(String? hotel_name) async {
    try {
      final response = await dio.get('roomtype-filter/?hotel_name=${hotel_name}');
      debugPrint('Room Type Response : ${response.data}');
      return RoomTypeResponse.fromJson(response.data);
    } on DioException catch(e) {
      throw Exception(e.toString());
    }
  }
}