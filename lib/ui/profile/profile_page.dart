import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/core/session_manager.dart';

import '../../bloc/app_setting/app_setting_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionManager = SessionManager();
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/bg-login.jpg'),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GilWil',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'gilwil@mail.com',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Personal Settings'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Implement navigation to personal settings
              },
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('App Settings'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Implement navigation to app settings
              },
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Account Security'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Implement navigation to account security
              },
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About App'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Implement navigation to about Indodax
              },
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                'Help Center',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.support),
              title: Text('Customer Service'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Implement navigation to customer service
              },
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.contact_phone),
              title: Text('Contact Us'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Implement navigation to contact us
              },
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Live Chat'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Implement navigation to live chat
              },
            ),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  sessionManager.signOut();
                  context.read<AppSettingBloc>().add(CheckSession());
                },
                icon: Icon(Icons.logout, color: Colors.red),
                label: Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}