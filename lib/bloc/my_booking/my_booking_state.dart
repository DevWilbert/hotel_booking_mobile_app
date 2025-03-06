part of 'my_booking_bloc.dart';

@immutable
sealed class MyBookingState {}

final class MyBookingInitial extends MyBookingState {}

final class MyBookingLoading extends MyBookingState {}

final class MyBookingLoaded extends MyBookingState {
  final MyBookingResponseList myBookingResponse;
  MyBookingLoaded({required this.myBookingResponse});
}

final class MyBookingError extends MyBookingState {
  final String message;
  MyBookingError({required this.message});
}
