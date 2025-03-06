import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/bloc/my_booking/my_booking_bloc.dart';
import 'package:hotel_app/core/session_manager.dart';
import 'package:hotel_app/response/booking_response.dart';

import '../../response/my_booking_response.dart';

class MyBookingPage extends StatelessWidget {
  const MyBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionManager = SessionManager();
    int? idUser = sessionManager.getActiveId();

    return BlocProvider(
      create: (context) => MyBookingBloc()..add(GetMyBookingUser(idUser: idUser)),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: BlocBuilder<MyBookingBloc, MyBookingState>(
          builder: (context, state) {
            if(state is MyBookingLoading) {
              return Center(child: CircularProgressIndicator(),);
            } else if (state is MyBookingError) {
              return Center(child: Text(state.message),);
            } else if (state is MyBookingLoaded) {
              if(state.myBookingResponse.listMyBookingResponse.length == 0) {
                return Center(child: Text('No Booking'),);
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  MyBookingResponse bookingResponse = state.myBookingResponse.listMyBookingResponse[index];
                  return MyBookingCard(bookingResponse: bookingResponse);
                },
                itemCount: state.myBookingResponse.listMyBookingResponse.length,
              );
            }
            return Container();

          },
        ),
      ),
    );
  }
}


class MyBookingCard extends StatelessWidget {
  final MyBookingResponse bookingResponse;

  MyBookingCard({required this.bookingResponse});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kode Booking : ${bookingResponse.codeBooking}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              'Hotel : ${bookingResponse.nameHotel}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                Icon(Icons.hotel, color: Colors.amber, size: 16),
                SizedBox(width: 5),
                Text(
                  '${bookingResponse.numOfRooms.toString()} kamar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 5),
                Text('${bookingResponse.detailBooking![0].typeName}'),
                Spacer(),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Check in'),
                    Text(
                      bookingResponse.detailBooking![0].checkInDate.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward),
                Column(
                  children: [
                    Text('Check out'),
                    Text(
                      bookingResponse.detailBooking![0].checkOutDate.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
