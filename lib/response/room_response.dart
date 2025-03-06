import '../models/room_model.dart';

class RoomResponse {
  final List<RoomModel> listRoom = [];

  RoomResponse.fromJson(json) {
    for(int i = 0; i < json.length; i++) {
      RoomModel roomModel = RoomModel.fromJson(json[i]);
      listRoom.add(roomModel);
    }
  }
}