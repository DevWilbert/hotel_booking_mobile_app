import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_app/core/api_client.dart';
import '../response/room_response.dart';

class RoomRepository extends ApiClient {

  Future<RoomResponse> getRoomAvailable(String? checkInDate, String? checkOutDate, String? hotel_name, String? type_name) async {
    try {
      final response = await dio.get(
          'room-available-bytype/?checkin_date=${checkInDate}&checkout_date=${checkOutDate}&hotel_name=${hotel_name}&type_name=${type_name}'
      );
      debugPrint('Available Room Response : ${response.data}');
      return RoomResponse.fromJson(response.data);
    } on DioException catch(e) {
      throw Exception(e.toString());
    }
  }
}

