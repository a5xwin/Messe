import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:messe/services/auth/login_or_register.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 60,
              left: 25,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Welcome to メッセ ",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Monument',
                      ),
                    ),
                    TextSpan(
                      text: "!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purpleAccent,
                        fontFamily: 'Monument',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            Positioned(
              left: 50,
              top: 130,
              child: Lottie.asset(
                'assets/lottie.json',
                width: 270,
                height: 270,
              ),
            ),
            
            Positioned(
              top: 420,
              left: 30,
              width: MediaQuery.of(context).size.width - 60,
              child: SizedBox(
                child: Text(
                  "Thinking about minimal, distraction-free messaging? Think Messe — simple, fast, and focused.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    fontFamily: 'Nothing'
                  ),
                ),
              ),
            ),
            
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 85,
              bottom: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  // Use pushAndRemoveUntil to clear navigation stack
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginOrRegister()), // Remove all previous routes
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Get Started"),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}