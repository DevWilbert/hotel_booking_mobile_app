import 'package:hotel_app/models/hotel_model.dart';
import 'package:hotel_app/models/room_type_model.dart';

class RoomModel {
  int? id;
  String? roomNumber;
  HotelModel? hotelModel;
  int? floor;
  RoomTypeModel? roomTypeModel;

  RoomModel({
    this.id,
    this.roomNumber,
    this.hotelModel,
    this.floor,
    this.roomTypeModel
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      roomNumber: json['room_number'],
      hotelModel: HotelModel.fromJson(json['hotel']),
      floor: json['floor'],
      roomTypeModel: RoomTypeModel.fromJson(json['type'])
    );
  }

}