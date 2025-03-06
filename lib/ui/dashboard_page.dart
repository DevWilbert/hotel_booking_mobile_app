import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/bloc/app_setting/app_setting_bloc.dart';
import 'package:hotel_app/core/session_manager.dart';

class DashBoard extends StatelessWidget {
  // const DashBoard({super.key});

  final sessionManager = SessionManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
              onPressed: (){
                sessionManager.signOut();
                context.read<AppSettingBloc>().add(CheckSession());
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
    );
  }
}
