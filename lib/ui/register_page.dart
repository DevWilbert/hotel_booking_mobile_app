import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/params/register_param.dart';
import 'dart:ui';

import '../bloc/register/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final tecUsername = TextEditingController();
  final tecEmail = TextEditingController();
  final tecPassword1 = TextEditingController();
  final tecPassword2 = TextEditingController();
  final tecFirstName = TextEditingController();
  final tecLastName = TextEditingController();

  bool hidePassword = true;

  void resetForm() {
    tecUsername.text = '';
    tecEmail.text = '';
    tecPassword1.text = '';
    tecPassword2.text = '';
    tecFirstName.text = '';
    tecLastName.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg-login-register-3.jpg'),
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
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Start Explore Our App with create your account',
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
                                    Icon(Icons.person, color: Colors.white),
                                labelText: 'Username',
                                labelStyle: TextStyle(color: Colors.white70),
                                hintText: 'Create your username',
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
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller: tecEmail,
                              decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.email, color: Colors.white),
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.white70),
                                hintText: 'Enter your email',
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
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller: tecFirstName,
                              decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.abc, color: Colors.white),
                                labelText: 'First Name',
                                labelStyle: TextStyle(color: Colors.white70),
                                hintText: 'Enter your First Name',
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
                                  return 'Please enter your First Name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: tecLastName,
                              decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.abc, color: Colors.white),
                                labelText: 'Last Name',
                                labelStyle: TextStyle(color: Colors.white70),
                                hintText: 'Enter your Last Name',
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
                                  return 'Please enter your Last Name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: tecPassword1,
                              obscureText: hidePassword,
                              decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.white),
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
                            SizedBox(height: 16),
                            TextFormField(
                              controller: tecPassword2,
                              obscureText: hidePassword,
                              decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.white),
                                labelText: 'Confirm Password',
                                labelStyle: TextStyle(color: Colors.white70),
                                hintText: 'Confirm your password',
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
                                  return 'Please enter your confirm password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: BlocConsumer<RegisterBloc, RegisterState>(
                                listener: (context, state) {
                                  if (state is RegisterSuccess) {
                                    resetForm();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.registerResponse.message.toString()))
                                    );
                                  } else if (state is RegisterError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(state.message.toString()))
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state is RegisterLoading) {
                                    return const Center(child: CircularProgressIndicator(),);
                                  } else if (state is RegisterFatalError){
                                    return Column(
                                      children: [
                                        Text(state.message.toString()),
                                        SizedBox(height: 10,),
                                        FilledButton(
                                            onPressed: (){
                                              resetForm();
                                              context.read<RegisterBloc>().add(RegisterReset());
                                            },
                                            child: Text('Kembali')
                                        ),
                                      ],
                                    );
                                  }
                                  return ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        String username = tecUsername.text;
                                        String email = tecEmail.text;
                                        String password1 = tecPassword1.text;
                                        String password2 = tecPassword2.text;
                                        String firstName = tecFirstName.text;
                                        String lastName = tecLastName.text;
                                        final param = RegisterParam(
                                            username: username,
                                            email: email,
                                            password1: password1,
                                            password2: password2,
                                            firstName: firstName,
                                            lastName: lastName
                                        );
                                        context.read<RegisterBloc>().add(RegisterPressed(param: param));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      // primary: Color(0xFF00C2CB),
                                      backgroundColor: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                    ),
                                    child: Text(
                                      'Create Account',
                                      style: TextStyle(fontSize: 16),
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
            ),
          ],
        ),
      ),
    );
  }
}
