import 'package:bloc/bloc.dart';
import 'package:hotel_app/models/hotel_model.dart';
import 'package:hotel_app/repo/hotel_repository.dart';
import 'package:hotel_app/response/hotel_response.dart';
import 'package:meta/meta.dart';

part 'hotel_pagination_event.dart';
part 'hotel_pagination_state.dart';

class HotelPaginationBloc extends Bloc<HotelPaginationEvent, HotelPaginationState> {
  final hotelRepository = HotelRepository();

  HotelPaginationBloc() : super(HotelPaginationInitial()) {
    on<GetHotelPagination>((event, emit) async {
      try {
        if (state is HotelPaginationInitial) {
          HotelResponse response = await hotelRepository.getHotelPagination(10, 0);
          emit(HotelPaginationLoaded(hotelResponse: response));
        } else {
          HotelPaginationLoaded hotelPaginationLoaded = state as HotelPaginationLoaded;
          HotelResponse response = await hotelRepository.getHotelPagination(10, hotelPaginationLoaded.hotelResponse!.listHotel.length);
          emit(response.listHotel.isEmpty
              ? hotelPaginationLoaded.copyWith(hasReachedMax: true)
              : hotelPaginationLoaded.copyWith(response: hotelPaginationLoaded.hotelResponse! + response)
          );
        }
      } catch (e) {
        emit(HotelPaginationError(message: e.toString()));
      }
    });
  }
}
