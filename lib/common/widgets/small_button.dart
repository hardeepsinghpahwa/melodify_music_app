import 'package:flutter/material.dart';
import 'package:music_app/core/configs/theme/app_colors.dart';

class SmallButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const SmallButton({required this.onPressed, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Center(child: Text(title,
        style: TextStyle(
          color: Colors.white,
        ),)),
      ),
    );
  }
}
