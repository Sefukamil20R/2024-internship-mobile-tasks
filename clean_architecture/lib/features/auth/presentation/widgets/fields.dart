import 'package:flutter/material.dart';

class Fields extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String text;
  final String? Function(String?)? validator;

  const Fields({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.text,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          fillColor: const Color.fromRGBO(250, 250, 250, 1),
          filled: true,
          hintText: hintText,
        ),
        validator: validator ?? (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $text';
          }
          return null;
        },
      ),
    );
  }
}
