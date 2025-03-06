part of 'booking_bloc.dart';

@immutable
sealed class BookingState {}

final class BookingInitial extends BookingState {}

final class BookingLoading extends BookingState {}

final class BookingSuccess extends BookingState {
  final BookingResponse bookingResponse;
  BookingSuccess({required this.bookingResponse});
}

final class BookingError extends BookingState {
  final String? message;
  BookingError({required this.message});
}

final class BookingFatalError extends BookingState {
  final String? message;
  BookingFatalError({required this.message});
}