import '../models/room_type_model.dart';

class RoomTypeResponse {
  final List<RoomTypeModel> listRoomType = [];

  RoomTypeResponse.fromJson(json) {
    for(int i = 0; i < json.length ;i++) {
      RoomTypeModel roomTypeModel = RoomTypeModel.fromJson(json[i]);
      listRoomType.add(roomTypeModel);
    }
  }
}