import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'homePage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF351A2B),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie.asset(
            //   'assets/lottie.json',
            //   height: height * 0.28,
            // ),
            Image.asset(
              'assets/money.png',
              height: height * 0.2,
            ),
            const SizedBox(height: 34),
            Text(
              'Decoding your financial\nfuture',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: width * 0.028,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                  fontFamily: 'poppins'),
            ),
          ],
        ),
      ),
    );
  }
}
