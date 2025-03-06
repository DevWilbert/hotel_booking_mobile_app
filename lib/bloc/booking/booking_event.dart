part of 'booking_bloc.dart';

@immutable
sealed class BookingEvent {}

final class BookingPressed extends BookingEvent {
  final BookingParam param;
  BookingPressed({required this.param});
}

final class BookingReset extends BookingEvent {}