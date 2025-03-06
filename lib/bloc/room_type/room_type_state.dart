part of 'room_type_bloc.dart';

@immutable
sealed class RoomTypeState {}

final class RoomTypeInitial extends RoomTypeState {}

final class RoomTypeLoading extends RoomTypeState {}

final class RoomTypeLoaded extends RoomTypeState {
  final RoomTypeResponse roomTypeResponse;

  RoomTypeLoaded({required this.roomTypeResponse});
}

final class RoomTypeError extends RoomTypeState {
  final String message;

  RoomTypeError({required this.message});
}