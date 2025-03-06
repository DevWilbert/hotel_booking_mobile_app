part of 'room_available_bloc.dart';

@immutable
sealed class RoomAvailableEvent {}

final class GetRoomAvailableEvent extends RoomAvailableEvent {
  final String? checkInDate;
  final String? checkOutDate;
  final String? hotel_name;
  final String? type_name;

  GetRoomAvailableEvent({
    required this.checkInDate,
    required this.checkOutDate,
    required this.hotel_name,
    required this.type_name,
  });
}