import 'package:flutter/material.dart';

class BasicOutlinedButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String title;

  const BasicOutlinedButton(
      {required this.onPressed, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: GestureDetector(onTap: onPressed, child: Center(child: Text(title,
        style: TextStyle(
          color: Colors.black
        ),))),
      ),
    );
  }
}
