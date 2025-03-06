import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hotel_app/models/hotel_model.dart';
import 'package:hotel_app/ui/hotel/detail_hotel_page.dart';
import 'package:intl/intl.dart';

import '../../bloc/hotel/pagination/hotel_pagination_bloc.dart';

class HotelPage extends StatefulWidget {
  const HotelPage({super.key});

  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  final controller = ScrollController();
  late HotelPaginationBloc bloc;

  void onScroll() {
    double maxScroll = controller.position.maxScrollExtent;
    double currentScroll = controller.position.pixels;
    if (maxScroll == currentScroll) bloc.add(GetHotelPagination());
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<HotelPaginationBloc>(context);
    controller.addListener(onScroll);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FilterChipWidget(label: 'All'),
              SizedBox(width: 8),
              FilterChipWidget(label: 'Latest'),
              SizedBox(width: 8),
              FilterChipWidget(label: 'Most Popular'),
              SizedBox(width: 8),
              FilterChipWidget(label: 'Cheapest'),
            ],
          ),
          SizedBox(height: 16),
          BlocBuilder<HotelPaginationBloc, HotelPaginationState>(
            builder: (context, state) {
              if (state is HotelPaginationLoading) {
                return const Center(child: CircularProgressIndicator(),);
              } else if (state is HotelPaginationError) {
                return Center(child: Text(state.message),);
              } else if (state is HotelPaginationLoaded) {
                if(state.hotelResponse!.listHotel.isEmpty) {
                  return Center(child: Text('Data Masih Kosong'),);
                }
                return Expanded(
                  child: GridView.builder(
                    controller: controller,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: state.hasReachedMax ? state.hotelResponse!.listHotel.length : state.hotelResponse!.listHotel.length + 1,
                    itemBuilder: (context, index) {
                      if (index < state.hotelResponse!.listHotel.length) {
                        HotelModel hotelModel = state.hotelResponse!.listHotel[index];
                        return HotelCard(hotelModel: hotelModel);
                      } else {
                        return Center(child: CircularProgressIndicator(),);
                      }

                    },
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}

class FilterChipWidget extends StatelessWidget {
  final String label;

  FilterChipWidget({required this.label});

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      onSelected: (bool selected) {
        // Implement filter functionality
      },
    );
  }
}

class HotelCard extends StatelessWidget {
  final HotelModel hotelModel;

  HotelCard({required this.hotelModel});

  String imageUrl = 'https://www.underconsideration.com/wordit/wordit_archives/0401_empty_Darrel_Austin.jpg';

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat("HH:mm:ss");

    // Parse the string
    DateTime checkInTime = format.parse(hotelModel.checkInTime.toString());
    DateTime checkOutTime = format.parse(hotelModel.checkOutTime.toString());

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 3 / 2,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: hotelModel.imageHotel != null ? NetworkImage(hotelModel.imageHotel.toString()) : NetworkImage(imageUrl),
                          fit: BoxFit.cover
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Icon(Icons.favorite_border, color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    hotelModel.name.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    minFontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    hotelModel.city.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.access_time_filled_rounded, color: Colors.orange, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'Check In : ' + DateFormat.Hm().format(checkInTime),
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Icon(Icons.access_time_filled_rounded, color: Colors.orange, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'Check Out : ' + DateFormat.Hm().format(checkOutTime),
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => HotelDetailPage(detailHotel: hotelModel))
          );
        },
      ),

    );
  }
}

String formatCurrency(int amount) {
  final formatter = NumberFormat.currency(
      locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0);
  return formatter.format(amount);
}
