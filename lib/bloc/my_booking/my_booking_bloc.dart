import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_app/repo/booking_repository.dart';
import 'package:hotel_app/response/my_booking_response.dart';
import 'package:meta/meta.dart';

part 'my_booking_event.dart';
part 'my_booking_state.dart';

class MyBookingBloc extends Bloc<MyBookingEvent, MyBookingState> {
  final bookingRepository = BookingRepository();

  MyBookingBloc() : super(MyBookingInitial()) {
    on<GetMyBookingUser>((event, emit) async {
      emit(MyBookingLoading());
      try {
        MyBookingResponseList response = await bookingRepository.getBookingUser(event.idUser);
        emit(MyBookingLoaded(myBookingResponse: response));
      } catch (e) {
        emit(MyBookingError(message: e.toString()));
        debugPrint(e.toString());
      }
    });
  }
}
