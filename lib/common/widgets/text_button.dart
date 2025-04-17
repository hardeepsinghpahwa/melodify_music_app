import 'package:flutter/material.dart';
import 'package:music_app/core/configs/theme/app_colors.dart';

class BasicTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color color;

  const BasicTextButton({
    required this.onPressed,
    required this.title,
    this.color = AppColors.primary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7,horizontal: 30),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(title, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
