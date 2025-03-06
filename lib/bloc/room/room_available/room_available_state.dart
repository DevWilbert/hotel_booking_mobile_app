part of 'room_available_bloc.dart';

@immutable
sealed class RoomAvailableState {}

final class RoomAvailableInitial extends RoomAvailableState {}

final class RoomAvailableLoading extends RoomAvailableState {}

final class RoomAvailableLoaded extends RoomAvailableState {
  final RoomResponse roomResponse;
  RoomAvailableLoaded({required this.roomResponse});
}

final class RoomAvailableError extends RoomAvailableState {
  final String message;
  RoomAvailableError({required this.message});
}
