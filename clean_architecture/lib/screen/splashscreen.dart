import 'package:clean_architecture/features/auth/presentation/pages/login_pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => LoginPage(), 
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/splash.png', fit: BoxFit.cover),
          Container(
            color: Colors.blue.withOpacity(0.7),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromRGBO(63, 81, 243, 1),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(38),
                  ),
                  child: Text(
                    'ECOM',
                    style: GoogleFonts.caveatBrush(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 85,
                        color: Color.fromRGBO(63, 81, 243, 1),
                      ),
                    ),
                  ),
                ),
                const Text(
                  'Ecommerce App',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}