import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/bloc/app_setting/app_setting_bloc.dart';
import 'package:hotel_app/bloc/login/login_bloc.dart';
import 'package:hotel_app/params/auth_param.dart';
import 'package:hotel_app/ui/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final tecUsername = TextEditingController();
  final tecPassword = TextEditingController();
  bool hidePassword = true;

  void resetForm() {
    tecUsername.text = '';
    tecPassword.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg-login-register-5.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login Account',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Please login with registered account',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 32),
                          TextFormField(
                            controller: tecUsername,
                            decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.email, color: Colors.white),
                              labelText: 'Username',
                              labelStyle: TextStyle(color: Colors.white70),
                              hintText: 'Enter your username',
                              hintStyle: TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Username';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: tecPassword,
                            obscureText: hidePassword,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock, color: Colors.white),
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white70),
                              hintText: 'Create your password',
                              hintStyle: TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => RegisterPage()));
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: BlocConsumer<LoginBloc, LoginState>(
                              listener: (context, state) {
                                if (state is LoginSuccess) {
                                  resetForm();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(state.loginResponse.message.toString())));
                                  context.read<AppSettingBloc>().add(CheckSession());
                                } else if (state is LoginError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(state.message.toString())));
                                }
                              },
                              builder: (context, state) {
                                if (state is LoginLoading)
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                else if (state is LoginFatalError) {
                                  return Column(
                                    children: [
                                      Text(state.message.toString()),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      FilledButton(
                                        onPressed: () {
                                          resetForm();
                                          context.read<LoginBloc>().add(LoginReset());
                                        },
                                        child: Text('Kembali'),
                                      ),
                                    ],
                                  );
                                }
                                return ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      String username = tecUsername.text;
                                      String password = tecPassword.text;
                                      final param = AuthParam(
                                          username: username,
                                          password: password);
                                      context
                                          .read<LoginBloc>()
                                          .add(LoginPressed(param: param));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    // primary: Color(0xFF00C2CB),
                                    backgroundColor: Colors.blueAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                  ),
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
