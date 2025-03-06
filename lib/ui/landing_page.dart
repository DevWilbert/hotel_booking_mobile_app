import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/bloc/booking/booking_bloc.dart';
import 'package:hotel_app/bloc/landing_page/landing_page_bloc.dart';
import 'package:hotel_app/ui/home/home_appbar.dart';
import 'package:hotel_app/ui/home/home_page.dart';
import 'package:hotel_app/ui/hotel/hotel_appbar.dart';
import 'package:hotel_app/ui/hotel/hotel_page.dart';
import 'package:hotel_app/ui/my_booking/my_booking_page.dart';
import 'package:hotel_app/ui/profile/profile_appbar.dart';
import 'package:hotel_app/ui/profile/profile_page.dart';

import '../bloc/hotel/pagination/hotel_pagination_bloc.dart';
import 'my_booking/my_booking_appbar.dart';

class LandingPage extends StatelessWidget {
  final int initialTabIndex;
  const LandingPage({super.key, this.initialTabIndex = 0});

  final List<BottomNavigationBarItem> bottomNavItems = const <
      BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.hotel),
      label: 'Hotel',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.book),
      label: 'My Booking',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      label: 'Profile',
    ),
  ];

  final List<Widget> bottomNavScreen = const <Widget>[
    HomePage(),
    HotelPage(),
    MyBookingPage(),
    ProfilePage(),
  ];

  final List<PreferredSizeWidget> appBarList = const <PreferredSizeWidget>[
    HomeAppBar(),
    HotelAppBar(),
    MyBookingAppBar(),
    ProfileAppBar(),
  ];

  final List<bool> extendBodyBehindAppBar = const [true, false, false, false];

  // final List<bool> extendBody = const [false, true, true, true];
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LandingPageBloc()..add(TabChange(tabIndex: initialTabIndex)),
        ),
        BlocProvider(
          create: (context) => HotelPaginationBloc()..add(GetHotelPagination()),
        ),
      ],
      child: BlocConsumer<LandingPageBloc, LandingPageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            // extendBody: extendBody.elementAt(state.tabIndex),
            extendBodyBehindAppBar: extendBodyBehindAppBar.elementAt(
                state.tabIndex),
            appBar: appBarList.elementAt(state.tabIndex),
            body: Center(child: bottomNavScreen.elementAt(state.tabIndex)),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.blue, // Background color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  // Make the background transparent
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white38,
                  elevation: 0,
                  currentIndex: state.tabIndex,
                  items: bottomNavItems,
                  onTap: (index) {
                    context.read<LandingPageBloc>().add(
                        TabChange(tabIndex: index));
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
