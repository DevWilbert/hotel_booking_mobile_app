import 'package:bloc/bloc.dart';
import 'package:hotel_app/repo/room_type_repository.dart';
import 'package:hotel_app/response/room_type_response.dart';
import 'package:meta/meta.dart';

part 'room_type_event.dart';
part 'room_type_state.dart';

class RoomTypeBloc extends Bloc<RoomTypeEvent, RoomTypeState> {
  final roomTypeRepository = RoomTypeRepository();
  RoomTypeBloc() : super(RoomTypeInitial()) {
    on<GetRoomTypeEvent>((event, emit) async {
      emit(RoomTypeLoading());
      try {
        RoomTypeResponse response = await roomTypeRepository.getRoomType(event.hotel_name);
        emit(RoomTypeLoaded(roomTypeResponse: response));
      } catch(e) {
        emit(RoomTypeError(message: e.toString()));
      }
    });
  }
}
