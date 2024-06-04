import 'package:flutter/material.dart';

const borderColor = Colors.grey;

class TextInputFieldMade extends StatelessWidget {
  final TextEditingController controller;
  final IconData myicon;
  final String myLableText;
  final bool isVisible;

  // ignore: prefer_const_constructors_in_immutables
  TextInputFieldMade(
      {super.key,
      required this.controller,
      required this.myicon,
      required this.myLableText,
      this.isVisible = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      obscureText: isVisible,
      controller: controller,
      cursorColor: Colors.white,
      decoration: InputDecoration(
          icon: Icon(
            myicon,
            color: Colors.white,
          ),
          labelText: myLableText,
          labelStyle: const TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: borderColor,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: borderColor,
              ))),
    );
  }
}
