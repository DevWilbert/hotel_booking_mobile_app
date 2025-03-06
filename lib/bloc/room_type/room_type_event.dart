part of 'room_type_bloc.dart';

@immutable
sealed class RoomTypeEvent {}

final class GetRoomTypeEvent extends RoomTypeEvent {
  final String? hotel_name;

  GetRoomTypeEvent({required this.hotel_name});
}
