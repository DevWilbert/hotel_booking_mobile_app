import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      // leading: IconButton(
      //   icon: Icon(Icons.menu, color: Colors.white70),
      //   onPressed: () {},
      // ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/profile.png'),
        ),
        SizedBox(width: 16),
        IconButton(
          icon: Icon(
            Icons.notifications_active,
            color: Colors.white70,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
