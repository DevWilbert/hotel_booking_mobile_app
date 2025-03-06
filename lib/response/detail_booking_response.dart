import 'package:hotel_app/models/detail_booking_model.dart';

class DetailBookingResponse {
  final List<DetailBookingModel> listDetailBookingModel = [];

  DetailBookingResponse.fromJson(json) {
    for(int i = 0; i < json.length; i++) {
      DetailBookingModel detailBookingModel = DetailBookingModel.fromJson(json[i]);
      listDetailBookingModel.add(detailBookingModel);
    }
  }
}