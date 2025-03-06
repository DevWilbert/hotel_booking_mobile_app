import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/bloc/room/room_available/room_available_bloc.dart';
import 'package:hotel_app/bloc/room_type/room_type_bloc.dart';
import 'package:hotel_app/models/room_model.dart';
import 'package:hotel_app/models/room_type_model.dart';
import 'package:hotel_app/ui/booking_detail/booking_detail_page.dart';
import 'package:intl/intl.dart';

class RoomPage extends StatefulWidget {
  final String? hotelName;
  final String? checkInDate;
  final String? checkOutDate;

  const RoomPage(
      {super.key,
      required this.hotelName,
      required this.checkInDate,
      required this.checkOutDate});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RoomTypeBloc()..add(GetRoomTypeEvent(hotel_name: widget.hotelName)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Room Selection',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00C6FB), Color(0xFF005BEA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Container(
              child: Text(
                  'Room Available From ${widget.checkInDate} until ${widget.checkOutDate}'),
            ),
            Container(
              child: BlocBuilder<RoomTypeBloc, RoomTypeState>(
                builder: (context, state) {
                  if (state is RoomTypeLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is RoomTypeError) {
                    return Center(
                      child: Text(state.message.toString()),
                    );
                  } else if (state is RoomTypeLoaded) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (_, index) {
                          RoomTypeModel roomTypeModel =
                              state.roomTypeResponse.listRoomType[index];
                          return BlocProvider(
                            create: (context) => RoomAvailableBloc()..add(GetRoomAvailableEvent(
                                checkInDate: widget.checkInDate,
                                checkOutDate: widget.checkOutDate,
                                hotel_name: widget.hotelName,
                                type_name: roomTypeModel.name,
                            )),
                            child: RoomCard(
                              roomTypeModel: roomTypeModel,
                              checkInDate: widget.checkInDate,
                              checkOutDate: widget.checkOutDate,
                            ),
                          );
                        },
                        itemCount: state.roomTypeResponse.listRoomType.length,
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoomCard extends StatefulWidget {
  final RoomTypeModel roomTypeModel;
  final String? checkInDate;
  final String? checkOutDate;

  RoomCard(
      {required this.roomTypeModel, required this.checkInDate, required this.checkOutDate});

  @override
  _RoomCardState createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  String? available_rooms;
  int _quantity = 1;
  RoomAvailableState? _roomAvailableState;

  String formatRupiah(String price) {
    double value = double.parse(price);
    final format = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return format.format(value);
  }

  void _showErrorQuantityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          title: Text(
            'Oops',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.redAccent,
            ),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Text('Kamar ini sedang tidak tersedia', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black87),);
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _showQuantityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          title: Text(
            'Select Quantity',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_circle, color: Colors.red, size: 30),
                    onPressed: () {
                      setState(() {
                        if (_quantity > 1) {
                          _quantity--;
                        }
                      });
                    },
                  ),
                  Text(
                    _quantity.toString(),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle, color: Colors.green, size: 30),
                    onPressed: () {
                      setState(() {
                        if (_quantity < int.parse(available_rooms!)) {
                          _quantity++;
                        }
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  if (_roomAvailableState is RoomAvailableLoaded) {
                    List<RoomModel> booking_room = [];
                    final roomResponse = (_roomAvailableState as RoomAvailableLoaded).roomResponse;
                    for(int i = 0; i < _quantity; i++) {
                      booking_room.add(roomResponse.listRoom[i]);
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => BookingDetailPage(listRoom: booking_room, checkInDate: widget.checkInDate, checkOutDate: widget.checkOutDate,),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: Color(0xffc5eff7),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.roomTypeModel.imageRoom.toString(),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.roomTypeModel.name.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.attach_money, size: 16),
                    SizedBox(width: 5),
                    Text('${formatRupiah(widget.roomTypeModel.price.toString())}'),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.person, size: 16),
                    SizedBox(width: 5),
                    Text(widget.roomTypeModel.capacity.toString()),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                BlocBuilder<RoomAvailableBloc, RoomAvailableState>(
                  builder: (context, state) {
                    if (state is RoomAvailableLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is RoomAvailableError) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else if (state is RoomAvailableLoaded) {
                      available_rooms = state.roomResponse.listRoom.length.toString();
                      _roomAvailableState = state;
                      return Column(
                        children: [
                          Text(
                              'Jumlah Kamar Tersedia : ${available_rooms}'),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if(int.parse(available_rooms!) <= 0) {
                          _showErrorQuantityDialog(context);
                        } else {
                          _showQuantityDialog(context);
                        }
                      },
                      child: Text('Book'),
                    ),
                    Icon(Icons.favorite_border),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
