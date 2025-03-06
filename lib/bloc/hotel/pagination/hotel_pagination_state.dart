part of 'hotel_pagination_bloc.dart';

@immutable
sealed class HotelPaginationState {}

final class HotelPaginationInitial extends HotelPaginationState {}

final class HotelPaginationLoading extends HotelPaginationState {}

final class HotelPaginationLoaded extends HotelPaginationState {
  final HotelResponse? hotelResponse;
  final bool hasReachedMax;
  HotelPaginationLoaded({this.hotelResponse, this.hasReachedMax = false});

  HotelPaginationLoaded copyWith({HotelResponse? response , bool? hasReachedMax}) {
    return HotelPaginationLoaded(
      hotelResponse: response ?? this.hotelResponse,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

final class HotelPaginationError extends HotelPaginationState {
  final String message;
  HotelPaginationError({required this.message});
}


// final class MenuRestoPaginationLoaded extends MenuRestoPaginationState {
//   final List<MenuRestoModel> listMenuRestoModel;
//   final bool hasReachedMax;
//   MenuRestoPaginationLoaded(
//       {this.listMenuRestoModel = const <MenuRestoModel>[], this.hasReachedMax = false});
//
//   MenuRestoPaginationLoaded copyWith({List<MenuRestoModel>? list, bool? hasReacedMax}) {
//     return MenuRestoPaginationLoaded(
//       listMenuRestoModel: list ?? this.listMenuRestoModel,
//       hasReachedMax: hasReachedMax ?? this.hasReachedMax,
//     );
//   }
//
// }
