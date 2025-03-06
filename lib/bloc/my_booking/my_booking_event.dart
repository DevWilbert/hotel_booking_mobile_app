part of 'my_booking_bloc.dart';

@immutable
sealed class MyBookingEvent {}


final class GetMyBookingUser extends MyBookingEvent {
  final int? idUser;
  GetMyBookingUser({required this.idUser});
}