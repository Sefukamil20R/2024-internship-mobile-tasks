import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/splash.png', fit: BoxFit.cover),
          Center(
            child: Text(
              'Welcome to Eccomerce App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          )
        ],
       ),


      );
    
  }
}