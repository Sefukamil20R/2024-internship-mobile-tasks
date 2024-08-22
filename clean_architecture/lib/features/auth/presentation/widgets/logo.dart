import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 8,
      ),
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromRGBO(63, 81, 243, 1), 
          width: 1.0, 
        ),
        borderRadius: BorderRadius.circular(8),
        
      ),
      child: Text(
        'ECOM',
        style: GoogleFonts.caveatBrush(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 40,
            color: Color.fromRGBO(63, 81, 243, 1),
          ),
        ),
      ),
    );
  }
}

