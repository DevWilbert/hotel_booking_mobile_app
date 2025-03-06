import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/bloc/booking/booking_bloc.dart';
import 'package:hotel_app/bloc/landing_page/landing_page_bloc.dart';
import 'package:hotel_app/params/booking_param.dart';
import 'package:hotel_app/params/detail_booking_param.dart';
import 'package:hotel_app/ui/landing_page.dart';
import 'package:intl/intl.dart';

import '../../core/session_manager.dart';
import '../../models/room_model.dart';

class BookingDetailPage extends StatefulWidget {
  final String? checkInDate;
  final String? checkOutDate;
  final List<RoomModel> listRoom;
  const BookingDetailPage(
      {super.key,
        required this.listRoom,
        required this.checkInDate,
        required this.checkOutDate});

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  int _getNumberOfDays(String checkInDate, String checkOutDate) {
    DateTime checkIn = DateFormat('yyyy-MM-dd').parse(checkInDate);
    DateTime checkOut = DateFormat('yyyy-MM-dd').parse(checkOutDate);
    return checkOut.difference(checkIn).inDays;
  }

  String formatRupiah(String price) {
    double value = double.parse(price);
    final format =
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return format.format(value);
  }

  int calculateTotalPayment(int numberOfDays, List<RoomModel> listRoom) {
    int total = 0;
    for (var room in listRoom) {
      debugPrint(room.roomTypeModel!.price!.toString());
      total += int.parse(room.roomTypeModel!.price!.replaceAll('.00', '')) *
          numberOfDays;
      debugPrint(total.toString());
    }
    return total;
  }

  int calculateSubTotal(int numberOfDays, RoomModel room) {
    int subtotal = 0;
    subtotal = int.parse(room.roomTypeModel!.price!.replaceAll('.00', '')) *
        numberOfDays;
    return subtotal;
  }

  final sessionManager = SessionManager();

  @override
  Widget build(BuildContext context) {
    int numberOfDays =
    _getNumberOfDays(widget.checkInDate!, widget.checkOutDate!);
    int totalPayment = calculateTotalPayment(numberOfDays, widget.listRoom);
    String totalPaymentString = totalPayment.toString();
    debugPrint(totalPaymentString);
    int subTotal = calculateSubTotal(numberOfDays, widget.listRoom[0]);

    int? idUser = sessionManager.getActiveId();

    return BlocProvider(
      create: (context) => BookingBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Booking Details'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00C6FB), Color(0xFF005BEA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Booking Detail',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent),
                      ),
                      SizedBox(height: 8),
                      Divider(thickness: 1, color: Colors.grey),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: widget.checkInDate,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Check-in',
                                suffixIcon: Icon(Icons.calendar_today),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              initialValue: widget.checkOutDate,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Check-out',
                                suffixIcon: Icon(Icons.calendar_today),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ListTile(
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        leading: Icon(Icons.hotel, color: Colors.blueAccent),
                        title: Text(
                          '${widget.listRoom[0].roomTypeModel!.name}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${formatRupiah(widget.listRoom[0].roomTypeModel!.price.toString())} / night',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                            Text(
                              'Stay For : $numberOfDays days',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Subtotal',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                            Text(
                              '${formatRupiah(subTotal.toString())}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Divider(thickness: 1, color: Colors.grey),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Qty : ',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent),
                            ),
                            Text(
                              '${widget.listRoom.length.toString()} room',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Payment:',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent),
                            ),
                            Text(
                              '${formatRupiah(totalPaymentString)}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Payment :',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                    ),
                    Text(
                      '${formatRupiah(totalPaymentString)}',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              BlocConsumer<BookingBloc, BookingState>(
                listener: (context, state) {
                  if (state is BookingSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Container(
                          padding: EdgeInsets.all(16),
                          height: 90,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle , color: Colors.white, size: 40,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Success',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    Text(
                                      'Booking Berhasil',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height - 250,
                        left: 10,
                        right: 10,
                      ),
                    ));

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) => LandingPage(initialTabIndex: 2,)
                      ),
                          (Route<dynamic> route) => false,
                    );
                  } else if (state is BookingFatalError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message.toString())));
                  }
                },
                builder: (context, state) {
                  if (state is BookingLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is BookingFatalError) {
                    return Center(
                      child: Text('Error : ${state.message.toString()}'),
                    );
                  }
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        List<DetailBookingParam> detailBooking = [];
                        for (int i = 0; i < widget.listRoom.length; i++) {
                          final paramDetail = DetailBookingParam(
                              idRooom: widget.listRoom[i].id,
                              idType: widget.listRoom[i].roomTypeModel!.id,
                              checkInDate: widget.checkInDate,
                              checkOutDate: widget.checkOutDate,
                              subtotal: subTotal.toString());
                          detailBooking.add(paramDetail);
                        }

                        final param = BookingParam(
                            idHotel: widget.listRoom[0].hotelModel!.id,
                            idUser: idUser,
                            totalPayment: totalPayment.toString(),
                            numOfRooms: widget.listRoom.length.toString(),
                            detailBooking: detailBooking);

                        context
                            .read<BookingBloc>()
                            .add(BookingPressed(param: param));
                      },
                      child: Text('Confirm Booking'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        onPrimary: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
