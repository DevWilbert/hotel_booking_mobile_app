import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_app/core/api_client.dart';
import 'package:hotel_app/core/api_exception.dart';
import 'package:hotel_app/params/register_param.dart';
import 'package:hotel_app/response/register_response.dart';

class RegisterRepository extends ApiClient {

  Future<RegisterResponse> register(RegisterParam param) async {
    try {
      final response = await dio.post('register', data: param.toJson());
      debugPrint('Register Response : ${response.data}');
      return RegisterResponse.fromJson(response.data);
    } on DioException catch(e) {
      if (e.response != null) {
        debugPrint('Error response : ${e.response!.data}');
        if(e.response!.data['data']['username'] != null) {
          var message = e.response!.data['data']['username'][0];
          throw ApiException(message: message);
        } else if (e.response!.data['data']['email'] != null) {
          var message = 'Email : ' + e.response!.data['data']['email'][0];
          throw ApiException(message: message);
        } else if (e.response!.data['data']['password'] != null) {
          var message = e.response!.data['data']['password'][0];
          throw ApiException(message: message);
        } else if (e.response!.data['data']['password1'] != null) {
          var message = e.response!.data['data']['password1'][0];
          throw ApiException(message: message);
        } else {
          debugPrint('Type Error response : ${e.type}');
        }
      }
      throw Exception(e.toString());
    }
  }

}