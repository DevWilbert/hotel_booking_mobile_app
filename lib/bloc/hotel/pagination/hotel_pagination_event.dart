part of 'hotel_pagination_bloc.dart';

@immutable
sealed class HotelPaginationEvent {}

final class GetHotelPagination extends HotelPaginationEvent {}
