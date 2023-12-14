import 'package:flutter/material.dart';
import 'package:kp_project/screens/login_screen.dart';
import 'package:kp_project/screens/register_screen.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  const LoginOrRegisterScreen({super.key});

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {

  //buat lsg show login screen diawal
  bool showLoginScreen = true;

  //buat pergantian login dan register screen
  void switchScreen() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(onTap: switchScreen);
    } else {
      return RegisterScreen(onTap: switchScreen,);
    }
  }
}