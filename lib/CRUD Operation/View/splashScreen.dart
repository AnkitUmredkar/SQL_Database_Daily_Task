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
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie.json',
              height: height * 0.28,
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text('Decoding your financial future',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: width * 0.029,
                      fontWeight: FontWeight.bold,
                      // color: Color(0xffB43B28),
                      fontFamily: 'poppins')),
            ),
          ],
        ),
      ),
    );
  }
}