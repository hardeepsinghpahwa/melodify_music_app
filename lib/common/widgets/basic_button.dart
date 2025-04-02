import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String title;

  const BasicButton({required this.onPressed,required this.title,super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(80)
    ), child: Text(title,
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),));
  }
}
