import 'package:hotel_app/models/hotel_model.dart';

class HotelResponse {
  final List<HotelModel> listHotel;

  HotelResponse({required this.listHotel});

  HotelResponse copyWith({List<HotelModel>? listHotel}) {
    return HotelResponse(
      listHotel: listHotel ?? this.listHotel,
    );
  }

  HotelResponse.fromJson(List<dynamic> json)
      : listHotel = json.map((e) => HotelModel.fromJson(e)).toList();

  HotelResponse operator +(HotelResponse other) {
    return HotelResponse(
      listHotel: List.from(this.listHotel)..addAll(other.listHotel),
    );
  }
}
