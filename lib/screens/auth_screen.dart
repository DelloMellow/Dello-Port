import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kp_project/screens/home_screen.dart';
import 'package:kp_project/screens/login_or_register_screen.dart';

//screen ini dibuat hanya untuk proses pengecekan authentication saja
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData) {
            return const HomeScreen();
          }

          //user NOT logged in
          else {
            return const LoginOrRegisterScreen();
          }
        },
      ),
    );
  }
}