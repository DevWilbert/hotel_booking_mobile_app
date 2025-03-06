import 'package:bloc/bloc.dart';
import 'package:hotel_app/repo/room_repository.dart';
import 'package:hotel_app/response/room_response.dart';
import 'package:meta/meta.dart';

part 'room_available_event.dart';
part 'room_available_state.dart';

class RoomAvailableBloc extends Bloc<RoomAvailableEvent, RoomAvailableState> {
  final roomRepository = RoomRepository();
  RoomAvailableBloc() : super(RoomAvailableInitial()) {
    on<GetRoomAvailableEvent>((event, emit) async {
      emit(RoomAvailableLoading());
      try {
        RoomResponse response = await roomRepository.getRoomAvailable(
            event.checkInDate, event.checkOutDate,
            event.hotel_name, event.type_name
        );
        emit(RoomAvailableLoaded(roomResponse: response));
      } catch(e) {
        emit(RoomAvailableError(message: e.toString()));
      }
    });
  }
}
