import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:messe/pages/home_page.dart'; 
import 'package:messe/pages/splash_screen.dart';

class AuthGate extends StatelessWidget {
  final AsyncSnapshot<User?> snapshot;
  
  const AuthGate({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    // Show loading indicator while checking auth state
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // If user is logged in, go to home page
    if (snapshot.hasData) {
      return HomePage();
    }
    // If user is not logged in, show splash screen
    return const SplashScreen();
  }
}