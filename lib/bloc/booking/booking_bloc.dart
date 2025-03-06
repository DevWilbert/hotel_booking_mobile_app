import 'package:bloc/bloc.dart';
import 'package:hotel_app/params/booking_param.dart';
import 'package:hotel_app/repo/booking_repository.dart';
import 'package:hotel_app/response/booking_response.dart';
import 'package:meta/meta.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final bookingRepository = BookingRepository();

  BookingBloc() : super(BookingInitial()) {
    on<BookingPressed>(_onBookingPressed);
    on<BookingReset>(_onBookingReset);
  }

  void _onBookingPressed(BookingPressed event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    try {
      final param = BookingParam(
          idHotel: event.param.idHotel,
          idUser: event.param.idUser,
          totalPayment: event.param.totalPayment,
          numOfRooms: event.param.numOfRooms,
          detailBooking: event.param.detailBooking
      );
      BookingResponse response = await bookingRepository.postBooking(param);
      emit(BookingSuccess(bookingResponse: response));
    } catch (e) {
      emit(BookingFatalError(message: e .toString()));
    }
  }

  void _onBookingReset(BookingReset event, Emitter<BookingState> emit) {
    emit(BookingInitial());
  }

}
