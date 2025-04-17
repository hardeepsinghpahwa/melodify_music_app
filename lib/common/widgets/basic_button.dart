import 'package:flutter/material.dart';

import '../../core/configs/theme/app_colors.dart';

class BasicButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String title;

  const BasicButton({required this.onPressed,required this.title,super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      minimumSize: Size.fromHeight(80)
    ), child: Text(title,
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),));
  }
}
