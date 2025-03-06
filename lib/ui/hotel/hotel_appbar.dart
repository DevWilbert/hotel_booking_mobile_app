import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HotelAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HotelAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Hotel..',
            border: InputBorder.none,
            icon: Icon(Icons.search, color: Colors.black),
          ),
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00C6FB), Color(0xFF005BEA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      // backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.filter_list, color: Colors.black),
          onPressed: () {
            // Implement filter functionality
          },
        ),
      ],
    );
  }
}
